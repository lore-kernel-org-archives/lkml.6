Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1360CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA83F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4p8OBap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA83F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeICTNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeICTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:32 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 244982086E;
        Mon,  3 Sep 2018 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986382;
        bh=p9snF1qdMzLyhvN4b1OEFYzK/iiKY+mUnwVs9hfE1SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4p8OBapNm35McMBUD5S77Etr07vP2mR8wRxfJzkjFT2nBmTo/nlaD2Kzln9yHrN5
         RCZjL+oRWZI3mmRk8WWeXMNRvPk0j5MbpcODna3/zYn+cTfMLJb3sRu/d/db8wXtZ3
         Kb9b+s0zQNxw+btvjeMzM4z3l9kflP0RcpO/kVcQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Chris Phlipot <cphlipot0@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/13] perf util: Fix bad memory access in trace info.
Date:   Mon,  3 Sep 2018 11:52:21 -0300
Message-Id: <20180903145224.12318-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

In the write to the output_fd in the error condition of
record_saved_cmdline(), we are writing 8 bytes from a memory location on
the stack that contains a primitive that is only 4 bytes in size.
Change the primitive to 8 bytes in size to match the size of the write
in order to avoid reading unknown memory from the stack.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829061954.18871-1-cphlipot0@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index c85d0d1a65ed..7b0ca7cbb7de 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -377,7 +377,7 @@ static int record_ftrace_printk(void)
 
 static int record_saved_cmdline(void)
 {
-	unsigned int size;
+	unsigned long long size;
 	char *path;
 	struct stat st;
 	int ret, err = 0;
-- 
2.14.4

