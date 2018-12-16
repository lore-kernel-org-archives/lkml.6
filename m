Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A04C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFBB21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544986776;
	bh=iEh2czqkRKQxKSmj42FERBP8dXMhD2BdHqh9k8fmnhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cIP1E+4nXRemKbuHRUMBH+LSSQyvohttIbTgCChljTv2CFK3k3z9oUg0f34V9kX2o
	 Og9XzW2bh6rbaBCQWHKf/zX04iTyTNVwywaVtbMshutK2LiDJuBJ0immVaCGYm897R
	 TiUzWS/8VBoLc4xl6g0q6VKm/Pjuk5qqP3Yui0M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbeLPS7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbeLPS7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:59:34 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9195A21842
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 18:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544986773;
        bh=iEh2czqkRKQxKSmj42FERBP8dXMhD2BdHqh9k8fmnhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pnf1Qqlz7p3DreCSow9XsJInT7KL2AH4BC4RJimruBizMY+21Ew66DRvWZuYZmQ6a
         iF92nLu+cAiCgrrqohN3Tu6qeNNrW66hiHNhyXTmunTCjla991+e8LjUxM2OWmg4pr
         B+lwB4gspEuJSUv7U5J7P3r6xDdz1ftcxvXo9zBc=
Received: by mail-wm1-f43.google.com with SMTP id y185so3106946wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 10:59:33 -0800 (PST)
X-Gm-Message-State: AA+aEWaPH6CtR3XYmOXmn7T7Q86qFuRr1pEd8bIiG+iFy8R0RSbB5/MF
        KQz8jXwUXs/SkUjFGRAIhFg3D3GE9qxqUhelXHcOFA==
X-Google-Smtp-Source: AFSGD/UO/YP0DBMKjdaBpudLiMwz6gWufOtCry40XHR9ndsedbVgFPzIMfgVEOxZsY1CgkkRNf6GzdWiBaCh3YqfkuE=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr8736220wmh.83.1544986771932;
 Sun, 16 Dec 2018 10:59:31 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181215225009.GB23599@brightrain.aerifal.cx> <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org>
 <20181216023259.GE23599@brightrain.aerifal.cx> <alpine.LFD.2.21.1812160319120.11202@eddie.linux-mips.org>
 <20181216181336.GG23599@brightrain.aerifal.cx>
In-Reply-To: <20181216181336.GG23599@brightrain.aerifal.cx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 16 Dec 2018 10:59:19 -0800
X-Gmail-Original-Message-ID: <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
Message-ID: <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
Subject: Re: Fixing MIPS delay slot emulation weakness?
To:     Rich Felker <dalias@libc.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:13 AM Rich Felker <dalias@libc.org> wrote:
>
> On Sun, Dec 16, 2018 at 01:50:13PM +0000, Maciej W. Rozycki wrote:
> > On Sat, 15 Dec 2018, Rich Felker wrote:
> >
> >
> >  It doesn't help that information about that is scattered across many
> > documents.  You can check for the NODS flag in the opcodes library from
> > binutils though, which is almost 100% accurate, except for the SYNC
> > instructions, for semantic reasons (i.e. they are allowed, but we don't
> > want GAS to reorder them).  Most of the disallowed stuff is in the
> > microMIPS instruction set, due to encodings that execute as hardware
> > macros.
>
> I think it suffices to emulate what compilers generate in delay slots,
> which should be fairly minimal and stable. At the very least we could
> enumerate everything GCC and LLVM already emit there, and get them to
> upstream a policy of not adding new insns as fpu-delay-slot-allowed.
> If someone is writing asm by hand to do ridiculous things in the delay
> slot with random ISA extensions, they shouldn't expect it to work.
>

I feel like I have to ask: the real thing preventing emulation is that
new nonstandard instructions might get used in FPU delay slots on
non-FPU-supporting hardware?  This seems utterly nuts.  If you're
using custom ISA extensions, why on Earth are you also using emulated
floating point instructions?  You're targetting a specific known CPU
if you do this, so you should use only instructions that actually work
on that CPU.
