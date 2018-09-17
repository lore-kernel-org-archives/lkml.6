Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F969ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62F12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FhV1a3Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62F12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeIQIbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:41 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:24891
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728849AbeIQIbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFeoTuSV1M8Oix1hTAVao3AYpotwOgF8crShovtiGjw=;
 b=FhV1a3LmY+fVCPpBG62HeRsAh6pzqyEq3oMBW97HydGcUAym8GcoRNoSeDMl42gp/Y7unfB2N4MI1LMFafbt+250bACcHesZTVOpiWcXnehw1jQn22fXeOncFQZvExzfml/8Z2JiKfeaUkMXAWFsy/CHKOKf0eAvx0OPmZk91FY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 36/57] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Topic: [PATCH AUTOSEL 4.9 36/57] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Index: AQHUTjMYmgFK6nYhHEuRhD0rXUdA8A==
Date:   Mon, 17 Sep 2018 03:04:05 +0000
Message-ID: <20180917030340.378-36-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:rxwfaCQL89TMI9izOpMjaHV7sDkhaSIpaM3EoWQmkKFYJ8XuN6RbtA0d2G4jApbWj/qGdvnleNC3kx2sq3PjB7DqCLsE7SJdPrrfIfFRnOSzG0sqfm4gYw4v5N5hAWAsgyOzhs4E0PJtVAZMuTaM1uXeicMsr+ZJxukxjmOJtKtAg+mzDtJs+Pavu+YDz5a8MLfYZNh8Yz28ww8TDlZBQkwCTK4WyvL9jrkqOmiT8XXrgjEohcLXyxSYVEIE48K7rdaUnz2bOp9E7yujtBmaUMYkjTtGcpPhz6H1IIw4vcHfWM2iWMFdt+UJpf7z58VUkvs4JbF/DpR9uVzMvLVx5QrWPS/PcMs8G9hBX/jrg2kTkGnus3/CjBuZ844h50dBFL8FQsL3qF2m1gw4QxqStzwc0kNVjYQBrmRA4PxdZLTkNwhwHC3fqR+jcAurqYcXMmnU31Vac1GdqRA4jj2DqA==;5:w9q0n2jbmlpE7mZfbR6qnPaGBZaSuOpx65tWk/7+xuvL68vbP9XEwmWZac1X+6DjNRtziz4wMtNiQ73r0+j1G3bERiGWMVoQD6NSAuVuSwoUyppvnL84ZssvgtCIH18EwH7mMQT0+JWkHrmxzU0A9DyKJ8SGF386UQjI2ALvsaI=;7:jaFT16OdqIbnR4xQp4e3KJIWt/pqUfAhngz1BwUaVNtysy+y/bYMpSbBKz2Nj6LgZ2X5VER6tJwNrdvZAwAtVvI7Mp97U+SULBCHVuqFIcqABcpFrT9TrNT3rn9MmcezYy8WiRqqhsPp4RoZy45UasXTXeYkY/LKHchWxcBmx7jkgt1tuGw4tWxtko9tToFja5uYan7Flfi0OrKfr0aRW8pGPpc48jX/CqVAADkdQ0Mw+TJbYpvnb6iL73wWh7vs
x-ms-office365-filtering-correlation-id: 4a6087f8-771f-47f0-c35a-08d61c4a8a6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07579E2ADB95656233CE0189FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(39060400002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5fcudqyxJo5pbhmt4CRnwZopdxpljRSM69nqK3S69xDDgD1f9nP1agc20+kfrxe6R1LqX+tpan0YI48YmrZq9wX1t8RIuoOz24O4DuZAY2o+uel5r1k/L4JBcVi5bEJGa4b/Hu4/h+1C1liI63QfA3Q4tsYOZgbqF1m4CYBX3MVdhXsyEhLJNScnsR4T8djXueC/q/BgEa077Qg0HEIQ3Wn1XYmzqXv1avHwkmnlN0ZyZsci8EKQ/CK+wYibHjgnhztSgmBpB/zCw1mDpo/Qina6hRNmWBu3y1BQ0Bc+fKqtac2tfJjLJfYXKynWl0NPjIG9tawSjCr94lf4xKtfJ76hQGg4uR4LSP/v0K5lbOI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6087f8-771f-47f0-c35a-08d61c4a8a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:05.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 85c634e919bd6ef17427f26a52920aeba12e16ee ]

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/=
serial_cs.c
index 933c2688dd7e..8106353ce7aa 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -637,8 +637,10 @@ static int serial_config(struct pcmcia_device *link)
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc =3D=3D 0) &&
 	    ((link->func_id =3D=3D CISTPL_FUNCID_MULTI) ||
-	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
=20
 	/*
 	 * Apply any multi-port quirk.
--=20
2.17.1
