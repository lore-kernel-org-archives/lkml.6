Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF3EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E6A2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788968;
	bh=MbgKeDwgP2stM8IILUFzo1ufpxvSjMVmG0M7pb8yoNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9DVB9DUFaBzOTUbZEbS7ZkgFeTGEnm2Xsz9IRU0DbF9DmHV4vghqFwKi5SIOhOQJ
	 +0dFdIx2+xHgX9LmB5T3to2Fo5E7WG9AriADf9xGjBsV9ORooJBvHR47vq7q1eTqzk
	 4wlZPv9nK9caKbU0Hx8jP3aKl+GWSOioF1IW3sNI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E6A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbeLNMCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbeLNMCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199CC2146E;
        Fri, 14 Dec 2018 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788963;
        bh=MbgKeDwgP2stM8IILUFzo1ufpxvSjMVmG0M7pb8yoNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nnw2AUS5gszR2bCLPA0gIPd/XAHzsOpC7MEbT/T6hGa7zC4N+jj++GrcPsEVlAKLj
         yXdAkOQY88fxlJPJhl256FDwr2rh4v0YkjezTHgiMnoPNXZmX1SWVtKtx98sQW5XOa
         sXjHvJfPo0s5V3irWW6YjuGIbfKmZxlv7A2FdaYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/142] selftests: add script to stress-test nft packet path vs. control plane
Date:   Fri, 14 Dec 2018 12:58:45 +0100
Message-Id: <20181214115748.654076454@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 25d8bcedbf4329895dbaf9dd67baa6f18dad918c ]

Start flood ping for each cpu while loading/flushing rulesets to make
sure we do not access already-free'd rules from nf_tables evaluation loop.

Also add this to TARGETS so 'make run_tests' in selftest dir runs it
automatically.

This would have caught the bug fixed in previous change
("netfilter: nf_tables: do not skip inactive chains during generation update")
sooner.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/netfilter/Makefile    |  6 ++
 tools/testing/selftests/netfilter/config      |  2 +
 .../selftests/netfilter/nft_trans_stress.sh   | 78 +++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/netfilter/Makefile
 create mode 100644 tools/testing/selftests/netfilter/config
 create mode 100755 tools/testing/selftests/netfilter/nft_trans_stress.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f1fe492c8e17..f0017c831e57 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -24,6 +24,7 @@ TARGETS += memory-hotplug
 TARGETS += mount
 TARGETS += mqueue
 TARGETS += net
+TARGETS += netfilter
 TARGETS += nsfs
 TARGETS += powerpc
 TARGETS += proc
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
new file mode 100644
index 000000000000..47ed6cef93fb
--- /dev/null
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for netfilter selftests
+
+TEST_PROGS := nft_trans_stress.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/config b/tools/testing/selftests/netfilter/config
new file mode 100644
index 000000000000..1017313e41a8
--- /dev/null
+++ b/tools/testing/selftests/netfilter/config
@@ -0,0 +1,2 @@
+CONFIG_NET_NS=y
+NF_TABLES_INET=y
diff --git a/tools/testing/selftests/netfilter/nft_trans_stress.sh b/tools/testing/selftests/netfilter/nft_trans_stress.sh
new file mode 100755
index 000000000000..f1affd12c4b1
--- /dev/null
+++ b/tools/testing/selftests/netfilter/nft_trans_stress.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+#
+# This test is for stress-testing the nf_tables config plane path vs.
+# packet path processing: Make sure we never release rules that are
+# still visible to other cpus.
+#
+# set -e
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+testns=testns1
+tables="foo bar baz quux"
+
+nft --version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without nft tool"
+	exit $ksft_skip
+fi
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+tmp=$(mktemp)
+
+for table in $tables; do
+	echo add table inet "$table" >> "$tmp"
+	echo flush table inet "$table" >> "$tmp"
+
+	echo "add chain inet $table INPUT { type filter hook input priority 0; }" >> "$tmp"
+	echo "add chain inet $table OUTPUT { type filter hook output priority 0; }" >> "$tmp"
+	for c in $(seq 1 400); do
+		chain=$(printf "chain%03u" "$c")
+		echo "add chain inet $table $chain" >> "$tmp"
+	done
+
+	for c in $(seq 1 400); do
+		chain=$(printf "chain%03u" "$c")
+		for BASE in INPUT OUTPUT; do
+			echo "add rule inet $table $BASE counter jump $chain" >> "$tmp"
+		done
+		echo "add rule inet $table $chain counter return" >> "$tmp"
+	done
+done
+
+ip netns add "$testns"
+ip -netns "$testns" link set lo up
+
+lscpu | grep ^CPU\(s\): | ( read cpu cpunum ;
+cpunum=$((cpunum-1))
+for i in $(seq 0 $cpunum);do
+	mask=$(printf 0x%x $((1<<$i)))
+        ip netns exec "$testns" taskset $mask ping -4 127.0.0.1 -fq > /dev/null &
+        ip netns exec "$testns" taskset $mask ping -6 ::1 -fq > /dev/null &
+done)
+
+sleep 1
+
+for i in $(seq 1 10) ; do ip netns exec "$testns" nft -f "$tmp" & done
+
+for table in $tables;do
+	randsleep=$((RANDOM%10))
+	sleep $randsleep
+	ip netns exec "$testns" nft delete table inet $table 2>/dev/null
+done
+
+randsleep=$((RANDOM%10))
+sleep $randsleep
+
+pkill -9 ping
+
+wait
+
+rm -f "$tmp"
+ip netns del "$testns"
-- 
2.19.1



