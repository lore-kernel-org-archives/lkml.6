Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF06ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3C620873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjHWNr1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3C620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeJYWxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbeJYWw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DA12085B;
        Thu, 25 Oct 2018 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477201;
        bh=G4t2AF3onUlzYRhTSSW/W1jYUpRZNbDH8ypZpvOLpzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjHWNr1CvPtog9I+cITlFRbqCcfIYOlt4DysUY6IIiT9obdQmj3bZtqEdxIALQ2gY
         x1Y02Ie60iEa+Q9XWmG5v44/86GEwlH79Odw4muGKPzEAT0AfOfmkNbdSbAczOjOzp
         ttHRrvPGKcZIOfTuOMiQpT6kFwkX/PERygKgIdfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 45/98] perf machine: Fix __machine__findnew_thread() error path
Date:   Thu, 25 Oct 2018 10:18:00 -0400
Message-Id: <20181025141853.214051-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 260d819e3abdbdaa2b88fb983d1314f1b263f9e2 ]

When thread__init_map_groups() fails, a new thread should be removed
from the rbtree since it's gonna be freed.  Also update last match cache
only if the function succeeded.

Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/1420763892-15535-1-git-send-email-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/machine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 34fc7c8672e4..84238a10c34b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -389,7 +389,6 @@ static struct thread *__machine__findnew_thread(struct machine *machine,
 	if (th != NULL) {
 		rb_link_node(&th->rb_node, parent, p);
 		rb_insert_color(&th->rb_node, &machine->threads);
-		machine->last_match = th;
 
 		/*
 		 * We have to initialize map_groups separately
@@ -400,9 +399,12 @@ static struct thread *__machine__findnew_thread(struct machine *machine,
 		 * leader and that would screwed the rb tree.
 		 */
 		if (thread__init_map_groups(th, machine)) {
+			rb_erase(&th->rb_node, &machine->threads);
 			thread__delete(th);
 			return NULL;
 		}
+
+		machine->last_match = th;
 	}
 
 	return th;
-- 
2.17.1

