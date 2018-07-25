Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A393FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC9920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="McK2t8M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGYTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbeGYTN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:26 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8289620893;
        Wed, 25 Jul 2018 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541641;
        bh=Iyyav/WoMgogm7wNtNs8LGT6od91lV623UDLoKn4qEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=McK2t8M9uZRxRHb/GokCqVmwAlTJVLY3wYjHCC3CiocJrZ1d9spMEZw/hJJkxCPAS
         39TJTVPPik94mHz/zskgP4LEzS1t+4W37Kz7H4YKrk/XXo1oZzeZdtXcJ+oHFpT3G9
         Lc9Bm039mT28OocVY/NPoruH6UY6cM4Yupx1pypE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/27] perf cs-etm: Introduce invalid address macro
Date:   Wed, 25 Jul 2018 14:59:37 -0300
Message-Id: <20180725180001.15108-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch introduces invalid address macro and uses it to replace dummy
value '0xdeadbeefdeadbeefUL'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1529298599-3876-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 4d5fc374e730..938def6d0bb9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -31,6 +31,8 @@
 #endif
 #endif
 
+#define CS_ETM_INVAL_ADDR	0xdeadbeefdeadbeefUL
+
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
@@ -261,8 +263,8 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 	decoder->tail = 0;
 	decoder->packet_count = 0;
 	for (i = 0; i < MAX_BUFFER; i++) {
-		decoder->packet_buffer[i].start_addr = 0xdeadbeefdeadbeefUL;
-		decoder->packet_buffer[i].end_addr = 0xdeadbeefdeadbeefUL;
+		decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
+		decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].exc = false;
 		decoder->packet_buffer[i].exc_ret = false;
@@ -295,8 +297,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].exc = false;
 	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
-	decoder->packet_buffer[et].start_addr = 0xdeadbeefdeadbeefUL;
-	decoder->packet_buffer[et].end_addr = 0xdeadbeefdeadbeefUL;
+	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
+	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
-- 
2.14.4

