Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800202145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeLQLgu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:36:50 -0500
Received: from ozlabs.org ([203.11.71.1]:39931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbeLQLgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:36:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JJyl4Hyhz9sD4;
        Mon, 17 Dec 2018 22:36:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: make NULL pointer deferences explicit on bad page faults.
In-Reply-To: <276439ce-aad9-e72f-7bc9-c57fb4a59339@c-s.fr>
References: <42e7e2e9b74af526523fb5a1451fdb29cfe2687a.1539060806.git.christophe.leroy@c-s.fr> <87zht9udqh.fsf@concordia.ellerman.id.au> <276439ce-aad9-e72f-7bc9-c57fb4a59339@c-s.fr>
Date:   Mon, 17 Dec 2018 22:36:42 +1100
Message-ID: <87va3stmet.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Hi Michael,
>
> Le 14/12/2018 à 01:57, Michael Ellerman a écrit :
>> Hi Christophe,
>> 
>> You know it's the trivial patches that are going to get lots of review
>> comments :)
>
> I'm so happy to get comments.

Haha :)

>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> As several other arches including x86, this patch makes it explicit
>>> that a bad page fault is a NULL pointer dereference when the fault
>>> address is lower than PAGE_SIZE
>> 
>> I'm being pedantic, but it's not necessarily a NULL pointer dereference.
>> It might just be a direct access to a low address, eg:
>> 
>>   char *p = 0x100;
>>   *p = 0;
>> 
>> That's not a NULL pointer dereference.
>> 
>> But other arches do print this so I guess it's OK to add, and in most
>> cases it will be an actual NULL pointer dereference.
>> 
>> I wonder though if we should use 4096 rather than PAGE_SIZE, given
>> that's the actual value other arches are using. We support 256K pages on
>> some systems, which is getting quite large.
>
> Those invalid accesses are catched because the first page is marked non 
> present or non accessible in the page table, so I thing using PAGE_SIZE 
> here is valid regardless of the page size.

It's not a question of whether we catch the fault it's what we print
when we catch it. Most of the time on 64-bit the first few GB of the
page tables will be empty, so those will all fault, but we don't call
them NULL pointer deferences.

So I'm just saying that this is a heuristic, ie. an access close to zero
is probably an access at a small offset from a NULL pointer, but it may
not be. And so it's kind of arbitrary where we decide to make the cut
off point between printing that it's a NULL pointer vs a regularly bad
access.

Anyway I'm happy to use PAGE_SHIFT for now, if anyone complains we can
always change it.

>> What about:
>> 
>>    BUG: Unable to handle kernel instruction fetch at 0x00000000
>
> I think we still need to make it explicit that we jumped there due to a 
> NULL function pointer, allthought I don't have a good text idea yet for 
> this.

Being pedantic again, we don't know that it was a NULL function pointer.
You might have done a bad setcontext and set your NIP to zero.

But it's probably fine to print it as a hint, and it's probably right
most of the time.

cheers
