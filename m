Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B2DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DAA20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba4j0j//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DAA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392096AbeKVPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:42:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38781 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKVPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:42:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so8650424plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGD6LGfuEJSdi8k7OSAd3byEYzU7bXmiZ3zREoW/Ui4=;
        b=Ba4j0j//C/DOG6Avd6Dgg0WQs2crOOrEKlhTOyH13pdvd76JjRvgzGf1p9wkkMqTAA
         Vp85a5Y0siLRaopIK9XZvLx2LnMNLrJdMMoDcXUWVVnNayFKZfe8+MFHi6b+pOhrqVIe
         0ISjoZ1wb1nRLdMekEzzx2VzAjK3xdD5jdn7xu3J4thbuiJY8cQ8U6ju8sA84syDO+/E
         z5gqDhVimnl+VL5Pm6UQFfdiJFc2Z0xmts+6zzjkY+IOVl92xQOmSwnzBnHjQ/h7u8vX
         YwQPKyoGz1/L66zeP8tI27icmtOUY1dVedxy1o56zveVdt+t9zoc94SfolgcnQTW14K+
         o5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGD6LGfuEJSdi8k7OSAd3byEYzU7bXmiZ3zREoW/Ui4=;
        b=byjPc/SKXaLJMRQKEofv7ClKlEYLa0io2jhgGla1JXhLSQUlRaaMHeFTjpzfi2fHmI
         Yai5pyUX92oGCBkoXBS4tGlMuFC4utGiiQxC2k3958CpwBrFaNu7ssQoxDu+diho5KPD
         tjoJlvSeTWaIgkicovG1pCJUotNLjFhxG09R65ZElVUBpmw6fNLv5iSC+kM2rA/IPFZJ
         WyT1rR/Q7pjrmbixpFLJMlpNx7vNQ+guHZp6IDAfRAhJy1MDTDzBDs9u6lVsnjHu296x
         QZ59eP9F9HCfl/aZGD0hWg7TICai+Nv9spxHJFiRP9NGHfbw9nKBLLUiAfLteVtM+RUW
         dZ9A==
X-Gm-Message-State: AA+aEWaTTP4JvfGhtD+PfcJ3v6jePzLvoCAVdnVDpt9xfGDRC9CGbbtN
        7gWznSWpvxMvt1rhftKjx7QEZhCJ6RI=
X-Google-Smtp-Source: AFSGD/Uh2EP4ehbYg6ZH4wOqg5d9smFi+sPlaUG993FxfoXsTYVe/d22PCCOKqGbElLi/YzDzn1utg==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr8594456pgc.200.1542863082423;
        Wed, 21 Nov 2018 21:04:42 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id g190sm49239029pgc.28.2018.11.21.21.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 21:04:41 -0800 (PST)
Date:   Thu, 22 Nov 2018 14:04:37 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181122050437.GA182024@google.com>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
 <20181122021442.GB3441@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122021442.GB3441@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:14:43AM +0900, Sergey Senozhatsky wrote:
> On (11/21/18 05:34), Minchan Kim wrote:
> > > 
> > > Just a thought,
> > > 
> > > I wonder if it will make sense (and if it will be possible) to writeback
> > > idle _compressed_ objects. Right now we decompress, say, a perfectly
> > > fine 400-byte compressed object to a PAGE_SIZE-d object and then push
> > > it to the WB device. In this particular case it has a x10 bigger IO
> > > pressure on flash. If we can write/read compressed object then we
> > > will write and read 400-bytes, instead of PAGE_SIZE.
> > 
> > Although it has pros/cons, that's the my final goal although it would
> > add much complicated stuffs. Sometime, we should have the feature.
> 
> So you plan to switch to "compressed objects" writeback?

No switch. I want both finally. There are pros and cons.
Compressible write would be good for wearout of flash device(that's I want
to have it) but it has several read of a block(since the block has several
zpage) and decompression latency as well as complicated logic of management
of block. That's the unnecessary thing If backing device or system doesn't
have wearout concern.

> 
> > However, I want to go simple one first which is very valuable, too.
> 
> Flash wearout is a serious problem; maybe less of a problem on smart
> phones, but much bigger on TVs and on other embedded devices that have
> lifespans of 5+ years. With "writeback idle compressed" we can remove

Yub, It's a serious. That's why my patchset has writeback limitation,
stats as well as idle marking to help the system design.

> the existing "writeback incompressible pages" and writeback only
> "idle, compressed" pages.
> 
> The existing incompressible writeback is way too aggressive, and,

Do not agree. It depends on the system design.
Think idle page writeback. Once a day, you write out idle pages.
As a inital stage, you could write every idle pages into the storage.
it could be several hundred MB and next day? there is few MB write
because every idle pages were stored yesterday.
Even, we have a write_limit. You could estimate how per-day write
can demage your system. Your daemon can see one a day and decide
further write or not.

> additionally, it's too simple. It writes-back pages which can be
> swapped in immediately; which basically means that we do pointless
> PAGE_SIZE writes to a device which doesn't really like pointless
> writes.

This patchset aims for *IDLE page* writeback and you can define
what is IDLE page by yourself. It doesn't do pointless writeback.

> 
> It's a whole different story with idle, compressible pages writeback.

I don't understand your point.

> 
> 	-ss
