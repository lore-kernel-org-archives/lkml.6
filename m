Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15515ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A998921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RtUhH4ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A998921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbeITI30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:26 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387928AbeITI30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Po0FZdQDu5wQA45lsfnMZ+PGjfruAkZ8mXln7hiBSs=;
 b=RtUhH4ESub7Ih3fzcHuL+ZH/U1TnO0yFiNh5FDIZp3dygQ62R11XVpnwUTTJd9dBtoZ74oVEWcZXPMIgdxOoMyqguw8J0vkrdNtbpCo0dm4dL4jHK7IYHvkL5xFUpjbpNd/WmbOmWLp+1xofN9PbnQsGp4DE8UgFA7viyqp7nBw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/56] ice: Set VLAN flags correctly
Thread-Topic: [PATCH AUTOSEL 4.18 32/56] ice: Set VLAN flags correctly
Thread-Index: AQHUUIxRTHsYxi1PwEyTYiObxOUMNQ==
Date:   Thu, 20 Sep 2018 02:47:50 +0000
Message-ID: <20180920024716.58490-32-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:+6odef4IreylmiCKhDEgmy3yKwt034LJAq0q9FIIDpEojMDc3781n551WcP02dQYG6XhpvZifcanJ9Le+xW/nrrFa7DDxC5RYhWcdpwKj4OEuQ/AdZY+dM9dEofrqKiDOorvLUyg5F6IfKRwnFviBqo5ajcUY5kFoOVmYlmuZX5nyvCY96Cr5qR48hUDbKNvdNu+PGz3OskbA3LERUVcB00qJu+LOg53r9zbcMVu+3BpmrFtVNcrw1TbloDIn7zUs+HBtZmhHS3T41x3rqEeX+8MYnXLMr/UmgOYGsjCNIGXZHMPF1uqHt0WBS0j60hbIq/piSRwxVFvh5k2h0GBE1soFw2BWZaQ+Wd28CEhRTMl/MqeuFSUkZ/uji21+Zww+Lp9TEjRiy10qyoIvvDt3XaWzZ9Oy1mTriEBzs3gBRSwTp312GhnsKvxgssTa9SpPrJ/JwDYn14yxXwrv7vJIQ==;5:5Q1ZuFdnFOAxDcBNvBPvFCbA5GNrUexFDXPMxfpq9nzbz6LdWwKrjg8+Gt1bES5smRX/Tr3b88MM06XXSE7xQGTcAcVTxVKrWtcor1zY16yggDqaxPawNatetjfABj5dPNR/qxJmyPvU6k08rNKUG24UBrqvM7Io5mmWWwjg0Hc=;7:RJQ4Yif4TRRKKFVxszmae2f0wUTifZW20vQimzLynzUjaL7GiaEKoPIy/ayTBdXwDyDSYUat4k0Vnosqn3xD2LtwaO853UAjU1SAofHtZGmf3GPpA+PpgUAoB2L1mXuuNtK5A1v2gW73BXT5AOVlvqhHvUsiDzOU7l61UiuLM5h+1RrzUGtpbkusvfnS+Ru/zys19iJuvtJsmdKWzHZrMvneDW4SyMul1TpGe788mC2KGhbTENSHBXRkWZgmZkDA
x-ms-office365-filtering-correlation-id: d30798cd-8020-44f9-78cd-08d61ea3866b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016546CE0977999297CC8E36FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(575784001)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0isI6uQzN9/V6mfE0CeEo1hQt+flhMER0ODhJwv7p6HFL7TwzUjpZLHzAI/yB9czkUPvUJShyH6GGePiio3eA6KH+KBjxrDwJKLHhjfw0rkSd0eEMb9vNcFr530MPj49Sg2n9G/Bw31HozvLOkf1kfdVWhYBiYZ9JoPnGdLVEoAxtIQnO1QPxfNmENJt15pW0J5kj1amrhCknxVhcgMa/f5AoeuhuLcwmVePOsMUPho5VpAUYalYePuIQ9adrbPu22t8+704a6SQr0mJoVx22nQzr9cW7JgqfGuNuw8pd/RIq9ADDAV9VEKMUjU8C53Y1PBgJ+qasSG9ExO0n2poHj5/LWizGIo2wnW80Bh9u1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30798cd-8020-44f9-78cd-08d61ea3866b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:50.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit 5d8778d803e21f235e9bc727b5bd619f02abb88b ]

