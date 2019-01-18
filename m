Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FAEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1670B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOyZK/XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfARQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:15:03 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:54448 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfARQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:15:01 -0500
Received: by mail-yw1-f74.google.com with SMTP id f10so7128834ywc.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=acKuHWDxCAo2HtjYv0zQtkcTtJK21uLYyRX29pjdtaY=;
        b=OOyZK/XV1Jf2ajxcEWDA2gNbmCgZ01lv9jDs5rhxuE11ERFuA+qJCOuXhBuUgVc5Nm
         AqgltZ82enjTRDDWDBYQW3yYdDVAjtLQbe8gpl8f5ZG8cJ1fCo8Q47CqvXoxANRYA1GV
         Rk9yt7+262HG/5T6fv1J9FCZfMi30ksa9EeLFaa4skxzjylHpN4SbHb8osRYGDEKR6Hk
         8Rmr/NW/00g9X5yLT7/66sPw6D7/7/vjCSmLWM+xz8owAj8Y1l9ifR6/QmwAHeN1H8tD
         YTVbl1t7b8FB963/C0+dTasPIvpFm52jx3yZkI9m9i9gwICGMHbwu6kq3vapYIxrHXZ6
         JtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=acKuHWDxCAo2HtjYv0zQtkcTtJK21uLYyRX29pjdtaY=;
        b=RWr979Awhip5hl4KtbuyqBVzI3m0bRBTaeUKzeJxGcARCUgnlPxDVoBUUyQZdsqfVv
         rmiuBAVfpUm5ZkM2Wh5uMlU35yNlVMPJCwZgIirkfmWBbNQz5ca0J+Q3VynYlPDaDcfQ
         S9DBuNHX7+yO7nHOk7l1x6HDR8R7+Jsx0lkI9wAsx2681qtxzKrjXo4fmorOIxDW9gtf
         ydtcdTLUt6fcLW6Kv4/v9jZ/WUwyiBedt0llrgl2MCN5SyQahqCDSZPxg17bLjSrjmd2
         c/KqIA62o04AMcCW870T/Hid2mAhSh8PB2ELnuDGuJw3/kKZsZe1W4KbBZF0LeqecQbs
         gYAA==
X-Gm-Message-State: AJcUukeBNM5nYYYGCz0IfRlnaqygB8d4wcvnD676scjQeIvAny5J3qgh
        z5dvzTnojNloyyCX/tze03Nls6KqPQ==
X-Google-Smtp-Source: ALg8bN6WwyE31vQy/QLWcGSt63VbxDzoBHIcTgnWRt/U+D9i0B2yEe0Epxbgaf+avn6IqoKxIxVeqO2moA==
X-Received: by 2002:a81:52c7:: with SMTP id g190mr9425001ywb.4.1547828100227;
 Fri, 18 Jan 2019 08:15:00 -0800 (PST)
Date:   Fri, 18 Jan 2019 17:14:38 +0100
Message-Id: <20190118161440.220134-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
From:   Jann Horn <jannh@google.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        jannh@google.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple filesystems can already return EFSCORRUPTED errors to userspace;
however, so far, definitions of EFSCORRUPTED were in filesystem-private
headers.

I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
Dave Chinner says that I should instead hoist the definitions of
EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.

This patch is marked for stable backport because it is a prerequisite for
the following patch.

Cc: stable@vger.kernel.org
Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/ext2/ext2.h                   | 1 -
 fs/ext4/ext4.h                   | 1 -
 fs/xfs/xfs_linux.h               | 1 -
 include/linux/jbd2.h             | 1 -
 include/uapi/asm-generic/errno.h | 1 +
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index e770cd100a6a..7fafc19e5aa0 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -369,7 +369,6 @@ struct ext2_inode {
  */
 #define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
 #define	EXT2_ERROR_FS			0x0002	/* Errors detected */
-#define	EFSCORRUPTED			EUCLEAN	/* Filesystem is corrupted */
 
 /*
  * Mount flags
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 185a05d3257e..9397e97fc15b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3247,6 +3247,5 @@ extern const struct iomap_ops ext4_iomap_ops;
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _EXT4_H */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index edbd5a210df2..36e5c6549f15 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -125,7 +125,6 @@ typedef __u32			xfs_nlink_t;
 
 #define ENOATTR		ENODATA		/* Attribute not found */
 #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 
 #define SYNCHRONIZE()	barrier()
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0f919d5fe84f..1d0da9c78216 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1640,6 +1640,5 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _LINUX_JBD2_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..5ddebc1bf951 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -98,6 +98,7 @@
 #define	EINPROGRESS	115	/* Operation now in progress */
 #define	ESTALE		116	/* Stale file handle */
 #define	EUCLEAN		117	/* Structure needs cleaning */
+#define	EFSCORRUPTED	EUCLEAN	/* Filesystem is corrupted */
 #define	ENOTNAM		118	/* Not a XENIX named type file */
 #define	ENAVAIL		119	/* No XENIX semaphores available */
 #define	EISNAM		120	/* Is a named type file */
-- 
2.20.1.321.g9e740568ce-goog

