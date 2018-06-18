Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E52420874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QU0ptk9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E52420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeFRFLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:11:10 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35270 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbeFRFK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so8368252plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gd2fy0/Z7eDf8iwKzTR/pYByVowIHmmoYAASyMjR3u4=;
        b=QU0ptk9RwODRXdDVXA6KMqe/5VRxS/nIgh0gTSbLtLTrup+r6IPVnLoybL1Vgfjm5p
         Zrzd4Icsb4sDwruJCTtv4TWzRVOhQHspoDdiPkfvNg5ZHQBp4M3Zc2tjL1e8SB5DIr9S
         dmu/nz9pWFB5kWe1DgXRjxGlW/5q5cTNwf92A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gd2fy0/Z7eDf8iwKzTR/pYByVowIHmmoYAASyMjR3u4=;
        b=XEnocCx63TgW21pVIOkZ8vsWJrclWJlElmRIMTDujm7tTmKutowcAxI1FcZVggA+y7
         cZ/R5kPZ03kyQaFTB63NL//36hcClLAC2R7tConT2C0N131VpFHN03h/3GfeItdwjsMR
         weBuHBn7ZxolWmzCfpnyIGxP9Ri8R+nw9UMu3WFhppTF2yXzvbmHgtYv04WtBANYLcMc
         yENEI/2v/faJa4B9mmFLx7xGvGMeLD7FC+Ky+6meQIieSbPofyR0muER9vxYYrp6cesd
         Bt4xpqrS1Ps8uCuts/N1GE0zvKwngqMmZESLVWcXe/9nV1cLkE6x/V1S5c7NrK5rdpd9
         S8fw==
X-Gm-Message-State: APt69E2UwIGBBeRObkw1TN+xeqnbbYUzTwA0d0DDBfIMkQohRsp2EfIX
        l8MS8GoK6Vq/4ouUzBj3atPiNQ==
X-Google-Smtp-Source: ADUXVKIgqI9iXe5+/sZEQ7+m1F6a1Go/7FkZp/udMa32dHpHsM27rmlrGQcZYqOfvax8Ddwm0vy3Kw==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr12676679pll.186.1529298657213;
        Sun, 17 Jun 2018 22:10:57 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:56 -0700 (PDT)
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
Subject: [PATCH v1 6/6] perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
Date:   Mon, 18 Jun 2018 13:09:59 +0800
Message-Id: <1529298599-3876-7-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS_ETM_TRACE_ON packet itself can give the info that there have a
discontinuity in the trace, this patch is to add branch sample for
CS_ETM_TRACE_ON packet if it is inserted in the middle of CS_ETM_RANGE
packets; as result we can have hint for the trace discontinuity.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d3b7942..2ae6402 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -910,13 +910,23 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		etmq->period_instructions = instrs_over;
 	}
 
-	if (etm->sample_branches &&
-	    etmq->prev_packet &&
-	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
-	    etmq->prev_packet->last_instr_taken_branch) {
-		ret = cs_etm__synth_branch_sample(etmq);
-		if (ret)
-			return ret;
+	if (etm->sample_branches && etmq->prev_packet) {
+		bool generate_sample = false;
+
+		/* Generate sample for tracing on packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
+			generate_sample = true;
+
+		/* Generate sample for branch taken packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
+		    etmq->prev_packet->last_instr_taken_branch)
+			generate_sample = true;
+
+		if (generate_sample) {
+			ret = cs_etm__synth_branch_sample(etmq);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (etm->sample_branches || etm->synth_opts.last_branch) {
-- 
2.7.4

