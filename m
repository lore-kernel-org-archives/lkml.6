Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: ADUXVKI/2j54xledtkXgjEPms9m1Fr7elJi4D5y9Fz8xDF898qmBeIpz0q85rMbPeFg86FqKUDGA
ARC-Seal: i=1; a=rsa-sha256; t=1527004617; cv=none;
        d=google.com; s=arc-20160816;
        b=T/IqEAm63OuOV4dVsguDe3iW3OZ07479ZMB8pnskGR8ehc/MfPHhSLq/fXUETo9WyC
         dQztRUwkzdx16oXlFffXKwunoBvreHb/nWE9zEcV534kkrqGnER/r1nAsmpdDL7wHPun
         i4xhAijW08Hg9Cn7kw/nbCKjHo+CT7JjpeYo3SwiZ4O4Z/yKDBsRZe1pF49aLYWDkLSh
         IkmdTeAjX7ELYFTFHz7aqwMrtrpaz6IRpse7W9GTZm0dRIIDy90NvoN4ifNCi3Jjs8yl
         1x0bjEdPzfwHuPWgNNoKpH3hNuF2W22/ILTmoLBLOUt6xV8ArGjaBPhV6yfzkwrPJuF2
         kzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=DOmo6gwUs+DJcp0d5gPixSKPZX8XRDIGioKcMWtAAOQ=;
        b=PjQ7OA/+ClY/PAfmDoaVdGOk6aoHpI+NDcua1vJOGevZjhjRg5B8ThuGfseyY98rKF
         TIB+pvpUlvtq/u8bI1iKS5bhfJ1yMtymkAcroP9CdCsN5qd6duhJyl+qw4MiHYTAtDhR
         vbRC4n0CWb+EUCoSe8FDpAJLbeZfklcFAcYR9nlUYQwyKpMJ749ygtCmqsm/kcVXB+8A
         RcLfYz/qJVdvT/g64VTSRU5CrMPKARJyEciXZz4mGCvNcdddKHLfqM+G5WDIqrDcoU4h
         2hVgIh83HNyDq5NRTdAevQHzVGKW3t5om15rmUmqeOCkqRp3CKnDJHLbxbcTO62olFoQ
         3PNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH v3] usbip: vhci_sysfs: fix potential Spectre v1
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20180519011342.GA13962@embeddedgus>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <8d36b487-4187-4aef-1796-af6d10f357d7@kernel.org>
Date: Tue, 22 May 2018 09:56:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180519011342.GA13962@embeddedgus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1601180393207967260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 07:13 PM, Gustavo A. R. Silva wrote:
> pdev_nr and rhport can be controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'
> 
> Fix this by sanitizing pdev_nr and rhport before using them to index
> vhcis and vhci->vhci_hcd_ss->vdev respectively.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v3:
>  - Pass the addresses of pdev_nr and rhport into valid_port and
>    valid_args.
> 
> Changes in v2:
>  - Place the barriers into valid_port.
> 
>  drivers/usb/usbip/vhci_sysfs.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index 4880838..be37aec 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -10,6 +10,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +/* Hardening for Spectre-v1 */
> +#include <linux/nospec.h>
> +
>  #include "usbip_common.h"
>  #include "vhci.h"
>  
> @@ -205,16 +208,20 @@ static int vhci_port_disconnect(struct vhci_hcd *vhci_hcd, __u32 rhport)
>  	return 0;
>  }
>  
> -static int valid_port(__u32 pdev_nr, __u32 rhport)
> +static int valid_port(__u32 *pdev_nr, __u32 *rhport)
>  {
> -	if (pdev_nr >= vhci_num_controllers) {
> -		pr_err("pdev %u\n", pdev_nr);
> +	if (*pdev_nr >= vhci_num_controllers) {
> +		pr_err("pdev %u\n", *pdev_nr);
>  		return 0;
>  	}
> -	if (rhport >= VHCI_HC_PORTS) {
> -		pr_err("rhport %u\n", rhport);
> +	*pdev_nr = array_index_nospec(*pdev_nr, vhci_num_controllers);
> +
> +	if (*rhport >= VHCI_HC_PORTS) {
> +		pr_err("rhport %u\n", *rhport);
>  		return 0;
>  	}
> +	*rhport = array_index_nospec(*rhport, VHCI_HC_PORTS);
> +
>  	return 1;
>  }
>  
> @@ -232,7 +239,7 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>  	pdev_nr = port_to_pdev_nr(port);
>  	rhport = port_to_rhport(port);
>  
> -	if (!valid_port(pdev_nr, rhport))
> +	if (!valid_port(&pdev_nr, &rhport))
>  		return -EINVAL;
>  
>  	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
> @@ -258,7 +265,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(detach);
>  
> -static int valid_args(__u32 pdev_nr, __u32 rhport, enum usb_device_speed speed)
> +static int valid_args(__u32 *pdev_nr, __u32 *rhport,
> +		      enum usb_device_speed speed)
>  {
>  	if (!valid_port(pdev_nr, rhport)) {
>  		return 0;
> @@ -322,7 +330,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>  			     sockfd, devid, speed);
>  
>  	/* check received parameters */
> -	if (!valid_args(pdev_nr, rhport, speed))
> +	if (!valid_args(&pdev_nr, &rhport, speed))
>  		return -EINVAL;
>  
>  	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
> 

Looks good to me. Thanks for taking care of this.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

-- Shuah
