Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FEC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881CA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfBTODC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:03:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:28917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfBTODB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:03:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="321900369"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga005.fm.intel.com with ESMTP; 20 Feb 2019 06:02:59 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc] mei: hbm: clean the feature flags on link reset
Date:   Wed, 20 Feb 2019 16:55:37 +0200
Message-Id: <20190220145537.361-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The list of supported functions can be altered upon link reset,
clean the flags to allow correct selections of supported
features.

Cc: <stable@vger.kernel.org> v4.19+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hbm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 8f7616557c97..e6207f614816 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1029,29 +1029,36 @@ static void mei_hbm_config_features(struct mei_device *dev)
 	    dev->version.minor_version >= HBM_MINOR_VERSION_PGI)
 		dev->hbm_f_pg_supported = 1;
 
+	dev->hbm_f_dc_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_DC)
 		dev->hbm_f_dc_supported = 1;
 
+	dev->hbm_f_ie_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_IE)
 		dev->hbm_f_ie_supported = 1;
 
 	/* disconnect on connect timeout instead of link reset */
+	dev->hbm_f_dot_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_DOT)
 		dev->hbm_f_dot_supported = 1;
 
 	/* Notification Event Support */
+	dev->hbm_f_ev_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_EV)
 		dev->hbm_f_ev_supported = 1;
 
 	/* Fixed Address Client Support */
+	dev->hbm_f_fa_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_FA)
 		dev->hbm_f_fa_supported = 1;
 
 	/* OS ver message Support */
+	dev->hbm_f_os_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_OS)
 		dev->hbm_f_os_supported = 1;
 
 	/* DMA Ring Support */
+	dev->hbm_f_dr_supported = 0;
 	if (dev->version.major_version > HBM_MAJOR_VERSION_DR ||
 	    (dev->version.major_version == HBM_MAJOR_VERSION_DR &&
 	     dev->version.minor_version >= HBM_MINOR_VERSION_DR))
-- 
2.20.1

