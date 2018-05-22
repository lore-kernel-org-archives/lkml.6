Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqjM2IT+cef8gsbnA4bOsymR98GCiQ+gfsx7s36ORxJLzi2uTfcRUV4zChArRkYHQnM16/5
ARC-Seal: i=1; a=rsa-sha256; t=1527029786; cv=none;
        d=google.com; s=arc-20160816;
        b=dOyIBvA3h3EHhz1WQ1/rZymv0QdmySacDCseD9CCLcIFJBU8vH1Ml0VPGGLmfKINkc
         P4CMQ0qUg6stzfXaK8Bx2W1LdNbSY08w2q4TNSdTTd6QWkgmNwm/TljENgSOgalm9b98
         3jzb6TZRYjo/jOuojMGL4T+CWbQQvQJp5f8eroCvwJPqXc5VDNmm0jokHXroAOERajQ3
         BXJ0JkFkmwO4ieKTdJVSIg88KO8cePzT0S0yfsrk43TQ7e84X7MFyWzCaDmGbCNkwYy7
         mwoMC6lyun535xGRr+zLo01RzdaPEuH622sw6vp3x7dYo5yob4w9byJ/zqiEE2i2ChDD
         fXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=lnjfVvW9zVOUBRzCoKn7zJrn89SomOcWdE7HMMlh/Po=;
        b=BDgrteWUcm8oL2UKuc/YPgsRk4ivWiymHBUIveF96comG4041s7nhhunzpFf42Od9b
         8gBAfB8P8oYMykkHTUc0efPKpNnVHjE9MUVwR5n3q7UPfP2wSlcc4LYTMyipMx1Q+fnd
         scZJvR7Xcs28whlHHdLaEQynksd3RGw8foerFcpx0glPiZOJ+skKCxulCXQd5xbNntnO
         rzarfVkKrcrwNMZyVz8YSROtJhWkp4xnrJmHipLiYg7sFRiP32gR2NyjTAsrr2rO/+kx
         YO3ypNaOLI1i1LqACbjiD8dQUkSyWPdiJJaPUpiLYBQiNABjOR9Rf7c7izY3ocDdiN4y
         AijA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH v2] usbip: dynamically allocate idev by nports found in
 sysfs
To: Michael Grzeschik <m.grzeschik@pengutronix.de>, linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Shuah Khan <shuah@kernel.org>
References: <05a0fd16-cd54-1bb8-7566-0d88e1bd73cf@kernel.org>
 <20180522170407.10102-1-m.grzeschik@pengutronix.de>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <c57fa7e9-d811-234b-fefc-1be998c5a8f1@kernel.org>
Date: Tue, 22 May 2018 16:56:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522170407.10102-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600813163471096562?=
X-GMAIL-MSGID: =?utf-8?q?1601206785227839799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/22/2018 11:04 AM, Michael Grzeschik wrote:
> As the amount of available ports varies by the kernels build
> configuration. To remove the limitation of the fixed 128 ports
> we allocate the amount of idevs by using the number we get
> from the kernel.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> v1 -> v2: - reworked memory allocation into one calloc call
>           - added error path on allocation failure
> 
>  tools/usb/usbip/libsrc/vhci_driver.c | 14 +++++++++-----
>  tools/usb/usbip/libsrc/vhci_driver.h |  3 +--
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
> index c9c81614a66ad..6e2a9edfd1f0d 100644
> --- a/tools/usb/usbip/libsrc/vhci_driver.c
> +++ b/tools/usb/usbip/libsrc/vhci_driver.c
> @@ -242,13 +242,20 @@ static int read_record(int rhport, char *host, unsigned long host_len,
>  
>  int usbip_vhci_driver_open(void)
>  {
> +	int nports = get_nports();
> 

I missed this error leg in my previous comments. get_nports() could return
errorwhich is -1.

>  	udev_context = udev_new();
>  	if (!udev_context) {
>  		err("udev_new failed");
>  		return -1;
>  	}
>  
> -	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver));
> +	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver) +
> +			nports * sizeof(struct usbip_imported_device));

nports could be -1 at this point.

> +	if (!vhci_driver) {
> +		err("vhci_driver allocation failed");
> +		return -1;
> +	}
>  
>  	/* will be freed in usbip_driver_close() */
>  	vhci_driver->hc_device =
> @@ -260,15 +267,12 @@ int usbip_vhci_driver_open(void)
>  		goto err;
>  	}
>  
> -	vhci_driver->nports = get_nports();
> +	vhci_driver->nports = nports;
>  	dbg("available ports: %d", vhci_driver->nports);
>  
>  	if (vhci_driver->nports <= 0) {
>  		err("no available ports");
>  		goto err;
This check should move up along with the get_nports() call.

> -	} else if (vhci_driver->nports > MAXNPORT) {
> -		err("port number exceeds %d", MAXNPORT);
> -		goto err;
>  	}
>  
>  	vhci_driver->ncontrollers = get_ncontrollers();
> diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
> index 418b404d51210..6c9aca2167051 100644
> --- a/tools/usb/usbip/libsrc/vhci_driver.h
> +++ b/tools/usb/usbip/libsrc/vhci_driver.h
> @@ -13,7 +13,6 @@
>  
>  #define USBIP_VHCI_BUS_TYPE "platform"
>  #define USBIP_VHCI_DEVICE_NAME "vhci_hcd.0"
> -#define MAXNPORT 128
>  
>  enum hub_speed {
>  	HUB_SPEED_HIGH = 0,
> @@ -41,7 +40,7 @@ struct usbip_vhci_driver {
>  
>  	int ncontrollers;
>  	int nports;
> -	struct usbip_imported_device idev[MAXNPORT];
> +	struct usbip_imported_device idev[];
>  };
>  
>  
> 

thanks,
-- Shuah
