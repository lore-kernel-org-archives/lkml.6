Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37366C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D666A20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WbgbahD0";
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="eCSIkuGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D666A20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeGKKc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:32:59 -0400
Received: from forward104p.mail.yandex.net ([77.88.28.107]:54260 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbeGKKc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:32:59 -0400
X-Greylist: delayed 756 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2018 06:32:56 EDT
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id B3C52181BC3;
        Wed, 11 Jul 2018 13:14:57 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QIlY3WS5VM-Eu1G4nPP;
        Wed, 11 Jul 2018 13:14:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1531304097;
        bh=XCCe7vZc7GQyW/Uk20RcYER7XQFfgxW8goHDS9VObxA=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=WbgbahD0+vZJfY3jnRlpGa+xI1+WC81hJZdXBnPchpOduLhpn/jZRvMAZ+8rW8vpI
         KOxfFiGvAOvK9jE9PkbZQ6A4SsUnLCQRSLyy94R808f93VSpN5JhTiPtoU32YX/9dC
         9tEgueIFzhdbbd6/DnLpi4KmciYvZ7xscM/3BOHM=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fDNQFekDBA-EmhCeUUh;
        Wed, 11 Jul 2018 13:14:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1531304094;
        bh=XCCe7vZc7GQyW/Uk20RcYER7XQFfgxW8goHDS9VObxA=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=eCSIkuGGxcPhycRObxIrrwZk4lN1sPuTvO3aqvHXxpZvZefNyJllo4kHv+gkw4dh+
         RWbHVp4cBjBxmrYVpnHRPUW6P7P6Zs1xWkn2pgQKiQWB8D75meSOpG0ByfSFOICrVf
         XwXcAzmMoqMNG+zMQKj0C/EXrL2VcvzYeHMdgeRY=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@linux-mips.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Date:   Wed, 11 Jul 2018 18:05:51 +0800
Message-ID: <5471216.FKXZRxKFUI@flygoat-ry>
In-Reply-To: <20180710121727.GK2476@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com> <tencent_26F8B9E004D4512B2225FCE1@qq.com> <20180710121727.GK2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-7-10 Tue at 20:17:27=EF=BC=8CPeter Zijlstra Wrote=EF=BC=9A

Hi Peter
Since Huacai unable to send email via client, I'm going to reply for him=20
=20
> Sure.. we all got that far. And no, this isn't the _real_ problem. This
> is a manifestation of the problem.
>=20
> The problem is that your SFB is broken (per the Linux requirements). We
> require that stores will become visible. That is, they must not
> indefinitely (for whatever reason) stay in the store buffer.
>=20
> > I don't think this is a hardware bug, in design, SFB will flushed to
> > L1 cache in three cases:
> >=20
> > 1, data in SFB is full (be a complete cache line);
> > 2, there is a subsequent read access in the same cache line;
> > 3, a 'sync' instruction is executed.
>=20
> And I think this _is_ a hardware bug. You just designed the bug instead
> of it being by accident.
Yes, we understood that this hardware feature is not supported by LKML,
so it should be a hardware bug for LKML.
>=20
> It doesn't happen an _any_ other architecture except that dodgy
> ARM11MPCore part. Linux hard relies on stores to become available
> _eventually_.
>=20
> Still, even with the rules above, the best work-around is still the very
> same cpu_relax() hack.

As you say, SFB makes Loongson not fully SMP-coherent.
However, modify cpu_relax can solve the current problem,
but not so straight forward. On the other hand, providing a Loongson-specif=
ic=20
WRITE_ONCE looks more reasonable, because it the eliminate the "non-cohrenc=
y".
So we can solve the bug from the root.

Thanks.
=2D-
Jiaxun Yang


