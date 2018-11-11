Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F83C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8B9223C8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmpwVl1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8B9223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbeKLIRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732069AbeKLIRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4485D22353;
        Sun, 11 Nov 2018 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975275;
        bh=m15dQen3davKIidG4RJ/ddGJClbMAQu+iOcmzuG/I7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmpwVl1z7nB04AzS+uBJp9Q5MasvBD92MKUcqsi6FvPtyj/sid7S0s6TcilUJWmwK
         2zM5fCeOwpgoXipopiCd8FB41TmwdvraP2/9E94+UEceWPeogbop99MTb66JoU9eb5
         8Q5TXjK9e/FJUUeJqVSwZFBpTGtkCiG14LDxsQjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 184/361] f2fs: report error if quota off error during umount
Date:   Sun, 11 Nov 2018 14:18:51 -0800
Message-Id: <20181111221646.140564851@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlei He <heyunlei@huawei.com>

[ Upstream commit cda9cc595f0bb6ffa51a4efc4b6533dfa4039b4c ]

Now, we depend on fsck to ensure quota file data is ok,
so we scan whole partition if checkpoint without umount
flag. It's same for quota off error case, which may make
quota file data inconsistent.

generic/019 reports below error:

 __quota_error: 1160 callbacks suppressed
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...

If we failed in below path due to fail to write dquot block, we will miss
to release quota inode, fix it.

- f2fs_put_super
 - f2fs_quota_off_umount
  - f2fs_quota_off
   - f2fs_quota_sync   <-- failed
   - dquot_quota_off   <-- missed to call

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1852,7 +1852,9 @@ static int f2fs_quota_off(struct super_b
 	if (!inode || !igrab(inode))
 		return dquot_quota_off(sb, type);
 
-	f2fs_quota_sync(sb, type);
+	err = f2fs_quota_sync(sb, type);
+	if (err)
+		goto out_put;
 
 	err = dquot_quota_off(sb, type);
 	if (err || f2fs_sb_has_quota_ino(sb))
@@ -1871,9 +1873,20 @@ out_put:
 void f2fs_quota_off_umount(struct super_block *sb)
 {
 	int type;
+	int err;
 
-	for (type = 0; type < MAXQUOTAS; type++)
-		f2fs_quota_off(sb, type);
+	for (type = 0; type < MAXQUOTAS; type++) {
+		err = f2fs_quota_off(sb, type);
+		if (err) {
+			int ret = dquot_quota_off(sb, type);
+
+			f2fs_msg(sb, KERN_ERR,
+				"Fail to turn off disk quota "
+				"(type: %d, err: %d, ret:%d), Please "
+				"run fsck to fix it.", type, err, ret);
+			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
+		}
+	}
 }
 
 static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)


