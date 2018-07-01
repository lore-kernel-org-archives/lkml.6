Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA7EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C225B06
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615C225B06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeGASuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:50:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeGAQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80FA8AD8;
        Sun,  1 Jul 2018 16:11:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 13/85] arm64: ptrace: remove addr_limit manipulation
Date:   Sun,  1 Jul 2018 18:01:31 +0200
Message-Id: <20180701153122.883369156@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 59275a0c037ed6fabd6354730f1e3104264ab719 ]

We transiently switch to KERNEL_DS in compat_ptrace_gethbpregs() and
compat_ptrace_sethbpregs(), but in either case this is pointless as we
don't perform any uaccess during this window.

let's rip out the redundant addr_limit manipulation.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -945,9 +945,7 @@ static int compat_ptrace_gethbpregs(stru
 {
 	int ret;
 	u32 kdata;
-	mm_segment_t old_fs = get_fs();
 
-	set_fs(KERNEL_DS);
 	/* Watchpoint */
 	if (num < 0) {
 		ret = compat_ptrace_hbp_get(NT_ARM_HW_WATCH, tsk, num, &kdata);
@@ -958,7 +956,6 @@ static int compat_ptrace_gethbpregs(stru
 	} else {
 		ret = compat_ptrace_hbp_get(NT_ARM_HW_BREAK, tsk, num, &kdata);
 	}
-	set_fs(old_fs);
 
 	if (!ret)
 		ret = put_user(kdata, data);
@@ -971,7 +968,6 @@ static int compat_ptrace_sethbpregs(stru
 {
 	int ret;
 	u32 kdata = 0;
-	mm_segment_t old_fs = get_fs();
 
 	if (num == 0)
 		return 0;
@@ -980,12 +976,10 @@ static int compat_ptrace_sethbpregs(stru
 	if (ret)
 		return ret;
 
-	set_fs(KERNEL_DS);
 	if (num < 0)
 		ret = compat_ptrace_hbp_set(NT_ARM_HW_WATCH, tsk, num, &kdata);
 	else
 		ret = compat_ptrace_hbp_set(NT_ARM_HW_BREAK, tsk, num, &kdata);
-	set_fs(old_fs);
 
 	return ret;
 }


