Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892BDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34521208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EK3ussCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34521208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbeIQIvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:51:22 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbeIQI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp8WV33vnw67y1yNtnIPJPSfztlfyXwtp47n52+XmdU=;
 b=EK3ussCVh9eLtP7eMq3ed+GuuYfE8oCDuftm0Ej0EfL7pYM8Gm3QYSdSSK2NfGkZTN5rVvGMbA0q0fl6Eb/H4FSIG1jyO/lCvjt5JpfrohvVMHxiotbnou8tNihG7noEHeWkHViBGxc9TN4e22u0KHbck/PyaFOBUtoP+NTX/RY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/87] USB: serial: kobil_sct: fix modem-status
 error handling
Thread-Topic: [PATCH AUTOSEL 4.14 14/87] USB: serial: kobil_sct: fix
 modem-status error handling
Thread-Index: AQHUTjLhoDlvIxIQfE64JF2C/n+I8A==
Date:   Mon, 17 Sep 2018 03:02:33 +0000
Message-ID: <20180917030220.245686-14-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:R60PrVWDoirpfV1tnElEJrvXEf7JdgA4YZGYCS5K43UqP3AIhYF0s40egdM7iIoqr4FWG3Q4PaWZ3n5ik0/1i7TkXaATg5LEBAQ5gxTcSgbNZXurLMkzEtFYNRhG+VyStZq7ajgprBHT8cZLQf7uz8xVrNkntVV5+RuhpjWO+sW+v/zZe9/LawnE2WwUCroKBvpGT5LXMwllvMbPOzNCREg6zlFUEcoFCwMjkHvuYHbxHkynW1L4Ymoo2MqQCp5SZR9Wr7mKR0KO/G0DP1/TUbMUWHEu6VlnJaH7fYDS7N//BUaK4z/2F3ndDQ3cE8rLoZRtyM/n24J0TS53A+/veoePPT3S35OSekRA2K78MRZxIHEB/LQHWZ68xP/XeUikm1vZAeKt+tLkyDwkKo2YaYd3FM2oCkMcvvenf+uPi+W6POn8LcGQXWgUat4KhLo90mEHunkDemDAW4D2WShHmw==;5:xiIbma89fMLVYPTVu40niiDsWir+JlqNEjQ3+yBt76bRerFquATIskp/vIxK6tfiahONfSIszplDxvMsrnkijCPF2Kb3S95Q74k3DHJFlor9FkgxJDwdwsKhvPKOykf+qrVNYZyPq8tslRqc4GTYtzMN+IuQQivsDoc/1vA8S5c=;7:98rTZdVmWs9c0vwa6GqCOY792v+gODyNj2xRcL4TDT++vG/+UOZPR1DpPIjYcIPOCx4W/DBVSHWCQjQBv0xYcLs7kzfpRAkAmBwX2Z6TB8TFF26eraACbmXC8N53rX8PxDKmE0MVQelVDRcW4+kcyEak/RjHGbwp8oR6XmE4SM4oRA57MWFlI/udMBqraKjrTW8Cpybg2nYSAOZ7E1crJa+LgZsoMA93UG85YA9jDqIVRnI0ijCuPHHLY3YBfXmh
x-ms-office365-filtering-correlation-id: b2e9c79e-9dc3-4187-909e-08d61c4a281b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855CEA455FA6F343CD1B545FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: skb3cv6LoB/OTetvvobHP8m8DQX98cZTBKtXZ05SlXTOfOuAVEMjlg6476hvgSRFhGYsHbFw7nLDxsfDvHSXGjeYtd4GOCg1f+xrKqu6bsvZW83kuK1tauClga/SnAdfcZaWDnDXqPeX1khGZDX/3agjxZKdouvlPyHfCxSDPdmChS+tV9mG20JYhhJYu04YwPxKjsoQRdg+yhe8MGralvC1mpY/dt2vAh6fqFpGn+8bme+7YaP01EMlY5zKXIJQxCJX+5M+9w+wSFd4BwvXZA2UaucyV2ksOreHI1nBD3wB3z+2JKPrAPQ5eF788sUjL5S5ckw8oniJumuiLeNjDa3TUWZINKGQtBciPh1h5kA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e9c79e-9dc3-4187-909e-08d61c4a281b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:33.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 3024b9b25360..75181d3afd95 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -397,12 +397,20 @@ static int kobil_tiocmget(struct tty_struct *tty)
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
