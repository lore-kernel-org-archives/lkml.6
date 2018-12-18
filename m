Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B5218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170964;
	bh=q+gybM47QfLr/l5vJZBU7MwYg7decKm1cZ6BcJeLnZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kd/+FUP1hAw2mtcU/4bu/Ligplp11XsJbXwSE3Fcxyi9mmKIa+OxxJDGQrOVxDo7x
	 5kCci7ufzKOJCO0qcud8BgX39IT3CFdCJKoRWD7pkomT3oiaNt8sKQcCCLRJjaPuXD
	 aKyydiUaHd4P0CpG0k908ik0l+xHCBvgJ6LlsSgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeLRWJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbeLRWJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:21 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C714218A4;
        Tue, 18 Dec 2018 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170960;
        bh=q+gybM47QfLr/l5vJZBU7MwYg7decKm1cZ6BcJeLnZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BihY6yOiH2heiOCVB2PCgykRuvRt6FW/REGp77u1Xv2mrwyywFU1p1nDyqBA+3lEV
         ErRfe028MQpiY/LaQyQRdrsjbcrtz7a2aga5mHTDm1GAfqasjAvhzyFwkFYOOUYLPk
         /rS1hCO3yNMn+lqzrPjVM/ipVZzbxPOhLRzuhYqY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 17/63] perf tools: Cast off_t to s64 to avoid warning on bionic libc
Date:   Tue, 18 Dec 2018 19:06:47 -0300
Message-Id: <20181218220733.15839-18-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
2.19.2

