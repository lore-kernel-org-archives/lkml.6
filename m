Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED34218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170945;
	bh=JN5M7QWdkFHmiMgLUDg9fAl3gJubYDgjcWRWTdCcpns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFbUtSn5K1IQBPq9CyXQbaxYM8nIWpsDRg0614X6Hp5gDNLU4z+ZX2NULBviIYtDw
	 3VWsbDURLz9IG2/yss0dxzAqI7UbBBhJUmqzCu5iH3s00OT90BOo1uosMmFCtFKrm/
	 moe7dgNbLISHISyaK8kvEiRtAJFDVjv1YqiK6aGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeLRWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeLRWJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:02 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656ED217D9;
        Tue, 18 Dec 2018 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170941;
        bh=JN5M7QWdkFHmiMgLUDg9fAl3gJubYDgjcWRWTdCcpns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ivm+i1eaYwBMp/Z15/AXdVJ23iwT5dW5TeQhp0UgL9jXKZfysmgYPkAC6zRsniiG9
         TBiiV+yal7y/q1lfUFBYmdcWwz5P5AELiVkLooCU4YXwbe0I5EYa7OpaChEO+lqo9e
         fSAL7F4fdVgVcHVROtstvy3VdU5lQVPp9vx4QhIs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 12/63] perf trace beauty: renameat's newdirfd may also be AT_FDCWD
Date:   Tue, 18 Dec 2018 19:06:42 -0300
Message-Id: <20181218220733.15839-13-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Noticed while working on renameat2.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8omchrcjcvlwoxxv6wrjehfh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4b3f8407f8d5..a14ee4ed2c9f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -798,7 +798,8 @@ static struct syscall_fmt {
 	{ .name	    = "recvmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
-	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
+		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "renameat2",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
-- 
2.19.2

