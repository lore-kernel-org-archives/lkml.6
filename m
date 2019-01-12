Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1360420878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfALAJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:09:46 -0500
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:46786
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfALAJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:09:45 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 19:09:45 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ABAADXLDlc//yp0HYNVhoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgVEFAQEBAQsBgmmBKYQBiBqMPwEBBoEQg2uFaY5LgXsohEw?=
 =?us-ascii?q?DAoJNNAkNAQMBAQEBAQECgQmFWScEUigBBwUCJgJJFhODI4FpAwiuAHF8Mxq?=
 =?us-ascii?q?HcQSCJoELgXOJWHiBB4FEhWSBRYNAglcCj3dJNpEFCYcaiwELAoFXiEgDD4c?=
 =?us-ascii?q?/nCmCDk0uCoMnCYpRhg9liAqCTQEB?=
X-IPAS-Result: =?us-ascii?q?A2ABAADXLDlc//yp0HYNVhoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VEFAQEBAQsBgmmBKYQBiBqMPwEBBoEQg2uFaY5LgXsohEwDAoJNNAkNAQMBA?=
 =?us-ascii?q?QEBAQECgQmFWScEUigBBwUCJgJJFhODI4FpAwiuAHF8MxqHcQSCJoELgXOJW?=
 =?us-ascii?q?HiBB4FEhWSBRYNAglcCj3dJNpEFCYcaiwELAoFXiEgDD4c/nCmCDk0uCoMnC?=
 =?us-ascii?q?YpRhg9liAqCTQEB?=
X-IronPort-AV: E=Sophos;i="5.56,467,1539619200"; 
   d="scan'208";a="155670348"
Received: from unknown (HELO [192.168.1.228]) ([118.208.169.252])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 12 Jan 2019 08:00:27 +0800
Subject: [PATCH 1/3] autofs: drop dentry reference only when it is never used
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Date:   Sat, 12 Jan 2019 08:00:24 +0800
Message-ID: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

The function autofs_expire_run calls dput(dentry) to drop the reference
count of dentry. However, dentry is read via autofs_dentry_ino(dentry)
after that. This may result in a use-free-bug. The patch drops the
reference count of dentry only when it is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index d441244b79df..28d9c2b1b3bb 100644
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
 

