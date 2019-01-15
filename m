Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C722C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0741D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="On6RXlUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391378AbfAOXIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:08:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45076 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbfAOXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so1987014plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBbcO/FLwThPnzi9ctGancax6oPRinsiTg0II3oScgw=;
        b=On6RXlUUcE77eKNO+PGQZ6PETa/RedcAgn21UjeW5c60TBBoJQX7Io8Ezm7UFYxu39
         hsyo67UlNJInScryS+W+t/3wr6aRdEK6LtYCajq7Ys2wG1l0Ee6w8LfltwUDtQAvSmUN
         DZAa46lZP3mjb0uw0IWOZU6BuFaab+JcpIGTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bBbcO/FLwThPnzi9ctGancax6oPRinsiTg0II3oScgw=;
        b=JlCCcPfYOoWhxS0V0gdAyPvTlmGEb0M0oiqtQzq9prjM7EtfWV2/1cpZ3BWL7iJy3v
         zOUSjpWXdQFtuey0+u2TmsoKZtJyz8mjl/VWa3uiHf9gScY4FrI+9bkakYbnxbUlggU5
         TOkPmfeWTsjgsVFBranzrC6GVWIZvvdKZw4lh57fTDFXpkfn0gZfWvMjiQ+a54RM2LQO
         RnBeFPDI6tASOkE92b9RdCbH7a3ldM0GlAkyhWBqT8otSzhMrQXJwxlhnigVStK3Zg6s
         cfWv824cgBkCUn+wypIO68XAR2fVxFet2nMUqEbnJXL4EMfOnAHoFQDaCgck2EKyzao5
         FJCw==
X-Gm-Message-State: AJcUukc/2sQY+cKS++gKVGQDIRNe2jNCJU5BW4dGD2V6CLDeOsgsaTEB
        WWG8t81BTA2J5MKacDWUVvKelA==
X-Google-Smtp-Source: ALg8bN7+l3YPkRP9qcLyj4ZI/wD3XEov976kmI5a3XEqdMZ2PkcjH+3du2whuhuUJX/kFN6olhSwpw==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr6651355plh.78.1547593673313;
        Tue, 15 Jan 2019 15:07:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:07:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
Date:   Tue, 15 Jan 2019 16:07:39 -0700
Message-Id: <20190115230742.13730-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linaro <linaro@localhost.localdomain>

Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
used by other files than pmu.c

Signed-off-by: linaro <linaro@localhost.localdomain>
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

