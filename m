Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48049C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B04921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131832;
	bh=riImHYT9PqXiAiJmvXYRabhkyhsXjMUn/QGmCA9Xi5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqQ9RJWAJxxmCI37UwaFH7zszk3U2SQseLslOGUaNC+tf888+sxkPXuvoVOdku/mC
	 OcOXVxDcdF17w1I2uSfn6Pf4PyWHtEXBdRoMRLJNjV4ikLPUtN7Avfb7uQ6O9ICoua
	 YOEVLHnvIiTXLGKr2YWP+lgoULGmjTmJ9NNuw1Ew=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B04921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeLFVaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbeLFVa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:27 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4AE2146D;
        Thu,  6 Dec 2018 21:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131827;
        bh=riImHYT9PqXiAiJmvXYRabhkyhsXjMUn/QGmCA9Xi5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kf2G1zIA25gmVheRFrwjm+BNTY5MWDFzhTgzQzP2rY/A+2OGTNoQHw39qyekpxOLs
         lR9dE0BEdvnSdMEBeb8IxM/gC8c+uFIW+AXxVFy98VItVZY3ddpb7KaNov8htSnHt6
         oOEoc2ID/QEvo8M29W0TFYv8MC7LxRrlRgoVOAZo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 60/75] perf dso: Fix unchecked usage of strncpy()
Date:   Thu,  6 Dec 2018 18:25:47 -0300
Message-Id: <20181206212602.20474-61-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  In function 'decompress_kmodule',
      inlined from 'dso__decompress_kmodule_fd' at util/dso.c:305:9:
  util/dso.c:298:3: error: 'strncpy' destination unchanged after copying no bytes [-Werror=stringop-truncation]
     strncpy(pathname, tmpbuf, len);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    CC       /tmp/build/perf/util/values.o
    CC       /tmp/build/perf/util/debug.o
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: c9a8a6131fb6 ("perf tools: Move the temp file processing into decompress_kmodule")
Link: https://lkml.kernel.org/n/tip-tl2hdxj64tt4k8btbi6a0ugw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index bbed90e5d9bb..cee717a3794f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -295,7 +295,7 @@ static int decompress_kmodule(struct dso *dso, const char *name,
 		unlink(tmpbuf);
 
 	if (pathname && (fd >= 0))
-		strncpy(pathname, tmpbuf, len);
+		strlcpy(pathname, tmpbuf, len);
 
 	return fd;
 }
-- 
2.19.2

