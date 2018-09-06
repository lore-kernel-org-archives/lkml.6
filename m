Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C74FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3AA20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3AA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIFL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:58:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:41289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbeIFL6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:58:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 00:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,337,1531810800"; 
   d="scan'208";a="261165399"
Received: from shlabacsbb03.sh.intel.com (HELO localhost) ([10.239.146.208])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2018 00:24:07 -0700
From:   Zhi Jin <zhi.jin@intel.com>
To:     alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Zhi Jin <zhi.jin@intel.com>
Subject: [PATCH] stm class: increase pos if no free channels found
Date:   Thu,  6 Sep 2018 15:22:10 +0800
Message-Id: <1536218530-18601-1-git-send-email-zhi.jin@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering this case in find_free_channels():

bitmap:
       +------------------+-+-+-+-+-+-+-+-+-+-+
       |     ......       |0|0|0|0|0|0|0|1|0|0|
       +------------------+-+-+-+-+-+-+-+-+-+-+

1. Channel #2 has been occupied, so bit #2 is 1, and the others
   are all 0.
2. Another thread tries to find 4 free channels from #0.
3. In the 1st loop, pos starts from 0, and then it checks if the
   following 4 bits are all 0, but fails, as bit#2 is 1.
4. In the 2st loop, pos is not updated, and still starts from 0,
   so nothing changes against loop #1.
5. Dead loop ...

This patch is to update the pos in step #3 to avoid the issue.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Zhi Jin <zhi.jin@intel.com>
---
 drivers/hwtracing/stm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 10bcb5d73f90..c86a979b9bd7 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -244,6 +244,8 @@ static int find_free_channels(unsigned long *bitmap, unsigned int start,
 			;
 		if (i == width)
 			return pos;
+
+		pos += i;
 	}
 
 	return -1;
-- 
2.7.4

