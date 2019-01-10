Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985A2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670252177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547139415;
	bh=IhPFNqkYadQF+lR0BxBPhBkeNmhpbcqRhdudvUHDMjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFL4swPKTvR9L1IjEQmXtn9YBbjYsW22FInhxZDad/IUClKxcCMH2WNvN2+U4RJZN
	 rPVZoJ3vrrXglN6RJcl6pRItA7nfHQ6N0Imvc9R82IKZFY9Sw8McONQ6tSgFfQVihp
	 LnX0Fqzn7heN17px8PGjpgvy1Zliuy1gKuX7KRyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfAJQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfAJQ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:56:50 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534A120685;
        Thu, 10 Jan 2019 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547139409;
        bh=IhPFNqkYadQF+lR0BxBPhBkeNmhpbcqRhdudvUHDMjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEwczBGLIeZHa2+564el4y3YrDLi3d1KaM7GnJv9tSqfbN4nT3YyjfEyRG5kKw6L6
         Ltfr+OUd/GwHy7mR5PfZQQWWrnhITNN38gf1h5e6ySiyLFC1+eigOF8xqmTkRKfeXG
         16QEscafEPZbk/TMnCJrtk/f4/CjMtTCGIB4NRMQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/4] perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols
Date:   Thu, 10 Jan 2019 13:56:34 -0300
Message-Id: <20190110165636.19338-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110165636.19338-1-acme@kernel.org>
References: <20190110165636.19338-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When testing 'perf top' on a armhf system (32-bit, Orange Pi Zero), I
noticed that 'arch_cpu_idle' dominated, add it to the list of idle
symbols, so that we can see what is that being done when not idle.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4q2b5g4p2hrstrhp9t2mrlho@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 01f2c7385e38..48efad6d0f90 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -614,6 +614,7 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
 		"intel_idle",
-- 
2.20.1

