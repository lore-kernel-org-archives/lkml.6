Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E80C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC17820835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qrfz3ilx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC17820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIBRTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:54 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbeIBRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4H6aMZ3dEMPKUA9mwxN0sMWh7PNHD6J0V8eCqfP+v4=;
 b=Qrfz3ilxNg8jyrQ0IkDRgRY1USuUUyftLqEMuI4vuCffjhCiTVT+1ib9iospXu2ORqUef0FEQ24wuBlsCfgalrBY6pZyiX5WmzYaBe63UFcOAwVQ9bV+DMrbYb0JlDB91NXiWAUOBtrfoCdaPznuA82B2vD0CZUvpnFPGnWKy2g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 034/131] iwlwifi: pcie: don't access periphery
 registers when not available
Thread-Topic: [PATCH AUTOSEL 4.18 034/131] iwlwifi: pcie: don't access
 periphery registers when not available
Thread-Index: AQHUQr1emQUV5Sd6vES+UyC2/fNGeA==
Date:   Sun, 2 Sep 2018 13:03:40 +0000
Message-ID: <20180902064601.183036-34-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:ZOPJ4+vtPv+9MXqQXth59kDWnsaGiH3eGdLaOhNptXX7hJxIjDyOZPdQQjKNrWlYZdXUpLrhQw6t3eBunmiFx/bnBv5zo0IvRJbW2ndvvPqMKO/FtjaEbeJka3nYTfObwOob2pMqm17z99MctObteL13XOiQw7r31v80R8nxqE+agtZZOxNdn0gYcNrZQ0CMNAV2D3gia/BogNBtm6EZ99RB0gQcAwlcgnnRWnWgB+0FTFpBPNWWvyElo/47O/NqcogF/K3OAAVnS/9qS91MmtcJ9p5JddO5r114MeV4Z77xrA9LUDSvgpa0Yk4iPa8+6pPGJd3H36D26Jo08VuT2hvXvgB38bBplgihLmgkY6DDJmbCB5xdalcLJCxt63aRJrOVsdRERF8I1Vq2lx5T1qdh0QEQWqp6DKAEy8hLSUtWHXSLp3qO80Ez9c8TFtm/WqUSdfaK86GKG7+L086qFw==;5:YY1QBOUa5Ks/xGqLitUwsdXZe/XE7Ht0nqSapHimrmX/jXZMxJQiZOCjM9RLjKxCU4OiWH1osbSUmfTaDS0O0ydHp69MooTIWl1fKZqDSE6nCrgFemN4kLPMypMFgGP9BfWcCD2Nin5GRy06tJBLS6RJklV7BHp6pZ+kFUp/+Pc=;7:8JZ2cdA7xLDZC5EyjbWq8rv8+6U7XW3z2tENqf1rSztipVIvEFKl4fweQtyyK+LSacJxPH0LsLSU2PB3CYyN+0pjy4oF4V7gDzPKMmT7hqHqskZoWaWobng9yxRL63RzAkym2QLpsfdrGj0Jtwgv44+vjGrBhceLGrP8/4rWUkIr7+gefOW18PTAR4/WycoB+qmCDw9PhLOR4nrsNGyLFTmtCvQ0ifvhKCfyzo2wHVVHvEE2YHzgwX3XskIhzsns
x-ms-office365-filtering-correlation-id: 8e5a55c2-6dbd-41dc-43e6-08d610d49199
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135A28C4492667BC09A1A36FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oAw1LO1wj9MNL/2wsLlavng6S8kF2WnJSnNAs9SoS9nZ8wvrwE8aZxrkyGoRb//emiNZS6+/qniUdeJxQ3KQdh1Zxn8oKMYc941FYTZOq1NA14sw9xDx5Tu9IbSWNjztaClaHLlsP2N9FN1iLT4+FlmeiaqOEMrzLIdCJTrbdoy+4mpXbLoXsB3r12jyHvxIBuHMslU7pLMn8pB+Ih1xw+tB0Z1mmwsVVbsDF7KQjao4/M2UQQCdjJ/s98X2SPNYEG1xc5QZCWTkwJpKy93/QMeoRHG7Ggn/LmXo2UQVGAilafrurX1HglOliDZ/O9Qlf6CmewhYMQ9qotTrONKdzLMT5SEtlQFovRlNqkPcjWE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5a55c2-6dbd-41dc-43e6-08d610d49199
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:40.3226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit f98ad635c097c29339b7a7d6947173000485893d ]

The periphery can't be accessed before we set the
INIT_DONE bit which initializes the device.

A previous patch added a reconfiguration of the MSI-X
tables upon resume, but at that point in the flow,
INIT_DONE wasn't set. Since the reconfiguration of the
MSI-X tables require periphery access, it failed.

The difference between WoWLAN and without WoWLAN is that
in WoWLAN, iwl_trans_pcie_d3_suspend clears the INIT_DONE
without clearing the STATUS_DEVICE_ENABLED bit in the
software status. Because of that, the resume code thinks
that the device is enabled, but the INIT_DONE bit has been
cleared.

To fix this, don't reconfigure the MSI-X tables in case
WoWLAN is enabled. It will be done in
iwl_trans_pcie_d3_resume anyway.

Fixes: 52848a79b9d2 ("iwlwifi: pcie: reconfigure MSI-X HW on resume")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  4 ++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 24 +++++++++----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wi=
reless/intel/iwlwifi/pcie/drv.c
index 8520523b91b4..d8d8443c1c93 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1003,6 +1003,10 @@ static int iwl_pci_resume(struct device *device)
 	if (!trans->op_mode)
 		return 0;
=20
+	/* In WOWLAN, let iwl_trans_pcie_d3_resume do the rest of the work */
+	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+		return 0;
+
 	/* reconfigure the MSI-X mapping to get the correct IRQ for rfkill */
 	iwl_pcie_conf_msix_hw(trans_pcie);
=20
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/=
wireless/intel/iwlwifi/pcie/trans.c
index 7229991ae70d..a2a98087eb41 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1539,18 +1539,6 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans=
 *trans,
=20
 	iwl_pcie_enable_rx_wake(trans, true);
=20
-	/*
-	 * Reconfigure IVAR table in case of MSIX or reset ict table in
-	 * MSI mode since HW reset erased it.
-	 * Also enables interrupts - none will happen as
-	 * the device doesn't know we're waking it up, only when
-	 * the opmode actually tells it after this call.
-	 */
-	iwl_pcie_conf_msix_hw(trans_pcie);
-	if (!trans_pcie->msix_enabled)
-		iwl_pcie_reset_ict(trans);
-	iwl_enable_interrupts(trans);
-
 	iwl_set_bit(trans, CSR_GP_CNTRL,
 		    BIT(trans->cfg->csr->flag_mac_access_req));
 	iwl_set_bit(trans, CSR_GP_CNTRL,
@@ -1568,6 +1556,18 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans=
 *trans,
 		return ret;
 	}
=20
+	/*
+	 * Reconfigure IVAR table in case of MSIX or reset ict table in
+	 * MSI mode since HW reset erased it.
+	 * Also enables interrupts - none will happen as
+	 * the device doesn't know we're waking it up, only when
+	 * the opmode actually tells it after this call.
+	 */
+	iwl_pcie_conf_msix_hw(trans_pcie);
+	if (!trans_pcie->msix_enabled)
+		iwl_pcie_reset_ict(trans);
+	iwl_enable_interrupts(trans);
+
 	iwl_pcie_set_pwr(trans, false);
=20
 	if (!reset) {
--=20
2.17.1
