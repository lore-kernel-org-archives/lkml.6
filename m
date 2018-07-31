Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0EDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED3F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeGaLME convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:12:04 -0400
Received: from ozlabs.org ([203.11.71.1]:51037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbeGaLME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:12:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41frnX2c5Fz9rxx;
        Tue, 31 Jul 2018 19:32:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org,
        Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
In-Reply-To: <20180730231738.GA20351@kermit-br-ibm-com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com> <20180727145811.12334-5-muriloo@linux.ibm.com> <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr> <20180730152838.GA23704@kermit-br-ibm-com> <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr> <20180730231738.GA20351@kermit-br-ibm-com>
Date:   Tue, 31 Jul 2018 19:32:28 +1000
Message-ID: <87va8vhhsj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> On Mon, Jul 30, 2018 at 06:30:47PM +0200, LEROY Christophe wrote:
>> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>> > On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
>> > > Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>> > >
>> > > > Simplify the message format by using REG_FMT as the register format.  This
>> > > > avoids having two different formats and avoids checking for MSR_64BIT.
>> > >
>> > > Are you sure it is what we want ?
>> >
>> > Yes.
>> >
>> > > Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?
>> >
>> > In fact, this changes how many zeroes are prefixed when displaying the
>> > registers
>> > (%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kernel:
>>
>> Indeed that's what I suspected. What is the real benefit of this change ?
>> Why not keep the current format for 32bits userspace ? All those leading
>> zeroes are pointless to me.
>
> One of the benefits is simplifying the code by removing some checks.  Another is
> deduplicating almost identical format strings in favor of a unified one.
>
> After reading Joe's comment [1], %px seems to be the format we're looking for.
> An extract from Documentation/core-api/printk-formats.rst:
>
>   "%px is functionally equivalent to %lx (or %lu). %px is preferred because it
>   is more uniquely grep'able."
>
> So I guess we don't need to worry about the format (%016lx vs. %08lx), let's
> just use %px, as per the guideline.

I don't think I like %px.

It makes the format string cleaner, but it means we have to cast
everything to void * which is ugly as heck.

I actually don't think the leading zeroes are helpful at all in the
signal message, ie. we should just use %lx there.

They are useful in show_regs() because we want everything to line up.

So I think I'll drop patch 3 and use 0x%lx in show_signal_msg(), meaning
we end up with, eg:

  [   73.414535] segv[3759]: segfault (11) at 0x0 nip 0x10000420 lr 0xfe61854 code 0x1 in segv[10000000+10000]
  [   73.414641] segv[3759]: code: 4e800421 80010014 38210010 7c0803a6 4bffff30 9421ffd0 93e1002c 7c3f0b78
  [   73.414665] segv[3759]: code: 39200000 913f001c 813f001c 39400001 <91490000> 39200000 7d234b78 397f0030


I'll do that unless anyone screams loudly, because it would be nice to
get this into 4.19.

cheers
