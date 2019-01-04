Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5251B218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626910;
	bh=Kl4VccB729T9lEES7IOk5KrVkKyfRbFrSksDZ56vlxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t1NLGRkfc2M5Cp1l6k0LipnQlmqW14jM/y1ueSlsWhwFOBp5gumqePWBCULZT8C5P
	 nw3J3uGzI3dZLup/pH0ZLyDObq8IOXoqvA1u/QqjUcQBJMFygWiOJtucIHPxnUtKlL
	 LndQslc9uNVOgDn3MZKQxHXoBX1/oRQQzWMlyp44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfADSfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbfADSem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:42 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E9F218FE;
        Fri,  4 Jan 2019 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626882;
        bh=Kl4VccB729T9lEES7IOk5KrVkKyfRbFrSksDZ56vlxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dw2mOxJnixJeRMDH2konegdQg6w7B+9Fqbgsl7eHKDU5aQc6SKCSNRsESutloSqVF
         REInXq4EFIzQzNieU8wQ+tFWXI/wvZ98FmDVcgaKnghNmZCHS5R4zZ2xo59XxJjMcq
         m8Ni7TkM3wTwLktFKX2sKyGuPnAh0cvQgJA/db9s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sanskriti Sharma <sansharm@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/16] perf strbuf: Remove redundant va_end() in strbuf_addv()
Date:   Fri,  4 Jan 2019 15:33:35 -0300
Message-Id: <20190104183337.12771-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattias Jacobsson <2pi@mok.nu>

Each call to va_copy() should have one, and only one, corresponding call
to va_end(). In strbuf_addv() some code paths result in va_end() getting
called multiple times. Remove the superfluous va_end().

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sanskriti Sharma <sansharm@redhat.com>
Link: http://lkml.kernel.org/r/20181229141750.16945-1-2pi@mok.nu
Fixes: ce49d8436cff ("perf strbuf: Match va_{add,copy} with va_end")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 9005fbe0780e..23092fd6451d 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -109,7 +109,6 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 			return ret;
 		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
-		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
 			va_end(ap_saved);
-- 
2.20.1

