Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE12177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jOj+48KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfA2JaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:30:14 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:40832
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfA2JaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQfMd2j02+uLdh1/xGMojDHPJ5kG753J0u3IpWVGb2w=;
 b=jOj+48KNeQSQj57Hx1YeoqT0mB/zb/mQmYPu+q2qTeANqyTLdNHSnrXsRd8Mk7SAYkC4axa7GZZpYHXyRrktp7ZkZss8i9RKoEIuaDpWW/90TOfs/E7NFsm1eOXSJmDcLgMwTCQbrgyxHBy3dm+3bhzKh8UtK6D3TvRGaVlgsbE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3598.eurprd04.prod.outlook.com (52.134.5.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Tue, 29 Jan 2019 09:30:08 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 09:30:08 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUt7U5Nbu/8bMgXkm1UbFq84pghg==
Date:   Tue, 29 Jan 2019 09:30:08 +0000
Message-ID: <20190129092955.24352-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0150.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::28) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3598;6:Eq8b4lFOViavS3MIcIxJ0QpuaFZySXYJ3bD+r9KFtOXwVObYl6YFnZUk10l0wkq/58Pk2QXL5uoeS/XFQC8Y3av+Wo2b1BS7WIbugTMTp+EYEAQ9RjQY9uCcjbKJ8r+d+qxbd4iWvHNgFUxqRpsEP7wYyzlhRLXeHytjWhDkTWBVZNRzm4464M0Vd+6mubfGXJr4lxA4CofMWV/8+eFlMlEhgsy/DNz6xO/kCK5Mi6u/iZgsmwAgZg7YjGY0bnUMQv5lc0X+1TyMNAzT3MEFR0/mNWrZ582ec1jo5A0441UpsczaDYRsQYTS5r2FtWJOHCnf3U2NS6QtTw2af62cqGNEpHDgRLX32ZL/2l5+sw++pYMG1BitOJVDfCy2NZYTtqF2Rf9IM//UFZeyF3RzN542XRLYbkXyedmbg5CaHIHoNQc3axE1G55jC8ZqN8lnQAVs75kNXPiFtDuEQrzNGw==;5:knhrU7s4Ty5g5du88apslOdSrPycd8ZUsRYFbshmGW+Vc7NVzGlxNgnAjYPgFLvdLf/FPcpsLx3yz88jWWs0gTrBosnj6A1DR6GK3KXRq7WjPaknQRkXyBOpfZnLJmJt6z21eLmYA01LRAk1MNBNtvHd3kkMzQD6zblmyEv+Ylnkf2UTnvAxRd1tQROAFMoxGNetuKFq/4MHWua7qZXVag==;7:rv9oDHzVThf1XSvlvRWV1dTimBkDgHsiGCBkjK6ECqFnRXcLnjXmr3oiXZP15txKIeSP1qTjMFNc1LUNXaq0dxC79imquRIP4SI78iAB2a7HbVMSn/q9GyITBIs6lXPCTuoYMPKlTA0d3xeT4W6GzA==
x-ms-office365-filtering-correlation-id: 38f1f0c4-5a35-4570-ec2b-08d685cc5be2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3598;
x-ms-traffictypediagnostic: VI1PR0402MB3598:
x-microsoft-antispam-prvs: <VI1PR0402MB3598DDA15DD40A61B8253825F9970@VI1PR0402MB3598.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(6506007)(2906002)(44832011)(39060400002)(4326008)(478600001)(52116002)(106356001)(1076003)(2351001)(316002)(53936002)(105586002)(66066001)(486006)(68736007)(386003)(102836004)(186003)(54906003)(26005)(6512007)(7736002)(8676002)(3846002)(6116002)(71190400001)(71200400001)(86362001)(2616005)(25786009)(14454004)(99286004)(2501003)(81166006)(50226002)(256004)(36756003)(5640700003)(6486002)(6436002)(81156014)(6916009)(8936002)(1730700003)(97736004)(476003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3598;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IECexbmfyUDBpGWUCq7zcUeVouXh4zJStDUaGrPIf9GaUgZkgJjzezISNr3SbOdWNOIZM5rS2J0vrFTMOZqSddfL5e3U4DE7pKUNvnxowylq4oHiDFTTlpu9SwE07C9tGjaAqQcOlTi9e3PYkNYd1HkYwEjKjbeEKe8fhkxzc6fBUPHmDJKk6P9yiiYbJijt1fVWyCFHXarkc4E8/i7ctD4LnaG11o048bW31FbRA8jmn0JawD7ivnPPubfS46I64Kv7szTmv5nnWvByVNov1ihpDsWy/iptvGJol0XWtFCNTy/NSukq3Bev3QL2AOStkTbOaKk0CF9up0jtn+sEZm5VHlj+INIxpbKXleSJ8F1CMSEwZB4qYMt7rzD0husxbHtSr1sJUZLtoTOvzOVZaogtsADaMUGW5C36XvhGQQw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f1f0c4-5a35-4570-ec2b-08d685cc5be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 09:30:07.6241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done via RPC call to SCU.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/misc.c           | 29 +++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
index 97f5424dbac9..9fc99a758f59 100644
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
@@ -97,3 +105,24 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32=
 resource,
 	return 0;
 }
 EXPORT_SYMBOL(imx_sc_misc_get_control);
+
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 address)
+{
+	struct imx_sc_msg_req_cpu_start msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
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

