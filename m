Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07845C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B000620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B000620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeIHCVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:21:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeIHCVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:21:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4E62D6B;
        Fri,  7 Sep 2018 21:38:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.9 63/63] fs/quota: Fix spectre gadget in do_quotactl
Date:   Fri,  7 Sep 2018 23:10:34 +0200
Message-Id: <20180907211016.418973601@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

commit 7b6924d94a60c6b8c1279ca003e8744e6cd9e8b1 upstream.

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
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/quota/quota.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -17,6 +17,7 @@
 #include <linux/quotaops.h>
 #include <linux/types.h>
 #include <linux/writeback.h>
+#include <linux/nospec.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -706,6 +707,7 @@ static int do_quotactl(struct super_bloc
 
 	if (type >= (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
 		return -EINVAL;
+	type = array_index_nospec(type, MAXQUOTAS);
 	/*
 	 * Quota not supported on this fs? Check this before s_quota_types
 	 * since they needn't be set if quota is not supported at all.


