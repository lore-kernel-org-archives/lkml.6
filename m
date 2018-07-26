Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A54C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED0320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeGZJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:30:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbeGZJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:30:13 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MTP5b-1fbHfA2uyF-00SOZS; Thu, 26 Jul 2018 10:14:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [stable 4.14] turn off -Wattribute-alias
Date:   Thu, 26 Jul 2018 10:13:22 +0200
Message-Id: <20180726081358.3829157-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:fHpgrsexntLLsSc/URMhUQgv1faNscQ1vwHLBRJtJShiQHRy+L2
 Gh1BqIbuYq0w5d4Vv/Ug+W8h8Durf0FqZRIvM2SYpEcxZCmYMPUNasYAUikwP0blSsOXoJY
 9zTAL49sFheiElRoVX4A0qwJS3IliA9nZPXWeN4P6wgoeDc9mNtNz1n82nnlQRQIye9kCLK
 ynh8C8OHBhe1V9LIp++Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bxKCtIWwhKM=:FwmdEtgtcQlhzMFuv/L2LF
 FKu2rPv53Pkn/HgKw7Y7gEoCibJ85fP1kpHBsG+VUCTxpP+WD9J85IBhjGFPweUApfOWEk9s3
 S3jWzb9cqqdWwDNyAlb6SHG6HcsLTS0dnSmAlpRz8mEy0DwXH0QYchH+nVnR3UIiXZ+tvGjIG
 13MepYcvD7Ah6Ln9RMMiF+MCs8j7Nfly5TADF+LjsbH+d/YVDr99OmK/4Y3dxB/TrDgCcpuDd
 cep1c0TsqcuA+l09FGTzclQ025QMkIIzufgoBYvBiakxaudz0YFyj2lIaxByaeK5i+/yT34N+
 ECjqnRwqmOtzcvuXHwyjrp8gyAFGMIFl+OjzoSTPk1LhyxH9xgXN+QRXNFSp5hv0jpil0cs7Y
 DRFasYUCDpR8m9z39o3v1BSUgZYAn5dbenRvezvvZOF6cU9AAMMpw/kpp+nKUWpOIXCUoffp0
 Hcpa2klWl6ZGWgksA2WAR7Ndo5gyr99GG7xpG4UeF768e7eV8TMhaw7D2satA8dsLWHAuav+q
 QagHNPZSXSRpz3cIF9UD88JTbNeo4iEi2mO/OaWrGlee/+3dTKJObxMzUmNZpR1pinVm6IozW
 bhkERfv/zRrOSv8X0mrXOIwcTtwybV+bzlTxDfHnE0iYW85Hpm5hRGA2W8BAKZpigo0rZ+OFQ
 f0FDfdjzCfQpK45dg71T/8Zaww3gRE9P1aOixRHsg5o+TaI3rrAEzK6XRjU1opxRMl/Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a44d6b2adb76..91f9d2d56eac 100644
--- a/Makefile
+++ b/Makefile
@@ -642,6 +642,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
-- 
2.18.0

