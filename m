Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAAEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64172089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865873;
	bh=j/G4bmn3qASXJ4v/9FCO+DUKGK3iDjAT3IlpmKgyGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmY2TFaThqtbcA2l1qnYJ+74E3ucuDlD93XOdAS8tK3ut8zeFQvjgzEwOTl3zjGwG
	 Mnxd/aokVkiAUqoOaLhxjnU/PM6PCyTMFAeLJ9CzocOpVJcCt1b19ktCAtOA66fese
	 2hKQYegLceQx87FB6B5OmbjveAZvRvyKnnM4nMPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfAGM5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfAGM5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F9A2173C;
        Mon,  7 Jan 2019 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865870;
        bh=j/G4bmn3qASXJ4v/9FCO+DUKGK3iDjAT3IlpmKgyGp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lq+zFNYdR1cEnH0IuLA6p2tcQmnxh2ER9j3aRSRh1+Jl2z7OcevgF/2qcjbrHtTCg
         Z3IJYTmbyQ+H7T1u0WBPYyN0iz5tG8ts2TASZWWDOSRSksDKyvbHg+XZQ1tR8yPkjC
         SDyFoJVeCniem/UnreTWZXdtI9RLGwk0tetWrIl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 104/170] perf env: Also consider env->arch == NULL as local operation
Date:   Mon,  7 Jan 2019 13:32:11 +0100
Message-Id: <20190107104505.249908319@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 804234f27180dcf9a25cb98a88d5212f65b7f3fd upstream.

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
Cc: stable@vger.kernel.org # 4.19
Link: https://lkml.kernel.org/n/tip-vcz4ufzdon7cwy8dm2ua53xk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/env.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -166,7 +166,7 @@ const char *perf_env__arch(struct perf_e
 	struct utsname uts;
 	char *arch_name;
 
-	if (!env) { /* Assume local operation */
+	if (!env || !env->arch) { /* Assume local operation */
 		if (uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;


