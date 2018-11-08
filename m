Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0292ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B319021019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXFBCarS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B319021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeKIHde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeKIHdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:33 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108042089A;
        Thu,  8 Nov 2018 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714166;
        bh=4StZPuTY25sjeQD2fl+WcDz6NEvez69q1QpyRDD+KW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXFBCarSU9C0yXMbSBlohWMEIUMQI5t/Xrn/k6B75QWYEgX1BwCQOpJTUtZMG/Tlv
         f174F+oexfJLv8oMPZbvlWJE9qnq/OVF0O/8eHgJiMug2A411wi/oQI9zynIKlDnm/
         C5fV5Qx96WTHxI9A63CyWI3QXh5HaqucHA5Pnd40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 077/144] perf tools: Fix segfault for symbol annotation on TUI
Date:   Thu,  8 Nov 2018 13:50:48 -0800
Message-Id: <20181108215100.870202054@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 813ccd15452ed34e97aa526ffc70d6d8e6c466c5 ]

Currently the symbol structure is allocated with symbol_conf.priv_size
to carry sideband information like annotation, map browser on TUI and
sort-by-name tree node.  So retrieving these information from symbol
needs to care about the details of such placement.

However the annotation code just assumes that the symbol is placed after
the struct annotation.  But actually there's other info between them.
So accessing those struct will lead to an undefined behavior (usually a
crash) after they write their info to the same location.

To reproduce the problem, please follow the steps below:

  1. run perf report (TUI of course) with -v option
  2. open map browser (by pressing right arrow key for any entry)
  3. search any function (by pressing '/' key and input whatever..)
  4. return to the hist browser (by pressing 'q' or left arrow key)
  5. open annotation window for the same entry (by pressing 'a' key)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/1421234288-22758-1-git-send-email-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 112d6e268150..dfa6c4c36b3e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -115,11 +115,6 @@ struct annotation {
 	struct annotated_source *src;
 };
 
-struct sannotation {
-	struct annotation annotation;
-	struct symbol	  symbol;
-};
-
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
 	return (((void *)&notes->src->histograms) +
@@ -128,8 +123,7 @@ static inline struct sym_hist *annotation__histogram(struct annotation *notes, i
 
 static inline struct annotation *symbol__annotation(struct symbol *sym)
 {
-	struct sannotation *a = container_of(sym, struct sannotation, symbol);
-	return &a->annotation;
+	return (void *)sym - symbol_conf.priv_size;
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, int evidx);
-- 
2.17.1



