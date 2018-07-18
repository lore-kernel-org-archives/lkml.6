Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C17ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B05206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B05206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbeGRMY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:24:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbeGRMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:24:58 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MLfvf-1fevyD03f9-000qZD; Wed, 18 Jul 2018 13:46:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        codalist@coda.cs.cmu.edu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] coda: stop using 'struct timespec' in user API
Date:   Wed, 18 Jul 2018 13:46:25 +0200
Message-Id: <20180718114645.591551-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:LJtO7M3C9E37y/JxrEQUrz6MxYLgD8dmvGExy2UoJmHN2LasiOX
 N96m+fNwHzqM6x4sWZ7vJzfiwgm2BOYJF8vsdDoK7efGNeFQyZqiYeGCXiScoX/ovBvHsvC
 tBO+SJz5eUmSsMa7M/ohZH06obmYv+1k8FaGfXgTREBD5SDo92mXQ/3HPRgCJBdqDjlgQFz
 NxI8H1NUsDYV8bTBRQXSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hv33/lR6LjQ=:y+6s1Fjx0VV2fSzYBHryR+
 IksXvzz01ImxLNBjFbZFJuUqVB52mwHHU6oGfjtQdmCCaB0kU2JjjoZL7sCK37uFJ396A9cHQ
 uQnlR+bE1kOiqgDwMcOqI2U8nmDFFlE3zZ4w5Vh9s+bMJGJpNR+FxNXcfaAlwRDUqnGju80re
 hG0JXa2gDL+rIDey0okVvVCG8OS36UHTELtRrOm8vGCspVglg5A4aJDaJ8bs7U9OJ8w3B2bVz
 OKXEcvNQkXlUqfJOeVx8JdwItPKw3QemyRB4XMYeRlmVKUvmAtNKB+MkrvnNz7nhQpPrtEr8m
 NfKI8FhAv4eAGdEC7XgfeXzySiAryFlK04ZBONANG7J5Zc/jmr5eXbWR9kj+9xXV8tn394uaf
 uIPXeETkhjVHkOyciKg4ijg5wGVWsVH/S9OXhGbYLiQw2Gp+WrfV2UNkDfLZe0Uw7YqBGHQbW
 5rEKAPzaTmyO/0dGpGLs9Lv1RXJpNfFSEKklqUDJz9ho5k6mCBqdMrvPomveVD70pFKESdoVq
 BvWni+hoHS1XZ9ZlqB63TEyopnu7sIe7X/8g+Dqpx/6XSEH3mDXBhrswqewJG4z3h8DUH8nTn
 rItSJ79w0fdjqMJEHCjxE+En1o4Zpeu9gyA0OT7biZlqrr5d/+SPetr1JNc9Rdk1BiKZA5Mqz
 Dlk7XcLFXJhEGl3Ped3oXsMUWPKtGJ1SBvug6Ut1kG4U7jjuiQ63g6t6umRl2Sx1ULqM=
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

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
Link: https://patchwork.kernel.org/patch/10474735/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on June 19, which lead to a short discussion
and an Ack, but the patch did not get picked up for 4.19 yet.

I'd still like to get a reply on my last point:

On Tue, Jun 19, 2018 at 9:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jun 19, 2018 at 6:56 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
>> That is definitely quite a hard problem because this propagates all the
>> way back to the Coda file servers and how they store metadata.
>> In fact the existing client-server protocol only uses 32-bit time in
>> seconds, so we already lose the nanosecond resolution and 64-bit systems
>> don't actually benefit from having the extra bits in their struct timespec.
>
> I couldn't find out enough background for this, maybe you can fill it
> in: I see that there is a user space component and a server component,
> but I'm not sure if there is exactly one of each, or if there are multiple
> implementations that are written against the same interface.
>
> If we only have one code base, it should be fairly straightforward to
> make it deal with 'unsigned' timestamps consistently, which would
> let the code work fine until 2106 rather than wrapping around from
> 2038 to 1902.
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

