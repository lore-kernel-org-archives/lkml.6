Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC28C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9drnlmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8623E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeJYWrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJYWrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:24 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4821620848;
        Thu, 25 Oct 2018 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476868;
        bh=ZKdDmys+nQRBq0sJRabr2Eqdg5UasF/q45lbnaasF0A=;
        h=From:To:Cc:Subject:Date:From;
        b=U9drnlmmAhalGOLAbXIXGda0b1fNk8pWRrYB+AZVB2nwAZV/Cr90i7VkcHfowUNCC
         P3wv0uFxmuBWOX4z5xidrxT9awK77KLSu3fienxEnQW/eiNITClef5kx65ZOcz0Aun
         RnXzl0pfGc5iZ2URi3VNUCxsEt+az/MOD+dJUMtQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/98] perf symbols: Fix memory corruption because of zero length symbols
Date:   Thu, 25 Oct 2018 10:12:46 -0400
Message-Id: <20181025141423.213774-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

[ Upstream commit 331c7cb307971eac38e9470340e10c87855bf4bc ]

Perf top is often crashing at very random locations on powerpc.  After
investigating, I found the crash only happens when sample is of zero
length symbol. Powerpc kernel has many such symbols which does not
contain length details in vmlinux binary and thus start and end
addresses of such symbols are same.

Structure

  struct sym_hist {
        u64                   nr_samples;
        u64                   period;
        struct sym_hist_entry addr[0];
  };

has last member 'addr[]' of size zero. 'addr[]' is an array of addresses
that belongs to one symbol (function). If function consist of 100
instructions, 'addr' points to an array of 100 'struct sym_hist_entry'
elements. For zero length symbol, it points to the *empty* array, i.e.
no members in the array and thus offset 0 is also invalid for such
array.

  static int __symbol__inc_addr_samples(...)
  {
        ...
        offset = addr - sym->start;
        h = annotation__histogram(notes, evidx);
        h->nr_samples++;
        h->addr[offset].nr_samples++;
        h->period += sample->period;
        h->addr[offset].period += sample->period;
        ...
  }

Here, when 'addr' is same as 'sym->start', 'offset' becomes 0, which is
valid for normal symbols but *invalid* for zero length symbols and thus
updating h->addr[offset] causes memory corruption.

Fix this by adding one dummy element for zero length symbols.

Link: https://lkml.org/lkml/2016/10/10/148
Fixes: edee44be5919 ("perf annotate: Don't throw error for zero length symbols")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1508854806-10542-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a38227eb5450..3336cbc6ec48 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -495,9 +495,19 @@ static struct ins *ins__find(const char *name)
 int symbol__alloc_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	const size_t size = symbol__size(sym);
+	size_t size = symbol__size(sym);
 	size_t sizeof_sym_hist;
 
+	/*
+	 * Add buffer of one element for zero length symbol.
+	 * When sample is taken from first instruction of
+	 * zero length symbol, perf still resolves it and
+	 * shows symbol name in perf report and allows to
+	 * annotate it.
+	 */
+	if (size == 0)
+		size = 1;
+
 	/* Check for overflow when calculating sizeof_sym_hist */
 	if (size > (SIZE_MAX - sizeof(struct sym_hist)) / sizeof(u64))
 		return -1;
-- 
2.17.1

