Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879CDECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BA421521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AXaHjpH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BA421521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbeITI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:54 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:41855
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387726AbeITI2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiMO0XjD4kHytGHf/YOZWNBv/ivkE+Sa/m0qPvxnnp4=;
 b=AXaHjpH1jra9WGlWmsiq9BS9ipco5xyViKWzfpke1IGsZdNIcOR3yEqlEfHz53jLJuvj+eXWUse1W6lt3V1HEVQJppJCiZZzFFl9u8jOsesOLpzQfkcCBOw2DGzKyrPj0udyEKqBWKJY2gHt0m/pJBhuoYkz2wrGMgEeTLX+xuA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 30/56] ice: Fix bugs in control queue processing
Thread-Topic: [PATCH AUTOSEL 4.18 30/56] ice: Fix bugs in control queue
 processing
Thread-Index: AQHUUIxQpWizZQZn406I/HCosMOU3Q==
Date:   Thu, 20 Sep 2018 02:47:48 +0000
Message-ID: <20180920024716.58490-30-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:1Z0GR7GiRozHke8boZTdf5v29YgSFl544txKQTZnSsydnJLn/xBEKbzDn9MUV1zv7yYIDrrzrO+H0fnn/8xtE2hsfrQMmgS6dzFw5gQxAHpWkFiLoZXNmbzNPJymnzTWGq82EmmOnTxjxTecunasUOTca4bBtz9sQg4ayClZtCRnijZXl7tk/zPAbpCrl0W5p1itOXChDNuvlVBwOsLpKhjkCgiBtnMEWK6ipIOV/viF9KrLqDfrnzynyMw96KvCszGfa4B12DSiiDIsz+FPSKyBBRwcU1ZhWmqvw+uiqNcM45Lr8O0D9TIqkN+TGQXm3S8J5u111jg+emh1CH/fBlkn1rIWR8hC7nA/kDDKMWz+936UwGrSaMdiPG4eGKD5/iHemjRUoh2VQ1O1OBHjgl19NBf+xwScHLZEQbI96unbS+DO5sNe2RRL/XSxYewxcocXAn+uNvUUxh1yzuzfyw==;5:Sa68oryuLpfTq/UkrmLjTpZ6ZK4azcf0qvtPQxe59q2TKf+AApFCREiNh2TWWWTN63pH3tw3QREyiCq21TOnA9dsMjKrUofWBaGLNDYD47WLMJ1XA9S8sZy+dV2C7kSu9a6iGrf9SOZZwodPD7JWWD1vfMzDtGvADA88cxaAsYE=;7:jPD5UwMjyJPNFT5y0YTmRLoqJ/p6tfrNAyVdkKAuIIzrGlyePZOqc53ZwYas4R5qC18VhqnaM7ftBaZJR1M4oNRLebZBvgZzPUxU9KBWfW9jTD+vznf/emkqZQB1Nv32CxbaKqCaKizOniQhLRyPSmjLwaqxqC4vyz6kKKXxxLQJYzB7ZPQqrWiTXarSgmqL4EQxVA8JF8+vT/B7P9lW20HhJNfR25FSkB4tqt+4aW9AXonxd9dc7hCf2L3lry7b
x-ms-office365-filtering-correlation-id: 9b2d323e-294e-48b4-8914-08d61ea373ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01650A47AE3B4F06001161BAFB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tm2kPf38WB/yESvszxgzpZBL414KiEdDq5uSK5L4nw88csp5DyGIgFFsRljsGF1gRCyaSadgp9w3fpiH3vkGlY0BdskmRBKp9RIkKYssZEo/tpxU8ELAva0unoT3h7BaSzvm6r9vSrvAAZt23O9ZgsoaARyYLOBmP5ekf2mjwLACVXhztrFIa/49ihD+iHLr6qHT4lYj8cy6OpimgOHsO+8WA6+O07wtdGLxjrCzxgRZHyRwnj38d8X18ifGZgo3b7cMNeNNTWyeHJQ+hHj+3Rf1etZEYeHx/UOcwz1ZpKRmVqaO+I7mtAE5a3GO4o5VTXKGJXG3wUayEq9MtuK/dCWTX9z/05CAuBTNJwwdjDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2d323e-294e-48b4-8914-08d61ea373ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:48.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit 3d6b640efcc1b07709b42dd2e9609401c6f88633 ]

