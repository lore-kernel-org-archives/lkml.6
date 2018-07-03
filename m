Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADBAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C96A21581
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C96A21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeGCGpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:45:21 -0400
Received: from icp-osb-irony-out2.external.iinet.net.au ([203.59.1.155]:36218
        "EHLO icp-osb-irony-out2.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753213AbeGCGpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:45:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AYAwA8Gjtb/1SrLHlcg3qBTxIog3mUR?=
 =?us-ascii?q?UkBAQEBAQEGgRA1iB2EKYhOgXoeGAGEQIM7ITQYAQIBAQEBAQECbSiFYARSKAE?=
 =?us-ascii?q?MAhgOAiMmFhOFCAMIDKkWgWkzGgKGew2BLoE6gQuHYoEOgQeBQoUyhSWCVQKMT?=
 =?us-ascii?q?jsti2UrCYwSgwuBQIZlAw+FHgErileIRjiBUk0uCoMkkF8yMHoBAY0iK4IbAQE?=
X-IPAS-Result: =?us-ascii?q?A2AYAwA8Gjtb/1SrLHlcg3qBTxIog3mURUkBAQEBAQEGgRA?=
 =?us-ascii?q?1iB2EKYhOgXoeGAGEQIM7ITQYAQIBAQEBAQECbSiFYARSKAEMAhgOAiMmFhOFC?=
 =?us-ascii?q?AMIDKkWgWkzGgKGew2BLoE6gQuHYoEOgQeBQoUyhSWCVQKMTjsti2UrCYwSgwu?=
 =?us-ascii?q?BQIZlAw+FHgErileIRjiBUk0uCoMkkF8yMHoBAY0iK4IbAQE?=
X-IronPort-AV: E=Sophos;i="5.51,302,1526313600"; 
   d="scan'208";a="122265891"
Received: from unknown (HELO pluto.themaw.net) ([121.44.171.84])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 03 Jul 2018 14:45:16 +0800
Subject: [PATCH] autofs - fix slab out of bounds read in getname_kernel()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 03 Jul 2018 14:45:15 +0800
Message-ID: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial patch contributed by Tomas Bortoli.

The autofs subsystem does not check that the "path" parameter is
present for all cases where it is required when it is passed in
via the "param" struct.

In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
ioctl command.

To solve it, modify validate_dev_ioctl() function to check that a
path has been provided for ioctl commands that require it.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
---
 fs/autofs/dev-ioctl.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index ea4ca1445ab7..86eafda4a652 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -135,6 +135,15 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 				cmd);
 			goto out;
 		}
+	} else {
+		unsigned int inr = _IOC_NR(cmd);
+
+		if (inr == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
+		    inr == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
+		    inr == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	err = 0;
@@ -271,7 +280,8 @@ static int autofs_dev_ioctl_openmount(struct file *fp,
 	dev_t devid;
 	int err, fd;
 
-	/* param->path has already been checked */
+	/* param->path has been checked in validate_dev_ioctl() */
+
 	if (!param->openmount.devid)
 		return -EINVAL;
 
@@ -433,10 +443,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	dev_t devid;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has been checked in validate_dev_ioctl() */
 
 	devid = sbi->sb->s_dev;
 
@@ -521,10 +528,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 	unsigned int devid, magic;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has been checked in validate_dev_ioctl() */
 
 	name = param->path;
 	type = param->ismountpoint.in.type;

