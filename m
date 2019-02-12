Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2309021B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfBLCNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:13:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:26869 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfBLCMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:12:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 18:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="146057852"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 18:12:52 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/6] x86, mm: remove check in save_mr
Date:   Tue, 12 Feb 2019 10:12:11 +0800
Message-Id: <20190212021215.13247-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190212021215.13247-1-richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check has been validated before calling save_mr. It is not
necessary to do this again.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1b980b70911a..6fb84be79c7c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -259,14 +259,12 @@ static int __meminit save_mr(struct map_range *mr, int nr_range,
 			     unsigned long start_pfn, unsigned long end_pfn,
 			     unsigned long page_size_mask)
 {
-	if (start_pfn < end_pfn) {
-		if (nr_range >= NR_RANGE_MR)
-			panic("run out of range for init_memory_mapping\n");
-		mr[nr_range].start = start_pfn<<PAGE_SHIFT;
-		mr[nr_range].end   = end_pfn<<PAGE_SHIFT;
-		mr[nr_range].page_size_mask = page_size_mask;
-		nr_range++;
-	}
+	if (nr_range >= NR_RANGE_MR)
+		panic("run out of range for init_memory_mapping\n");
+	mr[nr_range].start = start_pfn<<PAGE_SHIFT;
+	mr[nr_range].end   = end_pfn<<PAGE_SHIFT;
+	mr[nr_range].page_size_mask = page_size_mask;
+	nr_range++;
 
 	return nr_range;
 }
-- 
2.19.1

