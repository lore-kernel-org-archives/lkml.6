Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF02A20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfA3VHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:07:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3VHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:07:41 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gox53-0005ka-Vm; Wed, 30 Jan 2019 22:07:34 +0100
Date:   Wed, 30 Jan 2019 22:07:33 +0100
From:   Sebastian Sewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
References: <20190129132303.GE26906@osiris>
 <20190129151058.GG26906@osiris>
 <20190129171653.ycl64psq2liy5o5c@linutronix.de>
 <20190130094913.GC5299@osiris>
 <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
 <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 18:56:54 [+0100], Thomas Gleixner wrote:
> TBH, no clue. Below are some more traceprintks which hopefully shed some
> light on that mystery. See kernel/futex.c line 30  ...

The robust list it somehow buggy. In the last trace we had the
handle_futex_death() of uaddr 3ff9e880140 as the last action. That means
it was an entry in 56496's ->list_op_pending entry. This makes sense
because it tried to acquire the lock, failed, got killed.

According to uaddr pid 56956 is the owner. So 56956 invoked one of
pthread_mutex_lock() / pthread_mutex_timedlock() /
pthread_mutex_trylock() and should have obtained the lock in userland.
Depending on where it got killed, that mutex should be either recorded
in ->list_op_pending or the robust_list (or both if it didn't clear
->list_op_pending yet). But it is not.
Similar for pthread_mutex_unlock().
We don't have a trace_point if we abort processing the list.
On the other hand, it didn't trigger on x86 for hours. Could the atomic
ops be the culprit?

> Thanks,
> 
> 	tglx

Sebastian
