Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E63BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5797520882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRoJ+O/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5797520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIOFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:54:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37494 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeIOFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:54:19 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8F0bSur030654;
        Fri, 14 Sep 2018 19:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536971848;
        bh=U/URxLYk+u/unXsblN+t/eH+5kYwXM1lAsKzPedS5Ho=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nRoJ+O/GXT3mzr4/zEp9L/B9UeGQb13BDDQEC3BnBaAHsvRMeqzG8PDczZWieVwvH
         hFhzghnafEXZ8ogIoYRSM4MksG/mZkh4mqqIl/81tYdtGYfb0/ZYX49hTuxBmxhrjQ
         dI5iu+AsDFuAQKjx/jVILrFH8c8sTbD9UoSPFLmY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bSkv032390;
        Fri, 14 Sep 2018 19:37:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 14
 Sep 2018 19:37:28 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 14 Sep 2018 19:37:28 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bSVV010482;
        Fri, 14 Sep 2018 19:37:28 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8F0bSx13355;
        Fri, 14 Sep 2018 19:37:28 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 5/5] remoteproc/wkup_m3: Set deny_sysfs_ops flag
Date:   Fri, 14 Sep 2018 19:37:25 -0500
Message-ID: <20180915003725.17549-6-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180915003725.17549-1-s-anna@ti.com>
References: <20180915003725.17549-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wakeup M3 remote processor is controlled by the wkup_m3_ipc
client driver, so set the newly introduced 'deny_sysfs_ops' flag
to not allow any overriding of the remoteproc firmware or state
from userspace.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/wkup_m3_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 1ada0e51fef6..327757fd4d8f 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -168,6 +168,7 @@ static int wkup_m3_rproc_probe(struct platform_device *pdev)
 	}
 
 	rproc->auto_boot = false;
+	rproc->deny_sysfs_ops = true;
 
 	wkupm3 = rproc->priv;
 	wkupm3->rproc = rproc;
-- 
2.18.0

