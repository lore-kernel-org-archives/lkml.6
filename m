Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3937C10F18
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B9D2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfBUNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:50:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:43685 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfBUNuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:50:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 05:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="119707671"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2019 05:50:19 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Zhi Jin <zhi.jin@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 6/7] stm class: Fix an endless loop in channel allocation
Date:   Thu, 21 Feb 2019 15:49:58 +0200
Message-Id: <20190221134959.15121-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221134959.15121-1-alexander.shishkin@linux.intel.com>
References: <20190221134959.15121-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhi Jin <zhi.jin@intel.com>

There is a bug in the channel allocation logic that leads to an endless
loop when looking for a contiguous range of channels in a range with a
mixture of free and occupied channels. For example, opening three
consequtive channels, closing the first two and requesting 4 channels in
a row will trigger this soft lockup. The bug is that the search loop
forgets to skip over the range once it detects that one channel in that
range is occupied.

Restore the original intent to the logic by fixing the omission.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Zhi Jin <zhi.jin@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 93ce3aa740a9..c80b064224f6 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -244,6 +244,9 @@ static int find_free_channels(unsigned long *bitmap, unsigned int start,
 			;
 		if (i == width)
 			return pos;
+
+		/* step over [pos..pos+i) to continue search */
+		pos += i;
 	}
 
 	return -1;
-- 
2.20.1

