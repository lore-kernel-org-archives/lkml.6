Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC689C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774E32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697161;
	bh=RWsHV9a44Ez0t/bgabPmRit+VV8kabY0FEQVu569F1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkOyzpPPvsLhegvJ7gRkReK5wDG3UyeDe3AxMzCni2PK8gxLF9KlVxh4vvCRtp1h5
	 RY9bnuwZnd14fv+9aE99b81uC/EOnNhAZ57LUjjq64XSB4weNYJZRtQ12KzNKR1SJV
	 qKxE/L93adcgH2QOgqUh2hskpeH27ArMsGGToABw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfA1RjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfA1Pxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF9162147A;
        Mon, 28 Jan 2019 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690818;
        bh=RWsHV9a44Ez0t/bgabPmRit+VV8kabY0FEQVu569F1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/yxLH1JX31dXdTuKUGGLF3bR7/z2A6uRAgpMp22SkQm0iJq9ycEMYNqxKdq8+XSA
         f1OhxQqrx/O9wcKGJuABOdeo4KUlAiV6SY+lo14eLkjKKpEkqDrODA+xfm+Ue1ckh3
         0jhLkbA2ty2rQpiR0jzwCMIT3ibq+ONhYkzdwxBc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 201/304] perf probe: Fix unchecked usage of strncpy()
Date:   Mon, 28 Jan 2019 10:41:58 -0500
Message-Id: <20190128154341.47195-201-sashal@kernel.org>
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

[ Upstream commit bef0b8970f27da5ca223e522a174d03e2587761d ]

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this case the 'target' buffer is coming from a list of build-ids that
are expected to have a len of at most (SBUILD_ID_SIZE - 1) chars, so
probably we're safe, but since we're using strncpy() here, use strlcpy()
instead to provide the intended safety checking without the using the
problematic strncpy() function.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/probe-file.c: In function 'probe_cache__open.isra.5':
  util/probe-file.c:427:3: error: 'strncpy' specified bound 41 equals destination size [-Werror=stringop-truncation]
     strncpy(sbuildid, target, SBUILD_ID_SIZE);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1f3736c9c833 ("perf probe: Show all cached probes")
Link: https://lkml.kernel.org/n/tip-l7n8ggc9kl38qtdlouke5yp5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index aac7817d9e14..0b1195cad0e5 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -424,7 +424,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
 
 	if (target && build_id_cache__cached(target)) {
 		/* This is a cached buildid */
-		strncpy(sbuildid, target, SBUILD_ID_SIZE);
+		strlcpy(sbuildid, target, SBUILD_ID_SIZE);
 		dir_name = build_id_cache__linkname(sbuildid, NULL, 0);
 		goto found;
 	}
-- 
2.19.1

