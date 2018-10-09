Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F72FC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BC2213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BC2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIVpA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:45:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43621 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:44:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g9sz8-0005ij-Vn; Tue, 09 Oct 2018 16:27:43 +0200
Date:   Tue, 9 Oct 2018 16:27:42 +0200
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
Message-ID: <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com>
 <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de>
 <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-08 11:15:57 [+0200], Dmitry Vyukov wrote:
> Hi Sebastian,
Hi Dmitry,

> This seems to beak quarantine_remove_cache( ) in the sense that some
> object from the cache may still be in quarantine when
> quarantine_remove_cache() returns. When quarantine_remove_cache()
> returns all objects from the cache must be purged from quarantine.
> That srcu and irq trickery is there for a reason.

That loop should behave like your on_each_cpu() except it does not
involve the remote CPU.

> This code is also on hot path of kmallock/kfree, an additional
> lock/unlock per operation is expensive. Adding 2 locked RMW per
> kmalloc is not something that should be done only out of refactoring
> reasons.
But this is debug code anyway, right? And it is highly complex imho.
Well, maybe only for me after I looked at it for the first time…

> The original message from Clark mentions that the problem can be fixed
> by just changing type of spinlock. This looks like a better and
> simpler way to resolve the problem to me.

I usually prefer to avoid adding raw_locks everywhere if it can be
avoided. However given that this is debug code and a few additional us
shouldn't matter here, I have no problem with Clark's initial patch
(also the mem-free in irq-off region works in this scenario).
Can you take it as-is or should I repost it with an acked-by?

Sebastian
