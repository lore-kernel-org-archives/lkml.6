Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C754C04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017BA2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017BA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeHWMJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbeHWMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8eC9L3188555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:40:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8eBEa3188552;
        Thu, 23 Aug 2018 01:40:11 -0700
Date:   Thu, 23 Aug 2018 01:40:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d68a29c2823ff6bd7a25cb748b577f2d88c1f47a@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        tglx@linutronix.de, mpetlan@redhat.com
Reply-To: jolsa@kernel.org, acme@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com,
          hpa@zytor.com, namhyung@kernel.org, mpetlan@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20180817094813.15086-4-jolsa@kernel.org>
References: <20180817094813.15086-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Get rid of dso__needs_decompress()
 call in __open_dso()
Git-Commit-ID: d68a29c2823ff6bd7a25cb748b577f2d88c1f47a
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

Commit-ID:  d68a29c2823ff6bd7a25cb748b577f2d88c1f47a
Gitweb:     https://git.kernel.org/tip/d68a29c2823ff6bd7a25cb748b577f2d88c1f47a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Get rid of dso__needs_decompress() call in __open_dso()

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 51cf82cf1882..8ee1faa5726f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -468,6 +468,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	int fd = -EINVAL;
 	char *root_dir = (char *)"";
 	char *name = malloc(PATH_MAX);
+	bool decomp = false;
 
 	if (!name)
 		return -ENOMEM;
@@ -491,12 +492,13 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 			goto out;
 		}
 
+		decomp = true;
 		strcpy(name, newpath);
 	}
 
 	fd = do_open(name);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(name);
 
 out:
