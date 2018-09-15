Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB810ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5957621479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C94/ZYAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5957621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeIOHGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:10 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728534AbeIOGrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zErUAZijo00JIY1JqJKmduPnnECZADGOysVqePglNHU=;
 b=C94/ZYAjHMcZ+EH2uK5RTtn6RVgfCsZ7WiGGIBCEgP1c9cwJPjSWX9JbnJ6e9NzFzrDeDU59udBCw18g4kdPDV6fEuMBv1JyqDQ0utEnow/e/ia1iNDxS0pr0cCTPe+Prgyryc2kKlPfELWzstqpCA7xSV6D2MJUboCtYp/1bLo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/92] tty: fix termios input-speed encoding
Thread-Topic: [PATCH AUTOSEL 4.18 37/92] tty: fix termios input-speed encoding
Thread-Index: AQHUTJOnWDHfM+UYyE2ws0kDXmXjCQ==
Date:   Sat, 15 Sep 2018 01:30:15 +0000
Message-ID: <20180915012944.179481-37-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:bTAf4N5tR62AwhvkyEFX/3Mtv50CcEcyxRT10yo3ni+NGHSZVI7yboa045rZunWe6RTi9fheZIKc8mAn+/fZV0Z5hdbnllcYeoIwM1fQqfxeX0hck5JQ/gJHSaxQScD5wiqKFTUi0tZft2RMyH4FNI+rdWBl1azGvqeVPXfRWQgozSCLMogiKZMqQ/c04HBXx/aUI0i4fts+JxipIhuDXDtlW7kpn8vsnZHD3BDKocA6jPK6HTNcpsvVAZ4+v5W6Ew4LpjL+VJ3wY/RLaU8Bi5hQMVzhVPzpDt8mBJBw10pJ9zdPigc4VJpjiEqOxiq8Hl0ZJK1crSx+2naXf7wip9ypphwPBr75ACWp53+FUmU2MuhYISg5ZEg1WnBlXzSYSKldYeDtl3BHvAN2RWdx3M1Fg0i5LEdUz7AyZADPFGqc64N+84q3mWd/B8mHD3foJxeHenRIIB0i+M9IUCt0Zg==;5:cb9ER7HxJ8qgAsrRnAAhzUzUk6xndEq7XLlB9aEvpUm2T3Rz6SwrUExehFofBLWa/vml6j0KDg5dhRu8VReB0I5qqbKqdDEP8+IYLo7fkWtoa/bl4xJJYBNyAprEgJdS6Wjo9IxKycHjvMtC/TGIiScjbQYzjYkguYJYQkOyEm0=;7:k/Ty0T9HCyTSJQ7PJvXxLZf1jCCzpMXrCY973VBV7gqEDtogNcFmWY+jDxTVEpRuxrMHEWs0OQAG7kwQuj0zxY2zeKyhn9Y7UrKKNVpgWy51+2jOfhGMVJ5Pntn9uBtVj9aSh5m31OOoIzSERLoJnihqCViukHc76CdLjhnrMGXvtMuTCDwr7CqIxFxI25im2NTNfB1NSAaxODp+kS4kWfFm/9iS7qA38XPU6o4WY+8LmzRKjFoGQX/JCFECQt+G
x-ms-office365-filtering-correlation-id: f4a508f9-0f98-4788-9c51-08d61aaadb84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB07411AE3F6F54022D1E2313AFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aSTtTICv3bEF25CfssaN2gvUO2LWomfR/LyTOdh2q7QOJwWEDBUI/VRKy0cHB/mzOWumOf8LqB4gQzBDJppqGMsR6mN3p1aH6dKCCbdcntVycEdIwBSrvkwaxIu/8wYWjb56mhiztEz1xD7czPJhdFH9ZBjJk+3frbmMsZBR6aAc2THCgWjTOWblqy6brgYkYz1wJvKZznVJ0VzSJfs3gHN2FGV8TsC4Cu3RLpyNfD5Iq97ilGsLvBhepca3RAWBUWABQUeQac5cv2ILEJPfTw6mrspB3ikQJDFY6A7H9S5NvMTOv9hDF3CEIXPPFxqY+tlNuhFou7KifDGLoqNkhrGh2qOUFjJ3dNzO7v+awEs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a508f9-0f98-4788-9c51-08d61aaadb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:15.6981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit fada18c48d774b9e837928ecdce6a5d5fdd11ee7 ]

Make sure to clear the CIBAUD bits before OR-ing the new mask when
encoding the termios input baud rate.

This could otherwise lead to an incorrect input rate being reported back
and incidentally set on subsequent termios updates.

Fixes: edc6afc54968 ("[PATCH] tty: switch to ktermios and new framework")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/tty_baudrate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index d39b4f18e0d9..3e827a3d48d5 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -173,6 +173,9 @@ void tty_termios_encode_baud_rate(struct ktermios *term=
ios,
 		iclose =3D 0;
 #endif
 	termios->c_cflag &=3D ~CBAUD;
+#ifdef IBSHIFT
+	termios->c_cflag &=3D ~(CBAUD << IBSHIFT);
+#endif
=20
 	/*
 	 *	Our goal is to find a close match to the standard baud rate
--=20
2.17.1
