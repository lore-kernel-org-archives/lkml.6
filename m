Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7C120862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQI7ytwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7C120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeKKO4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:56:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52160 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:56:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so5402947wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ow2naLIzo/IFM+0nIo0ADveDbpQEOg73+66OVgTfy9U=;
        b=ZQI7ytwIjjXjYAjMgqVxg5oX0CEBzSbEVvYwYsQp5QaYUmbf2M94wheVNdyPWeBDVN
         diFTDtCflyNToZ2xD1XUkVqB7Vp8UPa3FWtsIX5NV9d38pibkxgQBQhlHZxgjOYQFgxn
         PdtwbZeyW/6HCqLgoC/9TxI8Gt4DtjJvJuYrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ow2naLIzo/IFM+0nIo0ADveDbpQEOg73+66OVgTfy9U=;
        b=TNI1uMjES2Zj4F8kx1AJ+uPVzCL4nV2cLVD+eoR0C2gwPAFcrB1uldgE+4m63iJWyV
         mFTRiF1h1FCkbm98ql6k5RGhy3i4Q3KpSmYebf3ZCk9raNmDSkx5tSjVLG9CFWonYkqs
         h++YrAZzG5MhYZC4cikQbkjB8ByDJg5SS6gn3yipeiXorJR4xI/P3WpF44ZsHtPCYfCc
         zJO3OAKIfDli5emm3gNgNi4pYeEfWvYIU/vRS2Y79YppK/I45j1In3OoB2CKBaUUNzOE
         AWwqbXaMQzY/vk7wLirl/IbE6EE4SGvz8TC1q0AcHXt1wsk92uId7mizTyHU0KK87+cL
         7vQg==
X-Gm-Message-State: AGRZ1gK1QBzLqkcQBAL6W41LupYjHcEr00a0aS7LBcDllaunHK3FxKiF
        zMvKqBV5jz5PrqGXhB2WFgNEAg==
X-Google-Smtp-Source: AJdET5c+ldmiS4mLJlazBDn1R2iFi/DEasDshjgvvesFvhzu7CJKJ8P95cqDMrGayeQVlENG1zduRA==
X-Received: by 2002:a1c:b645:: with SMTP id g66-v6mr4098881wmf.25.1541912910203;
        Sat, 10 Nov 2018 21:08:30 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id b66-v6sm4471045wmb.21.2018.11.10.21.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:08:29 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/2] perf cs-etm: Add support for sample flags
Date:   Sun, 11 Nov 2018 13:07:54 +0800
Message-Id: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seris adds support for sample flags so can facilitate perf
to print sample flags for branch instruction.

The patch 0001 is to set branch instruction flags in packet, this
patch has the core code in this series to set flags according to the
decoding element type, and also based on the elements including
instruction type, subtype and condition flag to help making decision
to set flags value.

The patch 0002 is to support sample flags by copying the flags value
from packet structure to sample structure, and it includes three fixing
up for TRACE_ON/TRACE_OFF and exception packets.

The patch series is based on OpenCSD v0.10.0 and Rob's patch 'perf:
Support for Arm A32/T32 instruction sets in CoreSight trace' also is
prerequisite to support A32/T32 ISAs.

This patch series is applied on the acme's perf core branch [1] with the
latest commit f1d23afaf677 ("perf bpf: Reduce the hardcoded .max_entries
for pid_maps") and has two prerequisites:
1) It's dependent on Rob's patch 'perf: Support for Arm A32/T32
   instruction sets in CoreSight trace' [2];
2) It's dependent on another patch series 'perf cs-etm: Correct packets
   handling' [3].

After applying the dependency patches and this patch series, we can
verify sample flags with below command:

  # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v1:
* Moved exception packets handling patches into patch series 'perf
  cs-etm: Correct packets handling'.
* Added sample flags fixing up for TRACE_OFF packet.
* Created a new function which is used to maintain flags fixing up.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
[2] http://archive.armlinux.org.uk/lurker/message/20181109.091126.9d69489d.en.html
[3] http://archive.armlinux.org.uk/lurker/message/20181111.045938.782b378b.en.html


Leo Yan (2):
  perf cs-etm: Set branch instruction flags in packet
  perf cs-etm: Add support sample flags

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 168 ++++++++++++++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   1 +
 tools/perf/util/cs-etm.c                        |  43 +++++-
 3 files changed, 210 insertions(+), 2 deletions(-)

-- 
2.7.4

