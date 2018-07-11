Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C838C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67BA21473
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1KMS+oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67BA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbeGKUvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389371AbeGKUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:21 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCDF2147A;
        Wed, 11 Jul 2018 20:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341914;
        bh=362VeYihTYXFUMjflm0047FqebWnSx1lvaVrReBsT6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1KMS+oM15Bg4eRtUg6Zq3pM395CUVlDvy/RYveGqP4d2WTjZXX8XAtom2C7faW4v
         +AyAwWiByuKLKo5jLo3Y+GfYcSaflN+GnkELsDP29G4QPuFpQRIqaynEgxhUPTiPr6
         90jYQoFm8Re8Qm5ZrQ1hyw2LuvmYm1dUW1CNYgk4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/14] perf test shell: Prevent temporary editor files from being considered test scripts
Date:   Wed, 11 Jul 2018 16:43:01 -0400
Message-Id: <20180711204305.12924-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allows a perf shell test developer to concurrently edit and run their
test scripts, avoiding perf test attempts to execute their editor
temporary files, such as seen here:

 $ sudo taskset -c 0 ./perf test -vvvvvvvv -F 63
 63: 0VIM 8.0                                              :
 --- start ---
 sh: 1: ./tests/shell/.record+probe_libc_inet_pton.sh.swp: Permission denied
 ---- end ----
 0VIM 8.0: FAILED!

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124658.15a506b41fc4539c08eb9426@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2bde505e2e7e..dd850a26d579 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -422,7 +422,7 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(dir, base, ent)	\
 	while ((ent = readdir(dir)) != NULL)	\
-		if (!is_directory(base, ent))
+		if (!is_directory(base, ent) && ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
-- 
2.14.4

