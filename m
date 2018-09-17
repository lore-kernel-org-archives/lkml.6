Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21ADECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A98920693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YKSM80CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A98920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeIQIci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:38 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:6882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730096AbeIQIch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ADX8KNnXRXUsgyxiobTaAVyW7jvlP/IoP+27YD8nE=;
 b=YKSM80CNXO1kjEdWeRV3XZOc5sY28nuZJEBeKiyhvQdW72LKek2nhQ99ewWlepHyQZ4mXAoqkh2JDIxJOV32vt88V9YX8+HdmUtqoVC24o7dQUkpubOelkOCFh32dh8uFqnceoJ3fEa3oqNO0dq5eYRlFoaZ2m9I7BkopHlFQVc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:07:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/43] USB: serial: kobil_sct: fix modem-status
 error handling
Thread-Topic: [PATCH AUTOSEL 4.4 09/43] USB: serial: kobil_sct: fix
 modem-status error handling
Thread-Index: AQHUTjM12GQGY4+yhkC4BFIdw6jK/w==
Date:   Mon, 17 Sep 2018 03:04:54 +0000
Message-ID: <20180917030445.484-9-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:apPyNrEFNKaHvYYhNe9dFEGimz7YgSIrKk2y0ZRV+vmHaz7irTYbL7GSo9Lc73I7Uxgssvct2Alk+FoW1uNA9RfWFPzw2Dq7UFxxpSxm6lu326RxbgDMnaPJ1d137DI7aBjtu59+tuzkFglbZyyZPzl8PbBRssAXdR1NGue7er+TsWB9+AHjMUJTsmIklCv5BRyEhvdhYiXdE9hTxOUZoP/mTH2bv2mWt693BlUTJkB+NCKIgIDlfPSRikwEosR7Ku3mw90WSRxkFkJ0cN+B+kXwZjlW185cmE4YUCc/9ZlCLXlpXtAFi6W3CeEok0Du74i2i+/QDgH18QsDdic9cnpkyNRnE8ispCw8cX6BCTCc+JPns/JQJ2HNgZVM+AgIRhM/pvAzVJDqq7yQQ5UccdLdTKWGCaL2S1XAC92tWEuEcZNcosw03LfvMJWgLh8tU8ho91IWn/UZg2uzPa67/g==;5:odS23z0kJtEk0i6MLRi4ROiKvGApqVqt/5NIag1ckP90+bhcCcLi06Hh9yX00Mt29KV9xGKVO0nMwJgyUo1oCVvx/pjDQANKNzjqKKBs9Yfl3hPUE972imQKssZJUR/wuFbDIiLMId+R7Pe1frEx955RDrLXPwh25z8gA08AMT0=;7:DgNqZS/ezhFFEs3iM7ky11gbIVv04geXI9UdY6WSwXvo6Ym4KW2igCUfuC9MS4xR5L0tjtUVO5KuOc2gUO4GAjGi8optmeqRjiBNpBeYK4xEkoqGYyzvoOghqwoMKVm8GHwRRJCTjImjfz3o05R8Nfbt5PrHne12xZEr/1UCv2KB5uE5XlOQkY/z+5fM/P+jnB8HtTsj9GATl+1q26QaaYMm1gRPNlAgqSGRk4ZUvvUsmsRoqBUPZsvLg+byKM3c
x-ms-office365-filtering-correlation-id: cb25acd7-c574-44dc-c934-08d61c4aa4fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB016656CE0B4B5731D91A4B16FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: TP9aL4yx/mjjAWfX062hwDTnr8Zas67Rqw5hrrk/NtGhvI9C5RNprfFkFslBeIY+jJuQV5y2SOBPDNY6kK7m2Km52UWacvZNWA7CYnSnrq4v5PoMjiinHLoL/EzlCdGKiw0Zh4GXxeoiktLRxKzq3F/0COnr41cVdoEdeHNTWdzorNnqXeDzt0qFLqT+c+uNfeOPairofRy2KTAIXFOd3mk3e1RaPzgX5gxduIrZWAR4KrNXNu6Wz6sBOUYZXTFc638OsCk+dQ7Solg4O6+RlOMZ99jVYT5b8tI0Dn62wnfBCe6Fto754zz3bGGYYVE7cOM2+soqkwhySv4o1oYlbxkQ74MKMVDBfPHiLqwu/3w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb25acd7-c574-44dc-c934-08d61c4aa4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:54.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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
