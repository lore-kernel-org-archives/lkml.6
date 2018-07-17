Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EAB20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrysLG/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EAB20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbeGQLkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:40:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38989 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbeGQLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:40:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id j8-v6so340772pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UlSyTexqAwK4MYfLigI+TnyLoCOHHHK+pty/7+NlggQ=;
        b=lrysLG/wiXO3mw8PIuex0DBmGzM/G5kboApRHajZzNmB9uFzLfj9mXEd9u+SqM5hJd
         bD+jBH+a4bR2Td7onkMjel8jvsl78Cg/GwjP6KB0hnTNMRZh2SRSLHS28tEYw2mrB7kM
         UYB3zciC6YOlA8kWtrhlt0x5iGGyv+luICpD0cimojn516Mhge6JApDMLfGUHaLDFN2I
         z+NF8A7KHRrikEd1KehVIXmU32tZKIPzxd9wvDCHisnyK8J/4u3fl6Abqu7+eWP4PcCq
         DiLehPTjgTqa/Gcnu3fudnpu+ANVoJudT4Yf5VPb8ioHJtR5XWCseUL9WCABKxL8H1x3
         uE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlSyTexqAwK4MYfLigI+TnyLoCOHHHK+pty/7+NlggQ=;
        b=qNN9Uw3Q5Lqj10IapjJW13l17c4QR+mkJYpToOirVvkjbNTPnP8NNyfctOFJ/SziD2
         TM5XGIiwMjDtqJG1KzlUwnpJDuZesEtDwPHyaE1qplDS7utTf7GfPE+SUBJokdTrFpyi
         G/gsFjX1Esw/8Q7Ggyn0WLdXBGfdzuKd05jvYe+HTAXcY5elHNa7k5VO9yI/rtjFj/5U
         e4X8/qmQLuA8v5fT0fnnuH2hzfqh20Q9pPQ9Tvb8RvvPymsU3DDkrGB7vrrBD4RdkwHM
         3MiQ+5rgLbiFY0vpm/6NUmHEKvpzSRUEj9nd5VqtAMZzQbMSbCb6wvm2p1Irqe9OIrom
         V51Q==
X-Gm-Message-State: AOUpUlHe52NjCgr5KH8+IQYIRz5O8EVcvhm/gzKJbn/jZ1qqkZ+Ru19X
        1f/UvZKoSYxm5CyVP8kcjMQ=
X-Google-Smtp-Source: AAOMgpf06HN38CnE8VJFDUxN4+qquewCyvjvamIiI+gLcHDwg3N/LiscnAW2AMdBo2mG+JUqUPU3QQ==
X-Received: by 2002:a63:943:: with SMTP id 64-v6mr1138364pgj.368.1531825696989;
        Tue, 17 Jul 2018 04:08:16 -0700 (PDT)
Received: from localhost.localdomain (simmani.postech.ac.kr. [141.223.121.100])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2188520pfl.156.2018.07.17.04.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:08:16 -0700 (PDT)
From:   Sangwon Hong <qpakzk@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH] perf list: Document missing options
Date:   Tue, 17 Jul 2018 20:07:38 +0900
Message-Id: <20180717110738.10779-1-qpakzk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing options --desc and --debug on the man page.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
---
 tools/perf/Documentation/perf-list.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14e13512c05f..1d3fb2846d2d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -18,6 +18,10 @@ various perf commands with the -e option.
 
 OPTIONS
 -------
+-d::
+--desc::
+Print extra event descriptions.
+
 --no-desc::
 Don't print descriptions.
 
@@ -25,11 +29,13 @@ Don't print descriptions.
 --long-desc::
 Print longer event descriptions.
 
+--debug::
+Enable debugging output.
+
 --details::
 Print how named events are resolved internally into perf events, and also
 any extra expressions computed by perf stat.
 
-
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
-- 
2.17.1

