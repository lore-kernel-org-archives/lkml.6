Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA80EC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6820989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131614;
	bh=z+IUTm7wqIb5bimWeyxqDGR2Wl80+UZr1hu/8VhKUkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YelTe8hufiYoBeGh91bSo79aIpLfsHzlxh7p1hUjqJgzhFYI7ex3ti4nm4kAH5k4p
	 czuePpbNIusrLeYrnE5IQo4cmIu+MZ+wjVhyaChhdLc2rLWuYOA2baLtixOwSdHxQE
	 0Gy94copsQG6nb4Pja/6fqyEn/ZZvyLX9U4aYoQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD6820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLFV0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLFV0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:26:52 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95FF2146D;
        Thu,  6 Dec 2018 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131611;
        bh=z+IUTm7wqIb5bimWeyxqDGR2Wl80+UZr1hu/8VhKUkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uByg53idaylpIGj7LhIcNv8KhLqLF5MkjdBgxPH4NvU/KSa0w2VcF6O5Uwx62V3Ar
         qZU1t4wo1HspomNAuR7EzTEmu9Fud2HbSAMol+1N38Rb+91E/eKgiZAW7bshGn+EZK
         0/X6265e6lqzlR3/Hqlb9xeuBGWKQJG1UJV6ClSQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org
Subject: [PATCH 05/75] perf env: Also consider env->arch == NULL as local operation
Date:   Thu,  6 Dec 2018 18:24:52 -0300
Message-Id: <20181206212602.20474-6-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll set a new machine field based on env->arch, which for live mode,
like with 'perf top' means we need to use uname() to figure the name of
the arch, fix perf_env__arch() to consider both (env == NULL) and
(env->arch == NULL) as local operation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/n/tip-vcz4ufzdon7cwy8dm2ua53xk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 59f38c7693f8..4c23779e271a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -166,7 +166,7 @@ const char *perf_env__arch(struct perf_env *env)
 	struct utsname uts;
 	char *arch_name;
 
-	if (!env) { /* Assume local operation */
+	if (!env || !env->arch) { /* Assume local operation */
 		if (uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
-- 
2.19.2

