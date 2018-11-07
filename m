Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA3BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7DE20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7DE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbeKGODO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:03:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38820 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKGODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:03:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA74YXYR033741;
        Tue, 6 Nov 2018 22:34:33 -0600
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA74YXiq083997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 22:34:33 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 22:34:32 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 22:34:33 -0600
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA74YOvm020896;
        Tue, 6 Nov 2018 22:34:30 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <d-gerlach@ti.com>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 2/2] opp: ti-opp-supply: Correct the supply in _get_optimal_vdd_voltage call
Date:   Wed, 7 Nov 2018 10:04:23 +0530
Message-ID: <1541565263-8296-3-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_get_optimal_vdd_voltage call provides new_supply_vbb->u_volt
as the reference voltage while it should be really new_supply_vdd->u_volt.

Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/opp/ti-opp-supply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 29e08a4..3f4fb4d 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -288,7 +288,7 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 	int ret;
 
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
-					  new_supply_vbb->u_volt);
+					  new_supply_vdd->u_volt);
 
 	if (new_supply_vdd->u_volt_min < vdd_uv)
 		new_supply_vdd->u_volt_min = vdd_uv;
-- 
1.9.1

