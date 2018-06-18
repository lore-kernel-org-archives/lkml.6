Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B299C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E7320874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxXTeWDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E7320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbeFRFKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:10:40 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:43065 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbeFRFKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:36 -0400
Received: by mail-pf0-f178.google.com with SMTP id y8-v6so7550208pfm.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTyHBCkH2jOA41M04ze7TFjT8uK1c0mYi0ne/zqeRPI=;
        b=PxXTeWDYr/i8hZWOLby54jizoK8xzVqNvY+Ahl2ktjGMpmtH3xyi8R1KVqO2QPaa+Y
         cDb5w7kjS6KfsHl063PkD4LcgOHzgQ+A99Z1++1xm4BiKIrg1SBxTSUxPt1L2wRuYLUP
         AcakncmuOycBLX8GalaLQZZKqeSCKgBUFoBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTyHBCkH2jOA41M04ze7TFjT8uK1c0mYi0ne/zqeRPI=;
        b=lpR+Kas8OK33LGIZZ+eDauavDaqbwNCQ9W1tkyUrEdY9cJvp52r8PYFNXbaXxXL3dN
         WWumG6LH9+NjxraUs9HOHK2je6wkDf1UX6i7h5H6cqfmJKc9KQdE5S3NLwYIhUT4UVAJ
         kmFpESyHQw7WLcx529bCKR2ojjtx76A4LQjKtaDxDg1SX22RdJHv/asrpPPdv+G4Xmwi
         /HX9FbVtk7UiuPW1ycKfJh2r9gzxHrR/IfmE3UvEa6fmiNpoZ6jb8bKO1QXeKN4rBU3f
         FDxl3XlYgGtwbCbXFWOTY4oRp0leFQywtDP74CYUXeWGlebpER9Nm3NRO5ojt1GrKHs+
         kbpA==
X-Gm-Message-State: APt69E3wQPe7+PLb63T0w/obn/auurYCq1dnyyXrwhZS1GkvhPDXAcqP
        j428vnrVkZb5jyqd4mEVg3L1mkSmYts=
X-Google-Smtp-Source: ADUXVKKs57fKjyvph0YR6/6BisvMess7960Hk7rW0ztgwNufP2ROoUib0Hqj6SVnidmVEwcuRzPEYg==
X-Received: by 2002:a63:2c94:: with SMTP id s142-v6mr9466225pgs.39.1529298636353;
        Sun, 17 Jun 2018 22:10:36 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/6] perf cs-etm: Introduce invalid address macro
Date:   Mon, 18 Jun 2018 13:09:54 +0800
Message-Id: <1529298599-3876-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces invalid address macro and uses it to replace dummy
value '0xdeadbeefdeadbeefUL'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 4d5fc37..938def6 100644
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
2.7.4

