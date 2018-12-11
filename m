Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22450C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5E12082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMxLwRDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLKHkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so12980208wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7KsG51IyxvMCicfAhv+X1OucWXiA4qhwMKrH6icak5k=;
        b=iMxLwRDg3PQZUIpt3OlWqvTuEZfmbgtvhqfN8lG6OI91R7LsqBjlMjaOJlM99vkOZx
         3exwV5HwXGH2rCT3nY9ZsH+wCRn4rwnfqZyO6w/n+FaUClJIikrQeQuipGq3cyDaJY4m
         PXc3GJxPvBDLcnD7eqIUO5uVdK3nwjoj2lRxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7KsG51IyxvMCicfAhv+X1OucWXiA4qhwMKrH6icak5k=;
        b=dkRrmX9P6iYgpfMlnZdF0wXu4l+HrUnafQIlDDYrxK3vQHRYUvUXzyVCdNM0DHkRPI
         6EmxZnQr8J4d6/OnrfP+UW3Cxc+QsxpWK7iP0pUiS2dQ82z75UBL1uXGiENfoVzVp7P2
         ragHfaLsfrGHOY16sXdhJrJYuuRGDAYj3YcJgoxDnvowziS9JV26EhWB1VL3lUQopGiu
         RTaxacwL2Z3kpUpCRU4ocMafo1JQ04AW9IzhgxbM27RsDwbrfXf/3va65d6Bndr2dxDL
         q9V10k7gJPC2a7F2OXhcLrVthsY7cegrXsxVoZok5jE+eDr2VTX7gaGgc0n10qwICf1C
         FuCg==
X-Gm-Message-State: AA+aEWbp+6U3xsODym8uv7AjnWXmja/HXuVjGqODj4UlhKqgeE2Xem0p
        oVjRLKLDxmLLIkZ+wbtvyGf0UQ==
X-Google-Smtp-Source: AFSGD/XfIo07y8495X6aVdm9zWCklhb9vK6Qn3VdBHA45vVAikhvz/10EWh+h8hx4/BgaYk8tEpT2g==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr11886334wru.33.1544514042362;
        Mon, 10 Dec 2018 23:40:42 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:41 -0800 (PST)
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
Subject: [PATCH v3 4/8] perf cs-etm: Refactor enumeration cs_etm_sample_type
Date:   Tue, 11 Dec 2018 15:38:24 +0800
Message-Id: <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values in enumeration cs_etm_sample_type are defined with setting
bit N for each packet type, this is not suggested in the usual case.

This patch refactor cs_etm_sample_type by converting from bit shifting
values to continuous numbers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2..3819a04 100644
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
2.7.4

