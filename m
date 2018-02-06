Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517930207; cv=none;
        d=google.com; s=arc-20160816;
        b=lqy9YhTfoJQ64frJENa7LfqMsLjrtdMVyVKzxCu/9cA7ebGMujdF665Zfx63NhSCQy
         ptw32FZPsKJdYmYeXnPtH5A5CqVK9eKMtFuIrNBZbC5EHPCCvarM+J2bs3k7rxr2/Txm
         4zl0N1ucSMcg50s3/cCNgtFJFnnoccqLspktmTDql0cO3w1xxqA0f0lIVLG8FyGbCYuF
         rirPkv7JZLri6dkd4xEko4MLybZJKgeWb+fIK5mDrqof15YNpE0Z2tAezTqzokqJKBgX
         8NYHix9/aglPFRk+RqpZI4+kWKIdKy6f1MCFdKt/1I1Lf8ndd48wDKvILAKAJVdF8WJe
         IkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gDMw3uglua2uMU7ChquCidQK0m7dCXIQE2xdkjovDCg=;
        b=ykFyWA2qOH1D5tAJd/YrE+kSRKhELCWGa3lxbgjpJYFL6y9uGimCbw3uOGKUqnrSWi
         MyFPy5h27KBWNtfsdAfVsDvaGsjIgivCAmVU8XpoG5BUhSP1xJ/O09+USAOcFHP5XJpU
         PB7WoTqDyXABvFv14oI6ICfLcVyykuZgsxURZgCb18ahlXhHHrMr1HPa/JU6bQZVhNUh
         bIKNDtsNGpUIQhv6uURsq3zvh9DMchR0rq1IZxoekR6gm1W0Z5Li1Rrce2rvWqLnryuB
         kGFWtsXGRkYuDWDi25j6qXqvlDAEYCFZ9lonXuKPbCWvlhCxyC6+NAYxriaiajeu42co
         KyCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fq5zn83A;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fq5zn83A;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x224OZlaoY5pQDkioYExaEbjBvEh/On2qP2MCfNyu757OwsPQjkUGuM1gcGEY1DgxumUUp96BgcLSo6idMMLExSU=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 16:16:47 +0100
X-Google-Sender-Auth: YmjWPGkRYPEHoPlncuWvrKsePdA
Message-ID: <CAK8P3a2rW8-3QNnKyw9tBenYfd+AWXT2KH16N+g=+eLzHLd2WA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
	Richard Weinberger <richard@nod.at>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, linux-usb@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591646200835555929?=
X-GMAIL-MSGID: =?utf-8?q?1591665185741411199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 11:14 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>         Hi all,
>
> If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
> symbol bad_dma_ops, thus causing a link failure if it is ever used.
>
> The intention of this is twofold:
>   1. To catch users of the DMA API on systems that do no support the DMA
>      mapping API,
>   2. To avoid building drivers that cannot work on such systems anyway.
>
> However, the disadvantage is that we have to keep on adding dependencies
> on HAS_DMA all over the place.
>
> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
> already covering intention #2.  Having to add an explicit dependency on
> HAS_DMA here is cumbersome, and hinders compile-testing.
>
> Hence I think the time is ripe to reconsider the link failure.
> This patch series:
>   - Changes get_dma_ops() to return NULL instead,
>   - Adds a few more dummies to enable compile-testing,
>   - Removes dependencies on HAS_DMA for symbols that already have
>     platform dependencies implying HAS_DMA.
>
> Note that adding more platform dependencies and/or dependencies on
> COMPILE_TEST is encouraged!
>
> This may make life harder for UML, though, as UML usually satisfies all
> other platform dependencies for HAS_DMA.  Similarly, HAS_IOMEM is even
> more complicated.  Can/do we want to do something similar for
> HAS_IOMEM?
>
> This series is against my current local tree, which has a few more
> "depends on HAS_DMA" than upstream.  Of course I will rebase, and split
> the last patch per subsystem, if this RFC is welcomed positively.
>
> Compile-tested with allmodconfig and allyesconfig for m68k/sun3.

David Woodhouse has been looking at some other structures with indirect
pointers (kvm_x86_ops) to reduce the overhead that was added for
avoiding speculative execution of those pointers. I wonder if there are
any dma_map_ops operations that are in a fastpath that needs a similar
optimization. If yes, we might want to think about how to do that part
first to avoid rewriting the same code more than once.

Otherwise, your approach seems fine.

       Arnd
