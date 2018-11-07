Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BBF20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BBF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbeKGODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:03:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59424 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKGODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:03:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA74YUb0130889;
        Tue, 6 Nov 2018 22:34:30 -0600
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA74YUEk083956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 22:34:30 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 22:34:30 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 22:34:30 -0600
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA74YOvl020896;
        Tue, 6 Nov 2018 22:34:28 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <d-gerlach@ti.com>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 1/2] opp: ti-opp-supply: Dynamically update u_volt_min
Date:   Wed, 7 Nov 2018 10:04:22 +0530
Message-ID: <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
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

The voltage range (min, max) provided in the device tree is from
the data manual and is pretty big, catering to a wide range of devices.
On a i2c read/write failure the regulator_set_voltage_triplet function
falls back to set voltage between min and max. The min value from Device
Tree can be lesser than the optimal value and in that case that can lead
to a hang or crash. Hence set the u_volt_min dynamically to the optimal
voltage value.

Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/opp/ti-opp-supply.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 9e5a9a3..29e08a4 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -290,6 +290,9 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
 	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
 					  new_supply_vbb->u_volt);
 
+	if (new_supply_vdd->u_volt_min < vdd_uv)
+		new_supply_vdd->u_volt_min = vdd_uv;
+
 	/* Scaling up? Scale voltage before frequency */
 	if (freq > old_freq) {
 		ret = _opp_set_voltage(dev, new_supply_vdd, vdd_uv, vdd_reg,
-- 
1.9.1

