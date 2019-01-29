Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF7C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE422083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5iuxOB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfA2MaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:30:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbfA2MaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:30:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so9617490pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ogFhqC1zhd8TWEoo9LulKJyn1R4ZPNj2Npeem7P1skM=;
        b=f5iuxOB4+/EiUDieLqPoazQiHKzkdE0k7bWX4IyKwA6TPSdXGcwZvDDwL3pZWYmfIz
         +crFvLdSTsSVYeH0bQ+ZpRH+8RXevARQYNwQyn5XshyJLLBR8MgiFksN07gk6xsdMz/W
         h7PmMJkPJZ2SiFRRkVl52n7scjOW7Tb45rYlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ogFhqC1zhd8TWEoo9LulKJyn1R4ZPNj2Npeem7P1skM=;
        b=PSpZ5VPDwy0ilIkk81ezCSrZoR7LZbKBXp7VJ08p4SrnDvZyp9b5/KYuH0SnfXEP/R
         VlhD6E9133k8f+ELiF9DNzNY4GXka6xyi1J3M8Q4HerQ/kymxjzvLOc+XrtBf6uo/pjJ
         WQQzgYTZepYAs17KyF5yRFFDkoReYt369LAG86p0xTKIYtszqj/A/ot2QjKUc1tCb4+a
         FUDemEdAnA/4I6tRWvJk+/q/Qb2SX/B6jjpUolQwERYpLnhdQZPIAPZm1YhF7UEMlPB8
         1GEMBSzuexqSFAQ8iD1YYSvshITDyCF9/a33UYspZU5NS3YYcp8D9mEAy/lqfHFG2dwp
         gT9A==
X-Gm-Message-State: AJcUukc4hr+mSjrPtmrIi+8hsaGeFWBzu6+zc53+/YaLMNW1TW8Q5DLx
        /rlYBvihEQqd4RyiPa5jHwI7Mg==
X-Google-Smtp-Source: ALg8bN7PSrBV3NuS4FCk6RUF+FOb2UNcsESw8Ij9TAJ3Bsff9YaU1Q5Wl8FBbTs7YL9SCQCZ5k0VNQ==
X-Received: by 2002:a63:304:: with SMTP id 4mr21493775pgd.99.1548765023004;
        Tue, 29 Jan 2019 04:30:23 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:30:22 -0800 (PST)
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
Subject: [PATCH v7 8/8] perf cs-etm: Set sample flags for exception return packet
Date:   Tue, 29 Jan 2019 20:28:42 +0800
Message-Id: <20190129122842.32041-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When return from exception, we need to distinguish if it's system call
return or for other type exceptions for setting sample flags.  Due to
the exception return packet doesn't contain exception number, so we
cannot decide sample flags based on exception number.

On the other hand, the exception return packet is followed by an
instruction range packet; this range packet deliveries the start address
after exception handling, we can check if it is a SVC instruction just
before the start address.  If there has one SVC instruction is found
ahead the return address, this means it's an exception return for system
call; otherwise it is an normal return for other exceptions.

This patch is to set sample flags for exception return packet, firstly
it simply set sample flags as PERF_IP_FLAG_INTERRUPT for all exception
returns since at this point it doesn't know what's exactly the exception
type.  We will defer to decide if it's an exception return for system
call when the next instruction range packet comes, it checks if there
has one SVC instruction prior to the start address and if so we will
change sample flags to PERF_IP_FLAG_SYSCALLRET for system call
return.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a714b31656ea..8b3f882d6e2f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1372,6 +1372,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
 			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
 					      PERF_IP_FLAG_TRACE_BEGIN;
+
+		/*
+		 * If the previous packet is an exception return packet
+		 * and the return address just follows SVC instuction,
+		 * it needs to calibrate the previous packet sample flags
+		 * as PERF_IP_FLAG_SYSCALLRET.
+		 */
+		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
+					   PERF_IP_FLAG_RETURN |
+					   PERF_IP_FLAG_INTERRUPT) &&
+		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
+			prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_SYSCALLRET;
 		break;
 	case CS_ETM_DISCONTINUITY:
 		/*
@@ -1422,6 +1436,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 			prev_packet->flags = packet->flags;
 		break;
 	case CS_ETM_EXCEPTION_RET:
+		/*
+		 * When the exception return packet is inserted, since
+		 * exception return packet is not used standalone for
+		 * generating samples and it's affiliation to the previous
+		 * instruction range packet; so set previous range packet
+		 * flags to tell perf it is an exception return branch.
+		 *
+		 * The exception return can be for either system call or
+		 * other exception types; unfortunately the packet doesn't
+		 * contain exception type related info so we cannot decide
+		 * the exception type purely based on exception return packet.
+		 * If we record the exception number from exception packet and
+		 * reuse it for excpetion return packet, this is not reliable
+		 * due the trace can be discontinuity or the interrupt can
+		 * be nested, thus the recorded exception number cannot be
+		 * used for exception return packet for these two cases.
+		 *
+		 * For exception return packet, we only need to distinguish the
+		 * packet is for system call or for other types.  Thus the
+		 * decision can be deferred when receive the next packet which
+		 * contains the return address, based on the return address we
+		 * can read out the previous instruction and check if it's a
+		 * system call instruction and then calibrate the sample flag
+		 * as needed.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_INTERRUPT;
+		break;
 	case CS_ETM_EMPTY:
 	default:
 		break;
-- 
2.17.1

