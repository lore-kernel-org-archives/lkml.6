Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B5ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929D321526
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFyVpt24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929D321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeISUEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732215AbeISUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FA421522;
        Wed, 19 Sep 2018 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367165;
        bh=QxW2Pp+s+W06eDf2e8KU/Ms6QJF/G6/5qFJTzXD6+zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFyVpt24o70deCxpnnvTwJxS/TqVl3OeSOzaGMUEyYsYcqvIMjcQo+4rLOsXKU1cz
         e5o2UCRvqKlExaQb7aRJURmRRX51yXmErFEfahYvB70tdgoS5hjdn7Wr7h2WvO7oLZ
         VrtuIzGKwhIc7lscY/uFFLBICYlVW9cJlYT4M9bU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/13] tools include: Adopt PTR_ERR_OR_ZERO from the kernel err.h header
Date:   Wed, 19 Sep 2018 11:25:29 -0300
Message-Id: <20180919142537.29985-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

Add PTR_ERR_OR_ZERO, so that tools can use it, just like the kernel.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 7a8b61ad44cb..094649667bae 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -52,4 +52,11 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
 }
 
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
 #endif /* _LINUX_ERR_H */
-- 
2.14.4

