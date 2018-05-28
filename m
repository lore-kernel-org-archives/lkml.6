Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034513AbeE1Pd2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:33:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032932AbeE1Pcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:32:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
Date: Mon, 28 May 2018 17:31:01 +0200
Message-Id: <20180528153222.2037158-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:ivnaRPfIEFtNNJ4kQMM7qjepuTZcsTkjMrVsVlMufh+C95dLyf6
 94y1kCbDQXiPqNkEx4l0q7FSSuIgL3Z0X5aR+zeQWziBO3TFRjXXTNq6/NGYTi2wGLrrZfn
 DAswGdlFyYMZdMzGg8jBAouNMOit0ARQaGZTpkTOSX3kVsqUL2PqCrXb+085lFvHtWswJ71
 CalneFaRZBO7WloJZ58Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NT5PdMcGH9Q=:G7frivC4faYB4eQKitWU/O
 2PnP5iaH6YqIBlkJ7xNd267i+DidTNjmSTj2Wvelw5HuQarJ22BBtrgc0wqZSieEqqlUuyDXy
 sx10cgo54XhOhPP+AWNKUnNfls7NJrUw6aYbkyOR6yX8vwFJQz6s+bgELrKEffIvnBa5FCDCJ
 tO/D55H5Fd31yTLgtxYvDJdqoSnuB6MQINdWVz1HiqvMgxwGqndQtjTotZO7PBl1rx+1bgiBP
 E/sqBF0qw2G5kc1++tHupBr2V2ASWx5Z4IXoUAu4KG+3X6ef5WpVIPv2F5qwP7kgaxzY10l7W
 kpzRMzCPGAWR/W9oB2ZEH9haQAUwg9t6VOkNRqPbbGSlSFnArZ25qLwYjvgo457S1aZbH5s8W
 CyezT8mB7FD1aTIczhP0EPGb0l9lvkYXBmHffQiihZXMV8KNBI3kvfrn1fwX14a0FRlUE5hYx
 PSuWzmXM9S6lgS0GpUMM92B4g9ZU0clCl7fkyQMpfKF1DJlhbavlwasE4hSgwCgBPZd39AzMq
 wf2LZe8//ECqbwJlhWCK1VShqMlSE8bSYdIsYjnp5KlGn1/L7YuN7aNhU5bR+9XMOdGD0vVSt
 3oIlt7LNslbEAf2YN3xnU+KXpfK4DCSWOxwEg7xEVn+PHcbsPqCPvyNbuZtzyaf61v+Nv3d2d
 iUjuqnmQdsXldMkUjDHITDCh1YVPhk6h+px95irdIjzFJlx2lxElF9Kpt9U4N6FqD5z0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build testing across architectures, I run into a build error on
all targets other than X86:

gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objdump: net/bpfilter/bpfilter_umh: File format not recognized
gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy:net/bpfilter/bpfilter_umh.o: Invalid bfd target

The problem is that 'hostprogs' get built with 'gcc' rather than
'$(CROSS_COMPILE)gcc', and my default gcc (as most people's) targets x86.

To work around it, adding an X86 dependency gets randconfigs building
again on my box.

Clearly, this is not a good solution, since it should actually work fine
when building native kernels on other architectures but that is now
disabled, while cross building an x86 kernel on another host is still
broken after my patch.

What we probably want here is to try out if the compiler is able to build
executables for the target architecture and not build the helper otherwise,
at least when compile-testing. No idea how to do that though.

Link: http://www.kernel.org/pub/tools/crosstool/
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bpfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
index 60725c5f79db..61cc4fcbb4d0 100644
--- a/net/bpfilter/Kconfig
+++ b/net/bpfilter/Kconfig
@@ -9,6 +9,7 @@ menuconfig BPFILTER
 if BPFILTER
 config BPFILTER_UMH
 	tristate "bpfilter kernel module with user mode helper"
+	depends on X86 # actually depends on native builds
 	default m
 	help
 	  This builds bpfilter kernel module with embedded user mode helper
-- 
2.9.0
