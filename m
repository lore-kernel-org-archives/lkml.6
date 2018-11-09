Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F95FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC320818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABC320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeKJGbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:31:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54393 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:31:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA9Kmp4W2516120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Nov 2018 12:48:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA9KmpNb2516117;
        Fri, 9 Nov 2018 12:48:51 -0800
Date:   Fri, 9 Nov 2018 12:48:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-15035388439f892017d38b05214d3cda6578af64@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, tglx@linutronix.de, x86@kernel.org,
        akataria@vmware.com, hpa@zytor.com, gy741.kim@gmail.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Reply-To: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          akataria@vmware.com, hpa@zytor.com, gy741.kim@gmail.com,
          x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@suse.de
In-Reply-To: <20181109152207.4d3e7d70@gandalf.local.home>
References: <20181109152207.4d3e7d70@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/vmware: Do not trace vmware_sched_clock()
Git-Commit-ID: 15035388439f892017d38b05214d3cda6578af64
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

Commit-ID:  15035388439f892017d38b05214d3cda6578af64
Gitweb:     https://git.kernel.org/tip/15035388439f892017d38b05214d3cda6578af64
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Fri, 9 Nov 2018 15:22:07 -0500
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 9 Nov 2018 21:39:14 +0100

x86/cpu/vmware: Do not trace vmware_sched_clock()

When running function tracing on a Linux guest running on VMware
Workstation, the guest would crash. This is due to tracing of the
sched_clock internal call of the VMware vmware_sched_clock(), which
causes an infinite recursion within the tracing code (clock calls must
not be traced).

Make vmware_sched_clock() not traced by ftrace.

Fixes: 80e9a4f21fd7c ("x86/vmware: Add paravirt sched clock")
Reported-by: GwanYeong Kim <gy741.kim@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Alok Kataria <akataria@vmware.com>
CC: GwanYeong Kim <gy741.kim@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>
CC: virtualization@lists.linux-foundation.org
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181109152207.4d3e7d70@gandalf.local.home
---
 arch/x86/kernel/cpu/vmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d9ab49bed8af..0eda91f8eeac 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -77,7 +77,7 @@ static __init int setup_vmw_sched_clock(char *s)
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
-static unsigned long long vmware_sched_clock(void)
+static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
 
