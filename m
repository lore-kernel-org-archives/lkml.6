Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225tAPQ4bFlUwW2d5SsO7Qv4ZHegTHE8DWTmHjn2BjmdtiSmw/AOdyy439aH9Q9WeQb27cIt
ARC-Seal: i=1; a=rsa-sha256; t=1518443544; cv=none;
        d=google.com; s=arc-20160816;
        b=nY5BmmlrBObVgxPf0ctA5puoiOoOAOURPyfdq/JyN2q4opkhamdsboaLiixCQUUtdk
         n+RpHmIrXwH/Mu2O8T/i/0iqkWJCuLjm6iY644hNwLXseak98oUmLkkpm9ifCLVBQfrP
         1mK+sjmC+JE1O+nJpqfXzYZj1tfyczBj9qiEiU34XjH/eFgYJw+TwBmlSqhB6qDHZC9S
         uPBbqs9CXW660oLej/zztlxHsAEFUKOAA42yKFMCFUI1sXl4EowxA+dS5vBI1wiXvAAk
         L+YNFvB6+7cTtOJGTPEu7EaYM51bpAXiKdow0d6f5HeO8i27948FJCDDMH/XG3aIV9pI
         mMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ygL+1Bxq2gDSqfSdlmovuRAEpTB8sNpDAmTeb9XNVCU=;
        b=nIX+BQMaQQ7T5r6mMyXc6EoCSEVneGV1YDkSrHvYJWqBWkFNhwUGEDjnkpnqzPhmGm
         ByUZ8yNjBWZr+L1kCZQxEB4IOyut1zsES8iNFRh2LZjwGG65MrtMyo/mSBJIvrQ0boHC
         q720lOFSbLjC8JZFMD1hyjsNDGeJqNGL1Q0k0kFJCZPUgb2oX5W2KNt4B12AyFhHhXvv
         4dkjDAqKvNw4rdf6r4l2itgktauBhVj5aHVgJAoVW9WnbAjtZkSHq5xFn0qBToyvrSSr
         rUkdV0fQ1FLxXJ8wbvDgYkg3M6uqhIcMl1BiFmZsBCmfGJzj4kV4agA2ka180ZUn7vtJ
         o6Gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeBLNwY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 12 Feb 2018 08:52:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:28974 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933072AbeBLNwX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Feb 2018 08:52:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="30756365"
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Philip Li <philip.li@intel.com>
Subject: [PATCH] selftests/bpf/test_maps: exit child process without error in ENOMEM case
Date: Mon, 12 Feb 2018 21:52:04 +0800
Message-Id: <1518443524-18373-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592203458729605542?=
X-GMAIL-MSGID: =?utf-8?q?1592203458729605542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Li Zhijian <zhijianx.li@intel.com>

test_maps contains a series of stress tests, and previously it will break the
reset tests when it failed to alloc memory.
-----------------------
Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
Failed to create hashmap key=16 value=262144 'Cannot allocate memory'
Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
test_maps: test_maps.c:955: run_parallel: Assertion `status == 0' failed.
Aborted
not ok 1..3 selftests:  test_maps [FAIL]
-----------------------
after this patch, the rest tests will be continue when it occurs a ENOMEM failure

CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Philip Li <philip.li@intel.com>
Suggest-by: Daniel Borkmann <daniel@iogearbox.net>
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

