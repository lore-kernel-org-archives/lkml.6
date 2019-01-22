Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9BA2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z60QHjIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfAVSMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:12:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38192 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfAVSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:11:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so11855932plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SuxrcXTgi5Kz7buMh5CGnWQq0L/rwu8Ex3hQZBJw2VY=;
        b=Z60QHjIenHT4OyqBsheQMaxF6RYqBiV7QP2VycQw72Lnz8H7lTUiNzU5XFIvjxZMOd
         R2bV27OuAJFwleSNM7Dop+yv5TW+2A9PK6f1u1wfz8Ud6uRN3Xd2seGCMo1x9AveRPOQ
         lZiMeIWyeAYYBpcSzW4mn9GspNtVMVJWn3qKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SuxrcXTgi5Kz7buMh5CGnWQq0L/rwu8Ex3hQZBJw2VY=;
        b=eIJx5BxA2nHzI6/qidIGmtk/VjV594AAmk+NjXKHU2y1/FGJ1rxxGha3LSGZQdLRy5
         kscp/OhVN+Y2SYLziGKqRoJlU1zlJjcMfHovibTJ0HA+3ciWo2+X/ylAGsix2SUTAs9k
         mFI6rkefP24k9iL/fgPuA4GM5nGMRLKgUKsA8+6MfZNppskeNxywkHy9EUoVi+izT2Sx
         enbzZEHnx4MUUehUaGsAvZfsgWKD21Ph1Jqfz+XQUE1pjcFgeSMnTMCPcZKjJU39VE9u
         c6dDvd6tUORGXNuSkfmjxy0Dc/QBEa4DLW85XFnS40vYUZuYmHX+kPFQh/TzHB/GHXTi
         q+xQ==
X-Gm-Message-State: AJcUukdTKrA1M8xl7QYFqXJUPm5J6xIBNxnT7/w2hp3zWn9m9WtWENr1
        YYG8NErQXHUHivLbgyPey6pJ/Q==
X-Google-Smtp-Source: ALg8bN7w1+C3JWypkidqgF5L1s2LTAFioRI25vFKpCa3K33OcsF5051Z5O2eu90i7xRGJOr/hcWmyA==
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3mr35275336plb.83.1548180714066;
        Tue, 22 Jan 2019 10:11:54 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:11:53 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Subject: [PATCH v2 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
Date:   Tue, 22 Jan 2019 11:11:41 -0700
Message-Id: <20190122181144.26645-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
used by other files than pmu.c

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

