Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938121AbeE1LNY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938070AbeE1LNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:13:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 204/272] tools: hv: fix compiler warnings about major/target_fname
Date: Mon, 28 May 2018 12:03:57 +0200
Message-Id: <20180528100257.674016340@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 1330fc35327f3ecdfa1aa645e7321ced7349b2cd ]

This patch fixes the below warnings with new glibc and gcc:

hv_vss_daemon.c:100:13: warning: In the GNU C Library, "major" is defined
 by <sys/sysmacros.h>. For historical compatibility, it is currently
defined by <sys/types.h> as well, but we plan to  remove this soon.
To use "major", include <sys/sysmacros.h>  directly.

hv_fcopy_daemon.c:42:2: note: 'snprintf' output between 2 and 1040
bytes into a destination of size 260

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/hv/hv_fcopy_daemon.c |    3 ++-
 tools/hv/hv_vss_daemon.c   |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -23,13 +23,14 @@
 #include <unistd.h>
 #include <errno.h>
 #include <linux/hyperv.h>
+#include <linux/limits.h>
 #include <syslog.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <getopt.h>
 
 static int target_fd;
-static char target_fname[W_MAX_PATH];
+static char target_fname[PATH_MAX];
 static unsigned long long filesize;
 
 static int hv_start_fcopy(struct hv_start_fcopy *smsg)
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -22,6 +22,7 @@
 #include <sys/poll.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <mntent.h>
