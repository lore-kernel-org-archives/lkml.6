Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA535C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D499255E9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuhjUedT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D499255E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965971AbeGARVI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:21:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33775 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGARVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:21:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so6809868plb.0;
        Sun, 01 Jul 2018 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NY1ds3aJ+on14vDM8qa23ezal1wregqGhAvkHc6rFMA=;
        b=XuhjUedT1UKtzYoiVZgD8kT1wQF8K32hgxhMIRPeqQPdpYBfDkmhdkBC66FfWhjhSs
         rvwuqUAW5iZSk0BOjhItYLy5HIJUCKCmnswmZ1MWbidYLBSWaB9RHU7fT2sBeOIuN/2m
         BEF1YGM+MWjq8i6NAa2hg8QXXpwLYcsbjUNbVFWuw+uk+q7EUSvMQU1t+pukrv13wwIF
         gHqqpHcRehOjfLG2G7FHwVlMO886It1FX0MShPtl4md4tQ+sHdYsUah2K2zKg0dlTbLh
         i9qHCwsmiWBVIqTESPFoqpUGFHqnEm0+hBAvw0qHBrBR5PkaRxnOk65Eilb5Uob9u427
         jtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NY1ds3aJ+on14vDM8qa23ezal1wregqGhAvkHc6rFMA=;
        b=kaE/eMmZoPzgycE79UghrWpqCxG1D8Ol9NHqRVzriYHalJa+IrPh0VO43/JOxqMmZf
         1cv3Vh9WRq7iKTlW36LYkPnBikUeL3cCpEdZpzpzl3wyL5kpjrtwVHoJCAN6/lsnZ3F/
         IayoCFvwxnUH3v86HIQ2KPHKlC10pUSHbCWr22G87a9u7GbSEcAGqOlMa+ct6sUq9ol0
         cFNRS7NFxZp2BZwfi6DBJtDiutAy/TXUt/bHYxShhIvhNZMss+nf2q+IBlS5gstK58MP
         Htj5FV4GLbBWsnCTyHxvRL+560Iczyn4ehuIYifhknF3jBmlKo6B3APl6cYV+cBeJDAq
         yzqQ==
X-Gm-Message-State: APt69E1j9qSyWN9Er0ygDxvU4LGXEVkXOaQcBNt5+BV+OJUsBx6N4PBF
        aYHp15kZs4W51uRqQZ8q9MI=
X-Google-Smtp-Source: AAOMgpe7oh5x/SimbbMYzfsOmHT6xR8Qg5v6FoJ0AnEqa7xk/lUylD3v7VfHFGg+oGqfGzyNrM6vkg==
X-Received: by 2002:a17:902:8f86:: with SMTP id z6-v6mr18283615plo.38.1530465661484;
        Sun, 01 Jul 2018 10:21:01 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id 14-v6sm27794127pft.10.2018.07.01.10.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 10:21:00 -0700 (PDT)
Date:   Sun, 1 Jul 2018 10:20:58 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [dm-devel] [PATCH v3 9/9] crypto: shash: Remove VLA usage in
 unaligned hashing
Message-ID: <20180701172058.GA26715@sol.localdomain>
References: <20180629002843.31095-1-keescook@chromium.org>
 <20180629002843.31095-10-keescook@chromium.org>
 <20180630070301.GA1706@sol.localdomain>
 <CAGXu5jJ9eqETPdrvUZrV9bhnNQA6LwBuk+V5MeQrAS_M=_VX+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ9eqETPdrvUZrV9bhnNQA6LwBuk+V5MeQrAS_M=_VX+Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 10:04:59AM -0700, Kees Cook wrote:
> On Sat, Jun 30, 2018 at 12:03 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Thu, Jun 28, 2018 at 05:28:43PM -0700, Kees Cook wrote:
> >> @@ -88,11 +81,13 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
> >>       unsigned long alignmask = crypto_shash_alignmask(tfm);
> >>       unsigned int unaligned_len = alignmask + 1 -
> >>                                    ((unsigned long)data & alignmask);
> >> -     u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
> >> -             __aligned_largest;
> >> +     u8 ubuf[MAX_ALGAPI_ALIGNMASK + 1];
> >>       u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
> >>       int err;
> >>
> >> +     if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
> >> +             return -EINVAL;
> >> +
> >
> > How is 'ubuf' guaranteed to be large enough?  You removed the __aligned
> > attribute, so 'ubuf' can have any alignment.  So the aligned pointer 'buf' may
> > be as high as '&ubuf[alignmask]'.  Then, up to 'alignmask' bytes of data will be
> > copied into 'buf'... resulting in up to '2 * alignmask' bytes needed in 'ubuf'.
> > But you've only guaranteed 'alignmask + 1' bytes.
> 
> Hm, good point. Adding __aligned(MAX_ALGAPI_ALIGNMASK + 1) looks to
> fix this, yes?
> 
> Also, if __aligned() is used here, can't PTR_ALIGN() be dropped? (I
> think you pointed this out earlier.)

Sure, I'm just not sure whether __aligned() with such a large alignment is
guaranteed to work on stack variables on all architectures.  See e.g.
https://patchwork.kernel.org/patch/9507697/.

> 
> Also, is "unaligned_len" being calculated correctly? Let's say
> alignmask is 63. If data is binary ...111111, then unaligned_len will
> be 64 - 63 == 1, which is fine: we copy 1 byte out, bump the address
> by 1, and we're happily aligned to ...000000. If data is ...000000,
> then unaligned_len will be 64. But it should be 0. Shouldn't this be:
> 
> unsigned int unaligned_len;
> 
> unaligned_len = (unsigned long)data & alignmask;
> if (unaligned_len)
>     unaligned_len = alignmask + 1 - unaligned_len;
> 
> And then ubuf only needs to be MAX_ALGAPI_ALIGNMASK, without the +1?

shash_update_unaligned() is only called when 'data & alignmask'.
Similarly with shash_final_unaligned().

Though, calculating 'unaligned_len' could be simplified to

	unsigned int unaligned_len = -(unsigned long)data & alignmask;

which works either way.

- Eric
