Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E34BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DE221526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DE221526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbeITU40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35959 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbeITU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so9803455wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BggGwWKGXXokyu52K8wXFItmEMyNGicA2mykH7uClkQ=;
        b=EK10Mhe0e/VXZkaTzz4Y1iShWe7R0tLUUMnibAOTXySKiZprv8nkBqHf67ZUYdocBm
         CZs6EoHDdZaKzwtbwKs3zitI92MpdLE4XfobWkR0vzgCMkZG79jvP+2v/CUXsrZcI0UL
         YYr1UCetc0WUFmydnyrFwDtuCbqus0F7eCgHXC+SBDlfbNeIMs/wkb98XnBoEsSh0EmZ
         MXgu3mR2kvTid4oOeQXb/xjg3FjJSmvUacWwCps+XNNMTouatG6HCYOtVnKAdp8uScTF
         cYv4j/kaKk0L4igU62MlZCzyqGE55BNb6mAgo8Zki+Mupy8G03yY8VNnekcoRilJabj3
         pIrg==
X-Gm-Message-State: APzg51DEilUTf0yFUvz8JUt/hUBAqjC+R4PXYfLffw50vH0c1FRYvt3P
        /vtbdQ2PiByL0piyTgcvdO5ekJAN5Yg=
X-Google-Smtp-Source: ANB0VdZWeack8Wqr8qRmg3+MsnuP6z7UD4KW/3EoHRPXM+Ijqd1f4QQBvUe2yQbv9ZttwN/AL7igYw==
X-Received: by 2002:a5d:4849:: with SMTP id n9-v6mr14803189wrs.234.1537456347866;
        Thu, 20 Sep 2018 08:12:27 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:27 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Date:   Thu, 20 Sep 2018 17:12:13 +0200
Message-Id: <20180920151214.15484-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180920151214.15484-1-mszeredi@redhat.com>
References: <20180920151214.15484-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What happens if we introduce new flags for fsmount(2) and are already out
of flags for mount(2)?  I see a big mess that way.

So let's instead start a clean new set, to be used in the new API.

The MS_RELATIME flag was accepted but ignored.  Simply leave this out of
the new set, since "relatime" is the default.

The MNT_ prefix is already used by libmount, and we don't want any
confusion arising from that.  MOUNT_ feels a bit too long, so just go with
the short and sweet M_ prefix.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 28 +++++++++++++---------------
 include/uapi/linux/mount.h |  9 +++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7671c1f6fc22..027b99b993c0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3332,7 +3332,7 @@ EXPORT_SYMBOL_GPL(kern_mount);
  * Create a kernel mount representation for a new, prepared superblock
  * (specified by fs_fd) and attach to an open_tree-like file descriptor.
  */
-SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags)
+SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, m_flags)
 {
 	struct fs_context *fc;
 	struct file *file;
@@ -3347,30 +3347,28 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
 		return -EINVAL;
 
-	if (ms_flags & ~(MS_RDONLY | MS_NOSUID | MS_NODEV | MS_NOEXEC |
-			 MS_NOATIME | MS_NODIRATIME | MS_RELATIME |
-			 MS_STRICTATIME))
+	if (m_flags & ~(M_RDONLY | M_NOSUID | M_NODEV | M_NOEXEC |
+			 M_NOATIME | M_STRICTATIME | M_NODIRATIME))
 		return -EINVAL;
 
-	if (ms_flags & MS_RDONLY)
+	if ((m_flags & M_STRICTATIME) && (m_flags & M_NOATIME))
+		return -EINVAL;
+
+	if (m_flags & M_RDONLY)
 		mnt_flags |= MNT_READONLY;
-	if (ms_flags & MS_NOSUID)
+	if (m_flags & M_NOSUID)
 		mnt_flags |= MNT_NOSUID;
-	if (ms_flags & MS_NODEV)
+	if (m_flags & M_NODEV)
 		mnt_flags |= MNT_NODEV;
-	if (ms_flags & MS_NOEXEC)
+	if (m_flags & M_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	if (ms_flags & MS_NODIRATIME)
+	if (m_flags & M_NODIRATIME)
 		mnt_flags |= MNT_NODIRATIME;
 
-	if (ms_flags & MS_STRICTATIME) {
-		if (ms_flags & MS_NOATIME)
-			return -EINVAL;
-	} else if (ms_flags & MS_NOATIME) {
+	if (m_flags & M_NOATIME)
 		mnt_flags |= MNT_NOATIME;
-	} else {
+	else if (!(m_flags & M_STRICTATIME))
 		mnt_flags |= MNT_RELATIME;
-	}
 
 	f = fdget(fs_fd);
 	if (!f.file)
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 3634e065836c..fce3513fc242 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -1,6 +1,15 @@
 #ifndef _UAPI_LINUX_MOUNT_H
 #define _UAPI_LINUX_MOUNT_H
 
+/* Mount flags passed to fsmount(2) */
+#define M_RDONLY	0x01
+#define M_NOSUID	0x02
+#define M_NODEV		0x04
+#define M_NOEXEC	0x08
+#define M_NOATIME	0x10
+#define M_STRICTATIME	0x20
+#define M_NODIRATIME	0x40
+
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  *
-- 
2.14.3

