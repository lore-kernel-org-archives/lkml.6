Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E6D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E6D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935289AbeFROsK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:48:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934657AbeFROsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:48:07 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MYoWQ-1fhYW21AcU-00VOfw; Mon, 18 Jun 2018 16:47:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: use monotonic timestamp for stall detection
Date:   Mon, 18 Jun 2018 16:47:34 +0200
Message-Id: <20180618144741.339763-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:vHQmKBVQmbjqX8hGvUq/PTs0ZFDIM5QqFCxlcg2mhhWAPtLJ9II
 fkd61PAsHo2zVj7qQmvN+ga5P/M/q/G8SBWoA31j79z7IPGnleZt89uEtZOe+vcse0TbUVu
 jwz1TtGZso2CILqUwug7ZuLe4Lb72KEZaXfRvogvE0fp82i74uEMuOp/Ms+q06AeUWvfRgP
 0GrLwyJVD0F/8s+ZGl5cA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VeRCssyuIjo=:LGtcUsmCIH6anEfa61ggIW
 W1IDusg/Jt0sLr9uu47yIZhjp3LtdU9fv3fC69iajy7qlTUSLpRLipTL4/cyuspxJHWZ0HnPk
 6cBCFFALtIZVo4N3ff10aL72WPw3emC+vzlheiwJ/FI4KoZ9oZeKXtZ7CApqiR9kvzEAplaQy
 8EQZhaC9GIrep1UhV7PlmskWZanupMxhzrV5aaZKiMvzVbJYVVQzxAcjYUQ1YJ/6mDZfZGF3i
 vVuA4wxC7VdsxCd7gKseZdadVyop2NI0PDT4mdZoQ2tNmH3wGCI/hn8DggaA7hmkeGnvHWV2Y
 dFDQwdmRNttR/sl99PcCXVuG1jEoETx2r30RaQrQLcQwgsYKBCfu/ftv90NjRAUsXdZVpNm0R
 sC2UGK2AlQc8mt3vSAv8YaXz7why169qg31moaN2weH27+HGvJC79106SqqdkMY4/De5G7vUx
 jgkZj//EM5WKlSj9xvcH5rb25YUeHrfi0hOESv+PTlhyBwFL6ZfqlLUxjhNea37D6IIvRRxql
 mE7OgTzy4qMMMZEZaSvwq/De1Sy7BQPROvAcZbLh6wpoIscySAgEFY5tLcccRZ93lzbrLdR+a
 bhb3drQPTFREFUOtPDGr4eap2acXXdZFy6woHiom3LomwcGyjj8DgdJQDGhyM5Wf17Bjmo7ez
 XuyHGr3QuuVQ4NlJJEgI94XmfWNsG9x9Wc82xmEpJlmNWoVeNko+7qCY7+gZR+Z2Mvfk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() call is deprecated because it overflows on 32-bit
architectures. The algorithm in rcu_torture_stall() can deal with
the overflow, but another problem here is that using a CLOCK_REALTIME
stamp can lead to a false-positive stall warning when a settimeofday()
happens concurrently.

Using ktime_get_seconds() instead avoids those issues and will never
overflow. The added cast to 'unsigned long' however is necessary to
make ULONG_CMP_LT() work correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/rcu/rcutorture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 42fcb7f05fac..f42cf69ef539 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1446,7 +1446,7 @@ static int rcu_torture_stall(void *args)
 		VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
 	}
 	if (!kthread_should_stop()) {
-		stop_at = get_seconds() + stall_cpu;
+		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
 		rcu_read_lock();
 		if (stall_cpu_irqsoff)
@@ -1455,7 +1455,8 @@ static int rcu_torture_stall(void *args)
 			preempt_disable();
 		pr_alert("rcu_torture_stall start on CPU %d.\n",
 			 smp_processor_id());
-		while (ULONG_CMP_LT(get_seconds(), stop_at))
+		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
+				    stop_at))
 			continue;  /* Induce RCU CPU stall warning. */
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
-- 
2.9.0