In the struct ice_aqc_vsi_props the field port_vlan_flags is an
overloaded term because it is used for both port VLANs (PVLANs) and
regular VLANs. This is an issue and is very confusing especially when
dealing with VFs because normal VLANs and port VLANs are not the same.
To fix this the field was renamed to vlan_flags and all of the #define's
labeled *_PVLAN_* were renamed to *_VLAN_* if they are not specific to
port VLANs.

Also in ice_vsi_manage_vlan_stripping, set the ICE_AQ_VSI_VLAN_MODE_ALL
bit to allow the driver to add a VLAN tag to all packets it sends.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 24 +++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c     | 31 +++++++++++--------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/=
ethernet/intel/ice/ice_adminq_cmd.h
index 6d3e11659ba5..a0614f472658 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -329,19 +329,19 @@ struct ice_aqc_vsi_props {
 	/* VLAN section */
 	__le16 pvid; /* VLANS include priority bits */
 	u8 pvlan_reserved[2];
-	u8 port_vlan_flags;
-#define ICE_AQ_VSI_PVLAN_MODE_S	0
-#define ICE_AQ_VSI_PVLAN_MODE_M	(0x3 << ICE_AQ_VSI_PVLAN_MODE_S)
-#define ICE_AQ_VSI_PVLAN_MODE_UNTAGGED	0x1
-#define ICE_AQ_VSI_PVLAN_MODE_TAGGED	0x2
-#define ICE_AQ_VSI_PVLAN_MODE_ALL	0x3
+	u8 vlan_flags;
+#define ICE_AQ_VSI_VLAN_MODE_S	0
+#define ICE_AQ_VSI_VLAN_MODE_M	(0x3 << ICE_AQ_VSI_VLAN_MODE_S)
+#define ICE_AQ_VSI_VLAN_MODE_UNTAGGED	0x1
+#define ICE_AQ_VSI_VLAN_MODE_TAGGED	0x2
+#define ICE_AQ_VSI_VLAN_MODE_ALL	0x3
 #define ICE_AQ_VSI_PVLAN_INSERT_PVID	BIT(2)
-#define ICE_AQ_VSI_PVLAN_EMOD_S	3
-#define ICE_AQ_VSI_PVLAN_EMOD_M	(0x3 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH	(0x0 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_STR_UP	(0x1 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_STR	(0x2 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_NOTHING	(0x3 << ICE_AQ_VSI_PVLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_S		3
+#define ICE_AQ_VSI_VLAN_EMOD_M		(0x3 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_STR_BOTH	(0x0 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_STR_UP	(0x1 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_STR	(0x2 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_NOTHING	(0x3 << ICE_AQ_VSI_VLAN_EMOD_S)
 	u8 pvlan_reserved2[3];
 	/* ingress egress up sections */
 	__le32 ingress_table; /* bitmap, 3 bits per up */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethern=
et/intel/ice/ice_main.c
index db580d41dbf9..5458c3ae10c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1367,13 +1367,15 @@ static void ice_set_dflt_vsi_ctx(struct ice_vsi_ctx=
 *ctxt)
 	ctxt->info.sw_flags =3D ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 	/* Traffic from VSI can be sent to LAN */
 	ctxt->info.sw_flags2 =3D ICE_AQ_VSI_SW_FLAG_LAN_ENA;
-	/* By default bits 3 and 4 in port_vlan_flags are 0's which results in
-	 * legacy behavior (show VLAN, DEI, and UP) in descriptor. Also, allow
-	 * all packets untagged/tagged.
+
+	/* By default bits 3 and 4 in vlan_flags are 0's which results in legacy
+	 * behavior (show VLAN, DEI, and UP) in descriptor. Also, allow all
+	 * packets untagged/tagged.
 	 */
-	ctxt->info.port_vlan_flags =3D ((ICE_AQ_VSI_PVLAN_MODE_ALL &
-				       ICE_AQ_VSI_PVLAN_MODE_M) >>
-				      ICE_AQ_VSI_PVLAN_MODE_S);
+	ctxt->info.vlan_flags =3D ((ICE_AQ_VSI_VLAN_MODE_ALL &
+				  ICE_AQ_VSI_VLAN_MODE_M) >>
+				 ICE_AQ_VSI_VLAN_MODE_S);
+
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |=3D ICE_UP_TABLE_TRANSLATE(0, 0);
 	table |=3D ICE_UP_TABLE_TRANSLATE(1, 1);
@@ -3732,10 +3734,10 @@ static int ice_vsi_manage_vlan_insertion(struct ice=
_vsi *vsi)
 	enum ice_status status;
=20
 	/* Here we are configuring the VSI to let the driver add VLAN tags by
-	 * setting port_vlan_flags to ICE_AQ_VSI_PVLAN_MODE_ALL. The actual VLAN
-	 * tag insertion happens in the Tx hot path, in ice_tx_map.
+	 * setting vlan_flags to ICE_AQ_VSI_VLAN_MODE_ALL. The actual VLAN tag
+	 * insertion happens in the Tx hot path, in ice_tx_map.
 	 */
-	ctxt.info.port_vlan_flags =3D ICE_AQ_VSI_PVLAN_MODE_ALL;
+	ctxt.info.vlan_flags =3D ICE_AQ_VSI_VLAN_MODE_ALL;
=20
 	ctxt.info.valid_sections =3D cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 	ctxt.vsi_num =3D vsi->vsi_num;
@@ -3747,7 +3749,7 @@ static int ice_vsi_manage_vlan_insertion(struct ice_v=
si *vsi)
 		return -EIO;
 	}
