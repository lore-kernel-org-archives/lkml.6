Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3968C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129852;
	bh=GUzHqu9HqmDb4OTK48Ie+6vlWYawfqx70b2jzp46iF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CCi7emIhI0KU5jiIW8lyG1fpdDaBro3XZeLPvqNOdtK9GqWWR0xOZsnsqUg5N45xi
	 bRO6y31SqjaC/frzz/r4xDUDy6jzocNpPgykB/wJPHSSmCOQwGuc2ICSeQBDcQZ9Fw
	 9ChNKvylWjLTuax8XWJX4DY+vWZMR2w4GVSnyas8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfBYVYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731197AbfBYVYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AC020C01;
        Mon, 25 Feb 2019 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129847;
        bh=GUzHqu9HqmDb4OTK48Ie+6vlWYawfqx70b2jzp46iF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=or4V46Dfd2X9aHEBj0d4SPxd3+JBeKmZBp+WWJbLQgHe+g48Y4LF43ABXEVu1CbXJ
         W5B7LWvUUK2O0SoQAdQsWrDeMLGykwh2jOetGl7BIT1lziadEj6QH4fMNgozuT3OvL
         BWhZQ8xagwN9o4z5+wig3KbX2NUSqylgHmIwUjak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/152] selftests/bpf: retry tests that expect build-id
Date:   Mon, 25 Feb 2019 22:11:18 +0100
Message-Id: <20190225195048.957090671@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index d029cad08cbd8..89f8b0dae7ef0 100644
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



