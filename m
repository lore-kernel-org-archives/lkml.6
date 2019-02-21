Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4025820823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfBUPuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:50:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:50434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbfBUPue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:50:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 21 Feb 2019 07:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="136108178"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 07:50:32 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [GIT PULL v1 7/7] stm class: Prevent division by zero
Date:   Thu, 21 Feb 2019 17:50:06 +0200
Message-Id: <20190221155006.76832-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using STP_POLICY_ID_SET ioctl command with dummy_stm device, or any STM
device that supplies zero mmio channel size, will trigger a division by
zero bug in the kernel.

Prevent this by disallowing channel widths other than 1 for such devices.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
CC: stable@vger.kernel.org # v4.4+
---
 drivers/hwtracing/stm/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index c80b064224f6..c7ba8acfd4d5 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -735,7 +735,7 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	struct stm_device *stm = stmf->stm;
 	struct stp_policy_id *id;
 	char *ids[] = { NULL, NULL };
-	int ret = -EINVAL;
+	int ret = -EINVAL, wlimit = 1;
 	u32 size;
 
 	if (stmf->output.nr_chans)
@@ -763,8 +763,10 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
 
-	if (id->width < 1 ||
-	    id->width > PAGE_SIZE / stm->data->sw_mmiosz)
+	if (stm->data->sw_mmiosz)
+		wlimit = PAGE_SIZE / stm->data->sw_mmiosz;
+
+	if (id->width < 1 || id->width > wlimit)
 		goto err_free;
 
 	ids[0] = id->id;
-- 
2.20.1

