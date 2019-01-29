Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE5F2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hu9sy8Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfA2M3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:29:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40565 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2M3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:29:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so9276559plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fI4dv7garnzy2W+m3mE1OJK4oTIdQwDug0wFO9zg2Vo=;
        b=hu9sy8QlavPoSx0f2aSnK3yC82eHibeUy45I8SrzNFHY3bUa31DXJPZEQCIiWTnJnt
         lytDw26Mg64tahth+FZGj47OVk8Wpl7JbdfspWAn4QRsgGjbDe9k4D2p9YUYkJv7a9lS
         eaBe7U74u0OOmH75rWDk0H3D3b7wAW9obTC3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fI4dv7garnzy2W+m3mE1OJK4oTIdQwDug0wFO9zg2Vo=;
        b=XhXF+E62FFswi3R6uQQOOr8hSBHOjleHLjb6mOTcPyhJzAMwzC+3fZtJACq02JlDMr
         0fY13oCQLxOp2UlVMCuEqgJ8ubpE8HR7ukujPH2tk4ijlsuVskwoQtWCo9ZisThf2ZR/
         dYipdWRLGk09q97qRLZJFE4Awyje5CNtiuQUkoxr6WhskwlrNDy9OvCOpPyGjuE0kyBC
         zGP85Hvp0uTdRrCdE/I4S4/sYXxuaJnHxynuIOhG6PBNraYWcN21M1la3S6YvPbkyCs+
         MDqojYXh0xQ6oWrruekvFY7zqnmLk7bQrASYJdwsfAJVQy8DgiuDfCKe8st0Vwqb2jCG
         b/aw==
X-Gm-Message-State: AJcUukdOML1GnaTgDUvWgf5HH+C+x3k3seXE/ipOy9TQT7n2G8OoMMKz
        9xOGcy72KXTXwgdWsAzUX3Jmbw==
X-Google-Smtp-Source: ALg8bN5WKyn2C5ryGtxlJEoMzd8powgeTXxcxgBpsMikqmir24LNyWwQZFnkEicUQfU9H/EVt24ZxQ==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr26151550pls.12.1548764987824;
        Tue, 29 Jan 2019 04:29:47 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:29:46 -0800 (PST)
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
Subject: [PATCH v7 0/8] perf cs-etm: Add support for sample flags
Date:   Tue, 29 Jan 2019 20:28:34 +0800
Message-Id: <20190129122842.32041-1-leo.yan@linaro.org>
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

This patch set is applied on the acme's perf core branch with the latest
commit bdec77cfe58d ("Merge remote-tracking branch 'tip/perf/urgent'
into perf/core").

This patch set has been verified for x86 and arm64 perf building and
also is verified with below command:

Before:

  # perf script -F,-time,+flags -k vmlinux

  [...]

  main  6650 [001]          1              branches:                                f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:                                  6b65a8 main+0x1c (/root/coresight_test/main)
  main  6650 [001]          1              branches:                                  6b6448 printf@plt+0x8 (/root/coresight_test/main)
  main  6650 [001]          1              branches:                                  6b642c _init+0x18 (/root/coresight_test/main)
  main  6650 [001]          1              branches:                                f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:                                f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)

  [...]


After:

  # perf script -F,-time,+flags -k vmlinux

  [...]

  main  6650 [001]          1              branches:   jmp                          f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   return                       f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
  main  6650 [001]          1              branches:   call                           6b65a8 main+0x1c (/root/coresight_test/main)
  main  6650 [001]          1              branches:   return                         6b6448 printf@plt+0x8 (/root/coresight_test/main)
  main  6650 [001]          1              branches:   return                         6b642c _init+0x18 (/root/coresight_test/main)
  main  6650 [001]          1              branches:   call                         f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   call                         f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   jmp                          f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
  main  6650 [001]          1              branches:   call                         f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)

  [...]


Changes from v6:
* Addressed Mathieu's suggestion for patch 0005, refined its commit log
  and comment and fixed cs_etm__get_cpu() definitions in header file;
  also tested with perf for Arm and x86 buildings.
* Added Mathieu's review tags.

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
 tools/perf/util/cs-etm.c                      | 394 +++++++++++++++++-
 tools/perf/util/cs-etm.h                      |  53 ++-
 4 files changed, 476 insertions(+), 18 deletions(-)

-- 
2.17.1

