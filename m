Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D089AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970A7208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131649;
	bh=8HSZB8PDCZMH5i+PO4sX0R0B6IRG/aXq5xwujMgYwtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tazt8p8G8S0hiFtANRMq8leKE70tCqmq65R0SFn1JVCVjMvlNWoKaCdw1paIGOzRb
	 qYvvmm/yHbQp3O+a8/o7tjBLzjMgQHah7rMRMAr13hX2y2zebz5g4kE6BQ727zxBOJ
	 hNgSamSrzNhlUMZXKlXrmUeMCijSoQ2e/NsMSDKs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970A7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLFV12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeLFV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:27 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636002082B;
        Thu,  6 Dec 2018 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131646;
        bh=8HSZB8PDCZMH5i+PO4sX0R0B6IRG/aXq5xwujMgYwtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rq7zXb1Isp9UXdGN6ZqKMg1FN7NhSo1evNDIWC+AyyIo1YvhX2Cp2w3rWIcIhAnmb
         fvAeLMdEZIebuJLoUrqODxUfYHPbNfA3jzBRsbg3MHmYqIWWylqc+yasOSCPvbQHRu
         6U96FXPlS9ZTRRFTJKvf1dRlkumvyM19WolegGt0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        zhong.weidong@zte.com.cn
Subject: [PATCH 13/75] tools include: Adopt ERR_CAST() from the kernel err.h header
Date:   Thu,  6 Dec 2018 18:25:00 -0300
Message-Id: <20181206212602.20474-14-acme@kernel.org>
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

Add ERR_CAST(), so that tools can use it, just like the kernel.

This addresses coccinelle checks that are being performed to tools/ in
addition to kernel sources, so lets add this to cover that and to get
tools code closer to kernel coding standards.

This originally was introduced in the kernel headers in this cset:

  d1bc8e954452 ("Add an ERR_CAST() function to complement ERR_PTR and co.")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/n/tip-tlt97p066zyhzqhl5jt86og7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 094649667bae..2f5a12b88a86 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -59,4 +59,17 @@ static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 	else
 		return 0;
 }
+
+/**
+ * ERR_CAST - Explicitly cast an error-valued pointer to another pointer type
+ * @ptr: The pointer to cast.
+ *
+ * Explicitly cast an error-valued pointer to another pointer type in such a
+ * way as to make it clear that's what's going on.
+ */
+static inline void * __must_check ERR_CAST(__force const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
 #endif /* _LINUX_ERR_H */
-- 
2.19.2

