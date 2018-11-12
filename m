Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F67CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED32241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyZ8gOJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ED32241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeKLTtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45380 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKLTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so8540100wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1yDznB1zlUn9X3/WRtGxgozB4Whpg1+Jm0y+uUAhQs=;
        b=PyZ8gOJocogy3BEEQogAOEoynZMxE8x1fvBu0cP2+n30x2NDzxjSXsAPqPzS7QF2yn
         559MfbGKyuGBpBtaanAwzOoQhFxdw4OpTCdGb2uaAZpuWQhrfq2eoWDkvEvCAEIUZ6/X
         Pmr2XAYw4kpma6U7p99Xbla+MYZenfrHl3AVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z1yDznB1zlUn9X3/WRtGxgozB4Whpg1+Jm0y+uUAhQs=;
        b=lJinqK8TvSrIEvKuukarOIWxXUrQVdExUaUEfCH2ixo8WED7rMPblGGt7lfa8leoch
         mOTaHPyP5McqlGy8YS1j5Xt0lbW+3BsLFGjBh0zs6mZGZioA4IoeylTxe7DvVrgqwOaJ
         dl9k5uvllBevfUGyyplU+Nj670WEOqnPtlRZA5jLkzpo3IsUWEmW0B7+9k+DzHJpurzO
         yV5VO4X0G4NfHX2sYJ8o0EtGu0GitGiD6ovxkE4bkw8EWV54L3KceWSNNt0rWpHC3sus
         /VsbY7lHwBEFmRmf4szwOn4JsxwtV3emErW1Fyd6KyonxvKy0QIwxGAD2pILx2x9rYby
         O+qw==
X-Gm-Message-State: AGRZ1gKFL0nYTIjW5IX1sWgBekHRxZHSPAim1QrwkETJRkG6YrdtVXiB
        C4Xs7Q0fn7C7iiGGYqquWFPjng==
X-Google-Smtp-Source: AJdET5cNricL6ewA3bg6OKKhOdQerlzg7sQ1hwsx5lzQkbAPiYr3jhHML+GAlyn5W5yKLyQBSw+HkQ==
X-Received: by 2002:a5d:4a11:: with SMTP id m17-v6mr273341wrq.259.1542016640333;
        Mon, 12 Nov 2018 01:57:20 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:19 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 07/12] cgroup: make all functions of all cftypes be invoked
Date:   Mon, 12 Nov 2018 10:56:27 +0100
Message-Id: <20181112095632.69114-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

When two or more policies share a file their respective cftypes are
linked together. The allowed operations on those files are: open,
release, write and show, mapped to the functions defined in the
cftypes.

This commit makes the cgroup core invoke, whenever one of those
operations is requested, the respective function of all the cftypes
linked together.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 kernel/cgroup/cgroup.c | 181 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 132 insertions(+), 49 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e3cc437669a8..6d4cfd6395ec 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3481,66 +3481,107 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 static int cgroup_file_open(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of->kn->priv;
+	struct cftype *n;
+	int ret = 0;
 
+	list_for_each_cft(cft, n) {
+		if (cft->open)
+			ret = cft->open(of);
+		/*
+		 * If there has been an error with the open function of one of
+		 * the cft associated with the file, we call the release
+		 * function of all the cftype associated to cft whose open
+		 * function succeded.
+		 */
+		if (ret) {
+			struct cftype *c = of->kn->priv;
+			struct cftype *n;
+
+			list_for_each_cft(c, n) {
+				if (cft == c)
+					break;
+				if (c->release)
+					c->release(of);
+			}
+			break;
+		}
+	}
 
-	if (cft->open)
-		return cft->open(of);
-	return 0;
+	return ret;
 }
 
 static void cgroup_file_release(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of->kn->priv;
+	struct cftype *n;
 
-	if (cft->release)
-		cft->release(of);
+	list_for_each_cft(cft, n)
+		if (cft->release)
+			cft->release(of);
 }
 
+/*
+ * Call all the write functions of the cftypes associated with the file.
+ *
+ * When a write fails, don't keep trying to write into the file via the write
+ * functions of the other cftypes associated with it.
+ */
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup *cgrp = of->kn->parent->priv;
 	struct cftype *cft = of->kn->priv;
+	struct cftype *n;
 	struct cgroup_subsys_state *css;
-	int ret;
+	int ret = 0;
 
-	/*
-	 * If namespaces are delegation boundaries, disallow writes to
-	 * files in an non-init namespace root from inside the namespace
-	 * except for the files explicitly marked delegatable -
-	 * cgroup.procs and cgroup.subtree_control.
-	 */
-	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
-	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
-	    ns != &init_cgroup_ns && ns->root_cset->dfl_cgrp == cgrp)
-		return -EPERM;
+	list_for_each_cft(cft, n) {
+		/*
+		 * If namespaces are delegation boundaries, disallow writes to
+		 * files in an non-init namespace root from inside the
+		 * namespace except for the files explicitly marked
+		 * delegatable - cgroup.procs and cgroup.subtree_control.
+		 */
+		if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
+		    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
+		    ns != &init_cgroup_ns && ns->root_cset->dfl_cgrp == cgrp)
+			return -EPERM;
 
