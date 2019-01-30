Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E088C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEB62184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qpo20fH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfA3J6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:58:05 -0500
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:65344
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbfA3J6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wr5A+n/o7vGMqHyokIbIoyn2xvGfaWpvmLwSio6oHM=;
 b=qpo20fH5zSEIamF8mcfOZA4xZMo3WOPNg324uULiNm9w4iZBQCVKY6/Bs1QZcf+mhyGXB8B0lyfnqjpw6oPTTVEEuvPNCZUAtfZ1MjFlXz5IHGLw1rgsBVlBIpocdpVMI2AdmoNLZirl+LtW6WEAPY0SWsm+KC8yhsSCStcrgTs=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 09:58:00 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 09:58:00 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH v2] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUuIJIb5ERbmz8Z0ilGZjHtOs21Q==
Date:   Wed, 30 Jan 2019 09:58:00 +0000
Message-ID: <20190130095749.8952-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::14) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3357;6:S2y0u4IQCsiKMs+mOIuzdREqEXAPCIuUfNwMAnkECriu5v46X1FmmTlQoahEPYC8D4DuLZEYE5tnV+dm2v2fyQM78314Y2c39zRvJBArnyXNouB9Rl++Q/pgYoCE++rJMYsObOODYlclNCvKndQsWu7fVHW/xq2pYQ5cpH47UkCWSMCb8i6Eu9kxSvdZhihrXJguRtQoJ2iDOhs9tQ2Ug2wAUesfO0hpkPQWgk6DBxT1ovM9Wbyb+5JbvdcyJtoREg/QZkxEF7EwS56pdSdMgNFp+5VJGPirj78rXaIoWOGixHFhBlMiXp07WdBfmamFy/tc4qwd2KkKBRNIORiSmr5JFhBLpa5/FXgnY6iYt8WDQwxVWcgISDLAkITsRdf0RUXTsN3qzOrJ6HkXf+6oSu8gwZE9QnxN71Xm0S+RGYjsSYAsX4uYLdaOG/LdEk1dpEo+TazB5bL/lRqEUKD/ng==;5:X0aYXlcNqC8c5/UB7/Q5fnGPiCpEqnh7QZefRvEaONZrU0abhBgEhV8ql5QsIPffJZy1syLRSF4DDVSTLX6h5GfgnQ6R6pYn2zMwfWq7lX7xHpl8UXlZZ3co0ROXg8gFCt4weU/YPyGs1KfKYre9cMfsLYX2Z4B1flqaU4ruDLc2tTHrnP6dBSUP78U27/1kwAhDfli4R/6O/V4aa1CPkA==;7:OWF/tlMS3EaWzUx4gWixhdv6/0IB0kIDCg0oM2pugB3N9uuQo3SBn/Coe5lqllfRDtkISlQIhZEFtNakZ9SgMLZDVnYtD2q6YHTFmntyLpliM1NLAo+98aHfANCZawrhmt+fZ3OueGwVOScgrqQPCw==
x-ms-office365-filtering-correlation-id: 71d2e86c-37eb-48c8-88b8-08d686996ac6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3357;
x-ms-traffictypediagnostic: VI1PR0402MB3357:
x-microsoft-antispam-prvs: <VI1PR0402MB3357BDAC149179B872BC92AEF9900@VI1PR0402MB3357.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(97736004)(71200400001)(71190400001)(66066001)(99286004)(52116002)(2501003)(6116002)(3846002)(86362001)(1076003)(54906003)(6486002)(6436002)(36756003)(316002)(106356001)(4326008)(2906002)(53936002)(39060400002)(2351001)(105586002)(6916009)(102836004)(25786009)(6506007)(6512007)(186003)(386003)(26005)(14454004)(1730700003)(81156014)(8676002)(81166006)(68736007)(5640700003)(7736002)(305945005)(8936002)(2616005)(44832011)(476003)(478600001)(486006)(256004)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3357;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ojixJACOvcmOE9BtTCVEhe9Tiix1bPiqqVwPl09A5H4qQWj9odbDS604zB9d+6/SAeQZG1KeThkC+nFsH+W48TkrtrngK990ksdKjHJSjGH7o50mTNFlJ03Tvl62fNPn56aWKeq7IQ7LqTx8BdCp8LlYO4aRkiRsxj1fqKNxzpovHiz8nO6lnmK/RR2yL5AE9f9B5XDFZavDbeZ6OiBp0tSCboUfOn4Bgq3Lkhi9vzNzoTowwUpVMbtyiT4asXYuXsZTpmz5v/kC77p9vxkJjNMi2rwarc8ZxJasyE9wg8c9ct1Mgt0XAK+k6pij4qmeKNrcqgtrYTd+SsPA/fFY+AwWSRh6Aqq3ZPldfJeajSO5tm++uWz2cz1fBaxbwd+ehm/oPCspd6VcsP2xatRz5TQROGzYB0ZbTTMyHy90bZ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d2e86c-37eb-48c8-88b8-08d686996ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 09:57:59.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done via RPC call to SCU.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
	- remove unused variable ret
	- add documentation for imx_sc_pm_cpu_start function

 drivers/firmware/imx/misc.c           | 38 +++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
index 97f5424dbac9..f511d6f624fd 100644
--- a/drivers/firmware/imx/misc.c
+++ b/drivers/firmware/imx/misc.c
@@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
 	u16 resource;
 } __packed;
=20
+struct imx_sc_msg_req_cpu_start {
+	struct imx_sc_rpc_msg hdr;
+	u32 address_hi;
+	u32 address_lo;
+	u16 resource;
+	u8 enable;
+} __packed;
+
 struct imx_sc_msg_req_misc_get_ctrl {
 	struct imx_sc_rpc_msg hdr;
 	u32 ctrl;
@@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32=
 resource,
 	return 0;
 }
 EXPORT_SYMBOL(imx_sc_misc_get_control);
+
+/*
+ * This function starts/stops a CPU identified by @resource
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ * @param[in]     enable      true for start, false for stop
+ * @param[out]    address     initial instruction address to be executed
+ *
+ * @return Returns 0 for success and < 0 for errors.
+ */
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 address)
+{
+	struct imx_sc_msg_req_cpu_start msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D (uint8_t)IMX_SC_RPC_SVC_PM;
+	hdr->func =3D (uint8_t)IMX_SC_PM_FUNC_CPU_START;
+	hdr->size =3D 4;
+
+	msg.address_hi =3D address >> 32;
+	msg.address_lo =3D address;
+	msg.resource =3D resource;
+	msg.enable =3D enable;
+
+	return imx_scu_call_rpc(ipc, &msg, false);
+}
+EXPORT_SYMBOL(imx_sc_pm_cpu_start);
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware=
/imx/svc/misc.h
index e21c49aba92f..c03bf2a23add 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 r=
esource,
 int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 			    u8 ctrl, u32 *val);
=20
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 address);
+
 #endif /* _SC_MISC_API_H */
--=20
2.17.1

