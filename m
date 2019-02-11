Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AD6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895435;
	bh=Or31T78x63lPIONTkxxEHPUisIYBzdDj5rkGtCtHwQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I+Nv6FbU+r2/eY1K9i7YzIOXSaqtxy2TN+/6DaRr2PbU20M2uw2Fx+ORiTS2Pb9ND
	 9KQACz0jHOcfzI3a6K1yMXhe23pzu8QLBXJmIl5bk6DgsIsa0VzkP4nLDoMGoJPK1V
	 GMgd3c58P/T+fvVg7yIggSCYvTwXL0qul5Btl1F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfBKOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbfBKOab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C6B320675;
        Mon, 11 Feb 2019 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895430;
        bh=Or31T78x63lPIONTkxxEHPUisIYBzdDj5rkGtCtHwQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTFrA48aEMJr8H7HaZx4ImPhkcb1c/2RijUApK6C15yCFkdz9gDlbjGuWMUsUOZ7A
         CAp7Hc/EKxa0RrE6SApuojhS1AdO9boGnwp81FfwulfUElECdYiwSFQ6o1X+NxLZfb
         W5DG/XUGJiF2dSFS2Y4PxFlvxDQjVs7mMMttwk/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 202/352] perf tools: Cast off_t to s64 to avoid warning on bionic libc
Date:   Mon, 11 Feb 2019 15:17:09 +0100
Message-Id: <20190211141859.996435371@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 866053bb644f754d1a93aaa9db9998fecf7a8978 ]

To avoid this warning:

    CC       /tmp/build/perf/util/s390-cpumsf.o
  util/s390-cpumsf.c: In function 's390_cpumsf_samples':
  util/s390-cpumsf.c:508:3: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'off_t' [-Wformat=]
     pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
     ^

Now the various Android cross toolchains used in the perf tools
container test builds are all clean and we can remove this:

  export EXTRA_MAKE_ARGS="WERROR=0"

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-5rav4ccyb0sjciysz2i4p3sx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/s390-cpumsf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index a2eeebbfb25f..68b2570304ec 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -506,7 +506,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
 	aux_ts = get_trailer_time(buf);
 	if (!aux_ts) {
 		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
-		       sfq->buffer->data_offset);
+		       (s64)sfq->buffer->data_offset);
 		aux_ts = ~0ULL;
 		goto out;
 	}
-- 
2.19.1



