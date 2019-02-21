Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F471C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5804E20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfBUPu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:50:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:50434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbfBUPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:50:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 21 Feb 2019 07:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="136108129"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 07:50:24 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL v1 3/7] intel_th: Only create useful device nodes
Date:   Thu, 21 Feb 2019 17:50:02 +0200
Message-Id: <20190221155006.76832-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the driver will create a device node for each output port,
with the intent to provide read access to that port's data. However,
only the memory ports are readable this way (msc0, msc1). Other output
ports don't need device nodes, so remove them.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index fc6b7f8b62fb..7c1acc2f801c 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -422,6 +422,7 @@ static const struct intel_th_subdevice {
 	unsigned		nres;
 	unsigned		type;
 	unsigned		otype;
+	bool			mknode;
 	unsigned		scrpd;
 	int			id;
 } intel_th_subdevices[] = {
@@ -456,6 +457,7 @@ static const struct intel_th_subdevice {
 		.name	= "msc",
 		.id	= 0,
 		.type	= INTEL_TH_OUTPUT,
+		.mknode	= true,
 		.otype	= GTH_MSU,
 		.scrpd	= SCRPD_MEM_IS_PRIM_DEST | SCRPD_MSC0_IS_ENABLED,
 	},
@@ -476,6 +478,7 @@ static const struct intel_th_subdevice {
 		.name	= "msc",
 		.id	= 1,
 		.type	= INTEL_TH_OUTPUT,
+		.mknode	= true,
 		.otype	= GTH_MSU,
 		.scrpd	= SCRPD_MEM_IS_PRIM_DEST | SCRPD_MSC1_IS_ENABLED,
 	},
@@ -635,7 +638,8 @@ intel_th_subdevice_alloc(struct intel_th *th,
 	}
 
 	if (subdev->type == INTEL_TH_OUTPUT) {
-		thdev->dev.devt = MKDEV(th->major, th->num_thdevs);
+		if (subdev->mknode)
+			thdev->dev.devt = MKDEV(th->major, th->num_thdevs);
 		thdev->output.type = subdev->otype;
 		thdev->output.port = -1;
 		thdev->output.scratchpad = subdev->scrpd;
-- 
2.20.1

