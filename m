Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B09FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC08520890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC08520890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeILUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:07:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52626 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeILUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:07:08 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MHfXI-1fz0Bb1MVw-003Iuh; Wed, 12 Sep 2018 17:01:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] compat_ioctl: add generic_compat_ioctl_ptrarg()
Date:   Wed, 12 Sep 2018 17:01:02 +0200
Message-Id: <20180912150142.157913-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:wz6vo7KIM91kt111ot1ATETat4nUfGMJb8FLy77lzIOkc5wfyKu
 wZ0kYboXWyxsU5awQ3oUor82AlfAk3f/J5do+S5nfBJ3NEq3BC0adeGjkRg7oKf9xNDEut+
 G3FwLM38ozOo3reZvfH6A0GecwDdx0aFfDjei3/mnJfoAnAYXWrLzMYPVK1RiOrbUWIXLNr
 HK0bIJ/e46ESuPiBdwWoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aeLDAMsSyZE=:TVJ+SS9XztZ8PspfoWbgn/
 QNGobgx/T3o6iRMkQ3R0C7VYzxGUQaCkU5TKbbUzzcePfqFWWa/LkJEtrcf0mBBN2sh9GZ6UO
 B9aiG2BtIaOs2ABbhYn9UurSrwk7wF21ZFJSz9Vw6sHR7Vh/nni9/XqVCaFqj3lhNtwIrXIbi
 scBywI3tltnx7LSQ55lcGl3TaKa94zB6Iu8ct08cbFy6wuzvFgWnw+3KF5Hr1/vex8+JEhuYe
 fPO66u961mjnEJLXTfE8e8gCuU0twUPBBp+VP42gRGBzoLI+jo1ge4BcgYdATtwND7qjsfR6G
 xXyJfCbYx/wM9QnOfoOUjC3UcCKe8hwUgpg8eHLCz5ZMxfjhjANZRgGEDL2OlFDNKWcI5gNsx
 uLl/OFqG/+3Fk5DOnFWC9Nnf0fWXJCJnYHRzoJ/Yi51o1RGHIxEyUmgywAmboS4zo7+NLHBMs
 1uMFkDA4Wh+gRsF8fVMZ9wLNItKcISagcEFdgyaAISXgWPzHGMuMepzUYU1rfongDROfjJqIO
 UqpWXHDWAi4tmqX+0xU/RJNdbX6KxlPiePnRHcSSGsR6wDSKoXB7DrNBuvu38Q6xQzByqzooc
 Oma7aA+m3VDKkLZ8nnTW3ZHZ1dG0uGy2fK0qmMtb5uVzfLBNxH5OJNEy31SX5I9ngKmGSKfMt
 tzcmXYpqgCXAVsOVBqzBA9MhfmifdHfENpWA62tuFN5bgATU5l2YCe/h31cVpmhv0cUY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers have ioctl() handlers that are completely compatible
between 32-bit and 64-bit architectures, except for the argument
that is passed down from user space and may have to be passed
through compat_ptr() in order to become a valid 64-bit pointer.

Using ".compat_ptr=generic_compat_ioctl_ptrarg" in file operations
should let us simplify a lot of those drivers to avoid #ifdef
checks, and convert additional drivers that don't have proper
compat handling yet.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c  | 10 ++++++++++
 include/linux/fs.h |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a9b00942e87d..2d7c7e149083 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -122,6 +122,16 @@
 	get_user(val, srcptr) || put_user(val, dstptr);	\
 })
 
+/* helper function to avoid trivial compat_ioctl() implementations */
+long generic_compat_ioctl_ptrarg(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (!file->f_op->unlocked_ioctl)
+		return -ENOIOCTLCMD;
+
+	return file->f_op->unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+EXPORT_SYMBOL_GPL(generic_compat_ioctl_ptrarg);
+
 static int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 33322702c910..18a90aa2dc93 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1643,6 +1643,13 @@ int vfs_mkobj(struct dentry *, umode_t,
 
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
+#ifdef CONFIG_COMPAT
+extern long generic_compat_ioctl_ptrarg(struct file *file, unsigned int cmd,
+					unsigned long arg);
+#else
+#define generic_compat_ioctl_ptrarg NULL
+#endif
+
 /*
  * VFS file helper functions.
  */
-- 
2.18.0

