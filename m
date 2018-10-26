Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E917ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E03E20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E03E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeJZQKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:10:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:10:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7YSlj137225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:34:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7YSJ1137222;
        Fri, 26 Oct 2018 00:34:28 -0700
Date:   Fri, 26 Oct 2018 00:34:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Milian Wolff <tipbot@zytor.com>
Message-ID: <tip-c1c9b9695cc8868048f45c7e2559f65bc0be7382@git.kernel.org>
Cc:     jolsa@kernel.org, milian.wolff@kdab.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          milian.wolff@kdab.com, jolsa@kernel.org, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181021191424.16183-1-milian.wolff@kdab.com>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Allow extended console debug output
Git-Commit-ID: c1c9b9695cc8868048f45c7e2559f65bc0be7382
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

Commit-ID:  c1c9b9695cc8868048f45c7e2559f65bc0be7382
Gitweb:     https://git.kernel.org/tip/c1c9b9695cc8868048f45c7e2559f65bc0be7382
Author:     Milian Wolff <milian.wolff@kdab.com>
AuthorDate: Sun, 21 Oct 2018 21:14:23 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 12:37:53 -0300

perf script: Allow extended console debug output

The script tool isn't using a browser, yet use_browser wasn't set
explicitly to zero. This in turn lead to confusing output such as:

  ```
  $ perf script -vvv ...
  ...
  overlapping maps in /home/milian/foobar (disable tui for more info)
  ...
  ```

Explicitly set use_browser to 0 now, which gives us the extended
debug information now in perf script as expected.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20181021191424.16183-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4da5e32b9e03..bd468b90801b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
 		exit(-1);
 	}
 
-	if (!script_name)
+	if (!script_name) {
 		setup_pager();
+		use_browser = 0;
+	}
 
 	session = perf_session__new(&data, false, &script.tool);
 	if (session == NULL)
