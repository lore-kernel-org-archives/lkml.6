Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFC2218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479124;
	bh=aPHmhPRHY51Unjb/DwYtTkW2Xmd+x7F1YwKWQh8K8QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rt9VLuUdNrj+ooJeAN5ETHe/yW5HpGvmrt1t7w6Lm+l5f1gl6HyiYp0SvbWHp54fX
	 4kz89pW46golp3RRJO+vgUdiJ8hH8G3NxcRYATx1OSJswa+XO3o/Iwp/TNdPGQFHB3
	 dgz0J5N1ovjK/vGj1Z1NF6kQNCb2nB/G7pNzbhIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfBFSwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfBFSwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:52:00 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FEB2186A;
        Wed,  6 Feb 2019 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479119;
        bh=aPHmhPRHY51Unjb/DwYtTkW2Xmd+x7F1YwKWQh8K8QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyvWTCuL29NQo7Q2lnX80Bwd2Rz8vn0QUm8C+nnNpeM1Qe9QHabCwc/oly2W7wP1D
         mJ1V08cemZO33HJh1mIb/45/lseoFL4ME5Bc1oKyDLvnALGUL5iuWfU/H1qUCiG0ni
         8ER5XkCldOCmFy8TvyJNb7Q199+SexKeoYYawOzo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 51/53] perf intel-pt: Fix CYC timestamp calculation after OVF
Date:   Wed,  6 Feb 2019 15:49:01 -0300
Message-Id: <20190206184903.24054-52-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

CYC packet timestamp calculation depends upon CBR which was being
cleared upon overflow (OVF). That can cause errors due to failing to
synchronize with sideband events. Even if a CBR change has been lost,
the old CBR is still a better estimate than zero. So remove the clearing
of CBR.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ecd25cdc1d3e..a54d6c9a4601 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1395,7 +1395,6 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
-	decoder->cbr = 0;
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
-- 
2.20.1

