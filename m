Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6267C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D7A20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D7A20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeG3Xpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:45:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:43404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeG3Xpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:45:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0551AAFC2;
        Mon, 30 Jul 2018 22:08:41 +0000 (UTC)
Date:   Mon, 30 Jul 2018 15:08:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] ipc/sem: prevent queue.status tearing in semop
Message-ID: <20180730220837.iojrnvdb3lippfj7@linux-r8p5>
References: <20180717052654.676-1-dave@stgolabs.net>
 <7909e12b-6dd7-e28a-010c-003545a8e4b5@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7909e12b-6dd7-e28a-010c-003545a8e4b5@colorfullife.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Manfred Spraul wrote:

>sma->use_global_lock is sometimes used with smp_load_acquire(), 
>sometimes without.
>So far, I assumed that this is safe.
>
>The same applies for nf_conntrack_locks_all, in nf_conntrack_all_lock()

So the netfilter code is safe wrt tearing as _all_ accesses are done with
barriers and/or under spinlock.

However, this isn't always the case for sma->use_global_lock, albeit harmless.

- sem_lock(): It doesn't matter if we get the first check right as we
end up rechecking with locks held.

	/*
	 * Initial check for use_global_lock. Just an optimization,
	 * no locking, no memory barrier.
	 */
	if (!sma->use_global_lock) {

- complexmode_enter/tryleave() are called under the ipc object lock, so that
is safe:

spin_lock()
complexmode_enter()
...
complexmode_tryleave()
spin_unlock()

- newary(): Init, no concurrency, of course.

So while I also like READ/WRITE_ONCE() calls in that it helps document the
code, I don't think we need/want want this. There's a comment there in the
first place.

Thanks,
Davidlohr
