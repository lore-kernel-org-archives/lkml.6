Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E83C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37610222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895900;
	bh=S4o7OIj/57ayV9M8bZ+wqRjqRphTcrD61lu22oS85qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQfIk9axXM0Ihw+42SgO4+RjSj77wLBOa7gh9/DZTmLL6JkbZ0Htq9wGyIh2NhpO+
	 Cj20KR+rS2pBudu8qabytqUFYKk0LcYIRFRPfsglMwM+NxtzUb3Ikln8YhBjiu1997
	 04mP8BEX2Q/GbksxSXrLCoBoRqEP3FfIsa4GjSVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfBKOiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfBKOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FFB222A2;
        Mon, 11 Feb 2019 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895895;
        bh=S4o7OIj/57ayV9M8bZ+wqRjqRphTcrD61lu22oS85qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZfA/TsP1mUFE6hxrWjrcxseHCB4DgTs8iR0bBeDrr1z67ZOgp4oPXyJkVLrqhadE
         fUmMWkEzzE/FaqB56QE44/QwW0i83fGg+rdhaFLOSKqhLXE+9BR1iQE95l4/f9P3sT
         DewKMa25Iwrb4uSphd91affzQaWU4oZcZv6XkKek=
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
Subject: [PATCH 4.20 347/352] perf tests evsel-tp-sched: Fix bitwise operator
Date:   Mon, 11 Feb 2019 15:19:34 +0100
Message-Id: <20190211141909.252984338@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -17,7 +17,7 @@ static int perf_evsel__test_field(struct
 		return -1;
 	}
 
-	is_signed = !!(field->flags | TEP_FIELD_IS_SIGNED);
+	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
 	if (should_be_signed && !is_signed) {
 		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
 			 evsel->name, name, is_signed, should_be_signed);


