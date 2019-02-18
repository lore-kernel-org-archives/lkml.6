Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A721900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497532;
	bh=n9g7DiLvsDGRL//KtI0LDtHCc11JJTMqOaOEEX4sirQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ep7xcvlvjLh2ufkJSvl2i37zpr3mdSxRJu78BNf/r6BGYdLSIhiMObMaxQToe/25x
	 j7HTYA/MFjWftInKXHBnYPhgOJJhDTloB0PtR8dfCCAvEl/qAWwfkWDZLKBtoefIrC
	 UaUxpI+SlRlNQPWS3G0uHlmPFZdD+FrtYbRc8mdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfBRNpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731340AbfBRNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA6CE218FC;
        Mon, 18 Feb 2019 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497527;
        bh=n9g7DiLvsDGRL//KtI0LDtHCc11JJTMqOaOEEX4sirQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbXtPvNtMfoVAT/Y5cJAxFmeKZFIz5OI1UukMTT3IioVbP5hm8K6nT2OXOpND/frI
         26BI6GBbI7W8+yGBz1W2RLkrkgHD2k+BZ0A+7+wzUyS2EagksM1rP7lQ+wKYZKugdx
         +EX6AmHywajDzYU3efJSf+Z+c0NmVRArD+NIbtUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 06/92] perf stat: Fix endless wait for child process
Date:   Mon, 18 Feb 2019 14:42:09 +0100
Message-Id: <20190218133455.188837879@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8a99255a50c0b4c2a449b96fd8d45fcc8d72c701 ]

We hit a 'perf stat' issue by using following script:

  #!/bin/bash

  sleep 1000 &
  exec perf stat -a -e cycles -I1000 -- sleep 5

Since "perf stat" is launched by exec, the "sleep 1000" would be the
child process of "perf stat". The wait4() call will not return because
it's waiting for the child process "sleep 1000" to end. So 'perf stat'
doesn't return even after 5s passes.

This patch lets 'perf stat' return when the specified child process ends
(in this case, the specified child process is "sleep 5").

Committer testing:

  # cat test.sh
  #!/bin/bash

  sleep 10 &
  exec perf stat -a -e cycles -I1000 -- sleep 5
  #

Before:

  # time ./test.sh
  #           time             counts unit events
       1.001113090        108,453,351      cycles
       2.002062196        142,075,435      cycles
       3.002896194        164,801,068      cycles
       4.003731666        107,062,140      cycles
       5.002068867        112,241,832      cycles

  real	0m10.066s
  user	0m0.016s
  sys	0m0.101s
  #

After:

  # time ./test.sh
  #           time             counts unit events
       1.001016096         91,412,027      cycles
       2.002014963        124,063,708      cycles
       3.002883964        125,993,929      cycles
       4.003706470        120,465,734      cycles
       5.002006778        163,560,355      cycles

  real	0m5.123s
  user	0m0.014s
  sys	0m0.105s
  #

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1546501245-4512-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1410d66192f7..63a3afc7f32b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -561,7 +561,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		wait4(child_pid, &status, 0, &stat_config.ru_data);
+		if (child_pid != -1)
+			wait4(child_pid, &status, 0, &stat_config.ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
-- 
2.19.1



