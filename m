Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C9ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDD621521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bp78Yuau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDD621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbeITIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:33:41 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388232AbeITIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEzO/MMZ/oU3AYTediuvBuwXdlLpOjB7AYbjbkvDza0=;
 b=Bp78Yuaut5VuHGJHuGOlP7Hw5g4rwAEGSqmluxJSXSUEt2GI1F6S99Bzgf937LlmlvaGkG8dWlTOmtc+KKbRTJ/p2rHnemsAa5oxCfNRsUKnYJVPoxydTYpdsmIlVS/UqYXSQOMYLTzWpvsEaI5VvBbRb2N0u4rC32rLzUYypSc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 01/14] qed: Wait for ready indication before
 rereading the shmem
Thread-Topic: [PATCH AUTOSEL 4.9 01/14] qed: Wait for ready indication before
 rereading the shmem
Thread-Index: AQHUUIxxbwlhAwAsDkaNdY5jJOEqOA==
Date:   Thu, 20 Sep 2018 02:48:42 +0000
Message-ID: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:BBR+6tY0Z+/Df7Oc9ifZ77TSVODsPhJvuUcf+laCwU+k6Vcxw7GG57svwqJ1q/UhbTfnR5GUlERRzXfcOYPQ00Aiszd+ezOc9v72MBoJ9cyQBNPNyKEAZw2QsVeanfONMo9aJQQNRk40W6usg2UYwEHyqo4iZ9yJe0RcZEJJQskp+HsJAJ4m7NsL1ljYDeR8g9xNdCTxI3sl5vXo+/LXIFP105p+5y/MSlaMfsOmpXOuHMA5VFzRp8Hun1EIkvJ1mtcoyW5aJd4pBTQiOeBz/LSF0CGvdk+pDzJq1QLt4owxM/Oz9lsRkMHoQBtBy2+VwmJIKumg99Vxlxu+Pg9ZcMYLjtkvPM8kURfHVTVjmECZbBHJ++O+mPPsgZCC/LT0+l9nqaDgK+0hrxJCreIKQPFYlCgs9U9XVHZGgEAe4c9TBFd5UJs+lNcx9kxp0OzPRmE5ZWQTEODjvUTFiB8iug==;5:FwBwFEtuennLezM+q7teiSGRIcMhIATkJxxDmFYOrvijRIBvfzaxy/pLt1WBfpaJ9mlbuXQkZdcb1mlwnRyS2OHz1n/C4HPCovanwd31IlUlvq/2DSOl9nqQKHDvkHFV4cK6JVLHp0jgfDjBZQPYEYVug/j9Dpd+kumpshZGpSg=;7:YMTJ3TU2gDcASwtOBNr2knt42vQuqKMfypJ3qDmCxmNlg7lkmD9NhUEmVAyIW6v0/6J0kjDMi9WLsmA0aVrBhkc68HHEyh0MxTsfF5G1dL46VfP/MW36+LC3H6kBfHRwqBpXe/8y7UxEb9BRLB/9Py+3MoDeq4OZeb8G8RDfbhn5h8PtsmDZN+xNOficAblcaGFM+Cy68KJxb9mvnCILwIhXZHlewVgBvLw1ICLs2/cF5WQglKoZlsVmbcp1RmbV
x-ms-office365-filtering-correlation-id: 0dfc02bf-2eeb-4ad6-3be2-08d61ea3aa89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744EC16416D9744E8510038FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fI9FrlHNoPE2tN1Xq8MOpxQMQ7f16DuTRK1+6cxUaLDe1rZul+Y72LYk7a8GfeFtL1En/vU40HRTiQi+BtLvNdzEgy/rfqIN60CejZj/5PmlV9xSm7H/hH8dVF1JkShMav9A+rzqVYUjmKbLeaDG7JgjlGLu8IQ1yiQRqZBLAOdz1x1VIRsxAhyBWNZAGvdk2Dirt80MzVk2S4CwhNGTjiTo1UDdZudH11NHpj8e8dkN7hrNhZnRhnLT8HmmidusDb4QbycKCHLAfFWxuJqS/c2wrvI/B4a3dM7iCSRcFqh9U5UNvuZaxNesUy/PutZb0BezMy8xQd2DyRtmPu+Nt16dKuWLBejF3MZ0GjRRJUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfc02bf-2eeb-4ad6-3be2-08d61ea3aa89
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:42.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit f00d25f3154b676fcea4502a25b94bd7f142ca74 ]

