Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63151ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1147B20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VQBH0tVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1147B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeIXV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:57:54 -0400
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:41732 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728312AbeIXV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1537804504;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=jkm4O9apag7jq/yOWRqDujn9+uZfKY5xgF95ikWDcns=;
        b=VQBH0tVAFaTb8pQrkQu+8T2iSBwpYnGq4Cdot+TeM3tVoeImH4HPQUQus7Ove9Tc
        3PGFMXrBYenuab/zD+35KwtsAx+kReJ3iXEu4a+o+u7eRMTPqqJg4GHloWqi5wWmuc+
        Xt2jVMbKZqWaMWEbeCtG81Gy1/ykBJzLAcQWsmgY=
Date:   Mon, 24 Sep 2018 15:55:04 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
In-Reply-To: <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
Message-ID: <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com> <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.24-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Dmitry Vyukov wrote:

> On Mon, Sep 24, 2018 at 5:08 PM, Christopher Lameter <cl@linux.com> wrote:
> > On Sun, 23 Sep 2018, Dmitry Vyukov wrote:
> >
> >> What was the motivation behind that WARNING about large allocations in
> >> kmalloc? Why do we want to know about them? Is the general policy that
> >> kmalloc calls with potentially large size requests need to use NOWARN?
> >> If this WARNING still considered useful? Or we should change it to
> >> pr_err?
> >
> > In general large allocs should be satisfied by the page allocator. The
> > slab allocators are used for allocating and managing small objects. The
> > page allocator has mechanisms to deal with large objects (compound pages,
> > multiple page sized allocs etc).
>
> I am asking more about the status of this warning. If it fires in
> input_mt_init_slots(), does it mean that input_mt_init_slots() needs
> to be fixed? If not, then we need to change this warning to something
> else.

Hmmm.. kmalloc falls back to the page allocator already?

See

static __always_inline void *kmalloc(size_t size, gfp_t flags)
{
        if (__builtin_constant_p(size)) {
                if (size > KMALLOC_MAX_CACHE_SIZE)
                        return kmalloc_large(size, flags);


Note that this uses KMALLOC_MAX_CACHE_SIZE which should be smaller than
KMALLOC_MAX_SIZE.


How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
are larger than the maximum allowed by the page allocator. Thus the warning
and the NULL return.

