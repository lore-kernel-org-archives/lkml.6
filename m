Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24340C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD1E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD1E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeGLOU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:20:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:62688 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbeGLOU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:20:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 07:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="57137149"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2018 07:11:10 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/3] mei: use correct type for counter variable in for loops
Date:   Thu, 12 Jul 2018 17:10:09 +0300
Message-Id: <20180712141010.11277-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180712141010.11277-1-tomas.winkler@intel.com>
References: <20180712141010.11277-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In for loops use same type for counter variable
as has the limiting variable.

drivers/misc/mei/bus-fixup.c:489:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
drivers/misc/mei/hw-txe.c:725:13: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
drivers/misc/mei/hw-txe.c:744:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 2 +-
 drivers/misc/mei/hw-me.c     | 2 +-
 drivers/misc/mei/hw-txe.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index e22fc9a768d9..a6f41f96f2a1 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -484,7 +484,7 @@ void mei_cl_bus_dev_fixup(struct mei_cl_device *cldev)
 {
 	struct mei_fixup *f;
 	const uuid_le *uuid = mei_me_cl_uuid(cldev->me_cl);
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(mei_fixups); i++) {
 
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index a12b464bc0b4..5bbea13ab171 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -530,9 +530,9 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 {
 	unsigned long rem;
 	unsigned long length = header->length;
+	unsigned long i;
 	u32 *reg_buf = (u32 *)buf;
 	u32 dw_cnt;
-	int i;
 	int empty_slots;
 
 	dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM(header));
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 4c1acf68089e..a5e551ffb2dd 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -709,10 +709,10 @@ static int mei_txe_write(struct mei_device *dev,
 	struct mei_txe_hw *hw = to_txe_hw(dev);
 	unsigned long rem;
 	unsigned long length;
+	unsigned long i;
 	u32 slots = dev->hbuf_depth;
 	u32 *reg_buf = (u32 *)buf;
 	u32 dw_cnt;
-	int i;
 
 	if (WARN_ON(!header || !buf))
 		return -EINVAL;
-- 
2.14.4

