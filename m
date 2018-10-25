Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11A120847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcKqpKZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11A120847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJYTnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYTnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:14 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EAD2083E;
        Thu, 25 Oct 2018 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465856;
        bh=FzNQZ4COHtBsMro01dySpWNCJE2yQk8T/pKd1TQEWAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcKqpKZy172dLQ6MkG1jq1MQg5KOMta1YKk7EE2ZxGXKczlPr4bXYga1R5z8GFfNu
         wgcslw3GJ78uxK7cTAX5NRgITZVEfZDVwYnM23hBcf/8dFxOufSnTsxGdRNV62Qvq3
         KG9/7pFqHjoXjYosa0kMcrscnDTEnywjwbyIm1J4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        David Tolnay <dtolnay@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Hemant Kumar <hemant@linux.vnet.ibm.com>,
        Li Bin <huawei.libin@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>, zhangmengting@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/37] perf symbols: Set PLT entry/header sizes properly on Sparc
Date:   Thu, 25 Oct 2018 08:09:58 -0300
Message-Id: <20181025111031.3440-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

Using the sh_entsize for both values isn't correct.  It happens to be
correct on x86...

For both 32-bit and 64-bit sparc, there are four PLT entries in the PLT
section.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexis Berlemont <alexis.berlemont@gmail.com>
Cc: David Tolnay <dtolnay@gmail.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: zhangmengting@huawei.com
Fixes: b2f7605076d6 ("perf symbols: Fix plt entry calculation for ARM and AARCH64")
Link: http://lkml.kernel.org/r/20181017.120859.2268840244308635255.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..6e70cc00c161 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -324,7 +324,17 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			plt_entry_size = 16;
 			break;
 
-		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/sparc/xtensa need to be checked */
+		case EM_SPARC:
+			plt_header_size = 48;
+			plt_entry_size = 12;
+			break;
+
+		case EM_SPARCV9:
+			plt_header_size = 128;
+			plt_entry_size = 32;
+			break;
+
+		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
 			plt_header_size = shdr_plt.sh_entsize;
 			plt_entry_size = shdr_plt.sh_entsize;
 			break;
-- 
2.14.4

