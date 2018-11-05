Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384D920831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384D920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeKEQqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:46:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:28770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeKEQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:46:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 23:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="89489600"
Received: from mke-mobl.ccr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.30.228])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2018 23:27:46 -0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     Song Liu <songliubraving@fb.com>, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>
Subject: [PATCH] kselftests/bpf: use ping6 as the default ipv6 ping binary when it exists
Date:   Mon,  5 Nov 2018 16:13:49 +0800
Message-Id: <1541405629-5580-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At commit deee2cae27 ("kselftests/bpf: use ping6 as the default ipv6 ping
binary if it exists"), it fixed similar issues for shell script, but it
missed a same issue in the C code.

Fixes: 371e4fcc9d96 ("selftests/bpf: cgroup local storage-based network counters")
CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/bpf/test_netcnt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_netcnt.c b/tools/testing/selftests/bpf/test_netcnt.c
index 7887df6..44889bc 100644
--- a/tools/testing/selftests/bpf/test_netcnt.c
+++ b/tools/testing/selftests/bpf/test_netcnt.c
@@ -81,7 +81,11 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	assert(system("ping localhost -6 -c 10000 -f -q > /dev/null") == 0);
+	if (system("which ping6 &>/dev/null") == 0) {
+		assert(system("ping6 localhost -c 10000 -f -q > /dev/null") == 0);
+	} else {
+		assert(system("ping -6 localhost -c 10000 -f -q > /dev/null") == 0);
+	}
 
 	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_INET_EGRESS, 0, NULL, NULL,
 			   &prog_cnt)) {
-- 
2.7.4

