Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCD920873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSdp3F6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCD920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbeJYWxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeJYWxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239482148E;
        Thu, 25 Oct 2018 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477237;
        bh=fQ0VW0zLV5ICMogiUHv2eTy26CDEsla9M+N7n/LiBJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSdp3F6C8nfkpPMYAtavHXQxxqZZRKtbgHrBC/zNWJ5WEd04Wc7hNBYoZ6K+tHZGL
         WL9Cnzpz7BaQPLqCp66cO8plRiB3orRNitxXkLwYzlfdQiACVAVbnCQZmvQqfxc6pu
         5qaLiwhgywyj0qP5Ju8GMOVzCYxo6UUEcL9/XmKU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vinson Lee <vlee@twitter.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 68/98] perf bench numa: Fix to show proper convergence stats
Date:   Thu, 25 Oct 2018 10:18:23 -0400
Message-Id: <20181025141853.214051-68-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

[ Upstream commit 2b42b09b88c831ba4da2d669581dde371c38c2af ]

With commit: e1e455f4f4d3 (perf tools: Work around lack of sched_getcpu
in glibc < 2.6), perf_bench numa mem with -c or -m option is not able to
correctly calculate convergence.

With the above commit, sched_getcpu always seems to return -1. The
intention of commit e1e455f was to add a sched_getcpu in glibc < 2.6.
Hence keep the sched_getcpu definition under an ifdef.

This regression happened occurred between v4.0 and v4.1

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vinson Lee <vlee@twitter.com>
Fixes:  e1e455f4f4d3 ("perf tools: Work around lack of sched_getcpu in glibc < 2.6")
Link: http://lkml.kernel.org/r/20150624111004.GA5220@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cloexec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 85b523885f9d..2babddaa2481 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,11 +7,15 @@
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
 
+#ifdef __GLIBC_PREREQ
+#if !__GLIBC_PREREQ(2, 6)
 int __weak sched_getcpu(void)
 {
 	errno = ENOSYS;
 	return -1;
 }
+#endif
+#endif
 
 static int perf_flag_probe(void)
 {
-- 
2.17.1

