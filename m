Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A96C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A4A2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A4A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeH3AV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:21:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36765 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH3AV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:21:57 -0400
Received: by mail-qk0-f194.google.com with SMTP id 93-v6so4288826qks.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laDqaM9wJs34Pr/0ik7GXtoQx0sblUxPifyxOlR3zcs=;
        b=RGXRdTPIXUsigceQpwppnHMy8HS/zUtwV0MHYuPObc4O90DccrRlyhz7pEqyybAbhP
         1BNvtJCG0mxVAJO7YlPCROjGBQvqCqSye1B6vwkTE4CSllYHiRzGpahyYfortUjpVrrt
         bIhE58aP0ZvVx/evfhmYx7EBT/HoGJgGrB8sEJ9lHlz71LWhTj+QqySr2pUGrDyfwc8s
         DpUNryCTjc+gYEVn/jaXk29tsaWE1yuWIFE++KKOdm3vL6SxMr8G4oyrfXlFdvngwyRz
         tlhQ0tN7khLd+tEyt04MPr4Vd04EN66LyEof0Cpj1wdjquTqj5GxYPrCN1KpcneGOCbW
         H8bA==
X-Gm-Message-State: APzg51CA3j9QJit4l+VcOJMUMCpScK6c/WJLMVxhtkXfRqlzZfsLxw/q
        s8jBi1K/9+U8Ml1wpVOzqH0QgL/L
X-Google-Smtp-Source: ANB0Vdbu2HmRMofvcXmaL7fZ1sRrlEsLjVT/mMYNu0EYdifagXtsNQSZ5ZFXmDpTEtThWhvJUFqVRg==
X-Received: by 2002:a37:944:: with SMTP id 65-v6mr8167233qkj.45.1535573821556;
        Wed, 29 Aug 2018 13:17:01 -0700 (PDT)
Received: from localhost (192-222-171-48.qc.cable.ebox.net. [192.222.171.48])
        by smtp.gmail.com with ESMTPSA id v10-v6sm3228609qtv.77.2018.08.29.13.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 13:17:00 -0700 (PDT)
From:   =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?= 
        <jeremie.galarneau@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?= 
        <jeremie.galarneau@efficios.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf tools: Initialize perf_data_file fd field
Date:   Wed, 29 Aug 2018 16:16:48 -0400
Message-Id: <20180829201648.19588-1-jeremie.galarneau@efficios.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the perf CTF converter fails with gcc 4.8.4
on Ubuntu 14.04 with the following error:

error: missing initializer for field ‘fd’ of ‘struct perf_data_file’
[-Werror=missing-field-initializers]

Per 4b838b0d and the ensuing discussion on the mailing
list, it appears that this affects other distributions
and gcc versions.

Signed-off-by: Jérémie Galarneau <jeremie.galarneau@efficios.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index abd38abf1d91..f75d4aa612c5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file.path = input,
+		.file      = { .path = input, .fd = -1 },
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-- 
2.18.0

