Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3FB20841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3FB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbeGLTsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:48:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeGLTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:48:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CJbTgc4025697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 12:37:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CJbTQ34025694;
        Thu, 12 Jul 2018 12:37:29 -0700
Date:   Thu, 12 Jul 2018 12:37:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eric Dumazet <tipbot@zytor.com>
Message-ID: <tip-a8802d97e73346bc81609df9dfba7d3306f40d87@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, john.stultz@linaro.org, edumazet@google.com,
        willemb@google.com, eric.dumazet@gmail.com, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, edumazet@google.com, peterz@infradead.org,
          john.stultz@linaro.org, linux-kernel@vger.kernel.org,
          willemb@google.com, hpa@zytor.com, eric.dumazet@gmail.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180711181641.10369-1-edumazet@google.com>
References: <20180711181641.10369-1-edumazet@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] ktime: Provide typesafe ktime_to_ns()
Git-Commit-ID: a8802d97e73346bc81609df9dfba7d3306f40d87
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

Commit-ID:  a8802d97e73346bc81609df9dfba7d3306f40d87
Gitweb:     https://git.kernel.org/tip/a8802d97e73346bc81609df9dfba7d3306f40d87
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Wed, 11 Jul 2018 11:16:41 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 12 Jul 2018 21:35:28 +0200

ktime: Provide typesafe ktime_to_ns()

Using ktime_to_ns() is nice to help backports to stable kernels.

Having a typesafe function instead of a macro avoid stupid typos
and waste of time tracking these typos.

Reported-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20180711181641.10369-1-edumazet@google.com

---
 include/linux/ktime.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 5b9fddbaac41..b2bb44f87f5a 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -93,8 +93,11 @@ static inline ktime_t timeval_to_ktime(struct timeval tv)
 /* Map the ktime_t to timeval conversion to ns_to_timeval function */
 #define ktime_to_timeval(kt)		ns_to_timeval((kt))
 
-/* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
-#define ktime_to_ns(kt)			(kt)
+/* Convert ktime_t to nanoseconds */
+static inline s64 ktime_to_ns(const ktime_t kt)
+{
+	return kt;
+}
 
 /**
  * ktime_compare - Compares two ktime_t variables for less, greater or equal
