Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D921741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690814;
	bh=Y1gVf3XEPfYUA/5LC1aBJwK7GVnbPX0rc5bztGiTDWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qoz5c6qOvdi340DwKzUKZ9dqRjkCWlgHzikcGjNNCbQgB/dMqX2fAhJT9NVQCfRie
	 u/JU4QmY4tEY66hJlwhesEeCoS1qKylj+NXnHOrwjahWuq6nh+4a2i716erdxVG8JC
	 IqST//6T/D5IyISa+d69j5RMRDBScGvAtgVnZjII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfA1Pxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbfA1Px3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB4420880;
        Mon, 28 Jan 2019 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690808;
        bh=Y1gVf3XEPfYUA/5LC1aBJwK7GVnbPX0rc5bztGiTDWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYBiGXelow+uKG3mLPQ0ZEEklz3vvyGdXEHWWxkWJtGygtuCQhaqNCa9h8A5pQSwW
         g1dfJ76CUQc6fEiJG9LIN7Um4Cr3ehl3vEyJ6gTqpC4m1jz//4tvgDHGJbSkmgaKGb
         xxB/o2i6sOGuYLM2s5/RGTQEZhi4CiDhqs+gJg14=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 198/304] perf dso: Fix unchecked usage of strncpy()
Date:   Mon, 28 Jan 2019 10:41:55 -0500
Message-Id: <20190128154341.47195-198-sashal@kernel.org>
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

