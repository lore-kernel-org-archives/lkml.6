Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B442083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h62oC/St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfA2MaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:30:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36788 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2MaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:30:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so9599964pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCTfSFlK4C7FXgdKOX/CUsRQoqsszJ7JLDVdsKNX608=;
        b=h62oC/St4ysiVkeDn5+gNpBIxbddW/cR8Q7J5/A4VfBEdO0y1pPxXkDwcdTwEhsCOm
         HNrpKoUj0H8ltawqSDNgqMqrVX/gJchBmGIGkmYSr/HNTHnt1Aca8ZxacPUkQyhGRnEA
         kJnGIKcu8w8fqD5SjPk8Ip/Q2CnCFfeYeflJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCTfSFlK4C7FXgdKOX/CUsRQoqsszJ7JLDVdsKNX608=;
        b=kvOItoLewgm/Nz/4XX3abZ86ZLpqiLcUtX7whsTqwCIfkvA3C57OS8xCaELlEVnGaj
         ++BJmontwUixX2+rE9M5ddAn7yLDkFGnBGD6z4Rxo3RHroL+WccrBttHqCRd/T9Z1Nu2
         ExTd7SzHEzic+aIlrCuPcWMCtY7nbxlEVeLbAgxSxE91pXYUachEtHRelljRJnu1JjV7
         EMcr0R5X0sqQEqqKH79nWSVWlFSzgTEbN8ssPOyVrCMHm7VD4Q+Uj3wqFVOXQzRM1xoJ
         7/thadnbqMqRW86sgeVk+kP2Dn6KPrvKpY1iK7J0FAY8h+sVLDXgL5PFNWz130DZ91IN
         G7Vg==
X-Gm-Message-State: AJcUukd7APK2Qg1k/M/nFRnLlEj1o+UyhVrw+9rdWVQqmtC2fxAINPgx
        dthjxWTn/ICS+sejRpKiIgQBlIvRz6Y=
X-Google-Smtp-Source: ALg8bN7GGisxap8BzjpfSfJJKj8wKKM0wCnICyIxgBjGKAPZeZb9sXA5hMJdWa6IS2QMyg1L5EDyiQ==
X-Received: by 2002:a63:2586:: with SMTP id l128mr23899786pgl.104.1548764999906;
        Tue, 29 Jan 2019 04:29:59 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:29:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 3/8] perf cs-etm: Set sample flags for trace discontinuity
Date:   Tue, 29 Jan 2019 20:28:37 +0800
Message-Id: <20190129122842.32041-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the middle of trace stream, it might be interrupted thus the trace
data is not continuous, the trace stream firstly is ended for previous
trace block and restarted for next block.

To display related information for showing trace is restarted, this
patch set sample flags for trace discontinuity:

- If one discontinuity packet is coming, append flag
  PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
  has been ended;
- If one instruction packet is following discontinuity packet, this
  instruction packet is the first one packet to restarting trace.  So
  set flag PERF_IP_FLAG_TRACE_START to discontinuity packet, this flag
  will be used to generate sample when connect with the sequential
  instruction packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d05cac5295f1..1aa29633ce77 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1111,6 +1111,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
 
 	switch (packet->sample_type) {
 	case CS_ETM_RANGE:
@@ -1170,8 +1171,26 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
 			packet->flags = PERF_IP_FLAG_BRANCH |
 					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Decoder might insert a discontinuity in the middle of
+		 * instruction packets, fixup prev_packet with flag
+		 * PERF_IP_FLAG_TRACE_BEGIN to indicate restarting trace.
+		 */
+		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_BEGIN;
 		break;
 	case CS_ETM_DISCONTINUITY:
+		/*
+		 * The trace is discontinuous, if the previous packet is
+		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
+		 * for previous packet.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_END;
+		break;
 	case CS_ETM_EXCEPTION:
 	case CS_ETM_EXCEPTION_RET:
 	case CS_ETM_EMPTY:
-- 
2.17.1

