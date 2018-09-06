Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4DCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D162083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D162083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeIFNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:54:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728039AbeIFNyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B16D84023351;
        Thu,  6 Sep 2018 09:19:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2CE1FA981;
        Thu,  6 Sep 2018 09:19:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/11] UAPI: Check headers build for C++ [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:19:37 +0100
Message-ID: <153622557736.14298.10350496216090814292.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:19:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:19:38 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that all the headers can be included from one file and built for C++,
thereby catching the use of C++ reserved words and bits of unimplemented
C++ in the UAPI headers.

Note that certain headers are excluded from the build, including:

 (1) Any header ending in "_32.h", "_64.h" or "_x32.h" as these are
     expected to be multiarch variant headers.

 (2) Endianness variant headers.

 (3) asm-generic/ headers (they're used conditionally by the asm/ headers
     and shouldn't be used directly).

 (4) netfilter_ipv*/ip*t_LOG.h headers.  They emit a warning indicating
     they're going to be removed soon.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: Michal Marek <michal.lkml@markovi.net>
cc: linux-kbuild@vger.kernel.org
---

 Makefile               |    1 
 scripts/headers-c++.sh |  124 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 scripts/headers-c++.sh

diff --git a/Makefile b/Makefile
index 19948e556941..38d655cb4474 100644
--- a/Makefile
+++ b/Makefile
@@ -1186,6 +1186,7 @@ headers_install: __headers
 	  $(error Headers not exportable for the $(SRCARCH) architecture))
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi $(hdr-dst)
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/headers-c++.sh check
 
 PHONY += headers_check_all
 headers_check_all: headers_install_all
diff --git a/scripts/headers-c++.sh b/scripts/headers-c++.sh
new file mode 100755
index 000000000000..7e56913629f8
--- /dev/null
+++ b/scripts/headers-c++.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Run headers_$1 command for all suitable architectures
+
+# Stop on error
+set -e
+
+if ! $CC -x c++ -c - -o /dev/null </dev/null 2>/dev/null
+then
+    echo "  CHECK   C++ HEADER COMPILATION [SKIPPED]"
+    exit 0
+fi
+
+echo "  CHECK   C++ HEADER COMPILATION"
+
+mkdir -p hdr-check
+cd hdr-check
+
+mkdir -p include/sys
+mkdir -p include/arpa
+mkdir -p include/xen/interface
+echo >include/endian.h
+echo >include/limits.h
+echo >include/stdint.h
+echo >include/stdlib.h
+echo >include/stdio.h
+echo >include/string.h
+echo >include/time.h
+echo >include/unistd.h
+echo >include/arpa/inet.h
+echo >include/sys/ioctl.h
+echo >include/sys/types.h
+echo >include/sys/time.h
+echo >include/sys/socket.h
+echo >include/xen/interface/xen.h
+
+cat >test.h <<EOF
+#ifdef __cplusplus
+#define NULL nullptr
+#define _Bool bool
+#else
+#define NULL ((void *)0)
+#define bool _Bool
+#endif
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/time.h>
+
+typedef __s8			int8_t;
+typedef __s16			int16_t;
+typedef __s32			int32_t;
+typedef __s64			int64_t;
+typedef __u8			uint8_t;
+typedef __u16			uint16_t;
+typedef __u32			uint32_t;
+typedef __u64			uint64_t;
+typedef long int		intptr_t;
+typedef unsigned long int	uintptr_t;
+typedef unsigned short		u_short;
+typedef unsigned int		u_int;
+typedef unsigned long		u_long;
+typedef char			*caddr_t;
+
+typedef __kernel_clockid_t	clockid_t;
+typedef __kernel_ino_t		ino_t;
+typedef __kernel_pid_t		pid_t;
+typedef __kernel_sa_family_t	sa_family_t;
+typedef __kernel_size_t		size_t;
+typedef __kernel_uid_t		uid_t;
+
+typedef unsigned long		elf_greg_t;
+typedef elf_greg_t		elf_gregset_t[1];
+typedef unsigned long long	elf_fpregset_t[1];
+typedef unsigned long long	elf_fpxregset_t[1];
+
+#define INT_MIN ((int)0x80000000)
+#define INT_MAX ((int)0x7fffffff)
+
+extern size_t strlen(const char *);
+extern void *memset(void *, int, size_t);
+extern void *memcpy(void *, const void *, size_t);
+extern __u16 ntohs(__u16);
+extern __u16 htons(__u16);
+extern __u32 ntohl(__u32);
+extern __u32 htonl(__u32);
+
+typedef uint32_t		grant_ref_t;
+typedef uint16_t		domid_t;
+typedef unsigned long		xen_pfn_t;
+
+#define MSG_FIN         0x200
+
+typedef int SVGA3dMSPattern;
+typedef int SVGA3dMSQualityLevel;
+
+struct sockaddr
+{
+	sa_family_t	sa_family;
+	char		sa_data[14];
+};
+#define sockaddr_storage __kernel_sockaddr_storage
+
+#define _LINUX_PATCHKEY_H_INDIRECT
+
+EOF
+
+find ../usr/include -name '*.h' |
+    grep -v 'linux/byteorder/big_endian.h' |
+    grep -v 'linux/byteorder/little_endian.h' |
+    grep -v '_\(32\|64\|x32\)[.]h$' |
+    grep -v '/asm-generic/' |
+    # ip*t_LOG.h are deprecated
+    grep -v 'linux/netfilter_ipv4/ipt_LOG[.]h' |
+    grep -v 'linux/netfilter_ipv6/ip6t_LOG[.]h' |
+    sed -e 's!../usr/include/!#include <!' -e 's!$!>!' >>test.h
+
+echo '#include "test.h"' >test.cpp
+
+$CC -x c++ -o /dev/null -c test.cpp \
+    -nostdinc \
+    -isystem ./include \
+    -isystem ../usr/include \
+    -fpermissive \
+    -D PAGE_SIZE='#PAGE_SIZE_IS_NOT_VALID_OUTSIDE_OF_KERNEL'

