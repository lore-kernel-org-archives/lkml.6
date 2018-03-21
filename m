Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AG47ELunPt2h6THRTdNtTLwOcWQj31Fo57RFz3wUepLTPeN3THzeJia3ZT3aC0jQbm5yC7Y2FkBT
ARC-Seal: i=1; a=rsa-sha256; t=1521604774; cv=none;
        d=google.com; s=arc-20160816;
        b=iL4nxYnupG2BvI1svxWtfHr5aKd45bJyhIg/3tnercJoa81s7fBH7JdSv+hTE4VGSF
         iOwaA4JP/tchG1x0+JM++HcH7Xcl7rXvCjninqm/+XuKs8HTIB28LmaD9iByTCNPexpK
         +Q1nv+ywx9juel+Be5nYsksvVuqMNjRbM61Ex+3FJ41urH0gRxPBzex8mogz2wRFHx3P
         lwbEDRkT0LCu14h9AmFtzmkegwUvnXx5i0dorq73IC/Ih8hVlTvEd8ovlnlEmWbd+HFE
         lEA39hMGfrCimwv3pxsqJ+TDSjjNw+xLDkg/mxE/NSFUHQvq72N4OJejZrhGBklpG4nu
         0DFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LJiOEAEBZC+l+oJpSctCywiviwo13FyKsbge1YLqx/c=;
        b=TnovCb4Odaqwg2C+MU8ax9OmqUF5L/1NtlnUxL8L2Og8wN9HltewyzRLmRTvb7WXmG
         OR1jvzzBPEzYH22xenG/iiwbnNYEGyR6m58CLnclrlNOVt4NC1RfS031KJiqtLBWlGx6
         +cC4fAXBpZqaO6AJjb7gI/LJrX5t1kwZ+OFLygvYJTUMa1A5BjkipiYh0IrJjXE6kEan
         S6aGXlWXplGllMg1jKxSL0TUVRyk1EGqSuLZoWGVA317Q+y/UQdy7ow72rseL5z1WCNF
         jQQU/PjCnIPCwEqUOGihO8qjYzHdFlIcTVhvyUFbjrMKHCmgdfB3sGI7TRQUm2DMc4bE
         WJLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Date: Wed, 21 Mar 2018 04:59:31 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180321035931.GB28953@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308133331.19464-6-niklas.cassel@axis.com>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376627258900258?=
X-GMAIL-MSGID: =?utf-8?q?1595518247518969974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Greg,

Lorenzo	is fine with this series
( https://marc.info/?l=linux-kernel&m=152147837619191&w=2 )

However, he wants your ack on this patch before merging.

Could you please have a look at this patch?


Kind regards,
Niklas


On Thu, Mar 08, 2018 at 02:33:30PM +0100, Niklas Cassel wrote:
> A 64-bit BAR consists of a BAR pair, where the second BAR has the
> upper bits, so we cannot simply call pci_ioremap_bar() on every single
> BAR index.
> 
> The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
> flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
> resource flag set.
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
>  drivers/misc/pci_endpoint_test.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 320276f42653..fe8897e64635 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -534,12 +534,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> -		base = pci_ioremap_bar(pdev, bar);
> -		if (!base) {
> -			dev_err(dev, "failed to read BAR%d\n", bar);
> -			WARN_ON(bar == test_reg_bar);
> +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> +			base = pci_ioremap_bar(pdev, bar);
> +			if (!base) {
> +				dev_err(dev, "failed to read BAR%d\n", bar);
> +				WARN_ON(bar == test_reg_bar);
> +			}
> +			test->bar[bar] = base;
>  		}
> -		test->bar[bar] = base;
>  	}
>  
>  	test->base = test->bar[test_reg_bar];
> -- 
> 2.14.2
> 
