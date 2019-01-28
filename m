Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F4BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8222175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfA1Xql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:46:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37206 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfA1Xqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:46:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so7918304pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH6ZLE8Eb9duhOBZkvSjIT5Q/k6MwKWM2AYdzcsJtGg=;
        b=OpbdVvJAyMMwXes/nTI2zRwx5E4sGbvm4MABbqH0VbcQfXOREAyBGu2+79dEhFqDh/
         tEDemnVMgy9Ib0Z1FWScqOCSJYTr3Qlc/3rxjOsLPmk/2urMzuU5pwjxVtxjpQGSpt26
         S1SisPX0TLvfHj7zUHp3S4uQJiSzomIcPw8nAnoXubFuvx3IwmWYqcp4A1Pa7kYofJDx
         9AG4luUC4oooSnf6e4gktxHBOKeEExQhptImcvMUGEyUw3Q1m92aV6V5asiZWx64nc33
         ppRXD0gkKI0LTe55k3zvpYTBNNkLYAJwQdSTN9F++YM+11Wlugh/kuu4qGYRJ1fT0k3W
         Rqew==
X-Gm-Message-State: AJcUuke2lbYSpZR0VM/u9oG3zCnRDgK2nCGMlhSlS+UPStIUHu4+Z//G
        TKft6c9kympBoqfIhkYWx2TzTQ==
X-Google-Smtp-Source: ALg8bN6matX53BXBKXyJRWqIiXLCJjyXXPOmayM0l98FNINMPgIMIeEytoSsKn4Unk3UKZaSnsz9hQ==
X-Received: by 2002:a63:4f20:: with SMTP id d32mr21535419pgb.47.1548719197590;
        Mon, 28 Jan 2019 15:46:37 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f67sm52473331pfc.141.2019.01.28.15.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:46:36 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] kthread: Add __kthread_should_park()
Date:   Mon, 28 Jan 2019 15:46:24 -0800
Message-Id: <20190128234625.78241-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190128234625.78241-1-mka@chromium.org>
References: <20190128234625.78241-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing kthread_should_park() is used to check if the calling
kthread ('current') should park. The new __kthread_should_park()
receives a task_struct as parameter to check if the corresponding
kernel thread should be parked. Call __kthread_should_park() from
kthread_should_park() to avoid code duplication.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I'm not overly happy about the function name with the double
underscore prefix, but couldn't come up with anything better. I'm
open to suggestions :)
---
 include/linux/kthread.h | 1 +
 kernel/kthread.c        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311db..1577a2d56e9d4 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -56,6 +56,7 @@ void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
+bool __kthread_should_park(struct task_struct *k);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_data(struct task_struct *k);
 void *kthread_probe_data(struct task_struct *k);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 087d18d771b53..65234c89d85b4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -101,6 +101,12 @@ bool kthread_should_stop(void)
 }
 EXPORT_SYMBOL(kthread_should_stop);
 
+bool __kthread_should_park(struct task_struct *k)
+{
+	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(k)->flags);
+}
+EXPORT_SYMBOL_GPL(__kthread_should_park);
+
 /**
  * kthread_should_park - should this kthread park now?
  *
@@ -114,7 +120,7 @@ EXPORT_SYMBOL(kthread_should_stop);
  */
 bool kthread_should_park(void)
 {
-	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(current)->flags);
+	return __kthread_should_park(current);
 }
 EXPORT_SYMBOL_GPL(kthread_should_park);
 
-- 
2.20.1.495.gaa96b0ce6b-goog

