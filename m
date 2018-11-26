Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B062084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kPXTuxwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B062084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeKZMvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:51:02 -0500
Received: from m12-14.163.com ([220.181.12.14]:45641 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZMvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=buvgAOLwqloDZN9VvB
        9AgWN/CLf0MdCHRVAHlRRuGsI=; b=kPXTuxwzDntOWfqBCGfz3LhHGFyOauA+Av
        IU/iMPUHF3Pviap2/ixs9Yr/e5CgXWPWnAsSaIqkfWsHIsKf6ozQQeI0OCQNRwG9
        SwievB5I+sqi//2IiALFwcADPezcfNifW4uIU2WPMZjpmGuAzZQOT2WSV1HlQbZz
        /xKlLWAqQ=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowACHXNU3U_tbwMqkBw--.49337S3;
        Mon, 26 Nov 2018 09:58:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Ian Kent <raven@themaw.net>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] autofs: drop dentry reference only when it is never used
Date:   Mon, 26 Nov 2018 09:58:14 +0800
Message-Id: <1543197494-15688-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowACHXNU3U_tbwMqkBw--.49337S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr45tw4rCw43KF47WrW7urg_yoWDCrb_ua
        1UurWxWrWrJr1Fya17GrWftFn3WryrJFW8Zw4Svr1agFy5KFnrW3s8Jas8urWDW347AFW5
        Zr1qkr98CFy5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0loGPUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVBILclUMGKDOuwAAsr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function autofs_expire_run calls dput(dentry) to drop the reference
count of dentry. However, dentry is read via autofs_dentry_ino(dentry)
after that. This may result in a use-free-bug. The patch drops the
reference count of dentry only when it is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/autofs/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index d441244..28d9c2b 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -596,7 +596,6 @@ int autofs_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if (copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)))
 		ret = -EFAULT;
@@ -609,6 +608,8 @@ int autofs_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 
-- 
2.7.4


