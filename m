Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BBC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0C20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="saT/YKWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF0C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeICTNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:21 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E092086D;
        Mon,  3 Sep 2018 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986371;
        bh=XhUmay8aUeO4eLxCRIlOk7tCTpa5IcYVJXVAfPDjGTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=saT/YKWeRx8aDm0XCHbDeZSauNQH0ahBhhTqsB/0JhK8so+TCd+jEGt/CViDxHkyC
         tx0e6nOGhyFQy4zWZfJQIi6ahgPXwhIKIzbapqxcGfaOiRv8UutN1OAhk/0UdtFviE
         sqB5G/dh4PEF9JhbgiMZXPsB3Cy3kj6f2n9XGxPE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/13] perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint
Date:   Mon,  3 Sep 2018 11:52:17 -0300
Message-Id: <20180903145224.12318-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We can safely enable the breakpoint back for both the fail and success
paths by checking only the bp->attr.disabled, which either holds the new
'requested' disabled state or the original breakpoint state.

Committer testing:

At the end of the series, the 'perf test' entry introduced as the first
patch now runs to completion without finding the fixed issues:

  # perf test "bp modify"
  62: x86 bp modify                                         : Ok
  #

In verbose mode:

  # perf test -v "bp modify"
  62: x86 bp modify                                         :
  --- start ---
  test child forked, pid 5161
  rip 5950a0, bp_1 0x5950a0
  in bp_1
  rip 5950a0, bp_1 0x5950a0
  in bp_1
  test child finished with 0
  ---- end ----
  x86 bp modify: Ok

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f6ea33a9f904..22ede28ec07d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2867,16 +2867,11 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 	_perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, true);
-	if (err) {
-		if (!bp->attr.disabled)
-			_perf_event_enable(bp);
 
-		return err;
-	}
-
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		_perf_event_enable(bp);
-	return 0;
+
+	return err;
 }
 
 static int perf_event_modify_attr(struct perf_event *event,
-- 
2.14.4

