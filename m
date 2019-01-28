Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA8CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2600D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694736;
	bh=Oyqf9BnQPS345DBf1NfDZEm6bd8HEhJzwthu06fVxlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0kZAg98V3Os20g4gZs2R2S4NKumNjtlIAT3h/s+qIAKW76/4X6+BBCkS+s/KGZtg
	 NVjQ1tJrmVgF3IohJ5amLzREnvRrIiGQLQNxcfBH6MRPvkVRZws4kbaE2GY5g4BN4T
	 nitATiuKdCtYnxa7tkJX9mPrefYLAeobgg3OCt+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfA1Q6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733304AbfA1QQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2180B20879;
        Mon, 28 Jan 2019 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692203;
        bh=Oyqf9BnQPS345DBf1NfDZEm6bd8HEhJzwthu06fVxlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lb2V8Wu0PyGEy5tHBVb2DSNbyX25Ig563eWC5rS7EGABeLKtegoPeIw/mgz/H/k2g
         Id9rpCEKo/tJwxH/ymZXvlLPt65PelO3Rs9tZgsw93sagfiMiAzlk/0DbTNaa2TtFq
         ABYXN2MfI816lZeuhQ5IGhuoWQGKrUn8sXiYCPi4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 108/170] perf probe: Fix unchecked usage of strncpy()
Date:   Mon, 28 Jan 2019 11:10:58 -0500
Message-Id: <20190128161200.55107-108-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index cdf8d83a484c..6ab9230ce8ee 100644
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