This patch is a consolidation of multiple bug fixes for control queue
processing.

1)  In ice_clean_adminq_subtask() remove unnecessary reads/writes to
    registers. The bits PFINT_FW_CTL, PFINT_MBX_CTL and PFINT_SB_CTL
    are not set when an interrupt arrives, which means that clearing them
    again can be omitted.

2)  Get an accurate value in "pending" by re-reading the control queue
    head register from the hardware.

3)  Fix a corner case involving lost control queue messages by checking
    for new control messages (using ice_ctrlq_pending) before exiting the
    cleanup routine.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c |  5 +++-
 drivers/net/ethernet/intel/ice/ice_main.c     | 26 ++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/et=
hernet/intel/ice/ice_controlq.c
index c064416080e7..62be72fdc8f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1065,8 +1065,11 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_=
q_info *cq,
=20
 clean_rq_elem_out:
 	/* Set pending if needed, unlock and return */
-	if (pending)
+	if (pending) {
+		/* re-read HW head to calculate actual pending messages */
+		ntu =3D (u16)(rd32(hw, cq->rq.head) & cq->rq.head_mask);
 		*pending =3D (u16)((ntc > ntu ? cq->rq.count : 0) + (ntu - ntc));
+	}
 clean_rq_elem_err:
 	mutex_unlock(&cq->rq_lock);
=20
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethern=
et/intel/ice/ice_main.c
index 186e764a469a..46b35b78e8aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -916,6 +916,21 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum i=
ce_ctl_q q_type)
 	return pending && (i =3D=3D ICE_DFLT_IRQ_WORK);
 }
=20
+/**
+ * ice_ctrlq_pending - check if there is a difference between ntc and ntu
+ * @hw: pointer to hardware info
+ * @cq: control queue information
+ *
+ * returns true if there are pending messages in a queue, false if there a=
ren't
+ */
+static bool ice_ctrlq_pending(struct ice_hw *hw, struct ice_ctl_q_info *cq=
)
+{
+	u16 ntu;
+
+	ntu =3D (u16)(rd32(hw, cq->rq.head) & cq->rq.head_mask);
+	return cq->rq.next_to_clean !=3D ntu;
+}
+
 /**
  * ice_clean_adminq_subtask - clean the AdminQ rings
  * @pf: board private structure
@@ -923,7 +938,6 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ic=
e_ctl_q q_type)
 static void ice_clean_adminq_subtask(struct ice_pf *pf)
 {
 	struct ice_hw *hw =3D &pf->hw;
-	u32 val;
=20
 	if (!test_bit(__ICE_ADMINQ_EVENT_PENDING, pf->state))
 		return;
@@ -933,9 +947,13 @@ static void ice_clean_adminq_subtask(struct ice_pf *pf=
)
=20
 	clear_bit(__ICE_ADMINQ_EVENT_PENDING, pf->state);
=20
-	/* re-enable Admin queue interrupt causes */
-	val =3D rd32(hw, PFINT_FW_CTL);
-	wr32(hw, PFINT_FW_CTL, (val | PFINT_FW_CTL_CAUSE_ENA_M));
+	/* There might be a situation where new messages arrive to a control
+	 * queue between processing the last message and clearing the
+	 * EVENT_PENDING bit. So before exiting, check queue head again (using
+	 * ice_ctrlq_pending) and process new messages if any.
+	 */
+	if (ice_ctrlq_pending(hw, &hw->adminq))
+		__ice_clean_ctrlq(pf, ICE_CTL_Q_ADMIN);
=20
 	ice_flush(hw);
 }
--=20
2.17.1
