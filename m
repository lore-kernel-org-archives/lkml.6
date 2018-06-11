Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 357A7C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06C0208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMj5xPnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06C0208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933519AbeFKRsg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932768AbeFKRs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:48:29 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D068A208B1;
        Mon, 11 Jun 2018 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739309;
        bh=Kl+9bMI7esvr6LvaEzYpGvqBSn4EqSdUwTYuMxAP+GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMj5xPnPm+nmdoCNJFhmg3+h3juGKn3NN1vGkRQ+EIhy76b6JJ+bHxZhdvdBAEemO
         mVxYuvEhb5R6cIT2DdB1Uv6HVYY16sAgbpEeXqHsiy6qgYsibWgRQ2qAIc03ykzXHu
         PYRUlljn7Q0OfjibsyZRH/go+Qmb9xQljj82PA38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/12] perf hists: Make hist_entry__has_callchains() work with 'perf c2c'
Date:   Mon, 11 Jun 2018 14:48:00 -0300
Message-Id: <20180611174810.14815-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since 'perf c2c' uses 'struct hists' not allocated together with a
'struct perf_evsel' instance, we can't go from a 'struct hist_entry'
pointer to a 'struct perf_evsel' via he->hists, so, instead, check if
space was set aside for hist_entry->callchain[0] at hist_entry__new()
time.

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: fabd37b837f6 ("perf hists: Check if a hist_entry has callchains before using them")
Link: https://lkml.kernel.org/n/tip-e8ife8djvvvwmeze3s4yodii@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9ab9257ed887..8bf302cafcec 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -155,7 +155,7 @@ struct hist_entry {
 
 static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 {
-	return hists__has_callchains(he->hists);
+	return he->callchain_size != 0;
 }
 
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
-- 
2.14.3

