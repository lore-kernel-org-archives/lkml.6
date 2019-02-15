Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6410BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DD1222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191611;
	bh=kcG82EwS90zSs1OGXf/4oXgc3GD5RV1udOPgVs9Dang=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PqwDspgkktk29/hX6krhVdnmO6F8LDwVM3mPTyr/YLJfhod8EVazJUOxNZ+VxQW7N
	 9Uu3LbUdMwLG9t7jBXWPNY7Uwx2QU7CU3OK++nwJo/DdM573h/dKWIGmjGyvUio9eP
	 yqoXiKOucbQqsMPJlAntcaZ0hg3JBqbRRWDWzc8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfBOAqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbfBOAqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:47 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431C2222D9;
        Fri, 15 Feb 2019 00:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191606;
        bh=kcG82EwS90zSs1OGXf/4oXgc3GD5RV1udOPgVs9Dang=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdr1SfN8XmPWkh3lDRmVg/xCTFFwoT4YXDIykoj0dv0H45VuDmU9+DFUUZuWiRyPR
         CPCWMRK8kBbjGdRJoVPtvDgCwLQFLeI0lKujRBpt5I37OzzDi0X0rxncgISx/CInNX
         tkPzrNpBxy5MUez93l8yW70PtMfWk3RV332i4PGs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/43] tools feature: Undef _GNU_SOURCE at the end of feature tests
Date:   Thu, 14 Feb 2019 21:45:09 -0300
Message-Id: <20190215004539.23571-14-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we get all the tests in a single .c file for a first test,
tools/build/feature/test-all.c, if individual tests set that define and
fail to undef it at its end, then it the test-all.c build will fail due
to defining _GNU_SOURCE multiple times, getting us to the slow path,
so undef it at the end in tests that define it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w6s00jfo1xabgphzczadl59b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-get_current_dir_name.c | 1 +
 tools/build/feature/test-libpython.c            | 1 +
 tools/build/feature/test-setns.c                | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
index 573000f93212..c3c201691b4f 100644
--- a/tools/build/feature/test-get_current_dir_name.c
+++ b/tools/build/feature/test-get_current_dir_name.c
@@ -8,3 +8,4 @@ int main(void)
 	free(get_current_dir_name());
 	return 0;
 }
+#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-libpython.c b/tools/build/feature/test-libpython.c
index 0c1641b0d9a7..371c9113e49d 100644
--- a/tools/build/feature/test-libpython.c
+++ b/tools/build/feature/test-libpython.c
@@ -7,3 +7,4 @@ int main(void)
 
 	return 0;
 }
+#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 1f714d2a658b..4a1581ae7a55 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -5,3 +5,4 @@ int main(void)
 {
 	return setns(0, 0);
 }
+#undef _GNU_SOURCE
-- 
2.19.1

