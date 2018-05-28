Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033932AbeE1Kqn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163105AbeE1Kqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Philip Li <philip.li@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Li Zhijian <zhijianx.li@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 121/496] selftests/bpf/test_maps: exit child process without error in ENOMEM case
Date: Mon, 28 May 2018 11:58:26 +0200
Message-Id: <20180528100325.019798906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zhijian <zhijianx.li@intel.com>

[ Upstream commit 80475c48c6a8a65171e035e0915dc7996b5a0a65 ]

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
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_maps.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -126,6 +126,8 @@ static void test_hashmap_sizes(int task,
 			fd = bpf_create_map(BPF_MAP_TYPE_HASH, i, j,
 					    2, map_flags);
 			if (fd < 0) {
+				if (errno == ENOMEM)
+					return;
 				printf("Failed to create hashmap key=%d value=%d '%s'\n",
 				       i, j, strerror(errno));
 				exit(1);
