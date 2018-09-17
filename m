Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476D8208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hPHpML1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476D8208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeIQJCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:02:02 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728537AbeIQIZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqXHuZqPXUJ52GLaJsnjwYFNvyd0cCpS9zTEwM1sJrM=;
 b=hPHpML1VpovffHImMsHJyc4F6EbX5IW4OyJ0cWtx59vCgMNtFGf9A0DGnzI+n1L0vl3U263k5ZBIZIXM1IjNg257xZVenYiPW895188uUjq7w2jW/uHpwQ4vpbfwQBcI2DIq6F5aDS/REHVdo1Yk2QrHlNbtPzlMCvMAyj5ePpY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 020/136] USB: serial: kobil_sct: fix modem-status
 error handling
Thread-Topic: [PATCH AUTOSEL 4.18 020/136] USB: serial: kobil_sct: fix
 modem-status error handling
Thread-Index: AQHUTjKTjRXh+F5Bt0G0nJQV8ar/Og==
Date:   Mon, 17 Sep 2018 03:00:23 +0000
Message-ID: <20180917030006.245495-20-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:tv76fkTK2PRGEW/afTFvJ2dNPeLcs8Vh/nVI6l8cZ2hMf8UV0bP9RGyljuXp+GHkqaBQRlAbNzOitOpFYUjYSnM6yR0n0FWg0c7bRh66ybZxmxzHKaBVuSk+D7PoSis8NYdIx8J7VBaGSUJJQX1st92v3tZecgwfDj0MHVeHoZqGcqd7++O8qfdXtAmM+EPcA+rT96XHoIj3gHumQRPfspJc0yz/++kEcIFruQ/C1r7Xmib84XZx8dopO4gkK9H85OgTOye3gw5amc+mvnjXUGCDV+9504en3iTWXYyh9EN0jZ4hbi+LZvDkI39dcDPwbAUpgfiNpqmDqwY67DseBIMydgLb2Pa3+MwJ8Tkw1cgF6oTUtcnWHQyVSRdkX2bIcANjESqkxrT1kaA8T4wPrK+o4G5mBR3QcRM7XpBAjNDv4PIJyYKM4K88hHEw2NKKV0TZ6/aBfMJGK3zhwPkN3w==;5:aYdRsk6dzEBeDw/xFeocLIErRXaRfIpks7f0M5YlC74sVxNa5Q9tw2+bvh2w/bXyCfMpeI3ENaRxfG32UiKgt2AjMJhFqiLHY4F3p9odfwu39QP5QKCiEqWBUDBW/sniXkxdQIJgvssj/eqK/yHrVogWwrzahqJSh0K19YLt1a0=;7:qeyEgsthjONg64m43whzML56DZorcvbiFmnq1lyuAivUQYlxvlcmCozMMdNKVxgOBgN7wj/XzncK0A3yQsmNTrtkO7vcl9iOnVPqqcumzoVg3R6ttF9g2FfI964TgQ5s9UvvL92ABoRF4kJFpRgLOUwfsPSUpkrOUQy4Egzms5p6soVs2OHbW3wyKkhsFm8J/Pn94P0gnaovqV06HO5jW2nde2gectsJHoM1zn8a7U8WU0/geLJZu6aMYI0Zsxts
x-ms-office365-filtering-correlation-id: c211dc9e-e6e1-4d8d-b51b-08d61c49b7be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277A73499AB50D24C2F700BFB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: uyZPS2AQY1dWDHtOR5YqsywxMFoXVxOduMT5wItOh+q5j5i2WFKhW8SbzHFaxgIlmFyFqJ4jeZNUT7KIt+CRkLfvj3ZRZbGgeCOMNUSTVSgRt5kagrVS2g+0zC1Wr6DrBMCjPHoWzZg7ZbDG6wwEO1ZDoNOl6GzkT9XPYWn8HEaCSyHk6BYLChssewJPRlHNlRyWaTv+uAJ6tkjAn63JTm2rYqEwzAOPlPR07oRZkzaegOeroO+9LhfD+NVP3qqYQ1BN/GLVsesnSopQuUNrFBtUZ21x+tHSL0JPawwzjtE+p5V95LCcnTHNXCpzgmB/jPKQ47vTuPZbrdk9PVWsj9/dVMtYhiD77IfJBeJJwNg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c211dc9e-e6e1-4d8d-b51b-08d61c49b7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:23.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index a31ea7e194dd..a6ebed1e0f20 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -393,12 +393,20 @@ static int kobil_tiocmget(struct tty_struct *tty)
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
