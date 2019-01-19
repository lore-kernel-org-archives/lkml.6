Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21BBC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F47620850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxfMfnje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfASBoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:44:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34623 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfASBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:44:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so7450712pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+gI7uPG/kMFpjvedpiuVotP6KJ84HcEfWwY5I+LGi9I=;
        b=GxfMfnjeWS83+HeD1bR5fowABwHrLh9+7w3HzEeWX5FjWnhJQbvWUlf90S9VqQLda4
         zZNiKYaxtHL4oJtK0GvtuOKWWDBqkFywQeDcBPmoBFQ3qUI3mqiRRVo0ijiE9l6BS4WE
         W36A78xWiyOtkR6XXMWTB4dhfLfMK6OSeGBXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+gI7uPG/kMFpjvedpiuVotP6KJ84HcEfWwY5I+LGi9I=;
        b=HcGs0IL1kQfjkRHdkgIAcQYEdirnufPedieZON79jhISYZYnXiTXGYeBnm0wYoSpXP
         nnwBAf8y6dkkkTmNx+Ayy2NC1hB1DrIEFHMlavI6M/nllP/tHYMKHIemwyQU4VkZllX8
         M/2iPQt9mW484LSuUDUQ6LFweiC2Z+lRa7Kav5jQC4jHONHuuu40I4ZlFUwME7UsdMhM
         v+pu3l7Do/uBSaO8hMMIEZi9bqKMfZ16EPjHjkad8dgAGUsNPwANOm4vpFwHw0zu2DKF
         pkeUrcFAzrGjQ3QDL82zDB2SSrKkOvlxuiMBGS8wxiX20gy8P2H++bPa9o3XkLMSzH2m
         0jpA==
X-Gm-Message-State: AJcUukd1eo9LpWBhxFTcQzAnCAsqtKE1Bn0zEyeElqdZ9TfKW4W5nL0k
        BDOd5vLdbYkmkfBtuy6nSopReQ==
X-Google-Smtp-Source: ALg8bN6rfHMN+/FzJ0M7MmMKKTVdK5Q+HeWXGJ1ygSC3Pj2hqY/GScdJjTysGVnxLmQMtwMP6LWjbA==
X-Received: by 2002:aa7:8542:: with SMTP id y2mr21883180pfn.83.1547862245254;
        Fri, 18 Jan 2019 17:44:05 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:44:04 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 0/8] perf cs-etm: Add support for sample flags
Date:   Sat, 19 Jan 2019 09:43:39 +0800
Message-Id: <20190119014347.27441-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seris adds support for sample flags so can facilitate perf
to print sample flags for branch instruction.

Patch 0001 is used to save last branch information in packet structure,
this includes instruction type, subtype and condition flag to help
making decision for which branch instruction it is.  It passes related
information from decoder layer to cs-etm.c, so we use cs-etm.c as a
central place to set sample flags.

Patch 0002 is used to set sample flags for instruction range packet.

Patch 0003 is used to set sample flags for trace discontinuity packet.

Patches 0004/0005/0006 are preparation for exception packet handling:
Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
traceID/metadata tuple to access metadata pointer based on traceID, this
can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
ETMv4 have totally different definition for exception numbers.

Patch 0007 sets sample flags for exception packet; patch 0008 support
sample flags for exception return packet.

This patch series is applied on the acme's perf core branch with the
with latest commit 02bb912ae451 ("perf tools: Replace automatic const
char[] variables by statics").

After applying this patch series, we can verify sample flags with below
command:

  # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v5:
* Addressed Rob's suggestion to add specification info for exception
  number encoding;
* Added Rob's review tag in patch 0007.

Changes from v4:
* Fixed typos in comments, and removed redundant info from commit log;
* Addressed Mathieu's suggestion to add helper functions for metadata
  fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
* Addressed Mathieu's suggestion to include headers with alphabetical
  order.

Changes from v3:
* Fixed typos in commit logs;
* Rearranged fields in cs_etm_packet by grouping with same variable
  types;
* Fixed ETMv4 exception number which pointed by Mike;
* Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
  instruction to distinguish them;
* Refine ETMv4 return exception packet handling.

Changes from v2:
* Addressed Mathieu's suggestion to split one big patch to 3 small
  patches for setting sample flags, one is for instruction range
  packet, one is for discontinuity packet and one is for exception
  packet.
* Added supporting for ETMv3 exception packet.
* Followed Mathieu's suggestion to move all sample flags handling
  from decoder layer to cs-etm.c, thus it has enough info to set flags
  based on trace context in single place.

Changes from v1:
* Moved exception packets handling patches into patch series 'perf
  cs-etm: Correct packets handling'.
* Added sample flags fixing up for TRACE_OFF packet.
* Created a new function which is used to maintain flags fixing up.


Leo Yan (8):
  perf cs-etm: Add last instruction information in packet
  perf cs-etm: Set sample flags for instruction range packet
  perf cs-etm: Set sample flags for trace discontinuity
  perf cs-etm: Add exception number in exception packet
  perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
  perf cs-etm: Add traceID in packet
  perf cs-etm: Set sample flags for exception packet
  perf cs-etm: Set sample flags for exception return packet

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
 tools/perf/util/cs-etm.c                      | 405 +++++++++++++++++-
 tools/perf/util/cs-etm.h                      |  48 ++-
 4 files changed, 482 insertions(+), 18 deletions(-)

-- 
2.17.1

