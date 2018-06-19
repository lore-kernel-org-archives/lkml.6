Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A42AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2776F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2776F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966646AbeFSPjI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:39:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:39:07 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MNhBG-1fY4fH2Tyk-007HBR; Tue, 19 Jun 2018 17:38:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        codalist@coda.cs.cmu.edu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coda: stop using 'struct timespec' in user API
Date:   Tue, 19 Jun 2018 17:37:35 +0200
Message-Id: <20180619153822.3638475-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:TWSuSmbjFQtM41wgZekLNT3mbeGekGXfaTI8DVH+NQeQ+u1FYeb
 X+mtseh07BzgnLYLRcJrtFcG//7vgfWmLxGACZSxbKtwEpYl5b6+4QaPqU6UB7FOrEsw6bI
 6ZL+TNjEdMZ5HHFtMCeWWvE2QWEpn/X4Nz7DQNSuQarOWf7CkjjVnbzNhQj/J96hVwKz23l
 /Z1k2LC8O9I6Ngn1w2qOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aa5B2qAMyxA=:ZkysyUZGEuN4riIG88LclP
 iRvwoOSAmEsrfeniKC2LcGNRO1w7X9+lpmou5FP+W27Ytv4iKGubZqjSCggaqIGH33Amr419H
 kHFkJnN+MrChkLu7aVLp9yzkisxZWY55yyGVkcQdS0cBqppUP5K2c67M+gZiuvBE3Yn61KiOl
 jWW39Z4TXOQuOaUK/egbEftDt76OR7o4WioebfmK2Xllx9AvbUNNoadFsggcy4cki01QUZgdA
 W0jrikwwvXTUXdM6DuJvq/j/vEhAURqWEtfiyCoz3ML7NmRj+3m+kx1OauB6fbVTWOzLADBvd
 vkUypINJPZBUBqiD0HECBFaLocXaYwKjy35ECIqtNkrz73qPXhaxpT/dVpoiBz8WfYU/ks2oq
 WPD5uO0SxrlfYW8GsWw+dCrp2DcGtvOWJC/6gMYZsMgsxc2Xepnw/Ose6PMEJkxPnTj7GlihW
 fde1e1N7brMUTxOZIN2PNz6M+mvELlUbMgF0cCxcaPyhO0ig0lmhp3zdU+R2qkMwRPnXSORC1
 gX1ZTFQVGVyDscoXZVEw7ANLF6v0JXSlqykjs35QDkZ/wJ0ul0uUS38kidyh/RhNBkUyhBwNm
 DARsJ8XttVLgnx1twuEWwTRtZxv6gdm8KzVytlKo9PD/tjURETaMnPsyYuHoqa95QpoFZr71p
 yFLbDGckNOLIcIrXP2ugQjtqKLR6c7FFlUFthVieYofuF0gRRC8P2gvWhxV8+dV5QwwY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We exchange file timestamps with user space using psdev device
read/write operations with a fixed but architecture specific binary
layout.

On 32-bit systems, this uses a 'timespec' structure that is defined by
the C library to contain two 32-bit values for seconds and nanoseconds.
As we get ready for the year 2038 overflow of the 32-bit signed seconds,
the kernel now uses 64-bit timestamps internally, and user space will
do the same change by changing the 'timespec' definition in the future.

Unfortunately, this breaks the layout of the coda_vattr structure, so
we need to redefine that in terms of something that does not change.
I'm introducing a new 'struct vtimespec' structure here that keeps
the existing layout, and the same change has to be done in the coda
user space copy of linux/coda.h before anyone can use that on a 32-bit
architecture with 64-bit time_t.

An open question is what should happen to actual times past y2038,
as they are now truncated to the last valid date when sent to user
space, and interpreted as pre-1970 times when a timestamp with the
MSB set is read back into the kernel. Alternatively, we could
change the new timespec64_to_coda()/coda_to_timespec64() functions
to use a different interpretation and extend the available range
further to the future by disallowing past timestamps. This would
require more changes in the user space side though.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/filesystems/coda.txt | 11 ++++++---
 fs/coda/coda_linux.c               | 50 +++++++++++++++++++++++++++++---------
 include/uapi/linux/coda.h          | 20 ++++++++++++---
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/coda.txt b/Documentation/filesystems/coda.txt
index 61311356025d..ea5969068895 100644
--- a/Documentation/filesystems/coda.txt
+++ b/Documentation/filesystems/coda.txt
@@ -481,7 +481,10 @@ kernel support.
 
 
 
-
+  struct vtimespec {
+          long            tv_sec;         /* seconds */
+          long            tv_nsec;        /* nanoseconds */
+  };
 
   struct coda_vattr {
           enum coda_vtype va_type;        /* vnode type (for create) */
@@ -493,9 +496,9 @@ kernel support.
           long            va_fileid;      /* file id */
           u_quad_t        va_size;        /* file size in bytes */
           long            va_blocksize;   /* blocksize preferred for i/o */
-          struct timespec va_atime;       /* time of last access */
-          struct timespec va_mtime;       /* time of last modification */
-          struct timespec va_ctime;       /* time file changed */
+          struct vtimespec va_atime;      /* time of last access */
+          struct vtimespec va_mtime;      /* time of last modification */
+          struct vtimespec va_ctime;      /* time file changed */
           u_long          va_gen;         /* generation number of file */
           u_long          va_flags;       /* flags defined for file */
           dev_t           va_rdev;        /* device special file represents */
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index f3d543dd9a98..8addcd166908 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -66,6 +66,32 @@ unsigned short coda_flags_to_cflags(unsigned short flags)
 	return coda_flags;
 }
 
