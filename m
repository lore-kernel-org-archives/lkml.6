Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630EC22392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mesosphere-com.20150623.gappssmtp.com header.i=@mesosphere-com.20150623.gappssmtp.com header.b="PGD7bQeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630EC22392
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mesosphere.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHJAVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:21:31 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55718 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeHJAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:21:31 -0400
Received: by mail-wm0-f54.google.com with SMTP id f21-v6so54733wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mesosphere-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=y5SUO0900y/O2MdfMXqGOUZsTKUVy2Hm7Sr+XjOP4hM=;
        b=PGD7bQeIF1AEP+csexKGRryJBNqkizc6k3eRXIdishJyf8V80keq6c0X0zre1ZDLyl
         X9P1qZHpOr01+RqII4GjWegyo0ZsuBtv6IOmcYsZKgSEvzAefKfY4DtWlY72El1VdqfI
         IUe446i3gwLa/DBq9qABZ9Q+K/zbdoSHQfjR4CaC+Qc+CPQCiF27g7n2cfwaNX5cEmD3
         syqa78zgEjfhvK67ZKuT7QDoUUQY3dvEyozlssAVo5EqMsAZdh9oJTGeEqwHR5xrS3lg
         ltgbLBupqF4ukKjeK8k67A1xMaMNxeTYz32Xumg03XbnEbeRiAlmDxhpUjtpkBIOrMQU
         CHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y5SUO0900y/O2MdfMXqGOUZsTKUVy2Hm7Sr+XjOP4hM=;
        b=ewSZy9QGRYOsfcqqlkjoVI7S19xbwgJyUeHvF+G7gL5ecJLPNzrJwTRfzPz8rl/lTZ
         CZmKUgvhi2kkIbT0G160jPeeYHjw3TbvvT3PavjokJCc4/NAHAZ+IctBRIKvnflMbAJB
         POekbUu3sEn+4dHjICUQQfzKl2mDv//lHhD1i7AFL+s6wWfbhycg2B5sIMkN/m99C/0d
         ujVgRuFyH+4WzkxJ9U7lhqa6kluN3IMMXoAwPZk9tB7B7OiRQx55mUu0OUOCRPuqO3np
         Xe9zvnzWNT0BmYO6RWDVA0SiyN1cTpD6gzusD9Oc52vt/oke3wGzDnOiro+mXISjWoJE
         MsIA==
X-Gm-Message-State: AOUpUlGz9DNwCVWND/HFsZj9J+NffJhK1xpeqWZtPArIVreSG4dC1vwt
        OnTnUxCWm+WNVTGWNP8UFuoiGA==
X-Google-Smtp-Source: AA+uWPx8ZYkWBgvW5PCJdhQ6zuZy842x/MDfgY5WoyFZYUCyRUHPxtUasi3llnrSH9HdbRttCYjDZw==
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr42631wmb.118.1533851682407;
        Thu, 09 Aug 2018 14:54:42 -0700 (PDT)
Received: from localhost.localdomain (ipb218f773.dynamic.kabel-deutschland.de. [178.24.247.115])
        by smtp.gmail.com with ESMTPSA id f8-v6sm9629658wrj.9.2018.08.09.14.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 14:54:41 -0700 (PDT)
From:   Benno Evers <bevers@mesosphere.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Benno Evers <bevers@mesosphere.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Check for null when copying nsinfo.
Date:   Thu,  9 Aug 2018 23:53:48 +0200
Message-Id: <20180809215349.24299-1-bevers@mesosphere.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument to nsinfo__copy() was assumed to be valid, but some code paths
exist that will lead to NULL being passed.

In particular, running 'perf script -D' on a perf.data file containing an
PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
the event stream will lead to a segfault.

Since all calling code is already checking for a non-null return value,
just return NULL for this case as well.
---
 tools/perf/util/namespaces.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 5be021701f34..cf8bd123cf73 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
+	if (nsi == NULL)
+		return NULL;
+
 	nnsi = calloc(1, sizeof(*nnsi));
 	if (nnsi != NULL) {
 		nnsi->pid = nsi->pid;
-- 
2.17.1

