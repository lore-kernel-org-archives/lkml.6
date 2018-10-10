Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D720C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F6A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F6A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJJRPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:15:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45069 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:15:11 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gABBX-0004zk-Dl; Wed, 10 Oct 2018 11:53:43 +0200
Date:   Wed, 10 Oct 2018 11:53:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
Message-ID: <20181010095343.6qxved3owi6yokoa@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com>
 <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de>
 <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
 <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de>
 <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 11:45:32 [+0200], Dmitry Vyukov wrote:
> > Should I repost Clark's patch?
> 
> 
> I am much more comfortable with just changing the type of the lock.

Yes, that is what Clark's patch does. Should I resent it?

> What are the bad implications of using the raw spinlock? Will it help
> to do something along the following lines:
> 
> // Because of ...
> #if CONFIG_RT
> #define quarantine_spinlock_t raw_spinlock_t
> #else
> #define quarantine_spinlock_t spinlock_t
> #endif

no. For !RT spinlock_t and raw_spinlock_t are the same. For RT
spinlock_t does not disable interrupts or preemption while
raw_spinlock_t does.
Therefore holding a raw_spinlock_t might increase your latency.

Sebastian
