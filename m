Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863420823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479126;
	bh=39jd9hJbTUviDwER87ocrL7VYu7MtIfC1KZj2k9NBhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tzflBiVuu2nU/gJs4jhO+gpB7t9xrfIz6eacVTeg+PhKeP8G/AS90TsTklLILwMZx
	 5TZxSU0dKAYwcaE5dnel5q/aDVYpqX2rqAozAvy/nEASGRdk3in+xh+FysjaXFAtpq
	 iUmf13Kl7KNBb18pC8iuNv6NGHLv68Ph9QtEp5gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfBFSwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfBFSwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:52:02 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF29B206DD;
        Wed,  6 Feb 2019 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479121;
        bh=39jd9hJbTUviDwER87ocrL7VYu7MtIfC1KZj2k9NBhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2dmx5Ewpig4m+yrO6Wxb9U9/DbjQmR9D0QY/q6OyWF3ml+YY5a5OplqgBW8nhtyY
         ZsONF7fuoUpQYsW1SwOpwCS7GOMx5SiNjA2oyW7v8Hb67VaLFCmJKkn9rla9WaQLbz
         CpTSFVeigpcvDDe4zYhOx8fCNFc4Ns3rklLT+KfA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 52/53] perf intel-pt: Packet splitting can happen only on 32-bit
Date:   Wed,  6 Feb 2019 15:49:02 -0300
Message-Id: <20190206184903.24054-53-acme@kernel.org>
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

Data is copied when the trace is stopped, so packets are never split
between buffers except when processing if the buffer cannot fit in the
address space which can only happen on 32-bit systems. Change the logic
to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190206103947.15750-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index a54d6c9a4601..6e03db142091 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -868,7 +868,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 
 		ret = intel_pt_get_packet(decoder->buf, decoder->len,
 					  &decoder->packet);
-		if (ret == INTEL_PT_NEED_MORE_BYTES &&
+		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
 		    decoder->len < INTEL_PT_PKT_MAX_SZ && !decoder->next_buf) {
 			ret = intel_pt_get_split_packet(decoder);
 			if (ret < 0)
-- 
2.20.1

