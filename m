Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZr+HAfhHkrOR8BVckXb8X2xUbrOFM0dBfFMDwnwX9CFPeJReZdXTrSuFBS+vlF+InZIVpZC
ARC-Seal: i=1; a=rsa-sha256; t=1524855088; cv=none;
        d=google.com; s=arc-20160816;
        b=JbDf02Ks2Y2Gm0zd/KSCIQDvZM5Z+yhQQlQp8sq06a/BgJDcQkIAhdNoBj8dUIMzWm
         udDKMka7JNcs92JlOTdLUYOl1HH6izcDCaR7iASsuoXcuOxYMz1SalmHf3IzGPenWZDL
         D3suuygB1XsnOr5OaHm/a/TfoqWYdapq6DaSI/AOsvQTdctA9rJx7CJsufx8aNUloEyA
         jLGh0gjB0dR9Ii2ospbR4TjnOhNEYKYP53xx2vF7seJDTR04pEhI27EsB77swP4HhTv4
         63+pj/Op+JNEZ7Zpn51LshEy/X0rklf0CRJnGvr4im30t7l9FBV1mn5KwlHwed5UxEkX
         2tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=UzjuxfeGPP2QhyuYJUgocpStnQIPdKZ1Hvm7GQschbU=;
        b=f+lz0FPCzhQmARYPP8JNR3UozbCepXuCR0k6pWTE0JHKNIXTfNbChY4TP3NHbvmuoU
         Sp9qhmeop3ObRf0so2wtmlJXbfHqTLgHNKIYTaPoBamm53mGcBWxi/ec7EdSNYHRxsi4
         KpcD96uS/DRVk4ykhCMrCYbUoRTEKdCd8kIxQBzSxnksM+Q/1q9NvggPSgn4ZUHMDeoF
         q6IEBJ8pkylIPYxdQ3HGG70LCS1DTQQCSNZYYJ77GPl83bz2gYmychEJrxwXvvRqJ0rL
         E946oCkuqJ6sdlBc+4Wq8rpoOIw2fmcQS9I6VDepAoSV/KZW6BOJcSRytW89MUCunjhH
         nmHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=j/DtJo24;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=j/DtJo24;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=j/DtJo24;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=j/DtJo24;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CD7160314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 2/2] PCI/AER: Try slot reset before secondary bus reset
To: linux-pci@vger.kernel.org, sulrich@codeaurora.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, Frederick Lawler <fred@fredlawl.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <1524167784-5911-2-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <550e4064-9618-0784-643d-b3f9b364ba9e@codeaurora.org>
Date: Fri, 27 Apr 2018 14:51:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524167784-5911-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598205773144621610?=
X-GMAIL-MSGID: =?utf-8?q?1598926448368978551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn,

On 4/19/2018 3:56 PM, Sinan Kaya wrote:
> The endpoint observing AER_FATAL error might be connected to a PCI hotplug
> slot. Performing secondary bus reset on a hotplug slot causes PCI link
> up/down interrupts.
> 
> Hotplug driver removes the device from system when a link down interrupt
> is observed and performs re-enumeration when link up interrupt is observed.
> 
> This conflicts with what this code is trying to do. Try secondary bus
> reset only if pci_reset_slot() fails/unsupported.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pcie/aer/aerdrv.c      | 3 ++-
>  drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 779b387..4eaa524 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -318,7 +318,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>  
> -	pci_reset_bridge_secondary_bus(dev);
> +	if (pci_reset_slot(dev->slot))
> +		pci_reset_bridge_secondary_bus(dev);
>  	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
>  
>  	/* Clear Root Error Status */
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 0ea5acc..a915b0e6 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -407,7 +407,8 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>   */
>  static pci_ers_result_t default_reset_link(struct pci_dev *dev)
>  {
> -	pci_reset_bridge_secondary_bus(dev);
> +	if (pci_reset_slot(dev->slot))
> +		pci_reset_bridge_secondary_bus(dev);
>  	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
> 

If we put the 1/2 patch aside, what do you think about pulling this for 4.18?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
