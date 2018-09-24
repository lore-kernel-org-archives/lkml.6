Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2672C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA32D20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA32D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeIXSRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:17:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbeIXSRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:17:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5418D10A5;
        Mon, 24 Sep 2018 12:15:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 056/173] arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()
Date:   Mon, 24 Sep 2018 13:51:30 +0200
Message-Id: <20180924113120.104243611@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 14d6e289a89780377f8bb09de8926d3c62d763cd ]

It's possible for userspace to control idx. Sanitize idx when using it
as an array index, to inhibit the potential spectre-v1 write gadget.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -274,19 +274,22 @@ static int ptrace_hbp_set_event(unsigned
 
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
-		if (idx < ARM_MAX_BRP) {
-			tsk->thread.debug.hbp_break[idx] = bp;
-			err = 0;
-		}
+		if (idx >= ARM_MAX_BRP)
+			goto out;
+		idx = array_index_nospec(idx, ARM_MAX_BRP);
+		tsk->thread.debug.hbp_break[idx] = bp;
+		err = 0;
 		break;
 	case NT_ARM_HW_WATCH:
-		if (idx < ARM_MAX_WRP) {
-			tsk->thread.debug.hbp_watch[idx] = bp;
-			err = 0;
-		}
+		if (idx >= ARM_MAX_WRP)
+			goto out;
+		idx = array_index_nospec(idx, ARM_MAX_WRP);
+		tsk->thread.debug.hbp_watch[idx] = bp;
+		err = 0;
 		break;
 	}
 
+out:
 	return err;
 }
 


