Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B82C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE22082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCE22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeJ2TVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:21:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:1324 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbeJ2TVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:21:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 03:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,439,1534834800"; 
   d="scan'208";a="85003351"
Received: from mke-mobl.ccr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.30.228])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2018 03:33:11 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] kselftests/bpf: use ping6 as the default ipv6 ping binary if it exists
Date:   Mon, 29 Oct 2018 19:14:29 +0800
Message-Id: <1540811669-24696-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping binary on some distros doesn't support "ping -6" anymore.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
index 42544a9..a9bc6f8 100755
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
@@ -10,7 +10,7 @@ wait_for_ip()
 	echo -n "Wait for testing link-local IP to become available "
 	for _i in $(seq ${MAX_PING_TRIES}); do
 		echo -n "."
-		if ping -6 -q -c 1 -W 1 ff02::1%${TEST_IF} >/dev/null 2>&1; then
+		if $PING6 -c 1 -W 1 ff02::1%${TEST_IF} >/dev/null 2>&1; then
 			echo " OK"
 			return
 		fi
@@ -58,5 +58,6 @@ BPF_PROG_OBJ="${DIR}/test_skb_cgroup_id_kern.o"
 BPF_PROG_SECTION="cgroup_id_logger"
 BPF_PROG_ID=0
 PROG="${DIR}/test_skb_cgroup_id_user"
+type ping6 >/dev/null 2>&1 && PING6="ping6" || PING6="ping -6"
 
 main
-- 
2.7.4

