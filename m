Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB78C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A4D20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wsR5le8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfBFLwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:14 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:62276
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730144AbfBFLwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxG4dpq35KQC1ITUQMe9OTq7Nv5pqg2Uf9D9EhW7tFo=;
 b=wsR5le8+51AEpv/ix/lOZgW9Cbl0AZJiq2DtM9CYutl7O/otAa9DKhkvd1bo36Iti/pxUXsrZYq71sS6eNZzXl1FgJ1zjn7gMMR473Ik7LoAqN8AmpVssCHcKBY0RFg7/y5rOdFbxvqhoYI0uKHJrqpqR9XgIUnLIMKPq0HjpwU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3743.eurprd04.prod.outlook.com (52.134.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:01 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:01 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/7] staging: fsl-dpaa2/ethsw: Remove netdevice on port
 probing error
Thread-Topic: [PATCH 3/7] staging: fsl-dpaa2/ethsw: Remove netdevice on port
 probing error
Thread-Index: AQHUvhJe63BKBIYcukuv+vm+VSTauQ==
Date:   Wed, 6 Feb 2019 11:52:00 +0000
Message-ID: <1549453888-24593-4-git-send-email-ioana.ciornei@nxp.com>
References: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3743;6:muoBnh9SRkZBbevtKxlAN4O+0s/GbMFwAUxM9UJHll6ntSZReAGGvYszC4eo463kVjeZCDdb3ObC2cKWcqznktdo8rJYJ7skM3hyy6WvD+XhrGc/ruGzYdseRYBegIMe7aFFVj/Z/Mw/MmbH+ZEtxh7aNTnIjO4zCUAC2Y7gbFEy99jWAd9u7q+vIhvzy+SfYziKSJ6JV5u9ahy83dUOgamJH+UQrYf8wgF4XTc4HK8iWXDYdOo1dEg1Uol2LufYuE2lH7x6zBdoiUIDkSYbVNgIvcaRR5uiYl/IgUSlox7NhUN5wM2mKCg4tCsnoCCuhp2B98owIT9xeOGwHvj1EN/ol0BBI5+eHZmS0fDAPgnp5Ql38XCzMfrscfAMo53BsiUfEmyGJoj6ioen73oXf3vtMGhoT94/MUzG9W1Qn4/6imi9uDP5A/DSTWecbFd8ItbaDHw4bSZgkAEgITk2Ng==;5:5Lx6VXQE401cV8xgfOb/FJrFUo56JsEW5qMV0Slfu09zERpCO7YqLB8nPM/3ZEQZyExvAVJXa13m6lnw5yznldsokyjuibs3vVAbSnlqAxtft6UP7jhf2sFAaOqRl8UGm/D1//bJv2V65x06PX4zxD44e3fsVnFABrAYl3FQ42l80Xwpnet0D1b0QkaxDaFkYf4Z1oIgJ8pIcyNGqq37YQ==;7:huMAQ5E30AXWTNiVYL+ioWQ+toL4+Qu/kMTNMQHm/++JNUjEri7fYm8nnRYrNes1/Db99BSQesTO2LRn2WhfFODGsp5YvC2x2AH0Fn15Ca2mFq2Q2v21+BTWcOT/VcjcEV6kn/abc9sV2DJ0OdLzzg==
x-ms-office365-filtering-correlation-id: 9e77e805-b485-4332-1b98-08d68c2980ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3743;
x-ms-traffictypediagnostic: VI1PR0402MB3743:
x-microsoft-antispam-prvs: <VI1PR0402MB3743C0B081C1B43119AA0A0DE06F0@VI1PR0402MB3743.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(256004)(6486002)(386003)(6506007)(486006)(53936002)(68736007)(102836004)(478600001)(86362001)(2351001)(14454004)(105586002)(71190400001)(71200400001)(2616005)(11346002)(106356001)(6436002)(446003)(26005)(476003)(4326008)(305945005)(186003)(76176011)(7736002)(81156014)(97736004)(99286004)(44832011)(5640700003)(54906003)(8676002)(6512007)(36756003)(1730700003)(81166006)(316002)(3846002)(2501003)(6916009)(6116002)(25786009)(50226002)(52116002)(2906002)(66066001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3743;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UhPLzmDxdQQW2zotmQidfvUZ6Ksbf6nvNWnNu/DGU95HCT/3DlflgM1JOxiND8ZHnZBYFn1EH0RJ4oYPW/07QLgyJ7fAD5ovg7BKYmRxJ8FL18eDMs6o0nZeD5CtG8fG8dlB+j2SBLpom6ilpxqLH7e3vBF3Z412ZMc80Le3AgOYnD0jLIeHLeoXC5ngXKNHnfyCo2Q5bfuNELrzcz92fwBospMI+rklUT2daYxV8GdO2VYdyxs0bOQfCvoGtGX41Cka7AA4SMA0vLGu3efkOHsGaIfhsiCqe9VyTG8e1mdBwtiQ0APNX9oBUlL+wblk6LPTp7pbqd3x5jJy35cmKgmD82Kj/7HSkTdycUEyNVdGIxFzRnMWw8+oFNgca9U/cywIEuFZ3PXulzIWBu78VMSFyihMIDls/il3p94n/xo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77e805-b485-4332-1b98-08d68c2980ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:52:00.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

If the ethsw_port_init() call failed, the netdevice remains registered in
the system.

Use labels to ensure that netdevice is unregistered and freed in this case.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-=
dpaa2/ethsw/ethsw.c
index d15d03b..fa3af4a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1445,13 +1445,23 @@ static int ethsw_probe_port(struct ethsw_core *eths=
w, u16 port_idx)
 	err =3D register_netdev(port_netdev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev error %d\n", err);
-		free_netdev(port_netdev);
-		return err;
+		goto err_register_netdev;
 	}
=20
 	ethsw->ports[port_idx] =3D port_priv;
=20
-	return ethsw_port_init(port_priv, port_idx);
+	err =3D ethsw_port_init(port_priv, port_idx);
+	if (err)
+		goto err_ethsw_port_init;
+
+	return 0;
+
+err_ethsw_port_init:
+	unregister_netdev(port_netdev);
+err_register_netdev:
+	free_netdev(port_netdev);
+
+	return err;
 }
=20
 static int ethsw_probe(struct fsl_mc_device *sw_dev)
--=20
1.9.1

