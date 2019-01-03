Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB2CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5E32070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519633;
	bh=a7zoPeHf52NKWdDPx39iZvTqoBeDwMVA08oWbL7RSKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xYlAGzYs7wCNLK0alLm8qcCSCGVo+4eLx33z2Ha/OuysrTCwdDWE3h06nP3CashE9
	 8Wo7HVcJx/UkqPAB4LSKSXSNBF8shWLJzFqqjVI2CmMdCPPozNzJ/kxXg4+OXhxpM3
	 fNuIm14e2ftYMOr91imu8V4c3vtf3fvKV4dlgCBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfACMrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfACMrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:10 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01882070D;
        Thu,  3 Jan 2019 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519629;
        bh=a7zoPeHf52NKWdDPx39iZvTqoBeDwMVA08oWbL7RSKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urUKcXAbPOj2QeI7KMuO4EE3mzEv2O38ERqtSzdZM2t4maFcZDt/BgWUCtqDk6kz7
         /3zHS9VWKl+fltkD7RgKv1kG3TmphaSeYE5IoFGRmSSJ/gXihCd3GS9F/HNtipsBLx
         0dHEG8pXn4eBQc0bZqV1C02GFnvFbWISDvoJ7IC4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/29] perf c2c: Change the default coalesce setup
Date:   Thu,  3 Jan 2019 09:45:56 -0300
Message-Id: <20190103124609.29672-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Joe suggested to have the coalesce default set just to 'iaddr', because
it's easier to read on the default 'perf c2c report' output.

By removing the "pid" field from the default -c/--coalesce option, the
'perf c2c' report will group all the relevant PIDs under the instruction
address ('iaddr') bucket. User can always run "-c pid,iaddr" for a more
fine grained output on particular PIDs.

Suggested-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181228101820.28010-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f3aa9d02a5ab..964f3f5ef420 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -68,7 +68,7 @@ struct c2c_hist_entry {
 	struct hist_entry	he;
 };
 
-static char const *coalesce_default = "pid,iaddr";
+static char const *coalesce_default = "iaddr";
 
 struct perf_c2c {
 	struct perf_tool	tool;
-- 
2.19.2

