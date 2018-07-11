Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD05208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD05208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeGKCKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:10:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:64403 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbeGKCKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:10:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 19:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="63773453"
Received: from yangblan-mobl2.ccr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.30.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2018 19:08:09 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Pintu Agarwal <pintu.ping@gmail.com>
Subject: [PATCH v2] selftests/android: initialize heap_type to avoid compiling warning
Date:   Wed, 11 Jul 2018 10:08:00 +0800
Message-Id: <1531274880-9375-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
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
 tools/testing/selftests/android/ion/ionapp_export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
index a944e72..b5fa0a2 100644
--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -51,6 +51,7 @@ int main(int argc, char *argv[])
 
 	heap_size = 0;
 	flags = 0;
+	heap_type = ION_HEAP_TYPE_SYSTEM;
 
 	while ((opt = getopt(argc, argv, "hi:s:")) != -1) {
 		switch (opt) {
-- 
2.7.4

