Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D20C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A832B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975734;
	bh=howNbSFbtqVdOUBLsx5cXHOFR5FDwJVSK/aN9VXMmro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M8ml2h7/Xrz/wX0btyxn4hq7KF21Up/CWYcS6Di9ZXf6rs+zmeaf5YR+UQr3Mvayl
	 WSLK82cFPOijSLGUzEqawQJyri+HP0UnZWRal5DJMclkR/w6vsjg2iVQmiPf1zb91Y
	 EmT3DFkZ6NYgZaRuI2VpCFQMjvFF4FvVGAOLP6OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfAHT2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfAHT2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3F62070B;
        Tue,  8 Jan 2019 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975724;
        bh=howNbSFbtqVdOUBLsx5cXHOFR5FDwJVSK/aN9VXMmro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9KhVA0zklWyhE8bFCbYYUc8th/QC8ht/qYiq71/3Xj1DhmdwZM9AhaGzMC8dCcq0
         lHrAR53G/ZvGlGX+s7A+ZUetB/X4A4Mwra4PqiY7Ap5aweOb4EWHan5rNomUIm7WQI
         aV8+bIDzjQyhhDbv0cPDXt1zR4ZldM9ShoiiYPLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 079/117] perf intel-pt: Fix error with config term "pt=0"
Date:   Tue,  8 Jan 2019 14:25:47 -0500
Message-Id: <20190108192628.121270-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 1c6f709b9f96366cc47af23c05ecec9b8c0c392d ]

Users should never use 'pt=0', but if they do it may give a meaningless
error:

	$ perf record -e intel_pt/pt=0/u uname
	Error:
	The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
	event (intel_pt/pt=0/u).

Fix that by forcing 'pt=1'.

Committer testing:

  # perf record -e intel_pt/pt=0/u uname
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (intel_pt/pt=0/u).
  /bin/dmesg | grep -i perf may provide additional information.

  # perf record -e intel_pt/pt=0/u uname
  pt=0 doesn't make sense, forcing pt=1
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.020 MB perf.data ]
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/b7c5b4e5-9497-10e5-fd43-5f3e4a0fe51d@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index db0ba8caf5a2..ba8ecaf52200 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -524,10 +524,21 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 				    struct perf_evsel *evsel)
 {
 	int err;
+	char c;
 
 	if (!evsel)
 		return 0;
 
+	/*
+	 * If supported, force pass-through config term (pt=1) even if user
+	 * sets pt=0, which avoids senseless kernel errors.
+	 */
+	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
+	    !(evsel->attr.config & 1)) {
+		pr_warning("pt=0 doesn't make sense, forcing pt=1\n");
+		evsel->attr.config |= 1;
+	}
+
 	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
 				       "cyc_thresh", "caps/psb_cyc",
 				       evsel->attr.config);
-- 
2.19.1

