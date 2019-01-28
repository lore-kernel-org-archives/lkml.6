Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B0FC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E541B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690858;
	bh=cNhBxVPY2HlMccojuZ0tQfbd8C1CpjR4OeOlv5/JEHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mikMDylkCgUn6/frIXhR1gm9k/Z0jKyy32Cx8AgWhbMNJwnAOksQhjbZ+NRUmFsLn
	 A5t2gQ91OOMOEjtZn+at28GBgqJ2WVEVlvVcKKn02TTy4c4o7I/ghZbtN7/3QNPCTu
	 Q+1wsrgNehrRmbzmB2SQmHZZ51MDTfoAHxHdtNk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfA1PyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfA1PyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C52620855;
        Mon, 28 Jan 2019 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690853;
        bh=cNhBxVPY2HlMccojuZ0tQfbd8C1CpjR4OeOlv5/JEHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YH/FFIx2QeaIUosNHtQb3jD0+GlyoZwkXIxWUOHSHpsXJJY4Tb0he3HJS9H2Jhend
         b5C7CodtKdPufzG2fPqYaa3EOWiF2Rf7oGttWuOtJYc+hm2p7d9rnpZPetVJXkDtxI
         F5i70Wk+p8aD45rmWYPNZ/zOoa3QlOyLgd8STqpA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 213/304] perf tools: Cast off_t to s64 to avoid warning on bionic libc
Date:   Mon, 28 Jan 2019 10:42:10 -0500
Message-Id: <20190128154341.47195-213-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

