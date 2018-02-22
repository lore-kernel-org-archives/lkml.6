Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2270vsfSFjB9vtRKyVdWWP5m6oX4v8z0bfYqwAF5ImGD13+LMPQZO5Lpp/GBY/T68VmJ5jrW
ARC-Seal: i=1; a=rsa-sha256; t=1519266897; cv=none;
        d=google.com; s=arc-20160816;
        b=ouN0RuF+VQMhFqnb60rhZ9i7IyGtB8keI3sqdbiNzu2M4W+Xc4+VzhTrm36oXlsCRs
         wpo3wmWkR5ACFKxRVpqM2hLzrxpFiFUyXBpzRZhl6au2XAAcL1dbw263g98drL/Zc3e8
         FxMR7BaFcgdRwORCd2KWHJnU2WTOmu4e02zrPn/vSyZLwj2RvCe2/KFjU2Pje/mLTARx
         7mHuugpqkK8j1b/YsAp7Twf9V4SzCnKZd/j0CZcIJsI7S1pwn9nsd9Ne/NANn9c0h+qR
         0inEc2QkZMC85pPpzGn+nN6hiHc9IxoOfl+EmluzdFA5ufSocLdSJ/vuwac1c0BDkOFP
         B69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gl+0JmoGJTMZGY0OxoUOAIBejbYmqV+v1Y6D76mfUKQ=;
        b=y7csiPADiP9WoV0w7Nyt77zKOUjTlkmSA6svrCDCJ6iIitvtA5f836FTl0xUbPKvMQ
         LJlJXZyxTkfX/oBWMwBKRt0oDiloH4HlQd0LEOzLrGzJD8ipPwKYh+8yICSugTIzqldt
         H9OwMy3P36LY9iLYzYH7S7KxMkzPiuxHKDiKM6OXbEPsOxkgig/aTrUcSDzR7F5rFmyy
         VzEd2XhvAvoIF9Ix5CrYyqKdgwu+sm63o3PdU3YZabvLOUjvlReqhEPIBFFuxoMeVFJ5
         OYAloJ8SOk2XmUMgLKJZkninGnZbW8WfOpkgUa6xxVLovxh4TeCr70YwVp1L/gM+X8TV
         ld8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeBVCel (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 21:34:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:7819 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbeBVCek (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 21:34:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,376,1515484800";
   d="scan'208";a="20152533"
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Philip Li <philip.li@intel.com>
Subject: [PATCH v2] selftests/bpf/test_maps: exit child process without error in ENOMEM case
Date: Thu, 22 Feb 2018 10:34:02 +0800
Message-Id: <1519266842-29004-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593066805827109430?=
X-GMAIL-MSGID: =?utf-8?q?1593066805827109430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Li Zhijian <zhijianx.li@intel.com>

test_maps contains a series of stress tests, and previously it will break the
rest tests when it failed to alloc memory.
-----------------------
Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
Failed to create hashmap key=16 value=262144 'Cannot allocate memory'
Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
test_maps: test_maps.c:955: run_parallel: Assertion `status == 0' failed.
Aborted
not ok 1..3 selftests:  test_maps [FAIL]
-----------------------
after this patch, the rest tests will be continue when it occurs an ENOMEM failure

CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Philip Li <philip.li@intel.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 tools/testing/selftests/bpf/test_maps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 436c4c7..9e03a4c 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -126,6 +126,8 @@ static void test_hashmap_sizes(int task, void *data)
 			fd = bpf_create_map(BPF_MAP_TYPE_HASH, i, j,
 					    2, map_flags);
 			if (fd < 0) {
+				if (errno == ENOMEM)
+					return;
 				printf("Failed to create hashmap key=%d value=%d '%s'\n",
 				       i, j, strerror(errno));
 				exit(1);
-- 
2.7.4

