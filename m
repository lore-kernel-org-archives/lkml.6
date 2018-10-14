Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164D6C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AC02064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AC02064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJNQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:57:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeJNQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:57:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9E9FxL43116758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Oct 2018 02:15:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9E9FsOc3116755;
        Sun, 14 Oct 2018 02:15:54 -0700
Date:   Sun, 14 Oct 2018 02:15:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-4907c68abd3f60f650f98d5a69d4ec77c0bde44f@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, edumazet@google.com, mingo@kernel.org
Reply-To: mingo@kernel.org, edumazet@google.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20181011104019.695196158@infradead.org>
References: <20181011104019.695196158@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/tsc: Force inlining of cyc2ns bits
Git-Commit-ID: 4907c68abd3f60f650f98d5a69d4ec77c0bde44f
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

Commit-ID:  4907c68abd3f60f650f98d5a69d4ec77c0bde44f
Gitweb:     https://git.kernel.org/tip/4907c68abd3f60f650f98d5a69d4ec77c0bde44f
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Oct 2018 12:38:26 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Oct 2018 11:11:22 +0200

x86/tsc: Force inlining of cyc2ns bits

Looking at the asm for native_sched_clock() I noticed we don't inline
enough. Mostly caused by sharing code with cyc2ns_read_begin(), which
we didn't used to do. So mark all that __force_inline to make it DTRT.

Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: eric.dumazet@gmail.com
Cc: bp@alien8.de
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181011104019.695196158@infradead.org

---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index b52bd2b6cdb4..6d5dc5dabfd7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -58,7 +58,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void cyc2ns_read_begin(struct cyc2ns_data *data)
+void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -75,7 +75,7 @@ void cyc2ns_read_begin(struct cyc2ns_data *data)
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void cyc2ns_read_end(void)
+void __always_inline cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
@@ -104,7 +104,7 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
 	unsigned long long ns;