The MFW might be reset and re-update its shared memory.
Upon the detection of such a reset the driver rereads this memory, but it
has to wait till the data is valid.
This patch adds the missing wait for a data ready indication.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 50 +++++++++++++++++++----
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.c
index eaa242df4131..a89385ba6b63 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -97,18 +97,57 @@ int qed_mcp_free(struct qed_hwfn *p_hwfn)
 	return 0;
 }
=20
+/* Maximum of 1 sec to wait for the SHMEM ready indication */
+#define QED_MCP_SHMEM_RDY_MAX_RETRIES	20
+#define QED_MCP_SHMEM_RDY_ITER_MS	50
+
 static int qed_load_mcp_offsets(struct qed_hwfn *p_hwfn, struct qed_ptt *p=
_ptt)
 {
 	struct qed_mcp_info *p_info =3D p_hwfn->mcp_info;
+	u8 cnt =3D QED_MCP_SHMEM_RDY_MAX_RETRIES;
+	u8 msec =3D QED_MCP_SHMEM_RDY_ITER_MS;
 	u32 drv_mb_offsize, mfw_mb_offsize;
 	u32 mcp_pf_id =3D MCP_PF_ID(p_hwfn);
=20
 	p_info->public_base =3D qed_rd(p_hwfn, p_ptt, MISC_REG_SHARED_MEM_ADDR);
-	if (!p_info->public_base)
-		return 0;
+	if (!p_info->public_base) {
+		DP_NOTICE(p_hwfn,
+			  "The address of the MCP scratch-pad is not configured\n");
+		return -EINVAL;
+	}
=20
 	p_info->public_base |=3D GRCBASE_MCP;
=20
+	/* Get the MFW MB address and number of supported messages */
+	mfw_mb_offsize =3D qed_rd(p_hwfn, p_ptt,
+				SECTION_OFFSIZE_ADDR(p_info->public_base,
+						     PUBLIC_MFW_MB));
+	p_info->mfw_mb_addr =3D SECTION_ADDR(mfw_mb_offsize, mcp_pf_id);
+	p_info->mfw_mb_length =3D (u16)qed_rd(p_hwfn, p_ptt,
+					    p_info->mfw_mb_addr +
+					    offsetof(struct public_mfw_mb,
+						     sup_msgs));
+
+	/* The driver can notify that there was an MCP reset, and might read the
+	 * SHMEM values before the MFW has completed initializing them.
+	 * To avoid this, the "sup_msgs" field in the MFW mailbox is used as a
+	 * data ready indication.
+	 */
+	while (!p_info->mfw_mb_length && --cnt) {
+		msleep(msec);
+		p_info->mfw_mb_length =3D
+			(u16)qed_rd(p_hwfn, p_ptt,
+				    p_info->mfw_mb_addr +
+				    offsetof(struct public_mfw_mb, sup_msgs));
+	}
+
+	if (!cnt) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to get the SHMEM ready notification after %d msec\n",
+			  QED_MCP_SHMEM_RDY_MAX_RETRIES * msec);
+		return -EBUSY;
+	}
+
 	/* Calculate the driver and MFW mailbox address */
 	drv_mb_offsize =3D qed_rd(p_hwfn, p_ptt,
 				SECTION_OFFSIZE_ADDR(p_info->public_base,
@@ -118,13 +157,6 @@ static int qed_load_mcp_offsets(struct qed_hwfn *p_hwf=
n, struct qed_ptt *p_ptt)
 		   "drv_mb_offsiz =3D 0x%x, drv_mb_addr =3D 0x%x mcp_pf_id =3D 0x%x\n",
 		   drv_mb_offsize, p_info->drv_mb_addr, mcp_pf_id);
=20
-	/* Set the MFW MB address */
-	mfw_mb_offsize =3D qed_rd(p_hwfn, p_ptt,
-				SECTION_OFFSIZE_ADDR(p_info->public_base,
-						     PUBLIC_MFW_MB));
-	p_info->mfw_mb_addr =3D SECTION_ADDR(mfw_mb_offsize, mcp_pf_id);
-	p_info->mfw_mb_length =3D	(u16)qed_rd(p_hwfn, p_ptt, p_info->mfw_mb_addr)=
;
-
 	/* Get the current driver mailbox sequence before sending
 	 * the first command
 	 */
--=20
2.17.1
