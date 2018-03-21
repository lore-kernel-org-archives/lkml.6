Return-Path: <luc.vanoostenryck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521653327; cv=none;
        d=google.com; s=arc-20160816;
        b=ZMpqvEDpydCR1HhRu5+SczF88TYtZO8hkT0PcWtZgFHe0/9lFUr/BJMPS0F8UFEHfQ
         MXee4Y8qmmh9QfVhzGnxPEVZ/gFh/n+4okzsVyjvA25UD4U8QFUCSZc7oEd4NxHTGXgq
         ieKftmbys968doSrCb2m0uYLVl1o7dzBhEE7w04/OMlZbdfJl71HuVZ4LE7x5ypgHQj7
         wwP8L4Stoc5l32Wwmftjsfo3AtqY4BajHuCquSrx4mUtYeb98Hx9/IaIq/X7U2SGsOte
         fCB3YGyGzWRBOeHzaB53cpYxhyddF6ZtRFSBlywQOkUJCHhb4Sih3uSPQSnlwihh4584
         qCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=e9yh75WYwu1u2RxH34yfjdtqVWKOzZOlxgi6bDPR47g=;
        b=0ijI/Zc1xcm3TpFbcV9V1cAG3jthS+NnzpneJRXgNqL3dpsXOVVSbq3WvSo+9EdVSi
         DgLFchpjBtdnmptUf7JRHt3ct/Zz8n/SADg/9QhfUm5gnLo55Yolq7S/k9S0jj3ZBdx/
         Mic1k0c+LHugXGKZMjeWv0CMWdXYcj10c/YxK6TZc+DIUZcPsqA01vbvglX6rG2MJQ3n
         xPXjT/KneaJKEMNVOnzJnjvpMlkmIFckjVRDI4bfvyIh15CB7ymobwBBERv9VBd2ACL1
         suSKhQoAcgZ9FM6rn9MXx9BwNhVDEF4/ghPmpsNJRyfnHScbEUzdUASDS2cr/5IvcA0d
         zyoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YbDKL9AQ;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YbDKL9AQ;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtZrttiC3paZBxfkcCwgodm92isH12Nq9pa//OKBCPd9Rc7J6Y8uqInEUJmLgBqlJI8j8by8w==
Date: Wed, 21 Mar 2018 18:28:44 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
Message-ID: <20180321172843.p6srgiouvhcyyo4s@ltop.local>
References: <20180321163745.12286-1-logang@deltatee.com>
 <20180321163745.12286-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321163745.12286-2-logang@deltatee.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565968042571455?=
X-GMAIL-MSGID: =?utf-8?q?1595569159584336630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:37:36AM -0600, Logan Gunthorpe wrote:
> The semantics of the iowriteXXbe() functions are to write a
> value in CPU endianess to an IO register that is known by the
> caller to be in Big Endian. The mmio_writeXXbe() macro, which
> is called by iowriteXXbe(), should therefore use cpu_to_beXX()
> instead of beXX_to_cpu().
> 
> Seeing both beXX_to_cpu() and cpu_to_beXX() are both functionally
> implemented as either null operations or swabXX operations there
> was no noticable bug here. But it is confusing for both developers
> and code analysis tools alike.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  lib/iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/iomap.c b/lib/iomap.c
> index 541d926da95e..be120c13d6cc 100644
> --- a/lib/iomap.c
> +++ b/lib/iomap.c
> @@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
>  #endif
>  
>  #ifndef mmio_write16be
> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
> +#define mmio_write16be(val,port) __raw_writew(cpu_to_be16(val),port)
> +#define mmio_write32be(val,port) __raw_writel(cpu_to_be32(val),port)
>  #endif
>  
>  void iowrite8(u8 val, void __iomem *addr)
> -- 
> 2.11.0
> 

LGTM, feel free to add my
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
