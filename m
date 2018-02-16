Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBPUgK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:36:10 -0500
Received: from alln-iport-6.cisco.com ([173.37.142.93]:35249 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeBPUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:09 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="71375533"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 14/15] selinux: allow setxattr on rootfs so initramfs code can set them
Date: Fri, 16 Feb 2018 20:33:52 +0000
Message-Id: <1518813234-5874-17-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Kamensky <kamensky@cisco.com>

initramfs code supporting extended cpio format have ability to
fill extended attributes from cpio archive, but if SELinux enabled
and security server is not initialized yet, selinux callback would
refuse setxattr made by initramfs code.

Solution enable SBLABEL_MNT on rootfs even if secrurity server is
not initialized yet.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 security/selinux/hooks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..f3fe65589f02 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -706,6 +706,18 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (!ss_initialized) {
 		if (!num_opts) {
+			/*
+			 * Special handling for rootfs. Is genfs but supports
+			 * setting SELinux context on in-core inodes.
+			 *
+			 * Chicken and egg problem: policy may reside in rootfs
+			 * but for initramfs code to fill in attributes, it
+			 * needs selinux to allow that.
+			 */
+			if (!strncmp(sb->s_type->name, "rootfs",
+				     sizeof("rootfs")))
+				sbsec->flags |= SBLABEL_MNT;
+
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
-- 
2.10.3.dirty
