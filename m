Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE96AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54B520838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up2sWGzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54B520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeJ3WXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbeJ3WXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:23:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643332080A;
        Tue, 30 Oct 2018 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906224;
        bh=9oW7HV5TWB+xI9PP1euB86qqbz06Xv+geUhczDXLZ5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Up2sWGzRp58jHJ6pmTCQcXtV/lqtzudTuQpJ3fQDBx01JWTK4DuDfDrvNpHkjqPIv
         zTuhUOp3R6oWKl6c5ACX5oq/sR+ShqB0HUAEPYiCGw0ehWZXbnUOnHiq6t8mKce9KE
         dfWO7Oz6q5dHxtMAJiQFOesbnCtxfrxAil42CTHE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/13] bpf: do not blindly change rlimit in reuseport net selftest
Date:   Tue, 30 Oct 2018 09:29:11 -0400
Message-Id: <20181030132923.218124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 262f9d811c7608f1e74258ceecfe1fa213bdf912 ]

If the current process has unlimited RLIMIT_MEMLOCK,
we should should leave it as is.

Fixes: 941ff6f11c02 ("bpf: fix rlimit in reuseport net selftest")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/reuseport_bpf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
index cad14cd0ea92..b5277106df1f 100644
--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -437,14 +437,19 @@ void enable_fastopen(void)
 	}
 }
 
-static struct rlimit rlim_old, rlim_new;
+static struct rlimit rlim_old;
 
 static  __attribute__((constructor)) void main_ctor(void)
 {
 	getrlimit(RLIMIT_MEMLOCK, &rlim_old);
-	rlim_new.rlim_cur = rlim_old.rlim_cur + (1UL << 20);
-	rlim_new.rlim_max = rlim_old.rlim_max + (1UL << 20);
-	setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+
+	if (rlim_old.rlim_cur != RLIM_INFINITY) {
+		struct rlimit rlim_new;
+
+		rlim_new.rlim_cur = rlim_old.rlim_cur + (1UL << 20);
+		rlim_new.rlim_max = rlim_old.rlim_max + (1UL << 20);
+		setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+	}
 }
 
 static __attribute__((destructor)) void main_dtor(void)
-- 
2.17.1

