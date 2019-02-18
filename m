Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AA621901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498778;
	bh=Z7CREte0dj5m8AD2Wx6+fRmDxHmPe4vQH1TvOuPNUPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGC6hOYj+ekKdxnPr/peuDPL3UQbphqiljx/K69yn/DOgbq7eI28f46xuhi63esRq
	 2zKJjQg7CAQMy22AGbDxWxJCz978t7kSoN2U6TCa/sBwdTa3Jk03Z9uTTMOi9MbUD7
	 1CfpiHwrpWu26O9jQk3jsiySX0iuzRKfMX2+n4Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbfBROGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390335AbfBROGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140F8204FD;
        Mon, 18 Feb 2019 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498768;
        bh=Z7CREte0dj5m8AD2Wx6+fRmDxHmPe4vQH1TvOuPNUPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRrt0xN1n/woMeZZm1q36YMkN0HuNj+Tm+1o5QXQZAlAtS7mQ456VwORTy9N4QNca
         hWC2uVf60XZHZlVx6gIlbksZeeB5feP0q3xanU/kV+Y13BZiwMAMc+e+hYZxvQ76Bi
         baUMS6VTkKbRsoumnJnCyKPjhgePC3k5lKH8Lwec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 097/143] perf tests evsel-tp-sched: Fix bitwise operator
Date:   Mon, 18 Feb 2019 14:43:45 +0100
Message-Id: <20190218133532.594653372@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 489338a717a0dfbbd5a3fabccf172b78f0ac9015 upstream.

Notice that the use of the bitwise OR operator '|' always leads to true
in this particular case, which seems a bit suspicious due to the context
in which this expression is being used.

Fix this by using bitwise AND operator '&' instead.

This bug was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
Link: http://lkml.kernel.org/r/20190122233439.GA5868@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/tests/evsel-tp-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -16,7 +16,7 @@ static int perf_evsel__test_field(struct
 		return -1;
 	}
 
-	is_signed = !!(field->flags | FIELD_IS_SIGNED);
+	is_signed = !!(field->flags & FIELD_IS_SIGNED);
 	if (should_be_signed && !is_signed) {
 		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
 			 evsel->name, name, is_signed, should_be_signed);


