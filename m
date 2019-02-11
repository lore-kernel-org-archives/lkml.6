Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87410C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CB720700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896460;
	bh=Nbk/rwHCbNVzJ5rf7HlyV9cJe1w7t0o4pIUX5OmBFcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iqnUIyv2+nGAQJJb6E3X+t7lZPq7frbzp1ulZeSGlZE1F/CdNiyBz25mEpibxXI3h
	 yfzGBdgi2la/kZjdlXdEDX3smve4ZnUMCZIPm7Nwp4DnjJIv7m3YvPzavh1/776xuN
	 hVR/R7VnfGu40p2tlvD1MKQ9s1P2t0+iuHRyu8QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfBKOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbfBKOrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BFEF20700;
        Mon, 11 Feb 2019 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896454;
        bh=Nbk/rwHCbNVzJ5rf7HlyV9cJe1w7t0o4pIUX5OmBFcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLba6xwGI79H9ORpxHxAHi/9OhLMlR++rmPd3iQ0sfOIHPjwTbE5tJH/mkHwJhBna
         kIeW3Dgn/CppNbEIdwi2dCTXWs9s7dln8QrLxOE8dpY8remIOBndfHFSWEtXf74lRt
         DhvQCiJ1HIIlUutRet2m1Axd4xP8yNZioMEpBmas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 158/313] perf dso: Fix unchecked usage of strncpy()
Date:   Mon, 11 Feb 2019 15:17:18 +0100
Message-Id: <20190211141904.054763530@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



