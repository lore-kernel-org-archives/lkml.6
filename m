Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0079C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900B8222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191631;
	bh=XBAu5QzOJtsgdEUo+CIUU3DnQZcgGDL0fJUWjg0CPsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nw4crVNYfm6AsRR7VgtRNzWBWPFuK9pP5TLcNg77OVZYH5MoN9BOqhBVW8COrXgvU
	 doJWKYW5efVnhbGlXgqbWx+HVwsChAOJvcFpG8kkERrYGRsETV3XV01lt7DFcysxO7
	 91O4HPT0Dte5sOxJZCC5+bl/zPaI/5ZJB/o9brbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbfBOArJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388945AbfBOArG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:06 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B222229F;
        Fri, 15 Feb 2019 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191625;
        bh=XBAu5QzOJtsgdEUo+CIUU3DnQZcgGDL0fJUWjg0CPsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ub2pg6R72FE8QahqMwsoW+t5xzKGFwZHN5Msv6feyXQr2eVfjjhnabvw87tS1k5r6
         SAaQPoCh0LAaEV4822etp8q/GpQ0GpPzOCAq0UCq62/LMo+i92STl4EXjgk5bXWo+s
         5Gxt+kw/wq9CwfMQp7axj178uoYAF+Hi+/H5V9So=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/43] perf trace: Filter out gnome-terminal* parent
Date:   Thu, 14 Feb 2019 21:45:14 -0300
Message-Id: <20190215004539.23571-19-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like it does with 'sshd', to reduce the feedback loop when doing
system wide tracing on on a gnome GUI.

Need to figure out how to auto-filter the calls to other UI components
tho.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rjopq5y92itgokppdhe8sc6z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a9b51f59ab54..68a01e624ad3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2771,7 +2771,8 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		if (parent == NULL)
 			break;
 
-		if (!strcmp(thread__comm_str(parent), "sshd")) {
+		if (!strcmp(thread__comm_str(parent), "sshd") ||
+		    strstarts(thread__comm_str(parent), "gnome-terminal")) {
 			pids[nr++] = parent->tid;
 			break;
 		}
-- 
2.19.1

