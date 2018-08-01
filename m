Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3978FC46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C31208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQF5IClM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C31208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbeHAXZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbeHAXZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:46 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA69E20844;
        Wed,  1 Aug 2018 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159478;
        bh=BtcUyvx6Aw9ygzNlfVpAUqaho8KTSw/7QAGDA5asJlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQF5IClMaFFyeScZTeQEay1CZqql+P5yZ6c2lamk8oBxBEQIx2MytL+K4KQUm9cxC
         rY32u6BMS7ZwSaVj74M6hhJzy+8jpCeyh6s/sm8x0LUFjIEkdYJIBtI1x0vpKfIEXw
         aCyU2PKxBkcXsHPOWON2iad50el0y0LsF95B7IMc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/21] perf list: Unify metric group description format with PMU event description
Date:   Wed,  1 Aug 2018 18:36:44 -0300
Message-Id: <20180801213648.4814-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

PMU event descriptions use 7 spaces + '[' or 8 spaces as indentation.
Metric groups used a tab + '['. This patch unifies it to the way PMU
event descriptions are indented.

BEFORE:

  $ perf list
  [...]
  Metric Groups:

  DSB:
    DSB_Coverage
	  [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  [...]

AFTER:

  $ perf list
  [...]
  Metric Groups:

  DSB:
    DSB_Coverage
         [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  [...]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
LPU-Reference: 771439042.22924766.1532986504631.JavaMail.zimbra@redhat.com
Link: https://lkml.kernel.org/n/tip-mlo850517m6u1rbjndvd1bwr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 96eab4ec34ff..a28f9b5cc4ff 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -326,8 +326,8 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 				if (raw)
 					s = (char *)pe->metric_name;
 				else {
-					if (asprintf(&s, "%s\n\t[%s]",
-						     pe->metric_name, pe->desc) < 0)
+					if (asprintf(&s, "%s\n%*s%s]",
+						     pe->metric_name, 8, "[", pe->desc) < 0)
 						return;
 				}
 
-- 
2.14.4

