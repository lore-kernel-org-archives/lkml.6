Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF069C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B2E217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeLROXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:23:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:23:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIENUn62855958
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:23:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIENUQQ2855954;
        Tue, 18 Dec 2018 06:23:30 -0800
Date:   Tue, 18 Dec 2018 06:23:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-d1wz0hjjsh19xbalw69qpytj@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ui helpline: Use strlcpy() as a shorter form
 of strncpy() + explicit set nul
Git-Commit-ID: 4d0f16d059ddb91424480d88473f7392f24aebdc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20181218142330.Z2UUIVPqkKYejnmtZZ9PgApwX-xT4LaZ6IVYOUFMw_E@z>

Commit-ID:  4d0f16d059ddb91424480d88473f7392f24aebdc
Gitweb:     https://git.kernel.org/tip/4d0f16d059ddb91424480d88473f7392f24aebdc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Dec 2018 11:41:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:23 -0300

perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this case we are actually setting the null byte at the right place,
but since we pass the buffer size as the limit to strncpy() and not
it minus one, gcc ends up warning us about that, see below. So, lets
just switch to the shorter form provided by strlcpy().

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  ui/tui/helpline.c: In function 'tui_helpline__push':
  ui/tui/helpline.c:27:2: error: 'strncpy' specified bound 512 equals destination size [-Werror=stringop-truncation]
    strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: e6e904687949 ("perf ui: Introduce struct ui_helpline")
Link: https://lkml.kernel.org/n/tip-d1wz0hjjsh19xbalw69qpytj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/helpline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 4ca799aadb4e..93d6b7240285 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -24,7 +24,7 @@ static void tui_helpline__push(const char *msg)
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
-	strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
+	strlcpy(ui_helpline__current, msg, sz);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)
