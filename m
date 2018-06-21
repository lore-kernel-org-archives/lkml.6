Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5689C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC0F224E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="v/8DItKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC0F224E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeFUWfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:35:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41545 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933662AbeFUWd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:33:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so2046310pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0y0Y6HhK02jQ+sXqM8QUkLbOeY++kM/KqedsahzGKIA=;
        b=v/8DItKsXV1wW/9gmu/fAunqc2r/YfLSr6Bjp6zekC4WMfrSxdkvlOsLk7wIe+Qwsc
         MP5GOeSSjturX7QIy03de5gl5EN/SBNGHXni+RatgiO3LnJ3iOrKVBLyWNhnYhNUqXF0
         K3t5XubQ6r4KNtI+25WviVRgrvhAv60lTlc08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0y0Y6HhK02jQ+sXqM8QUkLbOeY++kM/KqedsahzGKIA=;
        b=YgOibZzYJxQMy3Xc5duDqVO33ey28ulEFH6Ec8Jwal1a3fylDk5U5JZ+OAv2HayYRu
         HHDZ6lBMp0EAlfTECdUTmeR47lEadWdekypr1ivxL3s5pumQo9L4bbC84xEgqdkqBrM2
         VcZzuY4/exC61BC5WzYXL2fQIfzl4Jw5w9Ie/SU721//+6FJ1J8pF6MSm9+L9kFDaTnP
         75qKAvfSDfbRmz6eULr2yXzrQ89pMQGf6qmpkiz5lNzHAhWjwoFD15s+nBxxpgBr6FcL
         IL4y7d0FErdknX3z/vnLgU5mqjwR/ksb/M3FAE6e162oVg0vR3cSvjloPNawIjiNNQeH
         IKJg==
X-Gm-Message-State: APt69E2ZeMxcAzd6lFX7ql8ksyIYSn4Wy1mz3QUtBsh/MGK2yHDlhbvk
        Ha79RSSZk+9ck+42k7rB0RRRGcn52e8=
X-Google-Smtp-Source: ADUXVKIKruIAgTPFb95500ts74p2UehqH73ZRU1FSHV7Nmch0sb+FKNVy4npyBJSq2RKGWjF6l/G+A==
X-Received: by 2002:a62:221a:: with SMTP id i26-v6mr29535847pfi.240.1529620406596;
        Thu, 21 Jun 2018 15:33:26 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x19-v6sm11060824pfi.5.2018.06.21.15.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:33:26 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 1/7] srcu: Add notrace variants of srcu_read_{lock,unlock}
Date:   Thu, 21 Jun 2018 15:32:30 -0700
Message-Id: <20180621223236.211495-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621223236.211495-1-joel@joelfernandes.org>
References: <20180621223236.211495-1-joel@joelfernandes.org>
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

