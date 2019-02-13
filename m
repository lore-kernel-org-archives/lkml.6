Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA11C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02FF222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025391;
	bh=EdUZ2KYYrjVVx8f7o1JIrWaKS8nYu5WM1x7fNFyK2no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jnrsD5AAAYE8jHsCft/otsCIWUDjJlXNk8SHnvLk35amLEju6hzPkf+5mRh16YwtB
	 0rAvHXFxjfx9X5iTMholq1cGFDeSMvguL4+BhtYuy7tgPyAEVFV7+rJGzj9vESGKqK
	 Tz6s69MmGx7EeEzKy7A+JP6QyBvGdZE1qr04xGdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbfBMCg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbfBMCgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BE7222C2;
        Wed, 13 Feb 2019 02:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025381;
        bh=EdUZ2KYYrjVVx8f7o1JIrWaKS8nYu5WM1x7fNFyK2no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8AMEQL5wrXjXDvYHf0rQEnypjsq5gcOIlKi0RymvYtYt+TbOG+rtVhTh+1kZzrT+
         FPpMgbChrTWw0feFCzn4H+VKBM5KZwHOCnWrjbmhzbLc+ZyowCGDBnTJ+N9hCkJvZC
         LqtbK2RwbanOdUyZng92UmDmO23SjPPgC3zN2THY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 091/105] selftests/bpf: retry tests that expect build-id
Date:   Tue, 12 Feb 2019 21:33:22 -0500
Message-Id: <20190213023336.19019-91-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit f67ad87ab3120e82845521b18a2b99273a340308 ]

While running test_progs in a loop I found out that I'm sometimes hitting
"Didn't find expected build ID from the map" error.

Looking at stack_map_get_build_id_offset() it seems that it is racy (by
design) and can sometimes return BPF_STACK_BUILD_ID_IP (i.e. can't trylock
current->mm->mmap_sem).

Let's retry this test a single time.

Fixes: 13790d1cc72c ("bpf: add selftest for stackmap with build_id in NMI context")
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 2d3c04f45530..998b6cc77ed6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1136,7 +1136,9 @@ static void test_stacktrace_build_id(void)
 	int i, j;
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
 	int build_id_matches = 0;
+	int retry = 1;
 
+retry:
 	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
 		goto out;
@@ -1249,6 +1251,19 @@ static void test_stacktrace_build_id(void)
 		previous_key = key;
 	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
 
+	/* stack_map_get_build_id_offset() is racy and sometimes can return
+	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
+	 * try it one more time.
+	 */
+	if (build_id_matches < 1 && retry--) {
+		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+		close(pmu_fd);
+		bpf_object__close(obj);
+		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
+		       __func__);
+		goto retry;
+	}
+
 	if (CHECK(build_id_matches < 1, "build id match",
 		  "Didn't find expected build ID from the map\n"))
 		goto disable_pmu;
@@ -1289,7 +1304,9 @@ static void test_stacktrace_build_id_nmi(void)
 	int i, j;
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
 	int build_id_matches = 0;
+	int retry = 1;
 
+retry:
 	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
 		return;
@@ -1384,6 +1401,19 @@ static void test_stacktrace_build_id_nmi(void)
 		previous_key = key;
 	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
 
+	/* stack_map_get_build_id_offset() is racy and sometimes can return
+	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
+	 * try it one more time.
+	 */
+	if (build_id_matches < 1 && retry--) {
+		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+		close(pmu_fd);
+		bpf_object__close(obj);
+		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
+		       __func__);
+		goto retry;
+	}
+
 	if (CHECK(build_id_matches < 1, "build id match",
 		  "Didn't find expected build ID from the map\n"))
 		goto disable_pmu;
-- 
2.19.1

