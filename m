Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2AF20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2SZV7wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2AF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3VPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:15:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52002 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3VPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:15:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so5176651wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qMuVDKOBd0O55VlM4Kp3hwxT+oQFuIsRKiWVIynp1Xc=;
        b=X2SZV7wUn/L/0YJqEzbFPQt50lJR5Imdy3CVRJLQeJ4Kwsv8XkhCVfl87xbnS16Nt1
         8hfmLr0faK2H72ciyaIHjSvNiN2v/RnAW4wBXmIn7tWpJa1wZViiTjG7L/I2jueInfJX
         iOWOMAzv6falCCDOd/k03zwDimGPsRovZ56nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qMuVDKOBd0O55VlM4Kp3hwxT+oQFuIsRKiWVIynp1Xc=;
        b=AqHzOoyespaJyC5k2q5XzoY/MVHMsM1FWNdq5jaI2SZLn+uSIAhcFftIfWlwEi1yoE
         GGaaGdUEl3XIW8Wbt3i5ycirbUOPajtQAbFhP9SNy+DKRKXmyvw9BJlwD90NXMY/j1sG
         AImoYC6a+757ydR9taIRYjZ1Z1PQM/NzNiHIqnYvDFM8g8yz1glozjh58EMvOrhIYaVD
         cTIrolvXSHVU4B6SVW/hOYuOnS9XXqfBqBKLEqTc/GlTqGZ7TxCst5KnG8wwwysOG7pS
         WFffhuR4nejtjXBzZnqBA9iMEWC+yaVBLFkFGrN8pPET7uptdiRtcl9BMUybAYrAbEQY
         XT+A==
X-Gm-Message-State: AA+aEWZzsWyeQWaDl7xVYYeXXPljJ+9sWtUDwjqMRxddt+YUsnEDJyJe
        mLF67W8rx1oCtpPDN0joInaXUQ==
X-Google-Smtp-Source: AFSGD/Xg0mtEyXuSLdRGFXoWRNwO5MU8H5YDvbA9W/vSM5kaC/l3Ri96yKBLGiOuZMMvwWN5yWyORg==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr5318224wmb.44.1543572380080;
        Fri, 30 Nov 2018 02:06:20 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id h2sm3262265wrv.87.2018.11.30.02.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 02:06:19 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH] perf evsel: Correct clock unit to nanosecond
Date:   Fri, 30 Nov 2018 18:06:05 +0800
Message-Id: <1543572365-11706-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0aa802a79469 ("perf stat: Get rid of extra clock display
function"), the cpu and task clock unit has been changed from
nanosecond value to millisecond value.  This introduces confusion for
CPU run time statistics, we can see in below flow the clock value is
scaled from nanosecond value to millisecond value; but this is
contradiction with statistics type 'STAT_NSECS', which always takes
clock as nanosecond unit.

  perf_stat__update_shadow_stats()
    `-> count *= counter->scale;
        update_runtime_stat(st, STAT_NSECS, 0, cpu, count);

And when 'perf stat' calculates frequencies for cpu cycles and other
events, it uses event count to divide clock and it expects divisor unit
has nanosecond value, but actually the clock value has been scaled to
millisecond value.  At the end we can exaggerate values in below output
result (e.g. 500M/sec for context-switches, cycle is 1079636.500 GHz).

  # perf stat -- sleep 1

   Performance counter stats for 'sleep 1':

                2.29 msec task-clock                #    0.002 CPUs utilized
                   1      context-switches          #  500.000 M/sec
                   1      cpu-migrations            #  500.000 M/sec
                  53      page-faults               # 26500.000 M/sec
           2,159,273      cycles                    # 1079636.500 GHz
           1,281,566      instructions              #    0.59  insn per cycle
             171,153      branches                  # 85576500.000 M/sec
              17,870      branch-misses             #   10.44% of all branches

To fix this issue, this patch changes back clock unit to nanosecond
level, as result we can see the correct frequency calculation:

  # perf stat -- sleep 1

   Performance counter stats for 'sleep 1':

           2,461,180 nsec task-clock                #    0.002 CPUs utilized
                   1      context-switches          #    0.406 K/sec
                   0      cpu-migrations            #    0.000 K/sec
                  54      page-faults               #    0.022 M/sec
           2,320,634      cycles                    #    0.943 GHz
           1,284,442      instructions              #    0.55  insn per cycle
             171,425      branches                  #   69.652 M/sec
              17,970      branch-misses             #   10.48% of all branches

This patch has side effect for changing unit field for perf command.
This is tested with below two cases: one is for normal output format and
another is for cvs output format.

Before:

  # perf stat  -e cpu-clock,task-clock -C 0 sleep 3

   Performance counter stats for 'CPU(s) 0':

            3,003.50 msec cpu-clock                 #    1.000 CPUs utilized
            3,003.50 msec task-clock                #    1.000 CPUs utilized

         3.003697880 seconds time elapsed

Now:

  # perf stat  -e cpu-clock,task-clock -C 0 sleep 3

   Performance counter stats for 'CPU(s) 0':

       3,003,684,880 nsec cpu-clock                 #    1.000 CPUs utilized
       3,003,682,780 nsec task-clock                #    1.000 CPUs utilized

         3.003881982 seconds time elapsed

Before:

  # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
  3003.64,msec,cpu-clock,3003644320,100.00,1.000,CPUs utilized
  3003.64,msec,task-clock,3003643300,100.00,1.000,CPUs utilized

Now:

  # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
  3003501460,nsec,cpu-clock,3003501660,100.00,1.000,CPUs utilized
  3003499500,nsec,task-clock,3003499500,100.00,1.000,CPUs utilized

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/evsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466..90a5381 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -267,10 +267,10 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 		 * The evsel->unit points to static alias->unit
 		 * so it's ok to use static string in here.
 		 */
-		static const char *unit = "msec";
+		static const char *unit = "nsec";
 
 		evsel->unit = unit;
-		evsel->scale = 1e-6;
+		evsel->scale = 1;
 	}
 
 	return evsel;
-- 
2.7.4

