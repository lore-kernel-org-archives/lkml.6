Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDADFC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EAE20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfBCNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:49:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52748 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbfBCNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:41 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0003ts-GV; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0006o9-St; Sun, 03 Feb 2019 14:49:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Johannes Pointner" <h4nn35.work@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.665777769@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 015/305] turn off -Wattribute-alias
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

Starting with gcc-8.1, we get a warning about all system call definitions,
which use an alias between functions with incompatible prototypes, e.g.:

In file included from ../mm/process_vm_access.c:19:
../include/linux/syscalls.h:211:18: warning: 'sys_process_vm_readv' alias between functions of incompatible types 'long int(pid_t,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)' {aka 'long int(int,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
 ^~~~~~~~~~~~~~~
../include/linux/syscalls.h:215:18: note: aliased declaration here
  asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,

This is really noisy and does not indicate a real problem. In the latest
mainline kernel, this was addressed by commit bee20031772a ("disable
-Wattribute-alias warning for SYSCALL_DEFINEx()"), which seems too invasive
to backport.

This takes a much simpler approach and just disables the warning across the
kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Pointner <h4nn35.work@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -620,6 +620,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warni
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)

