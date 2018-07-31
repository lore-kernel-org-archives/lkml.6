Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5ABC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1AC208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1AC208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeGaDPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:15:34 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35866 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbeGaDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:15:33 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so5156344ywg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VvzPI77O91f6C4e11bmQuxuRY/YPGS2bBG30MPbG5KE=;
        b=s0UNAs5L9W3/iVQZqOz+VoXlM+IrF6rDYgy5dPEHw1TSb89PWUdy3z24cjOjxi/JC1
         rC25QNssvXsYKKMK3PmQqdSrqK4RZ9d1CTMFa++5+A+84VOxdf9FwkjfN/53+uaQrKVJ
         LlWsun+z36VyJVkdAq6XJ6rHbMFsNRezuz0JqZ1x+xD1nJOBTPn5cIr7etsZ37GEE224
         J5Zx7ELfJ0+xtkvJyQFvtzgwV/upWM6kV3Vjm7GTF2YM5u3gZjV4qaOrUqYYXT7FzRnQ
         dc76uGrThA4riotpZl6gOc9vnGuUqRprIblRYzVfdH8XlJK3xTk6KGcJsuFc8HlqsGVe
         IAxg==
X-Gm-Message-State: AOUpUlE/THlhL9+d8F+YUooc62jkonc3Lf+r4GlZaj9Jp3xBkojvP3ch
        KX+Q2mER/Ud0hIfj+TvWiJdvog==
X-Google-Smtp-Source: AAOMgpf5C56sYwe7fuHPHncQ13Lz7QzkpbWPSYGImY+DO7OjtUSf6dpj9r7ADzcXx7qnuwrv5Nms4A==
X-Received: by 2002:a0d:e501:: with SMTP id o1-v6mr9966939ywe.409.1533001062356;
        Mon, 30 Jul 2018 18:37:42 -0700 (PDT)
Received: from builder.jcline.org ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id y133-v6sm13800287ywy.31.2018.07.30.18.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 18:37:41 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 1/2] fs/quota: Replace XQM_MAXQUOTAS usage with MAXQUOTAS
Date:   Tue, 31 Jul 2018 01:37:30 +0000
Message-Id: <20180731013731.1987-2-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731013731.1987-1-jcline@redhat.com>
References: <20180731013731.1987-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XQM_MAXQUOTAS and MAXQUOTAS are, it appears, equivalent. Replace all
usage of XQM_MAXQUOTAS and remove it along with the unused XQM_*QUOTA
definitions.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 fs/quota/quota.c               | 12 +++++-------
 include/linux/quota.h          |  8 +-------
 include/uapi/linux/dqblk_xfs.h |  5 -----
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 860bfbe7a07a..d403392d8a0f 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -120,8 +120,6 @@ static int quota_getinfo(struct super_block *sb, int type, void __user *addr)
 	struct if_dqinfo uinfo;
 	int ret;
 
-	/* This checks whether qc_state has enough entries... */
-	BUILD_BUG_ON(MAXQUOTAS > XQM_MAXQUOTAS);
 	if (!sb->s_qcop->get_state)
 		return -ENOSYS;
 	ret = sb->s_qcop->get_state(sb, &state);
@@ -354,10 +352,10 @@ static int quota_getstate(struct super_block *sb, struct fs_quota_stat *fqs)
 	 * GETXSTATE quotactl has space for just one set of time limits so
 	 * report them for the first enabled quota type
 	 */
-	for (type = 0; type < XQM_MAXQUOTAS; type++)
+	for (type = 0; type < MAXQUOTAS; type++)
 		if (state.s_state[type].flags & QCI_ACCT_ENABLED)
 			break;
-	BUG_ON(type == XQM_MAXQUOTAS);
+	BUG_ON(type == MAXQUOTAS);
 	fqs->qs_btimelimit = state.s_state[type].spc_timelimit;
 	fqs->qs_itimelimit = state.s_state[type].ino_timelimit;
 	fqs->qs_rtbtimelimit = state.s_state[type].rt_spc_timelimit;
@@ -427,10 +425,10 @@ static int quota_getstatev(struct super_block *sb, struct fs_quota_statv *fqs)
 	 * GETXSTATV quotactl has space for just one set of time limits so
 	 * report them for the first enabled quota type
 	 */
-	for (type = 0; type < XQM_MAXQUOTAS; type++)
+	for (type = 0; type < MAXQUOTAS; type++)
 		if (state.s_state[type].flags & QCI_ACCT_ENABLED)
 			break;
-	BUG_ON(type == XQM_MAXQUOTAS);
+	BUG_ON(type == MAXQUOTAS);
 	fqs->qs_btimelimit = state.s_state[type].spc_timelimit;
 	fqs->qs_itimelimit = state.s_state[type].ino_timelimit;
 	fqs->qs_rtbtimelimit = state.s_state[type].rt_spc_timelimit;
@@ -701,7 +699,7 @@ static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
 {
 	int ret;
 
-	if (type >= (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
+	if (type >= MAXQUOTAS)
 		return -EINVAL;
 	/*
 	 * Quota not supported on this fs? Check this before s_quota_types
diff --git a/include/linux/quota.h b/include/linux/quota.h
index ca9772c8e48b..f32dd270b8e3 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -408,13 +408,7 @@ struct qc_type_state {
 
 struct qc_state {
 	unsigned int s_incoredqs;	/* Number of dquots in core */
-	/*
-	 * Per quota type information. The array should really have
-	 * max(MAXQUOTAS, XQM_MAXQUOTAS) entries. BUILD_BUG_ON in
-	 * quota_getinfo() makes sure XQM_MAXQUOTAS is large enough.  Once VFS
-	 * supports project quotas, this can be changed to MAXQUOTAS
-	 */
-	struct qc_type_state s_state[XQM_MAXQUOTAS];
+	struct qc_type_state s_state[MAXQUOTAS];  /* Per quota type information */
 };
 
 /* Structure for communicating via ->set_info */
diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
index 03d890b80ebc..a5846cde8272 100644
--- a/include/uapi/linux/dqblk_xfs.h
+++ b/include/uapi/linux/dqblk_xfs.h
@@ -27,11 +27,6 @@
 #define XQM_CMD(x)	(('X'<<8)+(x))	/* note: forms first QCMD argument */
 #define XQM_COMMAND(x)	(((x) & (0xff<<8)) == ('X'<<8))	/* test if for XFS */
 
-#define XQM_USRQUOTA	0	/* system call user quota type */
-#define XQM_GRPQUOTA	1	/* system call group quota type */
-#define XQM_PRJQUOTA	2	/* system call project quota type */
-#define XQM_MAXQUOTAS	3
-
 #define Q_XQUOTAON	XQM_CMD(1)	/* enable accounting/enforcement */
 #define Q_XQUOTAOFF	XQM_CMD(2)	/* disable accounting/enforcement */
 #define Q_XGETQUOTA	XQM_CMD(3)	/* get disk limits and usage */
-- 
2.17.1

