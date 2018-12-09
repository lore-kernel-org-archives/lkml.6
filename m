Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E3FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E5C20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E5C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeLIWOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38036 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbeLIWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73B-0002iY-Vb; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003QG-5T; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jeremy Cline" <jcline@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>, "Jan Kara" <jack@suse.cz>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.755942707@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 154/328] fs/quota: Fix spectre gadget in do_quotactl
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[bwh: Backported to 3.16: The maximum valid quota type is command-dependent.
 Introduce a local variable rather than repeating the expression.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -17,6 +17,7 @@
 #include <linux/quotaops.h>
 #include <linux/types.h>
 #include <linux/writeback.h>
+#include <linux/nospec.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -405,10 +406,12 @@ static int quota_rmxquota(struct super_b
 static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
 		       void __user *addr, struct path *path)
 {
+	unsigned int max_quotas = XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS;
 	int ret;
 
-	if (type >= (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
+	if (type >= max_quotas)
 		return -EINVAL;
+	type = array_index_nospec(type, max_quotas);
 	if (!sb->s_qcop)
 		return -ENOSYS;
 

