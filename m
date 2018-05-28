Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969238AbeE1PqK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968571AbeE1KQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:16:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 063/268] proc: fix /proc/*/map_files lookup
Date: Mon, 28 May 2018 12:00:37 +0200
Message-Id: <20180528100209.066625799@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit ac7f1061c2c11bb8936b1b6a94cdb48de732f7a4 ]

Current code does:

	if (sscanf(dentry->d_name.name, "%lx-%lx", start, end) != 2)

However sscanf() is broken garbage.

It silently accepts whitespace between format specifiers
(did you know that?).

It silently accepts valid strings which result in integer overflow.

Do not use sscanf() for any even remotely reliable parsing code.

	OK
	# readlink '/proc/1/map_files/55a23af39000-55a23b05b000'
	/lib/systemd/systemd

	broken
	# readlink '/proc/1/map_files/               55a23af39000-55a23b05b000'
	/lib/systemd/systemd

	broken
	# readlink '/proc/1/map_files/55a23af39000-55a23b05b000    '
	/lib/systemd/systemd

	very broken
	# readlink '/proc/1/map_files/1000000000000000055a23af39000-55a23b05b000'
	/lib/systemd/systemd

Andrei said:

: This patch breaks criu.  It was a bug in criu.  And this bug is on a minor
: path, which works when memfd_create() isn't available.  It is a reason why
: I ask to not backport this patch to stable kernels.
:
: In CRIU this bug can be triggered, only if this patch will be backported
: to a kernel which version is lower than v3.16.

Link: http://lkml.kernel.org/r/20171120212706.GA14325@avx2
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Andrei Vagin <avagin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,8 @@
 #include "internal.h"
 #include "fd.h"
 
+#include "../../lib/kstrtox.h"
+
 /* NOTE:
  *	Implementing inode permission operations in /proc is almost
  *	certainly an error.  Permission checks need to happen during
@@ -1836,8 +1838,33 @@ end_instantiate:
 static int dname_to_vma_addr(struct dentry *dentry,
 			     unsigned long *start, unsigned long *end)
 {
-	if (sscanf(dentry->d_name.name, "%lx-%lx", start, end) != 2)
+	const char *str = dentry->d_name.name;
+	unsigned long long sval, eval;
+	unsigned int len;
+
+	len = _parse_integer(str, 16, &sval);
+	if (len & KSTRTOX_OVERFLOW)
+		return -EINVAL;
+	if (sval != (unsigned long)sval)
 		return -EINVAL;
+	str += len;
+
+	if (*str != '-')
+		return -EINVAL;
+	str++;
+
+	len = _parse_integer(str, 16, &eval);
+	if (len & KSTRTOX_OVERFLOW)
+		return -EINVAL;
+	if (eval != (unsigned long)eval)
+		return -EINVAL;
+	str += len;
+
+	if (*str != '\0')
+		return -EINVAL;
+
+	*start = sval;
+	*end = eval;
 
 	return 0;
 }
