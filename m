Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E56D20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E56D20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeG1Kdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:33:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:46595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbeG1Kdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:33:36 -0400
Received: from homer.simpson.net ([185.221.150.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIuSH-1fhQRx0z4T-002V5U; Sat, 28
 Jul 2018 11:07:24 +0200
Message-ID: <1532768842.9882.72.camel@gmx.de>
Subject: [rt-patch 2/3] sched: Introduce raw_cond_resched_lock()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 28 Jul 2018 11:07:22 +0200
In-Reply-To: <1532764179.9882.14.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ubRGQhKQhC26j1a5WD4YzW5tixkFddlB65V8Emf5mVpUBWgRxpO
 TFDfmjmblpZVwJ7spf9iutfb1F5XRmIT6rNeYw3j0M1WSLa1WHz97z51JCKeRpll3c6U5rU
 NVTgE7PKNGkIA5jp6101ZTJgiRzBS24u3wtMLytkLGyeqL3f4s05e0mUAsmlcvCKpNAXCp+
 1pyOJrGNPVfHxJDzNNGBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dEI3VqL9HLU=:Igaos/1hbAIi3HI1mCibNG
 Dszy6b4XtpeQslbHp6XRuUOvSVLVJKQn24kdNs8gek5lHTiECyy+qEy7zbi33JMNZFjkfuR5+
 v+rloI5/2ea79jMQB262ui6o2zLHxdOoROPOp9j0r4hvsOJtPtsBfF8SMMeJ4QuDmZ2WFFouN
 Y4dtDGEPaghE30Nt80Nauuc/RfgVuMIRRlC+Vyj1YSCXk0IIFQMkRpcwfRULCTVSY2kJ4jQwi
 K+RVSf1hqV+admuxRGKrWtzjB05N8leH1K4LShqpWONRGBOLeMJptb/qP1GEQlMEX1GFzRdhY
 LJrBg0lSdIY9cyQGqU08Z/8LMVLGxE0yEPyP0ZicQ9T87RmQoLkItAgq9BiqbMYIU2dNHTzxe
 gM8WqTBm7eVzi/m2eCp/GGnnTrgkJSq6s7z39gOGwgOuAeekr9thjmOtZGn46y43PFvPgl1X/
 0I3C6xf146WYEJWSL0GF1611Q6Oly8aGsUzhUvDN8bWmP2CN3OIYlsR5JdFy4/qGMaywp0Aam
 7R5Jm5U8sDa1X517v/Iki0qeV11VIGjlXx0qvB3esNzBH556rz8ykpdeCG+TTzeEdanQ7l3ck
 nvTZfd9MsP/PnllLo7E9uKuqTUJei2MksXqs019T6FRxcDtPpbjYnFOKUeOag5ivDiqvnI6ZU
 A1FbycuGUKvwU4yRmbAGqhcDvIfmJ2BiQlsMKMHqE6/WXTLUbkJOykkaxh+/a6CYqM1WikhEi
 p2DWcb3+D/xgH02b2sJTvKTn4Hg0NNlgZI5sw86r5SISESBiLCOYarN0IrM4DsPyXaDe3Cngc
 SDrHE1/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add raw_cond_resched_lock() infrastructure.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 include/linux/sched.h |   15 +++++++++++++++
 kernel/sched/core.c   |   20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1779,12 +1779,18 @@ static inline int _cond_resched(void) {
 })
 
 extern int __cond_resched_lock(spinlock_t *lock);
+extern int __raw_cond_resched_lock(raw_spinlock_t *lock);
 
 #define cond_resched_lock(lock) ({				\
 	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
 	__cond_resched_lock(lock);				\
 })
 
+#define raw_cond_resched_lock(lock) ({				\
+	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
+	__raw_cond_resched_lock(lock);				\
+})
+
 #ifndef CONFIG_PREEMPT_RT_FULL
 extern int __cond_resched_softirq(void);
 
@@ -1817,6 +1823,15 @@ static inline int spin_needbreak(spinloc
 #else
 	return 0;
 #endif
+}
+
+static inline int raw_spin_needbreak(raw_spinlock_t *lock)
+{
+#ifdef CONFIG_PREEMPT
+	return raw_spin_is_contended(lock);
+#else
+	return 0;
+#endif
 }
 
 static __always_inline bool need_resched(void)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5065,6 +5065,26 @@ int __cond_resched_lock(spinlock_t *lock
 }
 EXPORT_SYMBOL(__cond_resched_lock);
 
+int __raw_cond_resched_lock(raw_spinlock_t *lock)
+{
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
+
+	lockdep_assert_held(lock);
+
+	if (raw_spin_needbreak(lock) || resched) {
+		raw_spin_unlock(lock);
+		if (resched)
+			preempt_schedule_common();
+		else
+			cpu_relax();
+		ret = 1;
+		raw_spin_lock(lock);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__raw_cond_resched_lock);
+
 #ifndef CONFIG_PREEMPT_RT_FULL
 int __sched __cond_resched_softirq(void)
 {
