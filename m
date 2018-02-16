Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeBPUeD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:03 -0500
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:1571 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeBPUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:33:58 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="357044583"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 01/15] Documentation: add newcx initramfs format description
Date: Fri, 16 Feb 2018 20:33:37 +0000
Message-Id: <1518813234-5874-2-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the Linux security/integrity features are dependent on file
metadata, stored as extended attributes (xattrs), for making decisions.
These features need to be initialized during initcall and enabled as
early as possible for complete security coverage.

Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
support including them into the archive.

This patch describes "extended" newc format (newcx) that is based on
newc and has following changes:
- extended attributes support
- increased size of filesize to support files >4GB
- increased mtime field size to have 64 bits of seconds and added a
  field for nanoseconds
- removed unused checksum field

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 Documentation/early-userspace/buffer-format.txt | 46 ++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
index e1fd7f9dad16..8349b2f28b4b 100644
--- a/Documentation/early-userspace/buffer-format.txt
+++ b/Documentation/early-userspace/buffer-format.txt
@@ -24,6 +24,7 @@ grammar, where:
 	+	indicates concatenation
 	GZIP()	indicates the gzip(1) of the operand
 	ALGN(n)	means padding with null bytes to an n-byte boundary
+	[n]	means size of field is n bytes
 
 	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
 
@@ -31,20 +32,33 @@ grammar, where:
 
 	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)
 
-	cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
+	cpio_file := (cpio_newc_file | cpio_newcx_file)
+
+	cpio_newc_file := ALGN(4) + cpio_newc_header + filename + "\0" + \
+			  ALGN(4) + data
+
+	cpio_newcx_file := ALGN(4) + cpio_newcx_header + filename + "\0" + \
+			   ALGN(4) + xattrs + ALGN(4) + data
+
+	xattrs := xattr_entry*
+
+	xattr_entry := xattr_size[8] + xattr_name + "\0" + xattr_value
 
 	cpio_trailer := ALGN(4) + cpio_header + "TRAILER!!!\0" + ALGN(4)
 
 
 In human terms, the initramfs buffer contains a collection of
-compressed and/or uncompressed cpio archives (in the "newc" or "crc"
-formats); arbitrary amounts zero bytes (for padding) can be added
-between members.
+compressed and/or uncompressed cpio archives; arbitrary amounts
+zero bytes (for padding) can be added between members.
 
 The cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
 not ignored; see "handling of hard links" below.
 
-The structure of the cpio_header is as follows (all fields contain
+xattr_size is a total size of xattr_entry including 8 bytes of
+xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
+fields of cpio header (see below).
+
+The structure of the cpio_newc_header is as follows (all fields contain
 hexadecimal ASCII numbers fully padded with '0' on the left to the
 full width of the field, for example, the integer 4780 is represented
 by the ASCII string "000012ac"):
@@ -81,6 +95,28 @@ algorithm used.
 If the filename is "TRAILER!!!" this is actually an end-of-archive
 marker; the c_filesize for an end-of-archive marker must be zero.
 
+"Extended" newc format (newcx)
+"newcx" cpio format extends "newc" by increasing size of some fields
+and adding extended attributes support. cpio_newcx_header structure:
+
+Field name    Field size	 Meaning
+c_magic	       6 bytes		 The string "070703"
+c_ino	       8 bytes		 File inode number
+c_mode	       8 bytes		 File mode and permissions
+c_uid	       8 bytes		 File uid
+c_gid	       8 bytes		 File gid
+c_nlink	       8 bytes		 Number of links
+c_mtime	      16 bytes		 Modification time (seconds)
+c_mtime_nsec   8 bytes		 Modification time (nanoseconds)
+c_filesize    16 bytes		 Size of data field
+c_maj	       8 bytes		 Major part of file device number
+c_min	       8 bytes		 Minor part of file device number
+c_rmaj	       8 bytes		 Major part of device node reference
+c_rmin	       8 bytes		 Minor part of device node reference
+c_namesize     8 bytes		 Length of filename, including final \0
+c_xattrs_size  8 bytes		 Size of xattrs field
+
+Most of the fields match cpio_newc_header. c_chksum field is dropped.
 
 *** Handling of hard links
 
-- 
2.10.3.dirty
