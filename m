Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E99C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D725218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360592;
	bh=r3DJafyXJ38ed6QS9ewhIMRuYb5uLF9ukbfHqz6YxoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdgMU2BqdRu1a4LQGbrTGN/vF8CLqjZsSxjgu6vAInWIF1EQz/EH3NLBLExF9FDCT
	 mjVPgQKtEpARZHEZ8XugnmGbdMaN7t+YDnb6rIlCvMvS4syvKsOmGbwYrKSb0B5ZXN
	 isk5OEDrfXX3ztqhfqRkvrCeA00ytBskN+ZAh1EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfAXT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:28:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730861AbfAXT2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA154218A6;
        Thu, 24 Jan 2019 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358081;
        bh=r3DJafyXJ38ed6QS9ewhIMRuYb5uLF9ukbfHqz6YxoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/sJm1cZhRmG+qUpkcDPtjBXjIyhv/H102gSf+pbVNWMubhN8U2QFFFaYGunLYgx6
         DloNg1Hjd3DJttzzdXOdawkVfA5TgCF4DCt15XTCZYuGOsrIvBar9AvYK4ubpaySTB
         mcLJ+pMpfvQCexDR2TzOesIwpF/GsXLoOHFI9cgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 092/104] perf intel-pt: Fix error with config term "pt=0"
Date:   Thu, 24 Jan 2019 20:20:21 +0100
Message-Id: <20190124190205.010688831@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index c53f78767568..df21da796fa7 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -471,10 +471,21 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
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



