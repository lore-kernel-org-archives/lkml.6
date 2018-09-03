Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8FBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E40920862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIpnNq8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E40920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeICTNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeICTNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD9E20862;
        Mon,  3 Sep 2018 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986379;
        bh=J/rCD8CISAlK4jZcCk3WX9yPrmDuYC+bEUMTxSdDUkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIpnNq8t2ChFuqK6fOLgSSE9UYu/+rEkru8Uma2TU3rKruOzzPHrn6sz/r+KAZzJ1
         HyYve5vWisTJAgEDaSaAKo2I2l6Pgg8DjT3bGFeE68EXQkwcQSg8BjaHxSPWvZ63Di
         PKP9lC1YJmV8P56P8XI6BjWVOt8uRaRg7U5gNS2Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/13] perf tools: Streamline bpf examples and headers installation
Date:   Mon,  3 Sep 2018 11:52:20 -0300
Message-Id: <20180903145224.12318-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were emitting 4 lines, two of them misleading:

  make: Entering directory '/home/acme/git/perf/tools/perf'
  <SNIP>
    INSTALL  lib
    INSTALL  include/bpf
    INSTALL  lib
    INSTALL  examples/bpf
  <SNIP>
  make: Leaving directory '/home/acme/git/perf/tools/perf'

Make it more compact by showing just two lines:

  make: Entering directory '/home/acme/git/perf/tools/perf'
    INSTALL  bpf-headers
    INSTALL  bpf-examples
  make: Leaving directory '/home/acme/git/perf/tools/perf'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0nvkyciqdkrgy829lony5925@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3d1b12a5081..5224ade3d5af 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -777,14 +777,12 @@ endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBBPF
-	$(call QUIET_INSTALL, lib) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, include/bpf) \
-		$(INSTALL) include/bpf/*.h '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, lib) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, examples/bpf) \
-		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, bpf-headers) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
+		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, bpf-examples) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
+		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-- 
2.14.4

