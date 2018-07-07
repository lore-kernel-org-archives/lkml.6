Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C2C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4BF20873
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="wBSlLGO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4BF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeGGPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:23:26 -0400
Received: from bosmailout08.eigbox.net ([66.96.184.8]:42571 "EHLO
        bosmailout08.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeGGPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:23:24 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2018 11:23:23 EDT
Received: from bosmailscan13.eigbox.net ([10.20.15.13])
        by bosmailout08.eigbox.net with esmtp (Exim)
        id 1fboaL-0001S6-DZ; Sat, 07 Jul 2018 10:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P77KG+lkxBP+l3Nuh/5DVJPItaTrWHbw9wc+bHpb24g=; b=wBSlLGO/9rThuEl+Nq+woIuVut
        13XhvaTvJ5q2A71PR5ZfzALcWPejsXxM78ORTDTnxf8uoGsBdicFVTTrejyLn5i+tHL9pZuNpqlXo
        hKmUUriL5fmMpnquuWhn7xvIl6N1QALZNmwEDoiTyx841kzaDMfJYqz5qbpZmeddhYXtdsGpZs/vB
        9hxT/zmS90ZUShpEOHmnGddc4KYTBtHZHrrzL6AMHnneyl0CGFWrvfW2rD1K1lc5VSFwUQfiR7Jxf
        7haR+My/HV3KVsvlIOwsIGxAXczn6RKDWCPiLnzjz+iVsZVvZY0m3+BSQip1oyNUbvFiiZORnIgTq
        Gw+D9Arw==;
Received: from [10.115.3.31] (helo=bosimpout11)
        by bosmailscan13.eigbox.net with esmtp (Exim)
        id 1fboaL-0004Lg-AM; Sat, 07 Jul 2018 10:53:17 -0400
Received: from bosauthsmtp11.yourhostingaccount.com ([10.20.18.11])
        by bosimpout11 with 
        id 7qtC1y0070EKspE01qtFNt; Sat, 07 Jul 2018 10:53:17 -0400
X-Authority-Analysis: v=2.2 cv=PN5/wbiC c=1 sm=1 tr=0
 a=anyYG9rjTBM1sAjEBQ8Cew==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8
 a=Ke6CQby5A3MH8lVGL1gA:9 a=QEXdDO2ut3YA:10 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=12071 helo=localhost.localdomain)
        by bosauthsmtp11.eigbox.net with esmtpa (Exim)
        id 1fboaG-0003Mo-IQ; Sat, 07 Jul 2018 10:53:12 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     jakub.kicinski@netronome.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Cc:     Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH v1] bpf: fix compilation of samples/bpf/
Date:   Sat,  7 Jul 2018 17:52:03 +0300
Message-Id: <20180707145240.23544-1-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 37.142.20.114
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example of errors:

samples/bpf/test_lru_dist.c:39:8: error: redefinition of ‘struct list_head’
 struct list_head {
        ^~~~~~~~~
In file included from samples/bpf/test_lru_dist.c:9:0:
./tools/include/linux/types.h:69:8: note: originally defined here

In file included from samples/bpf/sock_example.c:27:0:
/usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’

samples/bpf/bpf_load.c: In function ‘load_and_attach’:
samples/bpf/bpf_load.c:90:15: error: ‘BPF_PROG_TYPE_RAW_TRACEPOINT’ undeclared (first use in this function); did you mean ‘BPF_PROG_TYPE_TRACEPOINT’?

samples/bpf/xdpsock_user.c:10:10: fatal error: linux/if_xdp.h: No such file or directory

samples/bpf/task_fd_query_user.c: In function ‘test_debug_fs_uprobe’:
samples/bpf/task_fd_query_user.c:270:31: error: ‘BPF_FD_TYPE_URETPROBE’ undeclared (first use in this function); did you mean ‘BPF_PROG_TYPE_KPROBE’?

samples/bpf/parse_varlen.c:111:8: error: redefinition of 'vlan_hdr'
struct vlan_hdr {
       ^
./include/linux/if_vlan.h:38:8: note: previous definition is here

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 Makefile                           | 1 +
 samples/bpf/Makefile               | 5 +++--
 samples/bpf/xdp_sample_pkts_user.c | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d15ac32afbaf..824006258319 100644
--- a/Makefile
+++ b/Makefile
@@ -441,6 +441,7 @@ export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
+export USERINCLUDE
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9ea2f7b64869..991273c81459 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -167,11 +167,12 @@ always += xdp_fwd_kern.o
 always += task_fd_query_kern.o
 always += xdp_sample_pkts_kern.o
 
-HOSTCFLAGS += -I$(objtree)/usr/include
+HOSTCFLAGS += -D__EXPORTED_HEADERS__ $(USERINCLUDE)
 HOSTCFLAGS += -I$(srctree)/tools/lib/
 HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
+HOSTCFLAGS += -I$(srctree)/tools/include
 HOSTCFLAGS += -I$(srctree)/tools/perf
+HOSTCFLAGS += -I./include # for generated/autoconf.h from USERINCLUDE
 
 HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
 HOSTCFLAGS_trace_helpers.o += -I$(srctree)/tools/lib/bpf/
diff --git a/samples/bpf/xdp_sample_pkts_user.c b/samples/bpf/xdp_sample_pkts_user.c
index 8dd87c1eb560..be7329697500 100644
--- a/samples/bpf/xdp_sample_pkts_user.c
+++ b/samples/bpf/xdp_sample_pkts_user.c
@@ -15,6 +15,9 @@
 
 #include "perf-sys.h"
 #include "trace_helpers.h"
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
 
 #define MAX_CPUS 128
 static int pmu_fds[MAX_CPUS], if_idx;
-- 
2.17.1

