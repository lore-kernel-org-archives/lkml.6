Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263C21C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6263C21C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeHIJU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:20:59 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43867 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:20:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet2-0008JP-ME; Thu, 09 Aug 2018 00:57:32 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet2-00054s-6l; Thu, 09 Aug 2018 00:57:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  9 Aug 2018 01:56:03 -0500
Message-Id: <20180809065605.32345-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87wot0yqsx.fsf_-_@xmission.com>
References: <87wot0yqsx.fsf_-_@xmission.com>
X-XM-SPF: eid=1fnet2-00054s-6l;;;mid=<20180809065605.32345-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18P5HIB1jMRJ5LmCsIvjXhjXBbMBC9PmmE=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v5 4/6] fork: Skip setting TIF_SIGPENDING in ptrace_init_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in calculate_sigpending will now handle this so
it is just redundant and possibly a little confusing
to continue setting TIF_SIGPENDING in ptrace_init_task.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 037bf0ef1ae9..4f36431c380b 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -214,8 +214,6 @@ static inline void ptrace_init_task(struct task_struct *child, bool ptrace)
 			task_set_jobctl_pending(child, JOBCTL_TRAP_STOP);
 		else
 			sigaddset(&child->pending.signal, SIGSTOP);
-
-		set_tsk_thread_flag(child, TIF_SIGPENDING);
 	}
 	else
 		child->ptracer_cred = NULL;
-- 
2.17.1

