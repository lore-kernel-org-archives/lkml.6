Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE78FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCAE2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895397;
	bh=yrp8uqFHK7uwYbqCqPdn7Kj+sSiWFpE9NqTQwqafvlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Gjfj+jUdtamZqbFAkdclRTtQOjp11z5mfihR0xUpXFuZciQDRFLUKcxGriADqBZ8
	 pUk1DTv/hhvRlLJ/RK9bkuNi9xpzsFnTOJEaPq9BI/1rAU2uiHqnUEH5xZeAsJvJAN
	 gH7MVm5MaUkMfusF2vwjGynoDDsMQNSfHo808pu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfBKO34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbfBKO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D592075C;
        Mon, 11 Feb 2019 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895390;
        bh=yrp8uqFHK7uwYbqCqPdn7Kj+sSiWFpE9NqTQwqafvlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jV1v1/G22fLh591DrmPK05KLxP0ASmTZSREVfQSeGEZN2/ZUSjcjiUMTypH+zvssP
         OBdPN9En1LZfXhA4c9e5Y5ESS4X1Xmo5VioGfVT5iilYQNG/9s/SoNPM9a6PqKUgZ+
         iVPviTyGLJgb4lHhJzMYWdwt3FmyrYfwkX/4T1Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 190/352] perf probe: Fix unchecked usage of strncpy()
Date:   Mon, 11 Feb 2019 15:16:57 +0100
Message-Id: <20190211141859.215511088@linuxfoundation.org>
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



