Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13725C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC69120862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8lt5oap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC69120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeGKHtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33365 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeGKHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so17880012pfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+eJSGIhaEeunDTeFMdqnAm1Tmh4ORKRMaDAXSv12rXI=;
        b=V8lt5oapV8uMZpW+uuQOGPTPSPELgstXNzxAZZoEWnTqsqIlZr5AWUsV2EcpwqacYZ
         zvOpsEvuIHTsPwDDU75Jbxu4PMMLchx59Qc1lHW5vjPSMXzDW3sVPs0wvzY7EsqocCDH
         T5DQ/OEqHKPRyj7/K9Xuy9oGA/G+J1XwS1yJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eJSGIhaEeunDTeFMdqnAm1Tmh4ORKRMaDAXSv12rXI=;
        b=A7qRqUrs+tuQv+wND5JH17U+N8/95VxktBr6yJZUc486Eif9j5cE8gQDiO0bP45uy0
         MZ1Sv1rnp74JUsxkG6PvvsbiWn6jQnDyv35/J6CHhgXW4TcEec3g0FJOQSDacRgOiV5Q
         2VoSP7pMiziuoN2y47vomjGVMlxz36SxDNr2iByW7GBRnGjqF+fiR4oSAuMIlk+j7yD4
         7Xnnd6MVkV/pfWOaTxOjG8F0dqRMHWT1Q5yA+STb/LvT3VnvN25QC81CpqBDij+EEkqU
         NzUlsQBDwmS4kVcZJ94QVDM86a/uFTc9KZg/4prL2DQMRq3tFUEDN4dxKVi1d+Ek6gp5
         zYnA==
X-Gm-Message-State: APt69E0exOJHCMicFYQYkGE9Wfn9Cq6bxnMVNqo3B9p3YnGEB+DwBJ/M
        148J6o5wp/xpPO8OpNZMLSvZ1g==
X-Google-Smtp-Source: AAOMgpcCtMf4/Uv2uEzYU29471jQP8VWCjHcm6ZxV5RP6BWsQGtnvvPQpeDrcohCjlVY9prkleYUkA==
X-Received: by 2002:aa7:82d9:: with SMTP id f25-v6mr28717815pfn.218.1531295172867;
        Wed, 11 Jul 2018 00:46:12 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:12 -0700 (PDT)
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
Subject: [PATCH v2 0/6] perf cs-etm: Fix tracing packet handling and minor refactoring
Date:   Wed, 11 Jul 2018 15:45:39 +0800
Message-Id: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due the current code is missing to handle cs-etm start tracing packet
and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.

This patch series is to fix cs-etm tracing packet handling:

Patch 0001 is to add invalid address macro for readable coding;

Patch 0002 is one minor fixing to return error code for instruction
sample failure;

Patches 0003~0006 are fixing patches for start tracing packet
and CS_ETM_TRACE_ON packet.

This patch series is applied to Linus tree on 4.18-rc4 with latest
commit: 1e09177acae3 ("Merge tag 'mips_fixes_4.18_3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux").

This patch series has been verified on Hikey620 platform with below two
commands:
perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
perf script -F cpu,event,ip,addr,sym -k ./vmlinux

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Changes from v1:
* Rebased on Linus mainline kernel 4.18-rc4;
* Added Mathieu 'reviewed' tags in patches.


Leo Yan (6):
  perf cs-etm: Introduce invalid address macro
  perf cs-etm: Bail out immediately for instruction sample failure
  perf cs-etm: Fix start tracing packet handling
  perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
  perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
    packet
  perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
 3 files changed, 68 insertions(+), 14 deletions(-)

-- 
2.7.4

