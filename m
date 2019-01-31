Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD4BC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BDA218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="glf4ziPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfAaSr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41212 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfAaSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so1864160plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7joT+FiIVI2um+Bj5G0r88fPyUv6XsFU9OyCfcSTWlE=;
        b=glf4ziPBQoTzLutgeF+Kepcv2UOvFNic2vzeLLP4nCNWMQCM3Rv0B0ZJe75bW3cncy
         +IhWEsfjSWk/9bisvLFqOIqzZPTjpQRv3nK1CktyUcZKc4wGG8r0BoZ9PtaFc04J0Lqo
         gIb04R7fqjNSJVnxqReFJF5V73z+BFLi0okJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7joT+FiIVI2um+Bj5G0r88fPyUv6XsFU9OyCfcSTWlE=;
        b=RLxRSodi+5oBkeQSfPZEwvj4QTbWOunahACsq9dz9IO4GTX6ZHpnD25lQZyGvZBbdK
         FcI540jGf9udJ8ScLs11w5dxwe9mbzQsbzrHHIzT6H0hTysCxPyVfNdEt0ZvPL7mBPVh
         NL8z7k0b+4il3CxGlHSEzM1aVS19XCPfwEXST9u30dTMRgExX687iGfZKrw6o070L/b/
         iDfzfm9hOOHttsT06B8QYxz1pkc8t40nSxeXbE4IFeOU7n0cB+99DQjeOyBp2gl/clvm
         aMaZ9tHMzyFQd70xIxT1NsT0gVPo8qCXdzAU9dOaw4WHfXoN0Dh8BYw02b0f3V8BDEpD
         JiJg==
X-Gm-Message-State: AJcUuke/0R0trH5maiAbvq1EKpPkPDmsoMHUVvCQr03X83CssoWjB0zc
        VD689XSXJVNk/KVKihgIPTQ1DQ==
X-Google-Smtp-Source: ALg8bN6nLnb3VX5nWFOBEDhC2QRl2u6YbdJ3hyz4n1FuiGrrdmOerDQIXatwGc+oQ/suKXAX/pEziw==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr33947349plb.70.1548960443889;
        Thu, 31 Jan 2019 10:47:23 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:47:23 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
Date:   Thu, 31 Jan 2019 11:47:11 -0700
Message-Id: <20190131184714.20388-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
used by other files than pmu.c

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/perf/util/pmu.c | 2 --
 tools/perf/util/pmu.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 11a234740632..51d437f55d18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -29,8 +29,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
-
 int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..350c54e0bd3d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -16,6 +16,7 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
+#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 
 struct perf_event_attr;
 
-- 
2.17.1

