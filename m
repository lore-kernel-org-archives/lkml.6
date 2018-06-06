Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="o53JA4dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D3BB607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeFFNyU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:54:20 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:32798 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeFFNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:54:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="346934929"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 3/7] seccomp: include net and bpf files
Date: Wed, 6 Jun 2018 15:53:22 +0200
Message-ID: <1528293206-24298-3-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to use CONFIG_SECCOMP_FILTER without CONFIG_NET, we have
to ensure that the required files that would be pulled in via
CONFIG_NET are compiled when dropping CONFIG_NET.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 kernel/bpf/Makefile | 3 ++-
 net/Makefile        | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index a713fd2..5d13269 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -4,7 +4,8 @@ obj-y := core.o
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
-ifeq ($(CONFIG_NET),y)
+
+ifneq ($(filter y,$(CONFIG_NET) $(CONFIG_SECCOMP_FILTER)),)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumap.o
 obj-$(CONFIG_BPF_SYSCALL) += offload.o
diff --git a/net/Makefile b/net/Makefile
index a6147c6..08f1875 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -11,6 +11,11 @@ obj-$(CONFIG_NET)		:= socket.o core/
 tmp-$(CONFIG_COMPAT) 		:= compat.o
 obj-$(CONFIG_NET)		+= $(tmp-y)
 
+ifneq ($(CONFIG_NET),y)
+obj-$(CONFIG_SECCOMP_FILTER)    += core/filter.o
+obj-$(CONFIG_SECCOMP_FILTER)    += core/flow_dissector.o
+endif
+
 # LLC has to be linked before the files in net/802/
 obj-$(CONFIG_LLC)		+= llc/
 obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/ bpf/
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
