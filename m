Return-Path: <lorenzo.pieralisi@arm.com>
X-Google-Smtp-Source: AG47ELsQdVtUI/8DJhGA34nWxGxxwRNGxTN8Dh/n7hDuX+C+OfIGAk9UTkORjKyuAhcs7HIerYQx
ARC-Seal: i=1; a=rsa-sha256; t=1519665988; cv=none;
        d=google.com; s=arc-20160816;
        b=L4sbSxuiSxKz6orDQY+W7T+rk/XxVJI1UbjFbkfbe8OJ0cOHSX46D8MRL2q60TayLp
         jRz5TDQ3mbEQcCl2wnxr6PSUgM+KpF5WaoUiScfWp7yn7aHBuaWkOwAu68FMUfYpnJVJ
         Wnm9G5czTf1dxAnxrFe34J7SbwVaqOc8W5Mgvo3nfcN0dpdDoV0XZubsi8qqazFIJCZ3
         GlERRlb7U8kXeDEW5vV/FPLvO3HhNfJ/yBhCFALm88vsqzHONxphJ4wd6jpW/Z0ho2OE
         kSEAs+4YPRS+horc9rwJz6eHzKDTjkaEFuiGZd3mvGpnBPen9PqK3G2ThiBg3dLko8TU
         HcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jPJ5rFvevkVT9zxVDZiCg+Gy5Zqfe2hhxolQD65HStA=;
        b=q2KEXB17WutcCYzt/pc4F/QxPB6tbHPBLdjHRwVrQKUbs0q+Esh/n2OnTEBcY/LdJ2
         Ki1if+5sJN1KlcznYM491qDtUfQD1fIz0WrhJ/f34HhFgg3UKh1X2PZauip6avzGiu8n
         rIa+w0dEFbDKBL/ClMaVdxLvoHZLcSHuhYYgcAzGIs1wlv8JwrktoPO+I4lKG7pKxd1t
         CMq6sN3x7pBX4KJ5A1YB8QZgpr1Isl4BQIlKTfUTbuPMmdJBwpPBQymMSftLWTZ4DneH
         iguwPpBgkQkx1XnIot5lxVIGRqQCfjNCxMnZ0/0/5BsFuxR22aaGIKWXgKkD3o4uzd6I
         yINQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lorenzo.pieralisi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=lorenzo.pieralisi@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lorenzo.pieralisi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=lorenzo.pieralisi@arm.com
Date: Mon, 26 Feb 2018 17:26:18 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180226172618.GA26815@e107981-ln.cambridge.arm.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-3-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208123346.20784-3-niklas.cassel@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591836133225578402?=
X-GMAIL-MSGID: =?utf-8?q?1593485283134287082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 01:33:45PM +0100, Niklas Cassel wrote:
> A 64-bit BAR uses the succeeding BAR for the upper bits,
> so we cannot simply call pci_ioremap_bar() on every single BAR.
> 
> Ignore BARs that does not have a valid resource length.
> 
> pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR1
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR3
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR5
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> Lorenzo/Bjorn: pci_resource_len() seems to fix my problem,
> but is it the correct function to use here?
> If BAR[x] is a 64-bit BAR, I'm assuming that pci_resource_len() on BAR[x+1]
> will always return 0 (since BAR[x+1] cannot have any prefetchable/type bits
> when BAR[x] is 64-bit).
> 
>  drivers/misc/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 320276f42653..3af31bfdcfdd 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -534,6 +534,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> +		if (pci_resource_len(pdev, bar) == 0)
> +			continue;

Should not it be handled by checking the resource flags as you loop
through the bar counter and incrementing the bar counter (+1) if
IORESOURCE_MEM_64 is detected ?

I would like to get Bjorn's point of view on this since it is definitely
more comprehensive than mine.

Thanks,
Lorenzo

>  		base = pci_ioremap_bar(pdev, bar);
>  		if (!base) {
>  			dev_err(dev, "failed to read BAR%d\n", bar);
> -- 
> 2.14.2
> 
