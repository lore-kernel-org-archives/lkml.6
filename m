Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51DB21773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBIM5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:57:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:57:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CvW432633795
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:57:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CvWHR2633792;
        Sat, 9 Feb 2019 04:57:32 -0800
Date:   Sat, 9 Feb 2019 04:57:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-d6d457451eb94fa747dc202765592eb8885a7352@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, acme@redhat.com
Reply-To: jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190109091835.5570-2-adrian.hunter@intel.com>
References: <20190109091835.5570-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix split_kallsyms_for_kcore() for
 trampoline symbols
Git-Commit-ID: d6d457451eb94fa747dc202765592eb8885a7352
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

Commit-ID:  d6d457451eb94fa747dc202765592eb8885a7352
Gitweb:     https://git.kernel.org/tip/d6d457451eb94fa747dc202765592eb8885a7352
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 9 Jan 2019 11:18:30 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols

Kallsyms symbols do not have a size, so the size becomes the distance to
the next symbol.

Consequently the recently added trampoline symbols end up with large
sizes because the trampolines are some distance from one another and the
main kernel map.

However, symbols that end outside their map can disrupt the symbol tree
because, after mapping, it can appear incorrectly that they overlap
other symbols.

Add logic to truncate symbol size to the end of the corresponding map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Link: http://lkml.kernel.org/r/20190109091835.5570-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7b194cf53cc0..758bf5f74e6e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -718,6 +718,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		}
 
 		pos->start -= curr_map->start - curr_map->pgoff;
+		if (pos->end > curr_map->end)
+			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
 		symbols__insert(&curr_map->dso->symbols, pos);