=20
-	vsi->info.port_vlan_flags =3D ctxt.info.port_vlan_flags;
+	vsi->info.vlan_flags =3D ctxt.info.vlan_flags;
 	return 0;
 }
=20
@@ -3769,12 +3771,15 @@ static int ice_vsi_manage_vlan_stripping(struct ice=
_vsi *vsi, bool ena)
 	 */
 	if (ena) {
 		/* Strip VLAN tag from Rx packet and put it in the desc */
-		ctxt.info.port_vlan_flags =3D ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH;
+		ctxt.info.vlan_flags =3D ICE_AQ_VSI_VLAN_EMOD_STR_BOTH;
 	} else {
 		/* Disable stripping. Leave tag in packet */
-		ctxt.info.port_vlan_flags =3D ICE_AQ_VSI_PVLAN_EMOD_NOTHING;
+		ctxt.info.vlan_flags =3D ICE_AQ_VSI_VLAN_EMOD_NOTHING;
 	}
=20
+	/* Allow all packets untagged/tagged */
+	ctxt.info.vlan_flags |=3D ICE_AQ_VSI_VLAN_MODE_ALL;
+
 	ctxt.info.valid_sections =3D cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 	ctxt.vsi_num =3D vsi->vsi_num;
=20
@@ -3785,7 +3790,7 @@ static int ice_vsi_manage_vlan_stripping(struct ice_v=
si *vsi, bool ena)
 		return -EIO;
 	}
=20
-	vsi->info.port_vlan_flags =3D ctxt.info.port_vlan_flags;
+	vsi->info.vlan_flags =3D ctxt.info.vlan_flags;
 	return 0;
 }
=20
--=20
2.17.1
