Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELtPGdUjI9v3+fhMo2VtMBMEBkVEcJKUJJqxkRwkfrZkWS8EfEilsPqkKA9S19/23vc8LWlg
ARC-Seal: i=1; a=rsa-sha256; t=1519824832; cv=none;
        d=google.com; s=arc-20160816;
        b=DfXlbcSZ68TJpMwVnoOirmhTgHT/KdadlO7QTKx/iJV6T5JS272NKnmV6xcD+qnnEr
         FLdVFKEMUr1X/yMOMh0PG3SHCXm9R3PYOkODDwn66yzF9LeiwmaMvVM+xVkz6QYZ60Fu
         ozaHX3dewMY5Wk1XlU7lV18kPmda93XeziqJRoHdjgZH5P4dPTD+ifLq63bXxtQ2HdEn
         ZhbeMo5U15vpNit8ZLsAyIHrd1DZjYoJJwyvPxEXObF0NE/K9cGqaCnJjYcZrVEJl/Qb
         7mOK2UodtuLCy20E/Ra0ncfyX7K+EtbkIa9z3m83CzSWF8nocot7iwdpxWDu1yPTwa+U
         Qbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=LsPRR15ehlwUJ6p0Ikd8VfsCkgBsIwypW1BdjDHOVlw=;
        b=dBogP9q3p6t7Xjzi1CNY4Kr5XvS5gcIuupCiZmbc7mryOdDz/L2lJZar1qZJPuRCIm
         4qFGqGy1HRDUP0cSgUxmFseLLTa5TciiKuetm0bUvPhsNB890PAu9+zK6tjo5dO4jUdE
         06zbcgtzWTte94W3USTJ/nMY3Ycva9XA+IwKtoLa5I/m9v8dDMMqAIPEE3GdKgpvfzMi
         YITgtJjnTmJFc5u47eOE7U5W4zsjeI38XyF+X6hxN1RuHTrAvubVphAFj037MlT/5Hit
         C2f+Gq6z8Ull1mVvsTgwcgNQ8NwNsrmaCbj1mkIAasieXdm9g30se7emk7yzBtq2LUps
         ZrfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v3] usb: host: ehci-platform: add support for optional
 external vbus supply
To: Amelie Delaunay <amelie.delaunay@st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Tony Prisk <linux@prisktech.co.nz>, Alan Stern <stern@rowland.harvard.edu>,
 Roger Quadros <rogerq@ti.com>, Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <dc412433-5a96-ea86-6d97-13877fe4806c@arm.com>
Date: Wed, 28 Feb 2018 13:33:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592910586052663664?=
X-GMAIL-MSGID: =?utf-8?q?1593651843977584442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Amelie,

Just a couple of drive-by coding style comments...

On 23/02/18 13:46, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> may be used.
> Add support for optional external vbus supply per port in ehci-platform.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> ---
> Changes in v3:
>   * Address Felipe Balbi comments: reduce indentation in
>     ehci_platform_port_power.
>   * Address Roger Quadros and Alan Stern comments: platforms can have one
>     external vbus supply per port, so add support to get as many optional
>     regulator as implemented ports on the host controller.
> 
> Changes in v2:
>   * Address Roger Quadros comments: move regulator_enable/disable from
>     ehci_platform_power_on/off to ehci_platform_port_power.
> ---
>   Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>   drivers/usb/host/ehci-platform.c                   | 52 +++++++++++++++++++++-
>   2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..cd576db 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>    - phys : phandle + phy specifier pair
>    - phy-names : "usb"
>    - resets : phandle + reset specifier pair
> + - portN_vbus-supply : phandle of regulator supplying vbus for port N
>   
>   Example (Sequoia 440EPx):
>       ehci@e0000300 {
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a96..8e9f201 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -29,6 +29,7 @@
>   #include <linux/of.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/reset.h>
>   #include <linux/usb.h>
>   #include <linux/usb/hcd.h>
> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>   	struct reset_control *rsts;
>   	struct phy **phys;
>   	int num_phys;
> +	struct regulator **vbus_supplies;
>   	bool reset_on_resume;
>   };
>   
> @@ -56,7 +58,8 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>   	struct platform_device *pdev = to_platform_device(hcd->self.controller);
>   	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
>   	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> -	int retval;
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int portnum, n_ports, retval;
>   
>   	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
>   
> @@ -71,11 +74,57 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>   	if (retval)
>   		return retval;
>   
> +	n_ports = HCS_N_PORTS(ehci->hcs_params);
> +	priv->vbus_supplies = devm_kcalloc(&pdev->dev, n_ports,
> +					   sizeof(struct regulator *),

Using "sizeof(*priv->vbus_supplies)" here will prevent people sending 
annoying cleanup patches later.

> +					   GFP_KERNEL);
> +	if (!priv->vbus_supplies)
> +		return -ENOMEM;
> +
> +	for (portnum = 0; portnum < n_ports; portnum++) {
> +		struct regulator *vbus_supply;
> +		char id[20];
> +
> +		sprintf(id, "port%d_vbus", portnum);
> +
> +		vbus_supply = devm_regulator_get_optional(&pdev->dev, id);
> +		if (IS_ERR(vbus_supply)) {
> +			retval = PTR_ERR(vbus_supply);
> +			if (retval == -ENODEV)
> +				priv->vbus_supplies[portnum] = NULL;

The array element here hasn't yet been assigned to since kcalloc() 
initially zeroed it, so this is entirely redundant - you can simply make 
the comparison a "!=" and remove the "else" case.

Robin.

> +			else
> +				return retval;
> +		} else {
> +			priv->vbus_supplies[portnum] = vbus_supply;
> +		}
> +	}
> +
>   	if (pdata->no_io_watchdog)
>   		ehci->need_io_watchdog = 0;
>   	return 0;
>   }
>   
> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
> +				    bool enable)
> +{
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int ret;
> +
> +	if (!priv->vbus_supplies[portnum])
> +		return 0;
> +
> +	if (enable)
> +		ret = regulator_enable(priv->vbus_supplies[portnum]);
> +	else
> +		ret = regulator_disable(priv->vbus_supplies[portnum]);
> +	if (ret)
> +		dev_err(hcd->self.controller,
> +			"failed to %s vbus supply for port %d: %d\n",
> +			enable ? "enable" : "disable", portnum, ret);
> +
> +	return ret;
> +}
> +
>   static int ehci_platform_power_on(struct platform_device *dev)
>   {
>   	struct usb_hcd *hcd = platform_get_drvdata(dev);
> @@ -134,6 +183,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
>   static const struct ehci_driver_overrides platform_overrides __initconst = {
>   	.reset =		ehci_platform_reset,
>   	.extra_priv_size =	sizeof(struct ehci_platform_priv),
> +	.port_power =		ehci_platform_port_power,
>   };
>   
>   static struct usb_ehci_pdata ehci_platform_defaults = {
> 
