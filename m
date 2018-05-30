Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeE3LJL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:09:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60771 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeE3LHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.61485687@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 060/153] s390: fix handling of -1 in set{,fs}[gu]id16
 syscalls
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eugene Syromiatnikov <esyr@redhat.com>

commit 6dd0d2d22aa363fec075cb2577ba273ac8462e94 upstream.

For some reason, the implementation of some 16-bit ID system calls
(namely, setuid16/setgid16 and setfsuid16/setfsgid16) used type cast
instead of low2highgid/low2highuid macros for converting [GU]IDs, which
led to incorrect handling of value of -1 (which ought to be considered
invalid).

Discovered by strace test suite.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/compat_linux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -114,7 +114,7 @@ asmlinkage long sys32_setregid16(u16 rgi
 
 asmlinkage long sys32_setgid16(u16 gid)
 {
-	return sys_setgid((gid_t)gid);
+	return sys_setgid(low2highgid(gid));
 }
 
 asmlinkage long sys32_setreuid16(u16 ruid, u16 euid)
@@ -124,7 +124,7 @@ asmlinkage long sys32_setreuid16(u16 rui
 
 asmlinkage long sys32_setuid16(u16 uid)
 {
-	return sys_setuid((uid_t)uid);
+	return sys_setuid(low2highuid(uid));
 }
 
 asmlinkage long sys32_setresuid16(u16 ruid, u16 euid, u16 suid)
@@ -163,12 +163,12 @@ asmlinkage long sys32_getresgid16(u16 __
 
 asmlinkage long sys32_setfsuid16(u16 uid)
 {
-	return sys_setfsuid((uid_t)uid);
+	return sys_setfsuid(low2highuid(uid));
 }
 
 asmlinkage long sys32_setfsgid16(u16 gid)
 {
-	return sys_setfsgid((gid_t)gid);
+	return sys_setfsgid(low2highgid(gid));
 }
 
 static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
