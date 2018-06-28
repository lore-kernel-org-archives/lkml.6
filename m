Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5576924A22
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UYBeuadd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5576924A22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030467AbeF1SWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:22:05 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43250 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030424AbeF1SV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:21:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id a14-v6so2822106pgw.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0y0Y6HhK02jQ+sXqM8QUkLbOeY++kM/KqedsahzGKIA=;
        b=UYBeuaddyHOkDRXB3clMsI+fP0kxjCx1sKemDpV4VuA+IFBBZeTd8a39mcrnsa+MFF
         XO3KcZO86q9uF0FH6KQaP0IeUaUqPEVM6EVCVSahfByi58RP5jhUa0acRkWZCAdP4ikW
         2Zh9c9ige893C0NYWLV93UjHdGS6tL2TcAniY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0y0Y6HhK02jQ+sXqM8QUkLbOeY++kM/KqedsahzGKIA=;
        b=d5MjQ2ZeEyRNnUrdo5bnEDJATbPTBtyDcUL/2uHzc+IqhPHb/i8wJiNFWQvoBhQKqg
         CyYtyntJ70U17A+Ihk7keAAHP/+SdSM+b4EcUZnuMMwzOavy2vzk9PkgUmvdfQLavOTc
         xBO0WdN3TxAyyIAD8dKCqtEQM51E2J8kmqWoWD7OvivpMpMi03MmvQWFdx1WpD+GB+al
         C0cFyvzqTriXz9Xqf+osPF0gwbEQ3sS3kTI8ZxZbpGJLhl4aA9i6HQmX6HS08Pzz50ZH
         sjj2G+SgsTQWbKUtacT2v9cFgerzDufdVHoqBwaeYe4bTXvJg+W6kzwoyX2l3EaMoe0H
         m4dA==
X-Gm-Message-State: APt69E2LmA4aDbhwuCgpKQxG+KyL+ZeM4XdRLlS5nxKMR4kWnVvNyCTb
        ywaVXesWtWHAtsu2Km9Jq9SG2UUvqrU=
X-Google-Smtp-Source: ADUXVKImXd1pmagiPhv2WH6F2+oMeVadbleJN1koIaJGcCeT0g+OfNCPH1cXggsrVttDvSHamL+Zdg==
X-Received: by 2002:a63:2f04:: with SMTP id v4-v6mr9540770pgv.33.1530210117657;
        Thu, 28 Jun 2018 11:21:57 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id q10-v6sm13686027pfj.7.2018.06.28.11.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:21:57 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 1/7] srcu: Add notrace variants of srcu_read_{lock,unlock}
Date:   Thu, 28 Jun 2018 11:21:43 -0700
Message-Id: <20180628182149.226164-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628182149.226164-1-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul McKenney <paulmck@linux.vnet.ibm.com>

This is needed for a future tracepoint patch that uses srcu, and to make
sure it doesn't call into lockdep.

tracepoint code already calls notrace variants for rcu_read_lock_sched
so this patch does the same for srcu which will be used in a later
patch. Keeps it consistent with rcu-sched.

[Joel: Added commit message]
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 91494d7e8e41..3e72a291c401 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -195,6 +195,16 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 	return retval;
 }
 
+/* Used by tracing, cannot be traced and cannot invoke lockdep. */
+static inline notrace int
+srcu_read_lock_notrace(struct srcu_struct *sp) __acquires(sp)
+{
+	int retval;
+
+	retval = __srcu_read_lock(sp);
+	return retval;
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @sp: srcu_struct in which to unregister the old reader.
@@ -209,6 +219,13 @@ static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__srcu_read_unlock(sp, idx);
 }
 
+/* Used by tracing, cannot be traced and cannot call lockdep. */
+static inline notrace void
+srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
+{
+	__srcu_read_unlock(sp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
-- 
2.18.0.rc2.346.g013aa6912e-goog

