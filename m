Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91B7258E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91B7258E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932990AbeGBDyp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:54:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:43408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbeGBDyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:54:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 20:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,297,1526367600"; 
   d="scan'208";a="63693723"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.29.56])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2018 20:54:03 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Pintu Agarwal <pintu.ping@gmail.com>
Subject: [PATCH 1/3] selftests/android: fix compiling error
Date:   Mon,  2 Jul 2018 11:53:52 +0800
Message-Id: <1530503634-32241-2-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lizhijian@haswell-OptiPlex-9020:/home/lizj/linux/tools/testing/selftests/android/ion$ make
gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionapp_export.c ipcsocket.c ionutils.c   -o ionapp_export
gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionapp_import.c ipcsocket.c ionutils.c   -o ionapp_import
gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionmap_test.c ipcsocket.c ionutils.c   -o ionmap_test
ionmap_test.c:12:27: fatal error: linux/dma-buf.h: No such file or directory
compilation terminated.
<builtin>: recipe for target 'ionmap_test' failed
make: *** [ionmap_test] Error 1

It requires headers_install to $TOP/usr

CC: Shuah Khan <shuah@kernel.org>
CC: Pintu Agarwal <pintu.ping@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/android/ion/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index e036952..9f83299 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -4,7 +4,10 @@ CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
 
 TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
 
-all: $(TEST_GEN_FILES)
+all: ../../../../../usr/include/linux/dma-buf.h $(TEST_GEN_FILES)
+
+../../../../../usr/include/linux/dma-buf.h:
+	make -C ../../../../../ headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../../usr
 
 $(TEST_GEN_FILES): ipcsocket.c ionutils.c
 
-- 
2.7.4

