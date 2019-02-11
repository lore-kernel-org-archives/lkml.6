Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE9C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895394;
	bh=YgYl8C4U7Mi0j6Dl9o1yps0br3RxPdmZWJah6lt6hYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajbEPklYaTJaE5EMkeeZ8J+one7SDAmnxwYX/Z567Je64I428Rgy6NLQk9ff+oCLO
	 oRsunhJLviDqr1GakllKAntiufr14Rp9W9U2OQSamShQXoiAo6YtTykQ8YCZJvm2sm
	 KKNu2pn3UjaqhkOQC/rMuFml240UQQiEo2fHAlew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfBKO3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfBKO3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D2C20675;
        Mon, 11 Feb 2019 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895381;
        bh=YgYl8C4U7Mi0j6Dl9o1yps0br3RxPdmZWJah6lt6hYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHjlhoypb15Ou8+qTC+ovrsUFQu35R2rJAUCUiuY0neE/X1U2R0bQ97ATqcspPBuy
         IHZksKDzIbQNQRDj5slUileUmTz+R/a+aDLo6BWsbY2c5yVD07H8bIXsYcdLXvauI8
         YJk9cWQ5pA+J8LH3RcFPI/srArxKhz2+zGgSjJIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 187/352] perf dso: Fix unchecked usage of strncpy()
Date:   Mon, 11 Feb 2019 15:16:54 +0100
Message-Id: <20190211141859.022631166@linuxfoundation.org>
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

[ Upstream commit fca5085c15255bbde203b7322c15f07ebb12f63e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



