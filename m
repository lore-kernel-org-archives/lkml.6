Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8865AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47990208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47990208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935873AbeFRJu2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:50:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964848AbeFRIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3306C84;
        Mon, 18 Jun 2018 08:21:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 093/279] arm64: ptrace: remove addr_limit manipulation
Date:   Mon, 18 Jun 2018 10:11:18 +0200
Message-Id: <20180618080612.648341955@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1458,9 +1458,7 @@ static int compat_ptrace_gethbpregs(stru
 {
 	int ret;
 	u32 kdata;
-	mm_segment_t old_fs = get_fs();
 
-	set_fs(KERNEL_DS);
 	/* Watchpoint */
 	if (num < 0) {
 		ret = compat_ptrace_hbp_get(NT_ARM_HW_WATCH, tsk, num, &kdata);
@@ -1471,7 +1469,6 @@ static int compat_ptrace_gethbpregs(stru
 	} else {
 		ret = compat_ptrace_hbp_get(NT_ARM_HW_BREAK, tsk, num, &kdata);
 	}
-	set_fs(old_fs);
 
 	if (!ret)
 		ret = put_user(kdata, data);
@@ -1484,7 +1481,6 @@ static int compat_ptrace_sethbpregs(stru
 {
 	int ret;
 	u32 kdata = 0;
-	mm_segment_t old_fs = get_fs();
 
 	if (num == 0)
 		return 0;
@@ -1493,12 +1489,10 @@ static int compat_ptrace_sethbpregs(stru
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


