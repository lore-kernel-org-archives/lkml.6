Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D86FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B7220866
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547683808;
	bh=MFxsYUng8SebaN97J3RA5nlKB2oMATKqK62CL+6gVag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pnJMcFw3y0ZP+WrHOuBeFiFKlIaTdpPX7Fv7dbJ+eoVL2RSGnhaIWyEid2ggAwuLi
	 iCvFPy63WGyAjHhUnDvOYedakickgUlhqMsLVJzuKIVGyYU6wdMovxpPKpqLb9HzeS
	 6ScDD6f2z7Qt5pSJeElS2Pb+qwRLG/LRWuR4/Tw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfAQAKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfAQAKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:10:05 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127A120866
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547683805;
        bh=MFxsYUng8SebaN97J3RA5nlKB2oMATKqK62CL+6gVag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kzHLYyMRVdQI5UJHHd5c0F5Pao9V4HZRVs8JfYrhcrV/VdsVSTHma6pnOxBI2oZL0
         s//ilvyNW+BvFD37z+ceF7Y1gIXRM3g3PYJn89JyqU4Sc1MH9VXr1OoTbxin9GAljV
         bw+wT16K7HfhWlFX7az2FpypQIjn6HX6DgbTAud8=
Received: by mail-wr1-f54.google.com with SMTP id r10so8976500wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:10:05 -0800 (PST)
X-Gm-Message-State: AJcUukcqAEjgahmvUlHcSRR7WVVUp3UN4ZDKwkMcGG6GsjzENr2KdnIh
        9JcmISbhcii7GHB5SPNh83lAJKNsE4lb9bTtJ+Zg3Q==
X-Google-Smtp-Source: ALg8bN5pU1+oh8LfBN+jn1PSpQVxTaG72rcDXj+9lWq4R/8E/eI7u4Agn2JZ5ZOYfG2kOPaEXRnilMt9WvCmDXJ/Pn4=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr9145353wri.199.1547683803556;
 Wed, 16 Jan 2019 16:10:03 -0800 (PST)
MIME-Version: 1.0
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
 <5AF03EBD02000000000F91D6@prv1-mh.provo.novell.com> <5AF03EBD02000078001FE590@prv1-mh.provo.novell.com>
 <5C3E1128020000780020DFAD@prv1-mh.provo.novell.com>
In-Reply-To: <5C3E1128020000780020DFAD@prv1-mh.provo.novell.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Jan 2019 16:09:52 -0800
X-Gmail-Original-Message-ID: <CALCETrXhDXbi7q6w7EkaT7=9P90kUuivQhz3B0HtoBapFgjkuA@mail.gmail.com>
Message-ID: <CALCETrXhDXbi7q6w7EkaT7=9P90kUuivQhz3B0HtoBapFgjkuA@mail.gmail.com>
Subject: Re: [PATCH v3] x86-64/Xen: fix stack switching
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 8:58 AM Jan Beulich <JBeulich@suse.com> wrote:
>
> While in the native case entry into the kernel happens on the trampoline
> stack, PV Xen kernels get entered with the current thread stack right
> away. Hence source and destination stacks are identical in that case,
> and special care is needed.
>
> Other than in sync_regs() the copying done on the INT80 path isn't
> NMI / #MC safe, as either of these events occurring in the middle of the
> stack copying would clobber data on the (source) stack.
>
> I'm not altering the similar code in interrupt_entry() and nmi(), as
> those code paths are unreachable afaict when running PV Xen guests.


Acked-by: Andy Lutomirski <luto@kernel.org>
