Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003A9218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357809;
	bh=yDJbYgAWK/3o/5GtQZuJ7r4Lw/O9ZmQK4X+UxEpRGvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqvFNS9wb4WFQ0kkbguwJyTrwBbLMG5sIEBtF1izglrziJy9hN9oVLZVYro8c5ZpA
	 jNFrBfXVQVg267y4bXYbQU9E0CbfiTfIuVl78kWdbwTva1tbdp9dXv86oar+2JgbJ+
	 czr3RU8JZ/qQK3ZKxYpItpvD0Lzbteck9OrcoLh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfAXTX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfAXTXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:23:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C336D218D2;
        Thu, 24 Jan 2019 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357801;
        bh=yDJbYgAWK/3o/5GtQZuJ7r4Lw/O9ZmQK4X+UxEpRGvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ik23kk/s4UfBahWbEBmHJD08Qdju++cSKIwQ2tVx2xxa0I4hxfSqD3weOgzBwEGcw
         r7G5hIHSXar+AC6NYGURoOFxks1h28Bdnlbo7ScRgO91JDG6Dmr/DfW9o4lZKDNJ6o
         5S7i7Du0C+gMlHfEinNuiFpXIC8f0wmnlJiF88mg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 45/52] perf svghelper: Fix unchecked usage of strncpy()
Date:   Thu, 24 Jan 2019 20:20:09 +0100
Message-Id: <20190124190150.152539845@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2f5302533f306d5ee87bd375aef9ca35b91762cb ]

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this specific case this would only happen if fgets() was buggy, as
its man page states that it should read one less byte than the size of
the destination buffer, so that it can put the nul byte at the end of
it, so it would never copy 255 non-nul chars, as fgets reads into the
orig buffer at most 254 non-nul chars and terminates it. But lets just
switch to strlcpy to keep the original intent and silence the gcc 8.2
warning.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  In function 'cpu_model',
      inlined from 'svg_cpu_box' at util/svghelper.c:378:2:
  util/svghelper.c:337:5: error: 'strncpy' output may be truncated copying 255 bytes from a string of length 255 [-Werror=stringop-truncation]
       strncpy(cpu_m, &buf[13], 255);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Fixes: f48d55ce7871 ("perf: Add a SVG helper library file")
Link: https://lkml.kernel.org/n/tip-xzkoo0gyr56gej39ltivuh9g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/svghelper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 283d3e73e2f2..48a841462536 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -333,7 +333,7 @@ static char *cpu_model(void)
 	if (file) {
 		while (fgets(buf, 255, file)) {
 			if (strstr(buf, "model name")) {
-				strncpy(cpu_m, &buf[13], 255);
+				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
 		}
-- 
2.19.1



