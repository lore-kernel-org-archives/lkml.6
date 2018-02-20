Return-Path: <rogerq@ti.com>
X-Google-Smtp-Source: AH8x226+mCounaPtsLEhWnJrer74EogV+lXhVMEuu+qvJeA2ioGVeXWYCvRXRPFZzBCjyCdFoLFd
ARC-Seal: i=1; a=rsa-sha256; t=1519135245; cv=none;
        d=google.com; s=arc-20160816;
        b=zg5lF39BRxISwdWS16BDckTud0XyEs4u+oJ5jINhIaxwt0//N1AyLl6AEMjklTc0TF
         uRg6SBshJwQ8DEoTShFoUWrUgWoxGvFR/OVcIyTXxyBbUq2ZUkohPDh3qWMoWaLi3G/k
         Aw/HBf7W8CeDc0wzTz5fmWMSc5ZiJypMSW3ScXGPurSo3YgllHCG/wZEw5Ue3MBXbuWJ
         +hF1SdWmVfJnVIkCNovpjiS6qDwGtvVQGR7E+0lLuuqk7c2Y/2YZEUgS+vGbo+babloC
         YbumJ0W2I+nGHssnFoFqmvPkIUKxsORVJ+VR3Fcw/MRUTFLEiHX7mH5Qb9U55vju/w6F
         k4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ZpV12qcL9Vio9bqj+uMjGLn3+pzSCyDvxj+vq9XQAxk=;
        b=IDzxW34trHQWl+RU3zp1wm5e4kTd77eNSqP1SkzCTbFSuMpe1ODzdd0wAndR+rUJL8
         gUCJSRTbuQeAcaC23fcr7I9gbROuaN1Zmd6gZZukb9ucoYf7Gzcn/56yJVb3J+C2paH0
         1zCYXfjhujo3g38U02WlOLM2x+yHTr/G+LnLQS65fAM/oTRWEmYw3fppKCRCiIMXPFK7
         V4fNOJt7wxefGkIc9iJkX7ICfU4kKD9niMmxJZRuqUTS4MFNNh4GakgRzBRmEXIyeOTm
         EzO6Tr2DzNm3zFbFSkH9SXbfaWHjt6gsN0aoMWV1y6uG6A9Hx1EXS7S02rqLI3Js7mSs
         Mfuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=QGTdYBBs;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=QGTdYBBs;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern
	<stern@rowland.harvard.edu>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <bfaa3001-d90f-7903-17e8-90af9a03c338@ti.com>
Date: Tue, 20 Feb 2018 16:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592910586052663664?=
X-GMAIL-MSGID: =?utf-8?q?1592928758709607534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 20/02/18 14:58, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> may be used.
> Add support for this optional external vbus supply in ehci-platform.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> ---
> Changes in v2:
>  * Address Roger Quadros comments: move regulator_enable/disable from
> ehci_platform_power_on/off to ehci_platform_port_power.
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>  drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..fc480cd 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - vbus-supply : phandle of regulator supplying vbus
>  

Can platforms have more than one regulator e.g. one regulator per port?

>  Example (Sequoia 440EPx):
>      ehci@e0000300 {
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a96..05be100 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>  	struct reset_control *rsts;
>  	struct phy **phys;
>  	int num_phys;
> +	struct regulator *vbus_supply;
>  	bool reset_on_resume;
>  };
>  
> @@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
> +				    bool enable)
> +{
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int ret = 0;
> +
> +	if (priv->vbus_supply) {
> +		if (enable)
> +			ret = regulator_enable(priv->vbus_supply);
> +		else
> +			ret = regulator_disable(priv->vbus_supply);
> +		if (ret)
> +			dev_err(hcd->self.controller,
> +				"failed to %s vbus supply: %d\n",
> +				enable ? "enable" : "disable", ret);
> +	}
> +	return ret;
> +}
> +
>  static int ehci_platform_power_on(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
> @@ -134,6 +155,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
>  static const struct ehci_driver_overrides platform_overrides __initconst = {
>  	.reset =		ehci_platform_reset,
>  	.extra_priv_size =	sizeof(struct ehci_platform_priv),
> +	.port_power =		ehci_platform_port_power,
>  };
>  
>  static struct usb_ehci_pdata ehci_platform_defaults = {
> @@ -247,6 +269,15 @@ static int ehci_platform_probe(struct platform_device *dev)
>  	if (err)
>  		goto err_put_clks;
>  
> +	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
> +	if (IS_ERR(priv->vbus_supply)) {
> +		err = PTR_ERR(priv->vbus_supply);
> +		if (err == -ENODEV)
> +			priv->vbus_supply = NULL;
> +		else
> +			goto err_reset;
> +	}
> +
>  	if (pdata->big_endian_desc)
>  		ehci->big_endian_desc = 1;
>  	if (pdata->big_endian_mmio)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
