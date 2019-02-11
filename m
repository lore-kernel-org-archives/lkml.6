Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C0C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB360222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897619;
	bh=6DF8NSeC+hQdGFYAeNQKrtc9fOMxR9+GSs6DQhWmavI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJf0351ieg0YOhQMnglEw0mXXBsCBUGE1I1Sw3zsWN6BYPvx9YIEOvI74GkkUC7oy
	 syp6B5GtM6K+34byIzD+iwDwhvJeMGYWudoYpf7cg0pqa6W/Zb0CUSYecx8adwAupM
	 glnZF5RWBZBFQ3Mbg2ZmNimf+pQrPp2Xrm4FoLRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbfBKPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391288AbfBKPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:06:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F6E222AD;
        Mon, 11 Feb 2019 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897615;
        bh=6DF8NSeC+hQdGFYAeNQKrtc9fOMxR9+GSs6DQhWmavI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxd83ViJ/B5saa8ItN7RxWe+3/d84Nwb1vnnBgtPuEdeqF85v2tqToHVphDLezCbQ
         Vd/GJmECyzVCnRdHjfGAfK0gu2gub7Lb096S5qBrK8D2fG1l/oX6OWVjMZ6or54Z4a
         s1aDN/SdpNmQQWfQRSdkoLHLHsTCLe+7511YlFUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 057/137] perf header: Fix unchecked usage of strncpy()
Date:   Mon, 11 Feb 2019 15:18:58 +0100
Message-Id: <20190211141817.255427931@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7572588085a13d5db02bf159542189f52fdb507e ]

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/header.c: In function 'perf_event__synthesize_event_update_unit':
  util/header.c:3586:2: error: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
    strncpy(ev->data, evsel->unit, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/header.c:3579:16: note: length computed here
    size_t size = strlen(evsel->unit);
                  ^~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: a6e5281780d1 ("perf tools: Add event_update event unit type")
Link: https://lkml.kernel.org/n/tip-fiikh5nay70bv4zskw2aa858@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ab36aa5585b4..a11f6760cce8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2988,7 +2988,7 @@ perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strncpy(ev->data, evsel->unit, size);
+	strlcpy(ev->data, evsel->unit, size + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
-- 
2.19.1



