Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D3C218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626855;
	bh=AH+N7C/KgfGeEueGBqbqhvRFY1ONQYch49SA8OumPBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X5EKr6y7Sa9X3q4EqGs8bj12jFOZaZhccrZmZIgDLpt7NQr3U0u4HV/FWSRk3Nm+X
	 seJLxzPlDZ2p6Bf5+iO1fOqEDaeB5ixwqEGDPjDwcL4tcVxArHGO3lJnY1l3JxB7vW
	 pYRy1vaC/bltpHrshCbpn65n4JwELBEXp2JURZxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfADSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfADSeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:11 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56BB1218E0;
        Fri,  4 Jan 2019 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626850;
        bh=AH+N7C/KgfGeEueGBqbqhvRFY1ONQYch49SA8OumPBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I00yiuViSmJPJf6Qcp8PlSNZ+g3bN7t147X140bkjc4NXwD8ByMsx0qScenIgUOTI
         aaY7thHDBy8W7RKLqex/yZ+5qGe5ONQd+utLxCSzR4D0r6dVIC6o3ZuFDMvS35OJyL
         ptrZXURJFwyypw31O0Zi+jUWwajKKeQ9WeVgidcg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 04/16] tools beauty: Make the prctl option table generator catch all PR_ options
Date:   Fri,  4 Jan 2019 15:33:25 -0300
Message-Id: <20190104183337.12771-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In ba8308856564 ("arm64: add prctl control for resetting ptrauth keys")
the PR_PAC_RESET_KEYS prctl option was introduced, get that into the
regex in addition to PR_GET_* and PR_SET_*:

So just get everything that matches '^#define PR_\w+' this ends up
adding these entries:

  $ tools/perf/trace/beauty/prctl_option.sh  > after
  $ diff -u before after
  --- before	2019-01-03 14:58:51.541807353 -0300
  +++ after	2019-01-03 15:17:05.909583804 -0300
  @@ -19,12 +19,18 @@
          [20] = "SET_ENDIAN",
          [21] = "GET_SECCOMP",
          [22] = "SET_SECCOMP",
  +       [23] = "CAPBSET_READ",
  +       [24] = "CAPBSET_DROP",
          [25] = "GET_TSC",
          [26] = "SET_TSC",
          [27] = "GET_SECUREBITS",
          [28] = "SET_SECUREBITS",
          [29] = "SET_TIMERSLACK",
          [30] = "GET_TIMERSLACK",
  +       [31] = "TASK_PERF_EVENTS_DISABLE",
  +       [32] = "TASK_PERF_EVENTS_ENABLE",
  +       [33] = "MCE_KILL",
  +       [34] = "MCE_KILL_GET",
          [35] = "SET_MM",
          [36] = "SET_CHILD_SUBREAPER",
          [37] = "GET_CHILD_SUBREAPER",
  @@ -33,8 +39,13 @@
          [40] = "GET_TID_ADDRESS",
          [41] = "SET_THP_DISABLE",
          [42] = "GET_THP_DISABLE",
  +       [43] = "MPX_ENABLE_MANAGEMENT",
  +       [44] = "MPX_DISABLE_MANAGEMENT",
          [45] = "SET_FP_MODE",
          [46] = "GET_FP_MODE",
  +       [47] = "CAP_AMBIENT",
  +       [50] = "SVE_SET_VL",
  +       [51] = "SVE_GET_VL",
          [52] = "GET_SPECULATION_CTRL",
          [53] = "SET_SPECULATION_CTRL",
          [54] = "PAC_RESET_KEYS",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-sg2pkmtjr5988bhbcp4yp6sw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index d32f8f1124af..3109d7b05e11 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -4,7 +4,7 @@
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
-regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
+regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
 egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
-- 
2.20.1

