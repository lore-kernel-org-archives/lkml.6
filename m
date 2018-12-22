Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE712C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C22821928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrZO5gq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404625AbeLVADS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:03:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37832 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404127AbeLVADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:03:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so3163988plr.4;
        Fri, 21 Dec 2018 16:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXCb53Dik/mAGbq0EMCuQfeJWt23k8QAnRE+gOQ5BoQ=;
        b=HrZO5gq2mqCtCg9m4SeU8UwCWrU/FLG7P4OCGWBY9AT/ABu6aXmS8LN/eZOXJ1XmSG
         p2gy1PY3MHSsVcJUuOp68+ZapOUWSrRGRCPr76ClbH6fKo0T8soBZ1unZ3pM3MLbp9Fs
         pZc0wbYKBRilyuxVCt5E/zX9Lgj4PPlAuNUsxN9dQbBx3oIJK5UdbGagf7cwS9Y3cwTF
         SpITk2VVcWyuCTZkbXxxj/6WAvRgiw39Shnzx5OHpJkww2RCO41BhYuTfegfVDDOpwJs
         XoKvIYVtnZsYvTIJJHRvS9ydU9Ax61IJrUVbH4AiDBTkaMDoeiQjiog0q8Qhvxk4fV2i
         Wqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXCb53Dik/mAGbq0EMCuQfeJWt23k8QAnRE+gOQ5BoQ=;
        b=PFCmvOWvKZiTVd/UOtrZ2PS5xnvPbhLPg1LOFPXUtw3QuiD122A4ozofWckIxxlqFT
         vMKnI0BGCKqfHdCK/Mj2S6WCM7Tch6ewtaMv1qGYtApGezCbXajaVOoEXdFqO0MoyZfO
         ia4B3rS3ueJUEf/MYs6uxxSac1HtYA1N+5OH8aEc2LTe3ntQ04jtU2hj9HZr4wu0PhZP
         EmY2JIS9tKzYAwVdRdRwDCFaLwpTQqagLFziKiqStQNOoEfNV8zDmPXDWeyErcx5jDve
         RCnZmmE0ysoSm0fP9LP5bSF84xDE2PyVvPHIXR3n+uCA4fuJYilPekZX8qfGdqaiTnZu
         XFrg==
X-Gm-Message-State: AJcUukfHzFySsPReTw8AaG+lOIUf4+x1bhqr9B7MFw0pxR1K8+uFlxra
        mIPdvzOmyWW2kGBEY1Y108A=
X-Google-Smtp-Source: ALg8bN4TSrVWV3/kVjA1zFKswwuEHRCSF5E0Q6VE32gKhDT0Gq/Nrm6GzsAl7DWdxY2ZfynUltwvTg==
X-Received: by 2002:a17:902:d68c:: with SMTP id v12mr4512216ply.4.1545436992020;
        Fri, 21 Dec 2018 16:03:12 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:608f])
        by smtp.gmail.com with ESMTPSA id 83sm36659266pgf.57.2018.12.21.16.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:03:11 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 2/7] cgroup: implement __cgroup_task_count() helper
Date:   Fri, 21 Dec 2018 16:03:02 -0800
Message-Id: <20181222000307.28231-3-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181222000307.28231-1-guro@fb.com>
References: <20181222000307.28231-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper is identical to the existing cgroup_task_count()
except it doesn't take the css_set_lock by itself, assuming
that the caller does.

Also, move cgroup_task_count() implementation into
kernel/cgroup/cgroup.c, as there is nothing specific to cgroup v1.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       | 16 ----------------
 kernel/cgroup/cgroup.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c950864016e2..a195328431ce 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -226,6 +226,7 @@ int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
 
+int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
 
 /*
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 51063e7a93c2..6134fef07d57 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -336,22 +336,6 @@ static struct cgroup_pidlist *cgroup_pidlist_find_create(struct cgroup *cgrp,
 	return l;
 }
 
-/**
- * cgroup_task_count - count the number of tasks in a cgroup.
- * @cgrp: the cgroup in question
- */
-int cgroup_task_count(const struct cgroup *cgrp)
-{
-	int count = 0;
-	struct cgrp_cset_link *link;
-
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &cgrp->cset_links, cset_link)
-		count += link->cset->nr_tasks;
-	spin_unlock_irq(&css_set_lock);
-	return count;
-}
-
 /*
  * Load a cgroup's pidarray with either procs' tgids or tasks' pids
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e06994fd4e34..7519a4307021 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -563,6 +563,39 @@ static void cgroup_get_live(struct cgroup *cgrp)
 	css_get(&cgrp->self);
 }
 
+/**
+ * __cgroup_task_count - count the number of tasks in a cgroup. The caller
+ * is responsible for taking the css_set_lock.
+ * @cgrp: the cgroup in question
+ */
+int __cgroup_task_count(const struct cgroup *cgrp)
+{
+	int count = 0;
+	struct cgrp_cset_link *link;
+
+	lockdep_assert_held(&css_set_lock);
+
+	list_for_each_entry(link, &cgrp->cset_links, cset_link)
+		count += link->cset->nr_tasks;
+
+	return count;
+}
+
+/**
+ * cgroup_task_count - count the number of tasks in a cgroup.
+ * @cgrp: the cgroup in question
+ */
+int cgroup_task_count(const struct cgroup *cgrp)
+{
+	int count;
+
+	spin_lock_irq(&css_set_lock);
+	count = __cgroup_task_count(cgrp);
+	spin_unlock_irq(&css_set_lock);
+
+	return count;
+}
+
 struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 {
 	struct cgroup *cgrp = of->kn->parent->priv;
-- 
2.19.2

