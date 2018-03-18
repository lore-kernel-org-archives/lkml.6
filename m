Return-Path: <luc.vanoostenryck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521389611; cv=none;
        d=google.com; s=arc-20160816;
        b=lYk8V3oCfQU+h9x9H2FdfbMNuSuerkBL8P2LmGlbof+hMR3Kmou0KEeHg12x0BD3ss
         XjKfk+/AxiZAcJ6TQ5ofn5pU/MwKEWf1EpNQKNKsys8Iq7p4DSkciYvitUK2Fg68flJ1
         V++eOCdOA6ijwipw3WkQFX/8PYnN1PKOlJaVuRMEUBGsLcObGaAVbqKzTA7l2qrWOMc4
         bDJynYaqUK20U+II9xWVYFIIBALkvlpc7JJtgf+yXTqjWCaCdNAOwYy69sMxx8OMVwEp
         5Ms/gT+roc3Jhg1Pois3Kzl7iKy2NPKgdY5/KoVWk7u7lLTMMQCutTB3fbNzsRU2NTXC
         fF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=gXtqpedl4O3FChNYVf1kt7CAyyy5SD5kDx72yosEDrA=;
        b=mTsRhFMQpQfzZeBdHP/ObiS5l1JJEJuA8ovigKc/Flvg+RcGnuGeDGpbtI6a2uKbKt
         LuLukIuWvVffg5C1CkQbqc2VXrVjj3e2P7z1F8ZYNZomwOaPVrLT4fwGGdWMBtH7gnAe
         R+n/z+9mbOkkMVbVMXF+C9b1wJvIDRwF7ylhQNNpOBCmt2h9iQCYOqwAbRLAQCjwZc0k
         XGxXbHpdlX2Scj3APkRF+kH7pJQzqvdw0WctPfJG2XmKqXu9ogvAGWnuk3peoWqnw+BI
         i9kwTqtluitkl5v2K3IttQZQZfAfe5/gQeiJg3C6o8HjLKlnTJVqNeZ1+4h+bbbh31zo
         rv/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IEH4XJor;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IEH4XJor;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsX3AFCdz1qtao83deXAAqR8sSFXe48imbmeXmCXTbM0cD9uGCqt5nNakQvRGWm5g4ez+SdVg==
Date: Sun, 18 Mar 2018 17:13:27 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v12 1/9] iomap: Fix sparse endian check warnings
Message-ID: <20180317190311.tdmx2vlcjttsjs5j@ltop.local>
References: <20180316154852.13206-1-logang@deltatee.com>
 <20180316154852.13206-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316154852.13206-2-logang@deltatee.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109905747636881?=
X-GMAIL-MSGID: =?utf-8?q?1595292633277427088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 09:48:44AM -0600, Logan Gunthorpe wrote:
> Warnings of the form:
> 
> lib/iomap.c:84:9: warning: cast to restricted __be16
> 
> Are found when running sparse checker with:
> 
> make C=2 CF=-D__CHECK_ENDIAN__
> 
> This patch casts them with __force to suppress the warnings.
 
Hi,

it looks correct but if you should explain why the warning
is not a valid one. Once done, you can then explain what problem
you have fixed instead of saying you suppressed a warning.

> Also, it looks like the wrong conversion function was used in

I would suggest to split the patch in two since it does two
different things which should have their own explanation.

> diff --git a/lib/iomap.c b/lib/iomap.c
> index 541d926da95e..a05d9fa21794 100644
> --- a/lib/iomap.c
> +++ b/lib/iomap.c
> @@ -106,8 +106,10 @@ EXPORT_SYMBOL(ioread32be);
>  #endif
>  
>  #ifndef mmio_write16be
> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
> +#define mmio_write16be(val, port) \
> +	__raw_writew((u16 __force)cpu_to_be16(val), port)
> +#define mmio_write32be(val, port) \
> +	__raw_writel((u32 __force)cpu_to_be32(val), port)
>  #endif

I think that in this sort of replacement, it's better to not split
the lines (even if larger than 80, that's it).

-- Luc Van Oostenryck
