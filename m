Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321F2C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D06206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfAITVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:21:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfAITU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:20:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 319A41E339;
        Wed,  9 Jan 2019 19:20:59 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA77F608C7;
        Wed,  9 Jan 2019 19:20:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/4] /proc/stat: Reduce irqs counting performance overhead
Date:   Wed,  9 Jan 2019 14:20:44 -0500
Message-Id: <1547061648-16080-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 09 Jan 2019 19:20:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v1: https://lkml.org/lkml/2019/1/7/899
 v2: Fix a minor bug in patch 4 & update the cover-letter.

As newer systems have more and more IRQs and CPUs available in their
system, the performance of reading /proc/stat frequently is getting
worse and worse.

It appears that the idea of caching the IRQ counts in the v1 patch to
reduce the frequency of doing percpu summation and use a sysctl parameter
to control it was not well received.

I have looked into the use of percpu counters for counting interrupts.
However, the followings are the reasons why I don't think percpu counters
is the right choice for doing that.

 1) There is a raw spinlock in the percpu_counter structure that may
    need to be acquired in the update path. This can be a performance
    drag especially if lockdep is enabled.

 2) The percpu_counter structure is 40 bytes in size on 64-bit
    systems compared with just 8 bytes for the percpu count pointer and
    an additional 4 bytes that I introduced in patch 2 which may not
    actually increase the size of the IRQ descriptor. With thousands
    of irq descriptors, it can consume quite a lot more memory. Memory
    consumption was a point that had been brought up in the v1 patch
    review.

 3) Reading the patch 4 commit log, one can see that quite a bit of CPU
    cycles was spent looking up the radix tree to locate the IRQ
    descriptors for each of the interrupts. Those overhead will still
    be there even if I use percpu counters. So using percpu counter
    alone won't be as performant as this patch or my previous v1 patch.
    Patch 4 optimizes the descriptor lookup process which is independant
    of the percpu counter choice.

 4) Patches 2 and 3 are the patches that modify the percpu counting aspect
    of the IRQ counts. The number of changed lines of code is only 14. So
    they are very simple changes.

This new patch optimizes the way the IRQ counts are retrieved and getting
rid of the sysctl parameter altogether to achieve a performance gain
that is close to the v1 patch. This is based on the idea that while many
IRQs can be supported by a system, only a handful of them are actually
being used in most cases. We can save a lot of time by focusing on
those active IRQs only and ignore the rests.

Patch 1 is the same as that in v1 while the other 3 patches are new.

Waiman Long (4):
  /proc/stat: Extract irqs counting code into show_stat_irqs()
  /proc/stat: Only do percpu sum of active IRQs
  genirq: Track the number of active IRQs
  /proc/stat: Call kstat_irqs_usr() only for active IRQs

 fs/proc/stat.c          | 123 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/irqdesc.h |   1 +
 kernel/irq/internals.h  |   6 ++-
 kernel/irq/irqdesc.c    |   7 ++-
 4 files changed, 125 insertions(+), 12 deletions(-)

-- 
1.8.3.1

