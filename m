Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C800C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CA12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YeFx17FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CA12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeLJQu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:50:26 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:24256
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbeLJQuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqFbx0VKhtoVm8BZ24rAMcG9MKLHBqjn6R5imZMoAHY=;
 b=YeFx17FUSshdPD383Jaif7PRWIvBy/obqYUTbTu7UptVas4fi0ZsHhIR36CdH1ILguzqy7r7RbPtLJb6wIQMvCwhp2hRTOAbDhx9lFBsf1LsP6v3zWEj9oJzZEiFDIdf6jbknA6RsgZf9vQAMAZjUhAnv+J9p27yXVOfWKMydEs=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 16:50:17 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:17 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 1/5] soc: fsl: dpio: perform DPIO Reset on Probe
Thread-Topic: [PATCH 1/5] soc: fsl: dpio: perform DPIO Reset on Probe
Thread-Index: AQHUkKhtevHApK9oQ0WMI/6A2CJhog==
Date:   Mon, 10 Dec 2018 16:50:17 +0000
Message-ID: <1544460591-14888-2-git-send-email-ioana.ciornei@nxp.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2750;6:BLCHQUurPNQBqpJm7yWrNdoasG7Qvo16kXYEUZH//gukJEe7pG6ItEhPbsSKiqqdmaq8sGG+P23yi0hTU8g0gQxepDjmxX1Atz+OI/pYvDliquiXiTmVOsto34P9Wj9mY+HR7rk5bzP6sZWSCXGnCU4EMyw+QQ5blwD9jBrgSl3O3DzIbdeWaN+Q23fMOWBKXyyjC02wWesx5RFScaVi0F7E5rohNWmIhqMejOsiqIkuyLgpjQ4LE1lsvMqMP+YqMjKtsKWOG5hYhdQwqa97Aojfd2k849cx9h/APXJXEUyvQebQgpIG5eGJxJEQF1UsbRvNeKIoZKOs8/NCI0orDZgRz9cnrGRz4sw16fSBkrCH0Nkw6+NXcsS6QbMJ0worVVWcJqXi/ZQkLO6zU54tswtDzvXVyTZk6U7+6SZwZeKfjS/qZh2hiMCke2AeoMHSuNry9+FC8sfvrby/WHpBoQ==;5:nvZ4xHiGfDRCNq7Do8HtJWwtLFblvEuUB3LTsLcE3yEygUAnmmXcRQLfSLnnImhhNkRTbbNzTnmy/t7iHCAM454mFrpJFp20dWDqAwPgQued0DdCKYd+RHhD0AqcKkCmk5NBuwb4xpWn2Vw7Kpy3Va2ccc+DI6lQghRcjRK0/M4=;7:haXgMINTQI3J9LqLVeqzWfD7/ge6EIx4zZTWwEu13pSTHJYpbVIcSzebMCD3wuqDbTDinBCxEeCwTS040b+oq+gzwX3Jm0irh7gOz/oCg2RbcmMue+RQKhzIltwCJq2AXmK3dWPwEK34WRfiGJRgLg==
x-ms-office365-filtering-correlation-id: 34502e75-4133-4a73-3c9d-08d65ebf904b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2750;
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750289523E374D81DA1C74AE0A50@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2750;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2750;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2501003)(11346002)(44832011)(53936002)(2616005)(71190400001)(476003)(2201001)(3846002)(6116002)(71200400001)(66066001)(486006)(305945005)(7736002)(86362001)(68736007)(36756003)(6436002)(81156014)(14444005)(316002)(110136005)(8936002)(14454004)(81166006)(478600001)(446003)(256004)(54906003)(25786009)(8676002)(6486002)(99286004)(76176011)(102836004)(106356001)(26005)(105586002)(386003)(2906002)(97736004)(5660300001)(6506007)(52116002)(6512007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2750;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1zda0kHoEMTdQwN0chTwjG3jnd6bZcb3N7ZMX0jk5qJd3+q1kveIlBtZDEraromTOKLpmMIENhYk7MhNdZayjMhVkMG+wIQ7T9jwzHVUIEOHSgwM6T1lYf8nke/wOxFrOpqOBnqQRIdWxQfiGfNJoFVsRNF5bIqmjJSLxe9bpUdMttfQaikLb8aNxORF4f9C/03I3XqnPyILIE9yanEcQDd4nojKXh8DKDf2GaLmZmS0CGF7Bi6l9LHPfE2KYT+x9BOgWG2p2axeJCF5gY0zfEIfs4jgX8GwjDBUZnHTu22vqSxBstFJEDatATaULTBG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34502e75-4133-4a73-3c9d-08d65ebf904b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:17.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Pledge <roy.pledge@nxp.com>

Invoke a DPIO reset command when a DPIO device is probed. This
will ensure the QBMan portal is in the state the driver expects.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-cmd.h    |  1 +
 drivers/soc/fsl/dpio/dpio-driver.c |  7 +++++++
 drivers/soc/fsl/dpio/dpio.c        | 23 +++++++++++++++++++++++
 drivers/soc/fsl/dpio/dpio.h        |  4 ++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/soc/fsl/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cm=
d.h
index ab8f82e..5814d2f 100644
--- a/drivers/soc/fsl/dpio/dpio-cmd.h
+++ b/drivers/soc/fsl/dpio/dpio-cmd.h
@@ -25,6 +25,7 @@
 #define DPIO_CMDID_ENABLE				DPIO_CMD(0x002)
 #define DPIO_CMDID_DISABLE				DPIO_CMD(0x003)
 #define DPIO_CMDID_GET_ATTR				DPIO_CMD(0x004)
+#define DPIO_CMDID_RESET				DPIO_CMD(0x005)
=20
 struct dpio_cmd_open {
 	__le32 dpio_id;
diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index 832175c..38ee9db 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -110,6 +110,12 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio=
_dev)
 		goto err_open;
 	}
=20
+	err =3D dpio_reset(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpio_reset() failed\n");
+		goto err_reset;
+	}
+
 	err =3D dpio_get_attributes(dpio_dev->mc_io, 0, dpio_dev->mc_handle,
 				  &dpio_attrs);
 	if (err) {
@@ -192,6 +198,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_=
dev)
 err_allocate_irqs:
 	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 err_get_attr:
+err_reset:
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 err_open:
 	fsl_mc_portal_free(dpio_dev->mc_io);
diff --git a/drivers/soc/fsl/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
index ff37c80..521bc69 100644
--- a/drivers/soc/fsl/dpio/dpio.c
+++ b/drivers/soc/fsl/dpio/dpio.c
@@ -196,3 +196,26 @@ int dpio_get_api_version(struct fsl_mc_io *mc_io,
=20
 	return 0;
 }
+
+/**
+ * dpio_reset() - Reset the DPIO, returns the object to initial state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPIO object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpio_reset(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token)
+{
+	struct fsl_mc_command cmd =3D { 0 };
+
+	/* prepare command */
+	cmd.header =3D mc_encode_cmd_header(DPIO_CMDID_RESET,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/soc/fsl/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
index 49194c8..b2ac4ba 100644
--- a/drivers/soc/fsl/dpio/dpio.h
+++ b/drivers/soc/fsl/dpio/dpio.h
@@ -80,4 +80,8 @@ int dpio_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *major_ver,
 			 u16 *minor_ver);
=20
+int dpio_reset(struct fsl_mc_io	*mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
 #endif /* __FSL_DPIO_H */
--=20
1.9.1