+static struct timespec64 coda_to_timespec64(struct vtimespec ts)
+{
+	/*
+	 * We interpret incoming timestamps as 'signed' to match traditional
+	 * usage and support pre-1970 timestamps, but this breaks in y2038
+	 * on 32-bit machines.
+	 */
+	struct timespec64 ts64 = {
+		.tv_sec = ts.tv_sec,
+		.tv_nsec = ts.tv_nsec,
+	};
+
+	return ts64;
+}
+
+static struct vtimespec timespec64_to_coda(struct timespec64 ts64)
+{
+	/* clamp the timestamps to the maximum range rather than wrapping */
+	struct vtimespec ts = {
+		.tv_sec = lower_32_bits(clamp_t(time64_t, ts64.tv_sec,
+						LONG_MIN, LONG_MAX)),
+		.tv_nsec = ts64.tv_nsec,
+	};
+
+	return ts;
+}
 
 /* utility functions below */
 void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
@@ -105,11 +131,11 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 	if (attr->va_size != -1)
 		inode->i_blocks = (attr->va_size + 511) >> 9;
 	if (attr->va_atime.tv_sec != -1) 
-		inode->i_atime = timespec_to_timespec64(attr->va_atime);
+		inode->i_atime = coda_to_timespec64(attr->va_atime);
 	if (attr->va_mtime.tv_sec != -1)
-		inode->i_mtime = timespec_to_timespec64(attr->va_mtime);
+		inode->i_mtime = coda_to_timespec64(attr->va_mtime);
         if (attr->va_ctime.tv_sec != -1)
-		inode->i_ctime = timespec_to_timespec64(attr->va_ctime);
+		inode->i_ctime = coda_to_timespec64(attr->va_ctime);
 }
 
 
@@ -130,12 +156,12 @@ void coda_iattr_to_vattr(struct iattr *iattr, struct coda_vattr *vattr)
         vattr->va_uid = (vuid_t) -1; 
         vattr->va_gid = (vgid_t) -1;
         vattr->va_size = (off_t) -1;
-	vattr->va_atime.tv_sec = (time_t) -1;
-	vattr->va_atime.tv_nsec =  (time_t) -1;
-        vattr->va_mtime.tv_sec = (time_t) -1;
-        vattr->va_mtime.tv_nsec = (time_t) -1;
-	vattr->va_ctime.tv_sec = (time_t) -1;
-	vattr->va_ctime.tv_nsec = (time_t) -1;
+	vattr->va_atime.tv_sec = (long) -1;
+	vattr->va_atime.tv_nsec = (long) -1;
+	vattr->va_mtime.tv_sec = (long) -1;
+	vattr->va_mtime.tv_nsec = (long) -1;
+	vattr->va_ctime.tv_sec = (long) -1;
+	vattr->va_ctime.tv_nsec = (long) -1;
         vattr->va_type = C_VNON;
 	vattr->va_fileid = -1;
 	vattr->va_gen = -1;
@@ -175,13 +201,13 @@ void coda_iattr_to_vattr(struct iattr *iattr, struct coda_vattr *vattr)
                 vattr->va_size = iattr->ia_size;
 	}
         if ( valid & ATTR_ATIME ) {
-		vattr->va_atime = timespec64_to_timespec(iattr->ia_atime);
+		vattr->va_atime = timespec64_to_coda(iattr->ia_atime);
 	}
         if ( valid & ATTR_MTIME ) {
-		vattr->va_mtime = timespec64_to_timespec(iattr->ia_mtime);
+		vattr->va_mtime = timespec64_to_coda(iattr->ia_mtime);
 	}
         if ( valid & ATTR_CTIME ) {
-		vattr->va_ctime = timespec64_to_timespec(iattr->ia_ctime);
+		vattr->va_ctime = timespec64_to_coda(iattr->ia_ctime);
 	}
 }
 
diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index 695fade33c64..027a8eb04423 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -211,6 +211,20 @@ struct CodaFid {
  */
 enum coda_vtype	{ C_VNON, C_VREG, C_VDIR, C_VBLK, C_VCHR, C_VLNK, C_VSOCK, C_VFIFO, C_VBAD };
 
+#ifdef __linux__
+/*
+ * This matches the traditional Linux 'timespec' structure binary layout,
+ * before using 64-bit time_t everywhere. Overflows in y2038 on 32-bit
+ * architectures.
+ */
+struct vtimespec {
+	long		tv_sec;		/* seconds */
+	long		tv_nsec;	/* nanoseconds */
+};
+#else
+#define vtimespec timespec
+#endif
+
 struct coda_vattr {
 	long     	va_type;	/* vnode type (for create) */
 	u_short		va_mode;	/* files access mode and type */
@@ -220,9 +234,9 @@ struct coda_vattr {
 	long		va_fileid;	/* file id */
 	u_quad_t	va_size;	/* file size in bytes */
 	long		va_blocksize;	/* blocksize preferred for i/o */
-	struct timespec	va_atime;	/* time of last access */
-	struct timespec	va_mtime;	/* time of last modification */
-	struct timespec	va_ctime;	/* time file changed */
+	struct vtimespec va_atime;	/* time of last access */
+	struct vtimespec va_mtime;	/* time of last modification */
+	struct vtimespec va_ctime;	/* time file changed */
 	u_long		va_gen;		/* generation number of file */
 	u_long		va_flags;	/* flags defined for file */
 	cdev_t	        va_rdev;	/* device special file represents */
-- 
2.9.0

