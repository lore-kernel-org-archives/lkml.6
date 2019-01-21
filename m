Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E14BC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfAULcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:32:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAULcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:32:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBWaor2496747
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:32:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBWaNZ2496744;
        Mon, 21 Jan 2019 03:32:36 -0800
Date:   Mon, 21 Jan 2019 03:32:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kangjie Lu <tipbot@zytor.com>
Message-ID: <tip-120e4e76857ddbc9268e1aa3f9de61a498e84618@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        stable@vger.kernel.org, mingo@kernel.org, kjlu@umn.edu
Reply-To: mingo@kernel.org, kjlu@umn.edu, tglx@linutronix.de,
          hpa@zytor.com, stable@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190109074524.10176-1-kjlu@umn.edu>
References: <20190109074524.10176-1-kjlu@umn.edu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Fix a potential double-fetch bug in
 sched_copy_attr()
Git-Commit-ID: 120e4e76857ddbc9268e1aa3f9de61a498e84618
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  120e4e76857ddbc9268e1aa3f9de61a498e84618
Gitweb:     https://git.kernel.org/tip/120e4e76857ddbc9268e1aa3f9de61a498e84618
Author:     Kangjie Lu <kjlu@umn.edu>
AuthorDate: Wed, 9 Jan 2019 01:45:24 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:26:17 +0100

sched/core: Fix a potential double-fetch bug in sched_copy_attr()

"uattr->size" is copied in from user space and checked. However, it is
copied in again after the security check. A malicious user may race to
change it. The fix sets uattr->size to be the checked size.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: pakki001@umn.edu
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190109074524.10176-1-kjlu@umn.edu
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a674c7db2f29..d4d3514c4fe9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4499,6 +4499,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return -EFAULT;
 
+	/* In case attr->size was changed by user-space: */
+	attr->size = size;
+
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
