Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C2BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0FA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FA5mk9tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0FA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeIQIdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:15 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731499AbeIQIdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPTi1YAfpswXuMyapEkp8zRrzMM8q6HbHnLSFqmtkZg=;
 b=FA5mk9tVMjrm09y+X6gTiQVWCJWYWS+6TKY0brHfzjGCBAN2LVmYAbQJFC+HmzKd6u7R270RPY+MIkLP+dPBMYlt6n6sEzqULXrCcMBKmUJsaA0UKJ/Bpj2/FrmAav2rF5r0lqaVC4oxlJeyul4d84sIj2i1zefgmrUtaEeWWYU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 05/29] USB: serial: kobil_sct: fix modem-status
 error handling
Thread-Topic: [PATCH AUTOSEL 3.18 05/29] USB: serial: kobil_sct: fix
 modem-status error handling
Thread-Index: AQHUTjNQEwY0IOtxaEqCX/p9Ih/V4A==
Date:   Mon, 17 Sep 2018 03:05:39 +0000
Message-ID: <20180917030533.592-5-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:CnBfPvx2dTINWo42M/smXvqX2oAJO+6DgCETy2R+wyJ5o+0Ps8yCbN8FnsGMDpJzXsW6OXP8x8DTB6xuZ71AwZUW+CRNAFi2hn35XpgI1XklWjl6XaTrn+Fev4vR3KgBdY73kydn3RLVn72cWFxd6KwECq23PyJZKN5P6vZsWxWsgKj3VwEBVictDCi5MM/0YQolxUeZ5nzDSAk9K3L2nb2h70dvd6QnyojKT9FH75K3dSZQ7YE8obYIxuU2+Z/GLJNvllCSdzp+IYWtZCG0cm6pIQQhpUv2E1m8sqBW4ZFUpyvoIWIBNKs7kyVeGx2ewDtvCHdkx9yAvUW48xnT2JyYbpI8/vrj8Vx3H5kqm1NLfxxbk9nkqD3sMX4QAXgF3AEiZrEpbBTr6BfHQ915ehoxUAaZaOjAhUQHY/Kz/YCfvWtkHxhvTeJHz6aq7zg5AqO7PKOYD0zqQcmy/I5jUg==;5:4UGADD+QPHZI9KevaSWSuqYry0j1Ud0hV2gq3S9X1ifTKWbJWVJ3N00B8BWAuNo/asONY3fiRcWVJfDBKMfqb7JRl20lzfiym4PFWrp5d0ttW5dkyErZTapAJ1/hDpXX3EI9FYvqejuyfwuFq54hwT7004RjW5AdRtQvWdzCV+I=;7:5yUz0js5SKsMBaoAowQD/sgF+Z+tQdtaId3+68XHXcyk6DfFrl1pwvQ/1JvEk/7fSaROVx01oPxI77BLOFqVX3dxO90Z1XdsaShoJoR5p7eIP7rKDtJ2d4C7ESUBYW8loaHGbq623CYmZKI+ibECrWuqHJWtBhSmvqcZ7bqmwL3625LJydzraT7klywu22RiplhibieNn5gXgm+xq79L/NkXwrPv6WKpXVTdaW9wmZnA1ONmON0tYI+ULJ3x4DEA
x-ms-office365-filtering-correlation-id: 5d1c9b37-c6d6-4f32-f77e-08d61c4ac012
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839FB8C9DDEC1460DA66AC1FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h1GTo1gdlUB+IRuu4GuQr6NPniT6MRWoxvkWQN7ZRCzfhsIL+uoJP8l0iQmLdquqAAJSfqIj5Pix/SAYS7Mb9SspmKoyxcSYkYuHdu7P/UhQtDstAP+pyrjWOlKrIo64SqjAEbFJa6yYmWysGEffIyOrGo3NH8Fx6YJ/IDmJu0+F0ipR/m04mpsYdBuBtFTaVq8Luq4b5JWluEskMRlb9KnGMutGYAmqXS24AIEM/W+R5FVfl72IQI982dJM6wqem2eyFp3yk3Fgvjs0uhjEHewQTmt6whyNcNj06V/gazpTWWDGzJt9Ccauu+P9qIwFGv9zOIZ3Ilzs9R17nL6AcDhvYfMuAK5EV//y2uhpqow=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1c9b37-c6d6-4f32-f77e-08d61c4ac012
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:39.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 02c420af251e..d056bdb42771 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -396,12 +396,20 @@ static int kobil_tiocmget(struct tty_struct *tty)
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
