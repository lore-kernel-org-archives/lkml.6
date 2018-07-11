Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CC1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C8820875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7TFSBa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C8820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeGKHt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41711 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeGKHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so8812189ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOhFeWQKL4l7VSWl48ZwW81Bvvd5Dpc7t8AlhIsqGMU=;
        b=Z7TFSBa7IXjcR6kZ9BJHPpvk89owgHTZ7JwGbCDUIrxfX77sGORypSLBnIYmoYIpE0
         t07RnIVXO5mN1+F9pKBGybuhcj9fl/unOUfIzXyd8B21fAC1aRa1OrDUhdnGS1BitiYk
         DYw75b7Zp/f7QnOcepf9OuezSu47L6A47tols=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOhFeWQKL4l7VSWl48ZwW81Bvvd5Dpc7t8AlhIsqGMU=;
        b=Nx5LPZYfRYjdbZeAi/XfbivHLVPIxci82LZmzir4ul1yuHqDQjmOJD3LkJNz+FtDCA
         eycMAVUog8SxQIqficj9v6m5qM4h2hd93FebsnvoZpzyfpmzLjOtuv5qEKebuEyGlupx
         q5JjaBcNviPqW7692bmEmKB3gzaIAf+D3xsH+NjYB0zRe7dO4WU1PeZgqJev1KJ2OU8G
         Ma1j9OmrzlIVYMHi6Ono9SXXpmdPzzJ1b5He36KnVA7tSJXFwOU/FTJlG/ZlWLf5ex1A
         OrDw1xIn4DSk0BEUfus2olw1lpOHRnyP7JhBWa5NBEIiqcfiYYJXjBf89CG731DfiZDK
         Hz8w==
X-Gm-Message-State: APt69E3K2TfBew6J+jClQFZFs8dtEUGTOTHobL+xTGYrXkEEnNW3Po4L
        M1tlgouL9RTjSdZ2OwB06Gpv66lFTcQ=
X-Google-Smtp-Source: AAOMgpex2mE7JdK7APRi3dtc4ZSbSrWLDl1ptTmP9QODnf4kvw+7b7gZLJpgGmYRaoFw72n5kJ2O1A==
X-Received: by 2002:a17:902:7044:: with SMTP id h4-v6mr22421314plt.179.1531295187415;
        Wed, 11 Jul 2018 00:46:27 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/6] perf cs-etm: Bail out immediately for instruction sample failure
Date:   Wed, 11 Jul 2018 15:45:41 +0800
Message-Id: <1531295145-596-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the instruction sample failure has happened, it isn't necessary to
execute to the end of the function cs_etm__flush().  This commit is to
bail out immediately and return the error code.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 822ba91..8b2c099 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -939,6 +939,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 		err = cs_etm__synth_instruction_sample(
 			etmq, addr,
 			etmq->period_instructions);
+		if (err)
+			return err;
+
 		etmq->period_instructions = 0;
 
 		/*
-- 
2.7.4

