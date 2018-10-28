Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C5C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C139C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeOZbKs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C139C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJ1VTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:19:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54428 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1VTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:19:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so5525902wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J19T3Goe9Qyq7xQM4/QFwTkUNe2LU8Fn8VCV3sVm5CA=;
        b=JeOZbKs43ekLZ3Wv76HuUkfoxCnQnupDJDsFn4cPbJ5Z1OJWCelE7rX+d9BY62hP9o
         XebfKVftjG3dXgr3LHjFfssJvxlc7VVs4q5uhXtfgIkCk4tkOkJCBBQojcQt8yISSoxV
         TLppkAv5B34Z/2lqXAqGzBn1Rcc5zqS3tB8ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J19T3Goe9Qyq7xQM4/QFwTkUNe2LU8Fn8VCV3sVm5CA=;
        b=ONsRoFysrLC78ZXAQa9mD1VVpuEiVH2gUxkx1FItuXKcpECrmQzwmxkAIAXopjjFfk
         hfsaowiS66DPruMoP26S2At2K69ZLOi8bW8WErg493pJQN2N/RHsyGq5qiAtyqO37dRY
         QPH7e/ha5JE0ijCGg8uZVznQnN0W9PY45feyAOjRsHWVuopjWG4Not1PcjrnBsWBI+8y
         I2GntM0B4HmP+MRbdkh2JxXwmBjC9DHv5ktIhuC5ff4OSVmdiazjFguWPNLCrlCWY1UL
         b0x8KF9iaBrArF4UfIZ4jFNijVu9npiJJyZwhmZ/2IhgHAkZD989hfYn2jEOs7Z4ESvU
         h4Mg==
X-Gm-Message-State: AGRZ1gINjY1uMKoTsVwwotQ6Mca931bhzOXoMV4AZUBGmwSPUE8SXx2N
        r4qIkye3qKgOdcxGgmMnAMdNjg==
X-Google-Smtp-Source: AJdET5fIpc4OJ0ZEBXV32qQGjF7UQA53iRJUX8xEAmfXr4W4P805Fz3FZVrKS8gAUhye96VV14SqsA==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192-v6mr11313690wme.135.1540730114843;
        Sun, 28 Oct 2018 05:35:14 -0700 (PDT)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id v30-v6sm18926830wra.67.2018.10.28.05.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Oct 2018 05:35:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] perf cs-etm: Add support for sample flags
Date:   Sun, 28 Oct 2018 20:34:51 +0800
Message-Id: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
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

The branch instructions also include exception taken and return
related instructions, so the first patch is used to generate branch
sample for exception packets; and the second patch is to track the
exception number.

The patch 0003 is to set branch instruction flags in packet, this
patch has the core code in this series to set flags according to the
decoding element type, and also based on the elements including
instruction type, subtype and condition flag to help making decision
to set flags value.

The patch 0004 is to support sample flags by copying the flags value
from packet structure to sample structure, and it includes two fixing
up for TRACE_ON and exception packets.

The patch series is based on OpenCSD v0.10.0 and Rob's patch 'perf:
Support for Arm A32/T32 instruction sets in CoreSight trace' also is
prerequisite to support A32/T32 ISAs.

The patches can be applied on the acme core branch [1] and tested on
Juno board with below commands for A64 and A32/T32 building:

  # perf script -F,-time,+flags,+ip,+sym,+addr -k vmlinux


Leo Yan (4):
  perf cs-etm: Generate branch sample for exception packet
  perf cs-etm: Track exception number
  perf cs-etm: Set branch instruction flags in packet
  perf cs-etm: Add support sample flags

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 237 +++++++++++++++++++++++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  11 +-
 tools/perf/util/cs-etm.c                        |  44 ++++-
 3 files changed, 277 insertions(+), 15 deletions(-)

-- 
2.7.4

