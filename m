Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D04C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8F208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB8F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGaDPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:15:30 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35549 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbeGaDP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:15:29 -0400
Received: by mail-yw0-f195.google.com with SMTP id t18-v6so5160687ywg.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2LCrVKVY9vzDCsSqoMVxj5uiVG4tv++pLhoThxBZT4=;
        b=c+Hr6X3lbiMrxrktTvvfVQGnsOLNMqp54uU4LQpQX0SNPuaRTNQ/87nJkxOqO0adax
         t4zeUg8LiV5VTQWkumwKnZRpNk2zszQQnM+/4W79uoTsb6JfAlJ7IVq/l7IvAQUgXQQ3
         HS4wHde4kYd5q5Gc1z5Qb4/fuyoXk0HPKsx2ewLmwwlzAii41D+RiME2wqK0E/EPdqTz
         sjtN887/WqCqP4W+mEOBgkT9jvW0tpfh1pwEmD5Q8WqZn6s7W1Li+OLn+Li5Mhy5IjZt
         IHqrWPRnFGSooyphhBnzyV3pUF1FZofMzoird72p2YJ/z7Xnj/TALm8PKGUXxG+esvgq
         qGZA==
X-Gm-Message-State: AOUpUlFwPDapKlKRgdEoonGLSOA5EzusP5uEEtp8wzjzKSpAQB9SS/zk
        3MKanWQ5DnkVBM3CeNEaoQRrHQ==
X-Google-Smtp-Source: AAOMgpdtIPRVsIrb2jflRppEwSj8Pedu5MIPsUWEu/J5rxX6Ln1DHCWmlSbV7kWumqxymmNGKzD54Q==
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr10003384ywd.414.1533001063520;
        Mon, 30 Jul 2018 18:37:43 -0700 (PDT)
Received: from builder.jcline.org ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id y133-v6sm13800287ywy.31.2018.07.30.18.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 18:37:42 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] fs/quota: Fix spectre gadget in do_quotactl
Date:   Tue, 31 Jul 2018 01:37:31 +0000
Message-Id: <20180731013731.1987-3-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731013731.1987-1-jcline@redhat.com>
References: <20180731013731.1987-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is user-controlled, so sanitize it after the bounds check to
avoid using it in speculative execution. This covers the following
potential gadgets detected with the help of smatch:

* fs/ext4/super.c:5741 ext4_quota_read() warn: potential spectre issue
  'sb_dqopt(sb)->files' [r]
* fs/ext4/super.c:5778 ext4_quota_write() warn: potential spectre issue
  'sb_dqopt(sb)->files' [r]
* fs/f2fs/super.c:1552 f2fs_quota_read() warn: potential spectre issue
  'sb_dqopt(sb)->files' [r]
* fs/f2fs/super.c:1608 f2fs_quota_write() warn: potential spectre issue
  'sb_dqopt(sb)->files' [r]
* fs/quota/dquot.c:412 mark_info_dirty() warn: potential spectre issue
  'sb_dqopt(sb)->info' [w]
* fs/quota/dquot.c:933 dqinit_needed() warn: potential spectre issue
  'dquots' [r]
* fs/quota/dquot.c:2112 dquot_commit_info() warn: potential spectre
  issue 'dqopt->ops' [r]
* fs/quota/dquot.c:2362 vfs_load_quota_inode() warn: potential spectre
  issue 'dqopt->files' [w] (local cap)
* fs/quota/dquot.c:2369 vfs_load_quota_inode() warn: potential spectre
  issue 'dqopt->ops' [w] (local cap)
* fs/quota/dquot.c:2370 vfs_load_quota_inode() warn: potential spectre
  issue 'dqopt->info' [w] (local cap)
* fs/quota/quota.c:110 quota_getfmt() warn: potential spectre issue
  'sb_dqopt(sb)->info' [r]
* fs/quota/quota_v2.c:84 v2_check_quota_file() warn: potential spectre
  issue 'quota_magics' [w]
* fs/quota/quota_v2.c:85 v2_check_quota_file() warn: potential spectre
  issue 'quota_versions' [w]
* fs/quota/quota_v2.c:96 v2_read_file_info() warn: potential spectre
  issue 'dqopt->info' [r]
* fs/quota/quota_v2.c:172 v2_write_file_info() warn: potential spectre
  issue 'dqopt->info' [r]

Additionally, a quick inspection indicates there are array accesses with
'type' in quota_on() and quota_off() functions which are also addressed
by this.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---

This patch isn't going to cleanly apply to stable without the "fs/quota:
Replace XQM_MAXQUOTAS usage with MAXQUOTAS" patch, but I'm not sure that
patch is really stable material and XQM_MAXQUOTAS has been 3 since
pre-v4.4 so the end result will be the same even if that patch isn't
backported.

 fs/quota/quota.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index d403392d8a0f..f0cbf58ad4da 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -18,6 +18,7 @@
 #include <linux/quotaops.h>
 #include <linux/types.h>
 #include <linux/writeback.h>
+#include <linux/nospec.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -701,6 +702,7 @@ static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
 
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
+	type = array_index_nospec(type, MAXQUOTAS);
 	/*
 	 * Quota not supported on this fs? Check this before s_quota_types
 	 * since they needn't be set if quota is not supported at all.
-- 
2.17.1

