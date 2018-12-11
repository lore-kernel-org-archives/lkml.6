Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD6B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pelw3oX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLKHkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39291 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so12956178wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DdJei3MXkGiE0iSB4u2n/6IcLLnmeX4skh5tiKXlEYc=;
        b=Pelw3oX02t5Wn+zKQ4m+N8Q2Dtp048djj7lyuhalY/P2THi7fEdeG+Bdnq1t9DWCFK
         fqtZNs8ALDy2Mz2QZiMlVxvS6eXVEY+0sXKLexHhklfSFc8m8IGnjV8dgEgFf4Y9KJS8
         mN58fXhibOuSqg/6lEofkfd1OuiHWd5HpeJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DdJei3MXkGiE0iSB4u2n/6IcLLnmeX4skh5tiKXlEYc=;
        b=ZS9bmYD7ThZJc/0r4B2UKrzprMGX2atbNs5mAYoZQ1IzyK7Xj2Rpujatpf6QN0d0zL
         Zj+86z8A7j4y7PSm6Vz9jx57xHwIprE+MVsMG/nvpvcQrv5+uOQZGeB/vN08MqBNBLzR
         Rwcc/yvba07Alda3Z3KfXCfCb1SDR+pcNoGx/owYZkjZBSumuItbpfReM0TdwMmK0thq
         w5EiNioyUsQvq9PeRxyeFuyLRHOLcscZ1yeaJdnykad96dAqjzUKwv+o3u3VW6w5pL2C
         xL/pKZo4g3oYOjwu6GAWsspg0lB0KKEww60W0Jhx/1sF/HHoopttZzjVCd04tx3OspXz
         XC9g==
X-Gm-Message-State: AA+aEWakqiNlPKu+Bg5qx+yssCc48duOPI4UAvTK07etmzcY+LCVDulc
        bh4Vpjznvhi+nGDm2Wck3plJ7g==
X-Google-Smtp-Source: AFSGD/W2mksq10IWLPb0pBv7dqPRVjxnWNUITcg+FVVsRbtXlN1SN2ELeckglNbpt/iDIa9FweWUMg==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr12066007wrp.200.1544514028756;
        Mon, 10 Dec 2018 23:40:28 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:27 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: [PATCH v3 1/8] perf cs-etm: Correct packets swapping in cs_etm__flush()
Date:   Tue, 11 Dec 2018 15:38:21 +0800
Message-Id: <1544513908-16805-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not
swap packets if without option '--itrace=il' to generate last branch
entries; thus for this case the 'prev_packet' doesn't point to the
correct previous packet and the stale packet still will be used to
generate sequential sample.  Thus if dump trace with 'perf script'
command we can see the incorrect flow with the stale packet's address
info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so
can save correct content to 'prev_packet'.  Finally this can fix the
wrong program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 23159c33..789707b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1042,7 +1042,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.7.4

