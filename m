Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42970C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E5D258DA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E5D258DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeGBDyL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:54:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:43408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752265AbeGBDyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:54:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 20:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,297,1526367600"; 
   d="scan'208";a="63693728"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.29.56])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2018 20:54:04 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Pintu Agarwal <pintu.ping@gmail.com>
Subject: [PATCH 2/3] selftests/android: initialize heap_type to avoid compiling warning
Date:   Mon,  2 Jul 2018 11:53:53 +0800
Message-Id: <1530503634-32241-3-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530503634-32241-2-git-send-email-lizhijian@cn.fujitsu.com>
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-2-git-send-email-lizhijian@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

root@vm-lkp-nex04-8G-7 ~/linux-v4.18-rc2/tools/testing/selftests/android# make
make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
make[1]: Entering directory '/root/linux-v4.18-rc2/tools/testing/selftests/android/ion'
gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionapp_export.c ipcsocket.c ionutils.c   -o ionapp_export
ionapp_export.c: In function 'main':
ionapp_export.c:91:2: warning: 'heap_type' may be used uninitialized in
this function [-Wmaybe-uninitialized]
  printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CC: Shuah Khan <shuah@kernel.org>
CC: Pintu Agarwal <pintu.ping@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/android/ion/ionapp_export.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
index a944e72..e3435c2 100644
--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -49,6 +49,7 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
+	heap_type = -1UL;
 	heap_size = 0;
 	flags = 0;
 
@@ -82,6 +83,12 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (heap_type == -1UL) {
+		printf("heap_type is invalid\n");
+		print_usage(argc, argv);
+		exit(1);
+	}
+
 	if (heap_size <= 0) {
 		printf("heap_size cannot be 0\n");
 		print_usage(argc, argv);
-- 
2.7.4

