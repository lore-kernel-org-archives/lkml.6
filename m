Return-Path: <mathias.nyman@linux.intel.com>
X-Google-Smtp-Source: AG47ELuFsJgvcwezSIIGhKl5Zjjmhqeo2BXoUnrc3d8SNBptiQvWiFsiP1S+mr7AdHn2M9/yKujf
ARC-Seal: i=1; a=rsa-sha256; t=1519913695; cv=none;
        d=google.com; s=arc-20160816;
        b=L8EDkjqayI6jagtEZqN9pd1iSqGQfFwcp1iaP9X5Wx/t2ffvYFSipdIW7Cl2K/Z4hk
         mCQjMIFdvUTRBS7Ax6ir4WahHoed1KnMbemNN4ifW6LC+2JYpC9JM8gJ/AMPce4/CSDI
         +/EVcMPcdBNtsxXnCcwWi4pGp2bGf3XvEmgbqA7k8zBhvBMyKDGuSMWiEvhVISt3nqeo
         h2xuSuDIwZ3gbzeNKS+JL5qhjTGRWyDRG3SYEVwwCtUsaASGhmp3WmOWxf/WjzBwHodu
         Bl/mdSic7qycP892X8R8aSPMvNkLOt0JgcKQ065TJ0ZX2rnRlxqeie1fA5kjwxZW/DU1
         Yaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=PTjCr3HW3r5DemgZuyTgaZyQkjgrqFQCMqX1wrUDNQs=;
        b=rbfCn4RBSqqC2U2QMMM4Xl2t8i/eMopOmTnVwK1F83NQn12gLftj/i072OhehXKsP0
         ztlhlUXtGXUEuQN2Txo5qtGEdr1BwJr3TtYlzwvyzqXx0E3QWsGs3QW0i8DOiyoUVsBT
         p1H0qv8ZGVFI5fw7HJb18J/TdDgN6cCq2PaSPf4lUz1VGz3b2s9a/zEpazHbvbElsSeX
         6oVUEG/VNVoa9WUNJ1vTW7VNTF/e27pC2Bl+fX60AYer1NV/r/uQF6ozV6VfU0Z8u6a7
         YKH4a9LA8hD0P8pEnipy3C/bwATYe+pt7l3stIC3lyNzFlaCDiTQASBUr+Orw59oseLG
         V5KA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mathias.nyman@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=mathias.nyman@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mathias.nyman@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=mathias.nyman@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="22074853"
Subject: Re: [PATCH 2/3] usb: xhci: tegra: Add runtime PM support
To: Jon Hunter <jonathanh@nvidia.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
 <1518626085-29102-2-git-send-email-jonathanh@nvidia.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <54bd00b7-2835-a253-0399-370e8c8203b8@linux.intel.com>
Date: Thu, 1 Mar 2018 16:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1518626085-29102-2-git-send-email-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592394886362728213?=
X-GMAIL-MSGID: =?utf-8?q?1593745023252742977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14.02.2018 18:34, Jon Hunter wrote:
> Add runtime PM support to the Tegra XHCI driver and move the function
> calls to enable/disable the clocks, regulators and PHY into the runtime
> PM callbacks.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   drivers/usb/host/xhci-tegra.c | 80 ++++++++++++++++++++++++++++++-------------
>   1 file changed, 56 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 02b0b24faa58..42aa67858b53 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -18,6 +18,7 @@
>   #include <linux/phy/tegra/xusb.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/reset.h>
>   #include <linux/slab.h>
> @@ -1067,22 +1068,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>   	 */
>   	platform_set_drvdata(pdev, tegra);
>   
> -	err = tegra_xusb_clk_enable(tegra);
> -	if (err) {
> -		dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
> -		goto put_usb2;
> -	}
> -
> -	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
> -	if (err) {
> -		dev_err(&pdev->dev, "failed to enable regulators: %d\n", err);
> -		goto disable_clk;
> -	}
> +	pm_runtime_enable(&pdev->dev);
>   
> -	err = tegra_xusb_phy_enable(tegra);
> +	err = pm_runtime_get_sync(&pdev->dev);
>   	if (err < 0) {

Does this mean that if runtime PM is disabled then clocks and regulator will never be enabled
for Tegra xhci?

How about keeping the clock and regualtor enabling in probe, and instead add something like:

pm_runtime_set_active(&pdev->dev);
pm_runtime_enable(&pdev->dev);
pm_runtime_get_noresume(&pdev->dev);

-Mathias
