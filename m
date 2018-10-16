Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84690C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2744821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2744821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeJQF40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:56:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:49772 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbeJQF40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:56:26 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4AF802E2;
        Tue, 16 Oct 2018 22:04:00 +0000 (UTC)
Date:   Tue, 16 Oct 2018 16:03:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [RFC PATCH 00/30] softirq: Make softirqs soft-interruptible (+
 per vector disablement)
Message-ID: <20181016160359.5523ae90@lwn.net>
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 01:11:47 +0200
Frederic Weisbecker <frederic@kernel.org> wrote:

> 945 files changed, 13857 insertions(+), 9767 deletions(-)

Impressive :)

I have to ask a dumb question, though.  Might it not be better to add a
new set of functions like:

	local_softirq_disable(mask);
	spin_lock_softirq(lock, mask);

Then just define the existing functions to call the new ones with
SOFTIRQ_ALL_MASK?  It would achieve something like the same result with
far less churn and conflict potential; then individual call sites could be
changed at leisure?  For extra credit, somebody could do a checkpatch rule
to keep new calls to the _bh functions from being added.

Thanks,

jon
