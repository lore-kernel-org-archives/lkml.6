Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeBPUeQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:16 -0500
Received: from alln-iport-1.cisco.com ([173.37.142.88]:6710 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeBPUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:07 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="71904794"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 12/14] gen_initramfs_list.sh: add -x option to enable newcx format
Date: Fri, 16 Feb 2018 20:33:49 +0000
Message-Id: <1518813234-5874-14-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

-x option populates extended attributes in cpio_list file passed to
get_init_cpio and selects newcx CPIO format.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 scripts/gen_initramfs_list.sh | 13 ++++++++++++-
 usr/Kconfig                   | 11 +++++++++++
 usr/Makefile                  |  3 ++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 86a3c0e5cfbc..cddb82f093d9 100755
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -24,6 +24,7 @@ $0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
 	-g <gid>       Group ID to map to group ID 0 (root).
 		       <gid> is only meaningful if <cpio_source> is a
 		       directory.  "squash" forces all files to gid 0.
+	-x             include file extended attributes in cpio archive.
 	<cpio_source>  File list or directory for cpio archive.
 		       If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
@@ -146,6 +147,9 @@ parse() {
 			;;
 	esac
 
+	$include_xattrs && \
+		getfattr -h -d -m - -e hex --absolute-names ${location} | \
+		sed -e '/^#/d' -e '/^$/d' -e 's/^/xattr /' >> ${output}
 	echo "${str}" >> ${output}
 
 	return 0
@@ -226,6 +230,8 @@ root_gid=0
 dep_list=
 cpio_file=
 cpio_list=
+cpio_opts=
+include_xattrs=false
 output="/dev/stdout"
 output_file=""
 is_cpio_compressed=
@@ -283,6 +289,10 @@ while [ $# -gt 0 ]; do
 			default_list="$arg"
 			${dep_list}default_initramfs
 			;;
+		"-x")   # include extended attributers
+			cpio_opts="-x"
+			include_xattrs=true
+			;;
 		"-h")
 			usage
 			exit 0
@@ -312,7 +322,8 @@ if [ ! -z ${output_file} ]; then
 			fi
 		fi
 		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
-		usr/gen_init_cpio $timestamp ${cpio_list} > ${cpio_tfile}
+		usr/gen_init_cpio $timestamp ${cpio_opts} ${cpio_list} \
+			> ${cpio_tfile}
 	else
 		cpio_tfile=${cpio_file}
 	fi
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..0cc03bc4614c 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,17 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config INITRAMFS_NEWCX
+	bool "Use newcx CPIO format for initramfs"
+	depends on INITRAMFS_SOURCE!=""
+	default n
+	help
+	  If selected "usr/gen_init_cpio" will generate newcx CPIO archive
+	  format that supports extended attributes.
+
+	  See <file:Documentation/early-userspace/buffer-format.txt> for
+	  more details.
+
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
 	depends on BLK_DEV_INITRD
diff --git a/usr/Makefile b/usr/Makefile
index 237a028693ce..1106bfd61475 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -29,7 +29,8 @@ ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
 			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
-        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+        $(if $(CONFIG_INITRAMFS_NEWCX), -x)
 
 # $(datafile_d_y) is used to identify all files included
 # in initramfs and to detect if any files are added/removed.
-- 
2.10.3.dirty
