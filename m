Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7DAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B156D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Apj1oepu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B156D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLKHkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33851 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so8328926wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QhESnTtb4oxO4oqXaTFof3KV9a2FuHSEH5X1fFwTnNc=;
        b=Apj1oepuxBiwwnLA8c5LR5Jik9SIHfQZ8dkw0tuhXTFNOxPc5d056h+3dFcSglG/HH
         VZHec2p1IFf+JHPTK24iw/CLhr0WYHCm+Znz6hqURz6vWScBUmPalXhdRsNwASY1/EjI
         v1wrrs//QbCvT24ResV8UxDGKMDcptWXWoX0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QhESnTtb4oxO4oqXaTFof3KV9a2FuHSEH5X1fFwTnNc=;
        b=LqZ4YbGXWLcW/QTEKIEkbnoLyxqRSTcdFznjE2l6fKGxXJW3pHXFYPnnYaur6NUpD8
         TJx8Z7hQ5ehFeO8OU66c2K8+G++ct5KUfqEVhM7k2CkSVdCR3topdAyNbyEcU4aBlOF2
         pMAerxJj9OsdhoIW2WpPz9rWVVXgLelo7Z/dAOLk6jESqC6/9J8BJITY5o/PaFQVCKfs
         xEsw0ej68ZQcV7+ke+tSQt+tW+O6Yi/tLNvNveep7a+oiwolir9ptYuAXk3a8pgr0MHA
         kpkRCaEckaazaApYmjATb02ueknysgYJQbL1kjG+iktfA3Qdo0GwXl+NVOPd3aHepp8k
         WZkA==
X-Gm-Message-State: AA+aEWY5095fA/4CXinn79VE7zFgIOUlHQilwjOMut+mMDL3GcwA2x1A
        PXV6E6L4f08PiQV4MKqGh5tUVQ==
X-Google-Smtp-Source: AFSGD/U24Tc5IovTleKguehoLu7e3cZQIrcRkVkbj98Zj9rm1T7colAgToZ/TpZjyduaCb4Z4NhULQ==
X-Received: by 2002:a1c:1112:: with SMTP id 18mr1367049wmr.30.1544514037870;
        Mon, 10 Dec 2018 23:40:37 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:37 -0800 (PST)
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
Subject: [PATCH v3 3/8] perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
Date:   Tue, 11 Dec 2018 15:38:23 +0800
Message-Id: <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cs_etm_decoder::trace_on is being assigned when TRACE_ON or NO_SYNC
element is coming, but it is never used hence it is redundant and can
be removed.

So let's remove 'trace_on' field from cs_etm_decoder struct.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0b4c862..97b39b1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -36,7 +36,6 @@
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
-	bool trace_on;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -411,12 +410,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_trace_on(decoder,
 						       trace_chan_id);
-		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
 		resp = cs_etm_decoder__buffer_range(decoder, elem,
-- 
2.7.4

