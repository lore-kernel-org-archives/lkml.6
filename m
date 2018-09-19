Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86737C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF162150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JCUEbNXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF162150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeITCaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45037 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731902AbeITCaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so6008449edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TXxaWmvWwJSZ82Le63q+MPVKCbZ0fMfBagChLVPhkoU=;
        b=JCUEbNXObW5AyGKN1SLiiJ2SILWfYQb6vQT6grrKNAC4JK1YrCKc0VKhYxHF/eUGc6
         pubfjI82efwkW9pZlk4KGblZvfuazFuc1o1uBD+6ukGK+ZiIwYx2T7mckb4RCIDO9dg8
         1ZqJz+S0rXhQwSx2UG1/pr9glGs5u34L33RgWlX0HDU3wIEliGx/zQuopTnpkADOCz92
         Q/SVkk2FBnRp3YtW8lpsVgIyOcon0SJScOdLq62NM1AkvRHNRV3hOT7I/h33t5laRadT
         r3QbqSviR77yuYdr9EjId+krvxGXabp/F0r4h85FFZEqMYG2qv4JIKwcgzWIC0nlZV3c
         uU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TXxaWmvWwJSZ82Le63q+MPVKCbZ0fMfBagChLVPhkoU=;
        b=SKzvJI514XqgjlDriOE2mCDMFXx//toPoL5qB+KyxKyVUaz+NojdLemR2DkYiUiewX
         WaL4u920BrEJz4MdbjXo8OJg/64CeT02G2izTHARGw5TU+yrVWdtV4yWAxrJtZvzBELo
         8Y6LiXrVmN431EHPzMlyGVZY5jivIvu6xH4AlNEeu6gf33oiZ8KKM42KYzmAzDIVSd1/
         QYhEnQK/fBwgc6nsAv1s5V9IT2QOodg23nQZcViJ+eHfkv8CtUyFOoxjsnAP7U1OK/GR
         ea7YZ8jlbuBe8nrH68ywH6AiYpG/BaB+e86TSpD+usWVCNUlhJzv9XMuDflEx4DjGqAF
         7bdw==
X-Gm-Message-State: APzg51DcocLh5JgO1ohwy1IvMt6i13UyCShKfWX8y693hhQGuuI6jjj1
        UGim15ENAUHS1/wO60ASi0uJuefhC+w=
X-Google-Smtp-Source: ANB0VdYsrYmPjpTQEsuuazJ5uuCqMm40wrSMF+xu1uFaQksn0+8ydkqc3A+7J2JsmspRWhNBN/wh9g==
X-Received: by 2002:a50:9306:: with SMTP id m6-v6mr59777681eda.206.1537390242440;
        Wed, 19 Sep 2018 13:50:42 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:41 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 02/20] timens: Add timens_offsets
Date:   Wed, 19 Sep 2018 21:50:19 +0100
Message-Id: <20180919205037.9574-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Introduce offsets for time namespace. They will contain adjustment
needed to convert clocks to/from host's.

Allocate one page for each time namespace that will be premapped into
userspace with vvar pages.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h |  2 ++
 include/linux/timens_offsets.h |  8 ++++++++
 kernel/time_namespace.c        | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/timens_offsets.h

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bf98f35efe07..4960c54f1b33 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
+#include <linux/timens_offsets.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
@@ -17,6 +18,7 @@ struct time_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 	struct ns_common ns;
+	struct timens_offsets *offsets;
 } __randomize_layout;
 extern struct time_namespace init_time_ns;
 
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
new file mode 100644
index 000000000000..7d7cb68ea778
--- /dev/null
+++ b/include/linux/timens_offsets.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIME_OFFSETS_H
+#define _LINUX_TIME_OFFSETS_H
+
+struct timens_offsets {
+};
+
+#endif
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 902cd9c22159..a985529754b4 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -13,6 +13,7 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -44,6 +45,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 {
 	struct time_namespace *ns;
 	struct ucounts *ucounts;
+	struct page *page;
 	int err;
 
 	err = -ENOSPC;
@@ -56,15 +58,22 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto fail_free;
+	ns->offsets = page_address(page);
+	BUILD_BUG_ON(sizeof(*ns->offsets) > PAGE_SIZE);
+
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto fail_free;
+		goto fail_page;
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	return ns;
-
+fail_page:
+	free_page((unsigned long)ns->offsets);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -93,6 +102,7 @@ void free_time_ns(struct kref *kref)
 	struct time_namespace *ns;
 
 	ns = container_of(kref, struct time_namespace, kref);
+	free_page((unsigned long)ns->offsets);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.13.6

