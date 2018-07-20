Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7A620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbeGTN1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbeGTN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:46 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91857CF3;
        Fri, 20 Jul 2018 12:34:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        Ian Kent <raven@themaw.net>,
        syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 64/92] autofs: fix slab out of bounds read in getname_kernel()
Date:   Fri, 20 Jul 2018 14:14:08 +0200
Message-Id: <20180720121421.506015757@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit 02f51d45937f7bc7f4dee21e9f85b2d5eac37104 upstream.

The autofs subsystem does not check that the "path" parameter is present
for all cases where it is required when it is passed in via the "param"
struct.

In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
ioctl command.

To solve it, modify validate_dev_ioctl(function to check that a path has
been provided for ioctl commands that require it.

Link: http://lkml.kernel.org/r/153060031527.26631.18306637892746301555.stgit@pluto.themaw.net
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/autofs4/dev-ioctl.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -148,6 +148,15 @@ static int validate_dev_ioctl(int cmd, s
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
@@ -284,7 +293,8 @@ static int autofs_dev_ioctl_openmount(st
 	dev_t devid;
 	int err, fd;
 
-	/* param->path has already been checked */
+	/* param->path has been checked in validate_dev_ioctl() */
+
 	if (!param->openmount.devid)
 		return -EINVAL;
 
@@ -446,10 +456,7 @@ static int autofs_dev_ioctl_requester(st
 	dev_t devid;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has been checked in validate_dev_ioctl() */
 
 	devid = sbi->sb->s_dev;
 
@@ -534,10 +541,7 @@ static int autofs_dev_ioctl_ismountpoint
 	unsigned int devid, magic;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has been checked in validate_dev_ioctl() */
 
 	name = param->path;
 	type = param->ismountpoint.in.type;


