Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40DCECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5568821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EH9vTiOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5568821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbeITI32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:28 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387928AbeITI32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaWDHGbq/rkbjUZQvfM5XJSEuUhMACOZOPRWjF12u6c=;
 b=EH9vTiOkoCXk1VHfhX6ysxm6Hy5jWeLitdNku+NCv+nlUav3Fx63TvL4razEOSqMbmw14BCQQ4yYbEhOncNOxMvu+KvGgDSGMffAmIk1qpOO9zZOS7eKGBvVFGyVd1c0BMbVLQMCT7kZNUDdY5d8p0G91He9D6EohbEE5MW2jZQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/56] ice: Fix a few null pointer dereference
 issues
Thread-Topic: [PATCH AUTOSEL 4.18 34/56] ice: Fix a few null pointer
 dereference issues
Thread-Index: AQHUUIxSiYpUXl5eqEGaGZAJevQ9hA==
Date:   Thu, 20 Sep 2018 02:47:51 +0000
Message-ID: <20180920024716.58490-34-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:62dI+1rMupfzJMmvDLvzVpwBAlnU8Gc6oteN/Q5Se+p+Cg+kJ1Wt6mph4WlC/yP6eA/M+t9ywKhHlI0Gq6f0oVNlGJgqMFM2txSkIb9F9nZGuGy81fWePAZOSAGCKds+3npRkcL2jwKRrz1wty6nP8PXqvGybqrfwxUtX0nmKXbUWHJ70Pfk8yPFapMyTJRcOLdI+qFq1oX83+Upo+xXVGaVkzBJpmtldOYRzYKf9oHtC9onF3/fJouJhmiLaCktJWwmZ/gGosAPKlavCRCUqgeGQFgA+c+hGMrS+Leg2MmGCguzNxIw+WzFxUdOk77K70SROqaD4XJ8IxBTs903+Pe7sXkQXv7YHDU6uhWEEpiaACK+N9qLa51YuIqypK/s/UgmxCoRNgYWr9m6lId8F/Uc5hQHO14VA0ytA9EHYK06y+MvFUofh/mPC2G1IsPeOq45vILBp2FX2LAzA/R4LA==;5:1steQ9ZgJ2npYaFcAdXFFTD7rVRBhKcgO3g0PNrb2TmvIaZ1Zw8JDvj4KQKW+BP9wr4dycVoVjcKRsEzvB0JvPZ4SY357XJwFnZopuztMWQGkxRUkutMjQ8KSfWKUc0c3oII5dA5VDR1oMlkDOcS9YoNuRTWv+cR5/kXVW6N9BE=;7:UCpQf19hDHnEKzjFNaBI1Vb6Un2vwlEUiXecCvLZX76lcJRhVTeBVSzPRqYfs46GQagnnneslYKMwf6hx+cJccsuo8urnNkQRDeFRUOtXGXTiVvINAy1j0kW636pGxw6ixvKA6oP/Aw+hsWo5HHHESw3tPrHZbfVp+TmhsQ4684p8MG5wEJwfnaLGq70zgtcMRsTkpsyPaVGZH3K3PSSSuuKMV7i8M6aX697D6yW+p0GVUkrSLk99Rovh+ALlsxx
x-ms-office365-filtering-correlation-id: e187626c-01f5-408e-c0cd-08d61ea386f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165FCB912DD2B685951A174FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AndXh95P3yBzBEz8fxF10vOc3kTJ5R6QfyOnI1WLI7OFXvdA5fvHIkDQcNGU+6ziqmpFEQcOvoOOMHruO4nROLqRni8uz3Yf4tlUubG3DurGWgAg2SN/rF/DqoHSxmkX+EiHQtsFGuwVfMDxGJsIjvoUb/hly5uddisnINgHAiSjtgQTXdGTU7Cp8DSeQA1tW4pd8CL8z+n0Wj5TuHDdzUv+ai9y7K90kI7sgFDv0tGpEIEyLkf5MuNesYLMI6uw6ETpn8tCKA1OLfadLadzoWYPUN5jv9iCub9vs6C3G9pTlaPgrM1RQB/PtCwXVUBbBMcAucMCJSS55GfjRapiFjrGuJ5QtJyAF/AKaxn7ZTA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e187626c-01f5-408e-c0cd-08d61ea386f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:51.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit c7f2c42b80ed6009f44e355aefc1e40db9485a9d ]

1) When ice_ena_msix_range() fails to reserve vectors, a devm_kfree()
   warning was seen in the error flow path. So check pf->irq_tracker
   before use in ice_clear_interrupt_scheme().

2) In ice_vsi_cfg(), check vsi->netdev before use.

3) In ice_get_link_status, check link_up before use.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c   | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethe=
rnet/intel/ice/ice_common.c
index d5300b606d5a..ebd701ac9428 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1483,7 +1483,7 @@ enum ice_status ice_get_link_status(struct ice_port_i=
nfo *pi, bool *link_up)
 	struct ice_phy_info *phy_info;
 	enum ice_status status =3D 0;
=20
-	if (!pi)
+	if (!pi || !link_up)
 		return ICE_ERR_PARAM;
=20
 	phy_info =3D &pi->phy;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethern=
et/intel/ice/ice_main.c
index 5458c3ae10c5..aaaa1e2a7df6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3260,8 +3260,10 @@ static void ice_clear_interrupt_scheme(struct ice_pf=
 *pf)
 	if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags))
 		ice_dis_msix(pf);
=20
-	devm_kfree(&pf->pdev->dev, pf->irq_tracker);
-	pf->irq_tracker =3D NULL;
+	if (pf->irq_tracker) {
+		devm_kfree(&pf->pdev->dev, pf->irq_tracker);
+		pf->irq_tracker =3D NULL;
+	}
 }
=20
 /**
@@ -4115,11 +4117,12 @@ static int ice_vsi_cfg(struct ice_vsi *vsi)
 {
 	int err;
=20
-	ice_set_rx_mode(vsi->netdev);
-
-	err =3D ice_restore_vlan(vsi);
-	if (err)
-		return err;
+	if (vsi->netdev) {
+		ice_set_rx_mode(vsi->netdev);
+		err =3D ice_restore_vlan(vsi);
+		if (err)
+			return err;
+	}
=20
 	err =3D ice_vsi_cfg_txqs(vsi);
 	if (!err)
--=20
2.17.1
