Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D27ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4114220854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4114220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbeGRQUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:20:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbeGRQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:20:42 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffoah-0000sh-On; Wed, 18 Jul 2018 17:42:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/2] irqchip/gic-v3-its: a raw_spinlock_t + early ->pend_page allocateion
Date:   Wed, 18 Jul 2018 17:42:03 +0200
Message-Id: <20180718154205.13704-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errors popped up in -RT. One is the spinlock_t usage in IRQ-off
region which should be a raw_spinlock_t. I don't see this to be used
during run-time or for long period of time so I don't thing this is an
issue.

The second problem is the ->pend_page allocation on the target_cpu early
during CPU bring up. It would be simpler to allocate the memory once on
the boot CPU instead the hotplug callback since the memory is never
free()ed. I *think* this is avoided because the number of possible CPUs
might be higher than what will actually come up (on x86 the BIOS
sometimes reports more possible_cpus than what is *really* possible, not
sure if ARM64 is there yet). Therefore I moved the allocation to an
earlier callback.

Sebastian

