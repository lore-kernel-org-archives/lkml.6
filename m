Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23096C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DC9218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171040;
	bh=SqmRLABnXNmbqu4cRZLHpt48Y33TI7BUDq8tMlrlags=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OjAux7a+9MdGsvkx4Ksis2Zt6FATddfhsQ3Z0Bv/X0d9ZZpHA+te/86vKjgJCBj2W
	 XpoSivhEjWgjTzxH9jI7gMZg135KcsPt5kvSyennUkVuxlYevHqOAre2f8lZDyoCkK
	 zefpryMBmJ+Nun3R3/ns/Q4OiIrbPVLPXn5gs6Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeLRWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeLRWKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:10:36 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A577218A2;
        Tue, 18 Dec 2018 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171036;
        bh=SqmRLABnXNmbqu4cRZLHpt48Y33TI7BUDq8tMlrlags=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Owzfmzw1OqM47NqixnWgc+qsT0AnMzzXFjRi9+n1rKID8+SMcTf6EbWqu4XlB3g10
         sgF3NW8dpgnRRlRDSGGZHJLKsqG51MJC3BufYPoScnHE+978Cdj5ct1gotJSi+ov3V
         qmHlMJL9REwLeo3aCxkBf4OmErMSP2yoJdlMwgFY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/63] perf cs-etm: Refactor enumeration cs_etm_sample_type
Date:   Tue, 18 Dec 2018 19:06:59 -0300
Message-Id: <20181218220733.15839-30-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The values in enumeration cs_etm_sample_type are defined with setting
bit N for each packet type, this is not suggested in the usual case.

This patch refactor cs_etm_sample_type by converting from bit shifting
values to continuous numbers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-5-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2b8292..3819a04a2c27 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,9 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
+	CS_ETM_TRACE_ON,
 };
 
 enum cs_etm_isa {
-- 
2.19.2

