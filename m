Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0E72145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayWWbl/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0E72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbeKQE4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:56:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeKQE4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:56:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so7326784pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x/lvamoglU0U4PQDU5Mad2BKeGCsyipe/gXmeLxf4w4=;
        b=ayWWbl/VKbU90Jb+pXdFu/5m3UN/SnEP8Nx9598Z1h270H1OxQLel2b2aq7hPy9Hll
         uzvh0hDMW9MAJYlFfr9ivklpg3S9xwR6HBGRS1cA4pxMmW+F4gw/b0vCvTSn4Sf6KWUu
         /guUwJTMcxpmCBiDqCnhnIDdSWOkDNmj7VhA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x/lvamoglU0U4PQDU5Mad2BKeGCsyipe/gXmeLxf4w4=;
        b=iP6m0XmmRadseqmqpXhDHag8oRB6xBdmwI8/5SLYDRfpuLnb/X1u9Nk6pZtAhh2scu
         av4HnnltKB27+uKgZN3aThEwjl15LExuwXOUNO5wlkehLPAI822NinMZ7WvhNJ0vl26k
         2BRfp3cRxn4LyGs0cQXa5FGxh6vyDa7OybEk31rVQPObWN3PH0Taoqy+JlouaaGF1/c7
         iMBdZnq+zlajA3ZhAzATf9sYsqUsvNcmzS2E97hy/PnSCgQsHSkDvSD+hpcBLeu8DIE3
         3nHwt9m2yQhM+pEdKtS8+7N5RntYC/Pd3Rai0nRPTcYBeMpI6EBzPZ4tCuZ9/nm96G5j
         ELBQ==
X-Gm-Message-State: AGRZ1gJI+YN6xffaZHU7m6H2ztFJWGHf7ckT33Na2CL9J4OISoNKMpQ4
        Ir90J5mjZcMcXOhkKcQVTKkMoQ==
X-Google-Smtp-Source: AJdET5dymRmeWXmeg67tdjfR2Q7qRw5lp0KwFy/DJZnI6tZda6qiBT4XcPy4rJGK45CLoTY662ymPg==
X-Received: by 2002:a63:680a:: with SMTP id d10mr11049323pgc.396.1542393754510;
        Fri, 16 Nov 2018 10:42:34 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v20-v6sm33724598pfm.114.2018.11.16.10.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 10:42:33 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Add support for ETMv3/PTM1.1 decoding 
Date:   Fri, 16 Nov 2018 11:42:29 -0700
Message-Id: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds support for ETMv3/PTM1.1 trace decoding.  The work has been
tested on TC2 and ST-Microelectronics' mp157c-ev1 board and applies cleanly
on 4.20-rc2 and Acme's perf/core branch [1].

*** Before this set ***

$ perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
Warning:
AUX data lost 2 times out of 2!

Error:
The perf.data file has no samples!

*** After this set ***

[...]

# Samples: 12K of event 'branches'
# Event count (approx.): 12049
#
# Children      Self  Command  Shared Object     Symbol                 
# ........  ........  .......  ................  .......................
#
    28.18%    28.18%  uname    libc-2.19.so      [.] strcmp
     9.13%     9.13%  uname    libc-2.19.so      [.] strcpy
     7.87%     7.87%  uname    libc-2.19.so      [.] strnlen
     5.58%     5.58%  uname    libc-2.19.so      [.] strlen
     2.24%     2.24%  uname    libc-2.19.so      [.] __rawmemchr
     1.91%     1.91%  uname    ld-2.19.so        [.] 0x000000000001156a
     1.49%     1.49%  uname    libc-2.19.so      [.] __argz_stringify
     1.46%     1.46%  uname    libc-2.19.so      [.] malloc
     0.96%     0.96%  uname    libc-2.19.so      [.] 0x0000000000054770
     0.91%     0.91%  uname    libc-2.19.so      [.] 0x000000000002430a
     0.85%     0.85%  uname    ld-2.19.so        [.] 0x0000000000007244
     0.83%     0.83%  uname    libc-2.19.so      [.] __stpcpy

[...]

Regards,
Mathieu

[1]. "6909b0a13389 perf stat: Use perf_evsel__is_clocki() for clock events"

Mathieu Poirier (3):
  perf tools: Add configuration for ETMv3 trace protocol
  perf tools: Add support for ETMv3 trace decoding
  perf tools: Add support for PTMv1.1 decoding

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 31 +++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  9 +++
 tools/perf/util/cs-etm.c                        | 73 ++++++++++++++++++++-----
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.7.4

