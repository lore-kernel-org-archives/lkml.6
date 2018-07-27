Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ACAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B1C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LztS+kAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B1C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeG0CfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:35:04 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57248 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbeG0CfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:35:04 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6R1Fexx045202;
        Thu, 26 Jul 2018 20:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532654140;
        bh=j72lq73NtZ6WcJqi6LjnMrZkNgEnY48S/HD0ZL4YlKw=;
        h=From:To:CC:Subject:Date;
        b=LztS+kALZeyGqivxPImbiSDocsfPDFB6Ym45Y1/uRUWuTqO8Yo4aQ0ItCkJexZ2ua
         KU3z0E6YU7HO+E/OtwS/gtHBPaOAxU4rz5h4CCCboIowMOU5WfdcmBOKp/EXhOpNyY
         2BqDTj/DvlEMfDVkea/3TsjivkhrOZI+Nw5n7k3g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6R1Fedd026904;
        Thu, 26 Jul 2018 20:15:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 26
 Jul 2018 20:15:39 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 26 Jul 2018 20:15:39 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6R1FdQ0000696;
        Thu, 26 Jul 2018 20:15:39 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w6R1Fdx08708;
        Thu, 26 Jul 2018 20:15:39 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH] remoteproc: Reset table_ptr in rproc_start() failure paths
Date:   Thu, 26 Jul 2018 20:15:35 -0500
Message-ID: <20180727011535.21729-1-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unwind the modified table_ptr and restore it to the local copy
upon any subsequent failures in the rproc_start() function. This
keeps the function to remain balanced on failures without the need
to balance any modified variables elsewhere.

While at this, do some minor cleanup of the extra lines between
the failure labels as well.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index eadff6ce2f7f..afef2d491c5b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -953,7 +953,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	if (ret) {
 		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
 			rproc->name, ret);
-		return ret;
+		goto reset_table_ptr;
 	}
 
 	/* power up the remote processor */
@@ -979,10 +979,11 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 
 stop_rproc:
 	rproc->ops->stop(rproc);
-
 unprepare_subdevices:
 	rproc_unprepare_subdevices(rproc);
-
+reset_table_ptr:
+	if (loaded_table)
+		rproc->table_ptr = rproc->cached_table;
 	return ret;
 }
 
-- 
2.18.0

