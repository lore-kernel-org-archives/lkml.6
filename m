Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1778C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9020693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC9020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeJHU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:27:04 -0400
Received: from foss.arm.com ([217.140.101.70]:50096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbeJHU1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:27:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73DA918A;
        Mon,  8 Oct 2018 06:15:23 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1D53F5B7;
        Mon,  8 Oct 2018 06:15:22 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Robert Love <rml@tech9.net>, Jonathan Corbet <corbet@lwn.net>
Cc:     kpreempt-tech@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: preempt-locking: Use better example
Date:   Mon,  8 Oct 2018 14:15:15 +0100
Message-Id: <1539004515-8152-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing wording implies that the use of spin_unlock whilst irqs are
disabled might trigger a reschedule. However the preemptible() test in
preempt_schedule will prevent a reschedule if irqs are disabled.

Lets improve the clarity of this wording to change the example from
spin_unlock to cond_resched() and cond_resched_lock() as these are
functions that will trigger a reschedule if the preempt count is 0 without
testing that irqs are disabled.

Also remove the 'Last Updated' line as this is not up to date and better
tracked via GIT.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 Documentation/preempt-locking.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/preempt-locking.txt b/Documentation/preempt-locking.txt
index c945062..509f5a4 100644
--- a/Documentation/preempt-locking.txt
+++ b/Documentation/preempt-locking.txt
@@ -3,7 +3,6 @@ Proper Locking Under a Preemptible Kernel: Keeping Kernel Code Preempt-Safe
 ===========================================================================
 
 :Author: Robert Love <rml@tech9.net>
-:Last Updated: 28 Aug 2002
 
 
 Introduction
@@ -92,11 +91,12 @@ any locks or interrupts are disabled, since preemption is implicitly disabled
 in those cases.
 
 But keep in mind that 'irqs disabled' is a fundamentally unsafe way of
-disabling preemption - any spin_unlock() decreasing the preemption count
-to 0 might trigger a reschedule. A simple printk() might trigger a reschedule.
-So use this implicit preemption-disabling property only if you know that the
-affected codepath does not do any of this. Best policy is to use this only for
-small, atomic code that you wrote and which calls no complex functions.
+disabling preemption - any cond_resched() or cond_resched_lock() might trigger
+a reschedule if the preempt count is 0. A simple printk() might trigger a
+reschedule. So use this implicit preemption-disabling property only if you
+know that the affected codepath does not do any of this. Best policy is to use
+this only for small, atomic code that you wrote and which calls no complex
+functions.
 
 Example::
 
-- 
2.7.4

