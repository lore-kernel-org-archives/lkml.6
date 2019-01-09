Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F05C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D972173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfAIRYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:24:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfAIRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:24:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8BA37D0DE;
        Wed,  9 Jan 2019 17:24:21 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49313600C8;
        Wed,  9 Jan 2019 17:24:18 +0000 (UTC)
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
Subject: [PATCH v2 0/4] /proc/stat: Reduce irqs counting performance overhead
Date:   Wed,  9 Jan 2019 12:23:44 -0500
Message-Id: <1547054628-12703-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 17:24:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lkml.org/lkml/2019/1/7/899

As newer systems have more and more IRQs and CPUs available in their
system, the performance of reading /proc/stat frequently is getting
worse and worse.

It appears that the idea of caching the IRQ counts in the v1 patch to
reduce the frequency of doing percpu summation and use a sysctl parameter
to control it was not well received.

This v2 patch optimizes the way the IRQ counts are retrieved and computed
and getting rid of the sysctl parameter altogether to achieve a performance
gain that is close to the v1 patch. This is based on the idea that while
many IRQs can be supported by a system, only a handful of them are actually
being used in most cases. We can save a lot of time by focusing on those
active IRQs only and ignore the rests.

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

