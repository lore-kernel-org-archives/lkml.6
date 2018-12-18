Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD192C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DD621852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeLRPHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:07:50 -0500
Received: from foss.arm.com ([217.140.101.70]:47680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLRPHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:07:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1266080D;
        Tue, 18 Dec 2018 07:07:49 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AAB83F59C;
        Tue, 18 Dec 2018 07:07:47 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:07:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181218150744.GB20197@arrakis.emea.arm.com>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
 <20181130181956.eewrlaabtceekzyu@linutronix.de>
 <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
 <20181205191400.qrhim3m3ak5hcsuh@linutronix.de>
 <16ac893a-a080-18a5-e636-7b7668d978b0@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ac893a-a080-18a5-e636-7b7668d978b0@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:51:41PM +0800, He Zhe wrote:
> On 2018/12/6 03:14, Sebastian Andrzej Siewior wrote:
> > With raw locks you wouldn't have multiple readers at the same time.
> > Maybe you wouldn't have recursion but since you can't have multiple
> > readers you would add lock contention where was none (because you could
> > have two readers at the same time).
> 
> OK. I understand your concern finally. At the commit log said, I wanted to use raw
> rwlock but didn't find the DEFINE helper for it. Thinking it would not be expected to
> have great performance, I turn to use raw spinlock instead. And yes, this would
> introduce worse performance.

Looking through the kmemleak code, I can't really find significant
reader contention. The longest holder of this lock (read) is the scan
thread which is also protected by a scan_mutex, so can't run
concurrently with another scanner (triggered through debugfs). The other
read_lock(&kmemleak_lock) user is find_and_get_object() called from a
few places. However, all such places normally follow a create_object()
call (kmemleak_alloc() and friends) which already performs a
write_lock(&kmemleak_lock), so it needs to wait for the scan thread to
release the kmemleak_lock.

It may be worth running some performance/latency tests during kmemleak
scanning (echo scan > /sys/kernel/debug/kmemleak) but at a quick look,
I don't think we'd see any difference with a raw_spin_lock_t.

With a bit more thinking (though I'll be off until the new year), we
could probably get rid of the kmemleak_lock entirely in scan_block() and
make lookup_object() and the related rbtree code in kmemleak RCU-safe.

-- 
Catalin
