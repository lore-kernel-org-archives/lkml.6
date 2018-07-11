Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3107C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D54120862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/m+IA6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D54120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeGKHtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:19 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:43284 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeGKHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:19 -0400
Received: by mail-pl0-f54.google.com with SMTP id c41-v6so8810644plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vW3cqebjdlydqMs6JbHwBlmxXx9urlbBEoZPw9FFXQA=;
        b=E/m+IA6tJldpTNUN28KPNYTUMALeXE1c3aisZSeM0vza4oUI2WypgO3EvHbSTMjl7b
         HE3f7QwSy0Hb4o8mEww6hSct8NA/E3R95vaVTlQqzKJZo4TKoXuzHIj/e4yI6TBXdf1m
         VUb2bCOaW4mhAEFlXdrMV/M02n7aSt4B7HsDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vW3cqebjdlydqMs6JbHwBlmxXx9urlbBEoZPw9FFXQA=;
        b=nakq/hyRXtxLit8a+IwYEBUuHgEzgKz2weCZYaVuWPiHuTFkOl6JgjV0GK837dwtWD
         a21Hpob8MT8A5L3xhq2B0BMv1WlOLO89Ps4ZPPLkeIMGq2/e+AfqHVgqrOK7KB7rfaGC
         rVU9iOiToF1QHUecMvBJfTsqpOipPutFiWJFa++93XbbCV9OpMwFpRQK7+xYIFKSqZxn
         4Ua2pUV1ytQT5BNuKU70/2qjXngsknYhvbQ6kBOxYnpZTOXQtmGEXVO1i65ABGZph5Zw
         c2qXbtxOraG65UZZbF5zG8N+cDRn2J6O6wE/PZ917gbc70qlqEdG4yhTyv/IUuZyJk/I
         DH7w==
X-Gm-Message-State: APt69E2dbzOzwyFE2NIJUw0XbfQH6qRez4hTup9uq/p8gdMeUOwDCyVi
        LYD5LHcVPZ0I/FH3lqyaXDXmEA==
X-Google-Smtp-Source: AAOMgpd7ooOWVKmayH4LHWEJGZqfPAQk6GNygBeVPG9mNWV4AxUyMulHFQNjpkta4PzKujp5iqYFPg==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr28192496plu.22.1531295181150;
        Wed, 11 Jul 2018 00:46:21 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:20 -0700 (PDT)
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
Subject: [PATCH v2 1/6] perf cs-etm: Introduce invalid address macro
Date:   Wed, 11 Jul 2018 15:45:40 +0800
Message-Id: <1531295145-596-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces invalid address macro and uses it to replace dummy
value '0xdeadbeefdeadbeefUL'.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

