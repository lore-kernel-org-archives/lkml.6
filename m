Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64641C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D60208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D60208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeGLLLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:25 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58380 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeGLLLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id AE9AD18188FB1;
        Thu, 12 Jul 2018 13:02:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/5] ubifs: Allow setting assert action as mount parameter
Date:   Thu, 12 Jul 2018 13:01:59 +0200
Message-Id: <20180712110200.13054-5-richard@nod.at>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110200.13054-1-richard@nod.at>
References: <20180712110200.13054-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose our three options to userspace.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/misc.c  | 11 +++++++++++
 fs/ubifs/misc.h  |  2 ++
 fs/ubifs/super.c | 24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/fs/ubifs/misc.c b/fs/ubifs/misc.c
index 586fd5b578a7..cd23de0f211d 100644
--- a/fs/ubifs/misc.c
+++ b/fs/ubifs/misc.c
@@ -56,3 +56,14 @@ void ubifs_warn(const struct ubifs_info *c, const char *fmt, ...)
 
 	va_end(args);
 }
+
+static char *assert_names[] = {
+	[ASSACT_REPORT] = "report",
+	[ASSACT_RO] = "read-only",
+	[ASSACT_PANIC] = "panic",
+};
+
+const char *ubifs_assert_action_name(struct ubifs_info *c)
+{
+	return assert_names[c->assert_action];
+}
diff --git a/fs/ubifs/misc.h b/fs/ubifs/misc.h
index f5d180c0c52e..21d35d7dd975 100644
--- a/fs/ubifs/misc.h
+++ b/fs/ubifs/misc.h
@@ -287,4 +287,6 @@ static inline int ubifs_next_log_lnum(const struct ubifs_info *c, int lnum)
 	return lnum;
 }
 
+const char *ubifs_assert_action_name(struct ubifs_info *c);
+
 #endif /* __UBIFS_MISC_H__ */
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index c2796373b837..524122da7868 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -445,6 +445,7 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
 			   ubifs_compr_name(c, c->mount_opts.compr_type));
 	}
 
+	seq_printf(s, ",assert=%s", ubifs_assert_action_name(c));
 	seq_printf(s, ",ubi=%d,vol=%d", c->vi.ubi_num, c->vi.vol_id);
 
 	return 0;
@@ -922,6 +923,7 @@ static int check_volume_empty(struct ubifs_info *c)
  * Opt_chk_data_crc: check CRCs when reading data nodes
  * Opt_no_chk_data_crc: do not check CRCs when reading data nodes
  * Opt_override_compr: override default compressor
+ * Opt_assert: set ubifs_assert() action
  * Opt_err: just end of array marker
  */
 enum {
@@ -932,6 +934,7 @@ enum {
 	Opt_chk_data_crc,
 	Opt_no_chk_data_crc,
 	Opt_override_compr,
+	Opt_assert,
 	Opt_ignore,
 	Opt_err,
 };
@@ -946,6 +949,7 @@ static const match_table_t tokens = {
 	{Opt_override_compr, "compr=%s"},
 	{Opt_ignore, "ubi=%s"},
 	{Opt_ignore, "vol=%s"},
+	{Opt_assert, "assert=%s"},
 	{Opt_err, NULL},
 };
 
@@ -1046,6 +1050,26 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 			c->default_compr = c->mount_opts.compr_type;
 			break;
 		}
+		case Opt_assert:
+		{
+			char *act = match_strdup(&args[0]);
+
+			if (!act)
+				return -ENOMEM;
+			if (!strcmp(act, "report"))
+				c->assert_action = ASSACT_REPORT;
+			else if (!strcmp(act, "read-only"))
+				c->assert_action = ASSACT_RO;
+			else if (!strcmp(act, "panic"))
+				c->assert_action = ASSACT_PANIC;
+			else {
+				ubifs_err(c, "unknown assert action \"%s\"", act);
+				kfree(act);
+				return -EINVAL;
+			}
+			kfree(act);
+			break;
+		}
 		case Opt_ignore:
 			break;
 		default:
-- 
2.18.0

