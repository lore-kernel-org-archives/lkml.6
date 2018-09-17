Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECFCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4D0214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o3yf+jU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4D0214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbeIQIbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:07 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730626AbeIQIbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ADX8KNnXRXUsgyxiobTaAVyW7jvlP/IoP+27YD8nE=;
 b=o3yf+jU+AQKJEaTEvVGy4HYpy4rTVIpYnlBfmzkqhuKSF4xna9/3ZxvMQwPLlPZMzXEeIoN29fZFwAOjep40QcgXclG3VGamWwaHKOaeW2/YWAfUejhTGE4DvSJ6SOLweRPn9entL/uNi0azLVupDmkGqvpuorqUtScFNcgXo34=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/57] USB: serial: kobil_sct: fix modem-status
 error handling
Thread-Topic: [PATCH AUTOSEL 4.9 10/57] USB: serial: kobil_sct: fix
 modem-status error handling
Thread-Index: AQHUTjMO6vlauQnX/ESTHuOdPigBOg==
Date:   Mon, 17 Sep 2018 03:03:49 +0000
Message-ID: <20180917030340.378-10-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:mrPgBLJC0R30TvE2LtwqvHToHD3sqIav9eWw2OKMR5bWvRNpGYxHaGfODenyLlAHkD50IOwv+mIQ2MdAWV6XcepRhjTe0jvHLfqdZ2owJ7Jc32dSokpP8xkL3J5xjdGP6OiLRrw37CJEJhVqrklZJUmf2OzQCVR3bgr5Ek0+ClbTOUh+uKbfEGQsuohE2O5Kz+6a6sr2CdC+vayX/z9bd2tP3zmYFi0qN9lMDoYww839wlc7SixlIoAAxerzpfPCL67ceLRb/S7X103k6pbW6V4oi+tpoXUtAD/WAnfpTPDu9Rj7iWi9d/+o753ZxbN7936K8CA3Tva+uNBHNY9KmNouBlz2+V5nsY8uNDK0UR5bgXv/spaUkd48dbjei/p0M2j0QJLq8aOPXTiKRy6+E1ERTPvboeqAaur/AU6DN8Fe6TR4qWGN9it6rjaaM4k8w+tTLu4tR4MzL2l4Wh7cwQ==;5:3qpmgNTf2+ZB+o2ApWXLw2jptnUHIWoAi1c+BR1+rSLWBPt5u6390cSbUmf4p00MKtahfWlcDPK+YFkhu873gq5an5arj9qoHWdUH0AXaegAy0X1BIlnMJyLA85m1WhDtJ7lajd5Di+rysQkGEaA33ilLCyiOESPPYKss/bRNiY=;7:/ScuAi+/JapKMkqb/B32Z1ihPCmatUkxVTBmSkU7xHnzarF8S0Ac9Pf7BJmcPCHuF9ZchDBKNHsMrJBNq4Sw6Ii26FYj4+JGbzx5qcR7vJA5EYeZnpV5ZK8hzxFvnxmyLsWb4SrV0Yb6/xPN6F4VTuJFb9ibsWTp0y6f7WSMrNzDMrU9zQez89jpzZynHIZrBBE5+f24drpP4yPJbfsyPlGo3UZZ8YNYrwZWKp9waRI1GJYqa9XESDJj3AvBhzbX
x-ms-office365-filtering-correlation-id: b594c7bc-d54f-4e72-4563-08d61c4a7205
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120313BDB93A915033491EBFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rpFMReFtEEHNA8QTgmaJRMYL1qeNG/OANtfWtCdFaFgoVwYX3iHcLGHWcoj4/10S/mdPo2w4q3g45W1o4jUSFbdXf3KQ3f5XgFInQBlKJ7Z1RcOvtIZubfE0QbXAmFAG3iUM+egPaQ0mwe03TCHYMxQN1Q+vJTaJdot/YVsOyYAPFywq4F1o0SCO2jWY+9vjxEARvMkPSszmg0ScDrtBL2cRIr/Gc9f8qP6FFE1BMShbIWeArT76OnU+tddhLooNSSHkpCjVfKsPlTksAF07IxweII1VEOUQApa4MRQZIr74BCDyyvrjzsNC1Mcd1GXQ6aUco3dRKLTsOP2AD0mZb4MY3puP53u4vZNzJfd8m8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b594c7bc-d54f-4e72-4563-08d61c4a7205
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:49.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit a420b5d939ee58f1d950f0ea782834056520aeaa ]

Make sure to return -EIO in case of a short modem-status read request.

While at it, split the debug message to not include the (zeroed)
transfer-buffer content in case of errors.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/serial/kobil_sct.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.=
c
index 813035f51fe7..7d252678c55a 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -408,12 +408,20 @@ static int kobil_tiocmget(struct tty_struct *tty)
 			  transfer_buffer_length,
 			  KOBIL_TIMEOUT);
=20
-	dev_dbg(&port->dev, "%s - Send get_status_line_state URB returns: %i. Sta=
tusline: %02x\n",
-		__func__, result, transfer_buffer[0]);
+	dev_dbg(&port->dev, "Send get_status_line_state URB returns: %i\n",
+			result);
+	if (result < 1) {
+		if (result >=3D 0)
+			result =3D -EIO;
+		goto out_free;
+	}
+
+	dev_dbg(&port->dev, "Statusline: %02x\n", transfer_buffer[0]);
=20
 	result =3D 0;
 	if ((transfer_buffer[0] & SUSBCR_GSL_DSR) !=3D 0)
 		result =3D TIOCM_DSR;
+out_free:
 	kfree(transfer_buffer);
 	return result;
 }
--=20
2.17.1
