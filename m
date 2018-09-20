Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84105ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351F621524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NzNFwts7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351F621524
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbeITI3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:34 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbeITI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR2LRTbyh+jlKCSsKzXjXYDIQMWWQ20bDR9izB2Eomo=;
 b=NzNFwts7mMDrAQ2I0jmNw+qiYGAqrE/YIEiB3S1/y5HZqnS7QGLd22qOIcQFVq/PSsTQEqhbX3zLrSIVA5LQ2+iwBslh2ZnRyyqdBOwEuOIXvexLuU6OSpY0koHBr8xEx4pq8rniaY9fEvXQcGngG8tCZu7NNqNcUDre6jpDliw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Basierski <sebastianx.basierski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 38/56] ixgbe: fix driver behaviour after issuing
 VFLR
Thread-Topic: [PATCH AUTOSEL 4.18 38/56] ixgbe: fix driver behaviour after
 issuing VFLR
Thread-Index: AQHUUIxUyJMineGzA0eMQXzvW6Q7XA==
Date:   Thu, 20 Sep 2018 02:47:53 +0000
Message-ID: <20180920024716.58490-38-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:v/vfaFC01hd0HaMS8YZsXm6G9CEW2ZD9d98wzTCSnOm5+BHoeNZ3bITPCsMysUFbwakWrne2bn93vw8auCYRObyFz9GRQfjpaGv2UmG4uwDBJNgLYV7Yc/Xcax+DPaVlhjqKwOi6huzVwbxemYVWPgEiqHN1U+/UHS8pp2UwoZxUj/00dEObzxl8dx3zU/1sD2jT7P4G7eRyjgXhTNTtTU3UDvtMQCXTeC+GQIcD3sKwsYAzGVTMZfiaE39h21n5z6+AJd5shuXvdQK0B9QSVBuD5+CCN1Gu4aFZlwF43KQs+2kek5jh1mhqWgvUZj/QDCE9G+Ik3e62iNilS1+0JWtyMxO021E1TxlG9qw6kbe750yRn5PBJV3xU5DTDAbtNLT0/ZWCenbqpnLVL+/VwY1WtBakTHAN3InP6URpdCqQTzG8fU/WOiY6L/S3bahcODwjQKJ1Eb2LvHJ35wmihA==;5:ZSg+5FYsKyublc5qLJkd8CLGuOt34f38vEGKD+4kDl9sTdLToriecux+TbDY2dlx9EbrRPz9EY6oROgeclBEGdcpGTPQ3ekL3+4F0/n4f2XP8jhnE1yOuI9KuN1JMs+mQETNCIlzp9qicPDr68e9MzRLfZzJXHtVX64qT+nFIus=;7:eerPJpzKoyzjidyehj0FayMo06Ed12URM96QZVPaMTwFsaWi0EiUjm2h/3CGxP0BiI+cgzmfon6ct80oWG0VYcFgW6UEVLutrxCa4aBeQn8Y09wcFNj4hbrLP53FHyZW6TmPBlDw1uGVF1SuJ0qMdRX/GXRrucDeaW7RY6cs+vdTrmsSPQeFlx3d0s+YhiC3wNqectZ979SoDN8ORafumXQzIRnBCsT5GrY+7H1MMvwcI2anewOjrIteNbAh+nsO
x-ms-office365-filtering-correlation-id: 5d7f28c4-d679-4f65-c447-08d61ea3883e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165DE7E1D02BA0B5609DC1CFB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UfMRR6AOFtMa/MmFgEeQgxKEoprUGeiPKkeLToRGSEQypvVfRUnmoaLZu7fuOd+UoBtrOb6j+AmdRIxUUJh2RxnfK6jLBozOdAkjHyhZqxr4h5M7cN9+esfM+HoSCZ23zcJFLfEAUxm0SYERT6DK+9s77SaD43JjtYeYOAfO3S7qDKlGPRVLZ4dZXGSTFEMaTHiT8JmzF43cCnpm5EOtDTHYKwArg9xcqZTQ3weW9dxd5kugOtB2VoSIvP3oV0uElMExqOPV85YaEJr/7t/A6C6WOJTcgGOZ+3KzCIXVNLzOLGRe+i3faBVfQ57aOlyvkgzAK5W4ZKrXGPDxUTPZ0T5fdARgep981ZU3IG04nPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7f28c4-d679-4f65-c447-08d61ea3883e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:53.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Basierski <sebastianx.basierski@intel.com>

[ Upstream commit 939b701ad63314f5aa90dcd3d866f73954945209 ]

Since VFLR doesn't clear VFMBMEM (VF Mailbox Memory)
and is not re-enabling queues correctly we should fix
this behavior.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 26 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_sriov.c
index 6f59933cdff7..2bc4fe475f28 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -688,8 +688,13 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *=
adapter,
 static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32=
 vf)
 {
 	struct ixgbe_hw *hw =3D &adapter->hw;
+	struct ixgbe_ring_feature *vmdq =3D &adapter->ring_feature[RING_F_VMDQ];
 	struct vf_data_storage *vfinfo =3D &adapter->vfinfo[vf];
+	u32 q_per_pool =3D __ALIGN_MASK(1, ~vmdq->mask);
 	u8 num_tcs =3D adapter->hw_tcs;
+	u32 reg_val;
+	u32 queue;
+	u32 word;
=20
 	/* remove VLAN filters beloning to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
@@ -726,6 +731,27 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_a=
dapter *adapter, u32 vf)
=20
 	/* reset VF api back to unknown */
 	adapter->vfinfo[vf].vf_api =3D ixgbe_mbox_api_10;
+
+	/* Restart each queue for given VF */
+	for (queue =3D 0; queue < q_per_pool; queue++) {
+		unsigned int reg_idx =3D (vf * q_per_pool) + queue;
+
+		reg_val =3D IXGBE_READ_REG(hw, IXGBE_PVFTXDCTL(reg_idx));
+
+		/* Re-enabling only configured queues */
+		if (reg_val) {
+			reg_val |=3D IXGBE_TXDCTL_ENABLE;
+			IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(reg_idx), reg_val);
+			reg_val &=3D ~IXGBE_TXDCTL_ENABLE;
+			IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(reg_idx), reg_val);
+		}
+	}
+
+	/* Clear VF's mailbox memory */
+	for (word =3D 0; word < IXGBE_VFMAILBOX_SIZE; word++)
+		IXGBE_WRITE_REG_ARRAY(hw, IXGBE_PFMBMEM(vf), word, 0);
+
+	IXGBE_WRITE_FLUSH(hw);
 }
=20
 static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_type.h
index 44cfb2021145..41bcbb337e83 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2518,6 +2518,7 @@ enum {
 /* Translated register #defines */
 #define IXGBE_PVFTDH(P)		(0x06010 + (0x40 * (P)))
 #define IXGBE_PVFTDT(P)		(0x06018 + (0x40 * (P)))
+#define IXGBE_PVFTXDCTL(P)	(0x06028 + (0x40 * (P)))
 #define IXGBE_PVFTDWBAL(P)	(0x06038 + (0x40 * (P)))
 #define IXGBE_PVFTDWBAH(P)	(0x0603C + (0x40 * (P)))
=20
--=20
2.17.1
