Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F101FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07DF20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977803;
	bh=71bZYqIvrgLKtNHcvSBPT2C7oSSe2PEcWzz8UMCPeaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/ilc+qmpseX2JN6jCevVhESicFMxsQZHcpVTO7PYpDBD7i6rHEg4cSpGalwZn6Sp
	 3i/E/C2779OHvLlgLJRsFECzDJIS2TSNp7VI6YofXyEIxLs31HPQsYdaf8FmrUZGnb
	 So2+OHSL36/yzdFjMsgQG13FmYLFCtEQLRupSKCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfAHUDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbfAHT2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443ED20827;
        Tue,  8 Jan 2019 19:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975727;
        bh=71bZYqIvrgLKtNHcvSBPT2C7oSSe2PEcWzz8UMCPeaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xw0Hq702SNWxzh9RRDdRemYEnxF8i6IuJ2g8dvLKJOJxWYQ6wgUYcJosLs+DAKR8I
         9UWTw64oqCrA2OZYEoCcxG7t7IAmX3+mjxm1l4TadTd+rDTJRuCW4752LrZgYrabBW
         LjzcMzMdfeWw/q0sZkyYNqKxkXg9qOSc9OiThp1I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 080/117] perf tests ARM: Disable breakpoint tests 32-bit
Date:   Tue,  8 Jan 2019 14:25:48 -0500
Message-Id: <20190108192628.121270-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 24f967337f6d6bce931425769c0f5ff5cf2d212e ]

The breakpoint tests on the ARM 32-bit kernel are broken in several
ways.

The breakpoint length requested does not necessarily match whether the
function address has the Thumb bit (bit 0) set or not, and this does
matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
background.

[1]: https://lkml.org/lkml/2018/11/15/205

As Will indicated, the overflow handling would require single-stepping
which is not supported at the moment. Just disable those tests for the
ARM 32-bit platforms and update the comment above to explain these
limitations.

Co-developed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203191138.2419-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/bp_signal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..910e25e64188 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -291,12 +291,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 
 bool test__bp_signal_is_supported(void)
 {
-/*
- * The powerpc so far does not have support to even create
- * instruction breakpoint using the perf event interface.
- * Once it's there we can release this.
- */
-#if defined(__powerpc__) || defined(__s390x__)
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * ARM requires explicit rounding down of the instruction
+	 * pointer in Thumb mode, and then requires the single-step
+	 * to be handled explicitly in the overflow handler to avoid
+	 * stepping into the SIGIO handler and getting stuck on the
+	 * breakpointed instruction.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
 	return false;
 #else
 	return true;
-- 
2.19.1

