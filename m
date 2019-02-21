Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4832147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712365;
	bh=PCM9AzpaVz/dPYCRpX9o6w5GFoji0g80XA5jrZYNZ6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jEPjiUPrgUQyBxv8Cxssa0yckhYOc6bP0E2xVsg9BJBK6TQ3//xuV7fGzSzmReOOA
	 IXpHwwmByU0EQnLIzyA7+4CNjaLW70Wb783/rhTpmvxZQAgbs9+yMy65wxIKMJRzyC
	 VAzjDTxh9WWaVQc0elVtOgPXFMuirLHHj1fTHEX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfBUB0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfBUB0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:03 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E0F2089F;
        Thu, 21 Feb 2019 01:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712362;
        bh=PCM9AzpaVz/dPYCRpX9o6w5GFoji0g80XA5jrZYNZ6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6XTr0dBV5TAX4bJ2bbQrdn0y9XS25/vBh1NP4rlgEreYsyUsThKMYyZz11PR9eYG
         7RLY9+Rkv9yvYCN8oVrj+fheHeFQJ19FjvombidFBHArmgWFIZlVe1V0GmExi9rUtN
         7HhOSdhHoul0H2PZSCzEmwKtcnwRbx+eyAyzi3xo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/17] perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support
Date:   Wed, 20 Feb 2019 22:25:33 -0300
Message-Id: <20190221012549.4069-2-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

If perf was built without trace support, the trace+probe_vfs_getname.sh
'perf test' entry fails:

  # perf trace -h
  perf: 'trace' is not a perf-command. See 'perf --help'

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: FAILED!

Check trace support, so that we'll skip the test in that case:

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: Skip

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190215134253.11454-1-tt.rantala@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe.sh               | 5 +++++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index 6293cc660947..e37787be672b 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -4,3 +4,8 @@ skip_if_no_perf_probe() {
 	perf probe 2>&1 | grep -q 'is not a perf-command' && return 2
 	return 0
 }
+
+skip_if_no_perf_trace() {
+	perf trace -h 2>&1 | grep -q -e 'is not a perf-command' -e 'trace command not available' && return 2
+	return 0
+}
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 50109f27ca07..147efeb6b195 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -12,6 +12,7 @@
 . $(dirname $0)/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
+skip_if_no_perf_trace || exit 2
 
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
-- 
2.19.1