-	if (cft->write)
-		return cft->write(of, buf, nbytes, off);
+		if (cft->write) {
+			ret = cft->write(of, buf, nbytes, off);
 
-	/*
-	 * kernfs guarantees that a file isn't deleted with operations in
-	 * flight, which means that the matching css is and stays alive and
-	 * doesn't need to be pinned.  The RCU locking is not necessary
-	 * either.  It's just for the convenience of using cgroup_css().
-	 */
-	rcu_read_lock();
-	css = cgroup_css(cgrp, cft->ss);
-	rcu_read_unlock();
+			if (ret)
+				break;
+			continue;
+		}
 
-	if (cft->write_u64) {
-		unsigned long long v;
-		ret = kstrtoull(buf, 0, &v);
-		if (!ret)
-			ret = cft->write_u64(css, cft, v);
-	} else if (cft->write_s64) {
-		long long v;
-		ret = kstrtoll(buf, 0, &v);
-		if (!ret)
-			ret = cft->write_s64(css, cft, v);
-	} else {
-		ret = -EINVAL;
+		/*
+		 * kernfs guarantees that a file isn't deleted with operations
+		 * in flight, which means that the matching css is and stays
+		 * alive and doesn't need to be pinned.  The RCU locking is not
+		 * necessary either.  It's just for the convenience of using
+		 * cgroup_css().
+		 */
+		rcu_read_lock();
+		css = cgroup_css(cgrp, cft->ss);
+		rcu_read_unlock();
+
+		if (cft->write_u64) {
+			unsigned long long v;
+
+			ret = kstrtoull(buf, 0, &v);
+			if (!ret)
+				ret = cft->write_u64(css, cft, v);
+		} else if (cft->write_s64) {
+			long long v;
+
+			ret = kstrtoll(buf, 0, &v);
+			if (!ret)
+				ret = cft->write_s64(css, cft, v);
+		} else {
+			return -EINVAL;
+		}
 	}
 
 	return ret ?: nbytes;
@@ -3562,22 +3603,64 @@ static void cgroup_seqfile_stop(struct seq_file *seq, void *v)
 		seq_cft(seq)->seq_stop(seq, v);
 }
 
+/*
+ * A file shared by more cftypes may be showing different values. In that case
+ * call all the show functions and print the name of the owner that defined
+ * them.
+ */
 static int cgroup_seqfile_show(struct seq_file *m, void *arg)
 {
 	struct cftype *cft = seq_cft(m);
+	struct cftype *n;
 	struct cgroup_subsys_state *css = seq_css(m);
+	char *first_seqshow_str = NULL;
+	size_t first_str_size = 0;
+	size_t current_str_size = 0;
 	int ret = 0;
 
-	if (cft->seq_show)
-		ret = cft->seq_show(m, arg);
-	else if (cft->seq_show_cft)
-		ret = cft->seq_show_cft(m, cft, arg);
-	else if (cft->read_u64)
-		seq_printf(m, "%llu\n", cft->read_u64(css, cft));
-	else if (cft->read_s64)
-		seq_printf(m, "%lld\n", cft->read_s64(css, cft));
-	else
-		ret = -EINVAL;
+	list_for_each_cft(cft, n) {
+		if (cft->seq_show) {
+			ret = cft->seq_show(m, arg);
+			if (ret)
+				break;
+		} else if (cft->seq_show_cft) {
+			ret = cft->seq_show_cft(m, cft, arg);
+			if (ret)
+				break;
+		} else if (cft->read_u64) {
+			seq_printf(m, "%llu\n", cft->read_u64(css, cft));
+		} else if (cft->read_s64) {
+			seq_printf(m, "%lld\n", cft->read_s64(css, cft));
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+		current_str_size = m->count - current_str_size;
+
+		if (first_seqshow_str == NULL) {
+			first_seqshow_str = kmalloc(m->size, GFP_KERNEL);
+			first_str_size = m->count;
+			strcpy(first_seqshow_str, m->buf);
+			first_str_size = m->count;
+		} else if (strcmp(first_seqshow_str,
+				  m->buf + m->count - current_str_size)) {
+			first_str_size = -1;
+		}
+
+		if (current_str_size) {
+			seq_printf(m, " - %s\n", cft->owner_name);
+			current_str_size = m->count;
+		}
+	}
+
+	/*
+	 * If all the cft->seqfile_show/read are equal, truncate the
+	 * output of the seqfile to the length of the first string.
+	 */
+	if (first_str_size != -1)
+		m->count = first_str_size;
+
+	kfree(first_seqshow_str);
 	return ret;
 }
 
-- 
2.16.1

