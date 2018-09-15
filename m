Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7B2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803BC21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hwyb/sDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803BC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeIOHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:27 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728516AbeIOGrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPEki9NfGI9xl1gdKcpMV9gwooV5/1+aWLV6gyvbjIw=;
 b=Hwyb/sDoPe/hyFiuMPbvymxs7YLEQdxw+lSLgNPMqa5Qj6jhrUdDhQslMAoc6oMk7FoR6sAp4hz1fJfltvMLTZbCPvgdwnFZatZ+L6F4mUHLsDsJLQwqCO6YQI3OxfBWKr2YX093T1wW/UtDItWWWmK/BrB2bsWxPdvGG4jkHjQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:44 +0000
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
Subject: [PATCH AUTOSEL 4.18 36/92] tty: fix termios input-speed encoding when
 using BOTHER
Thread-Topic: [PATCH AUTOSEL 4.18 36/92] tty: fix termios input-speed encoding
 when using BOTHER
Thread-Index: AQHUTJOnUNz7+5NEfEuK30Iuqi+qlg==
Date:   Sat, 15 Sep 2018 01:30:14 +0000
Message-ID: <20180915012944.179481-36-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:IhRfXtLeXyeAnN6PeZ/+GYL9RoWYk8Jks96qQug8PoaQ0njRk3oNJum02KhidsiCclb2F9nlpqVjEdnBzezE7kwxgBKCKcmnM2Q3YgbbgRj/C4HB0lItcpQddAw/t6I71RGQrfvriNBgmN05E3B0OUOH4LDIXlMgeiiPkbkjaojdz3KLv/EVQa5Q+eJjwgC52laEGxKrJpaAbjRTOnlIN01m9/BFQ6F+ZkBfgPyF25T5lCeg6OyYlaxAzb4R8mL2SHl6B+6E3TOWpzuAWvirW/oaIr2eCzA+GrYYc7IErBDDMTq2V9MHtzYiH44ti6wOzZ6Vcau10lnGJNErBMv3k2w45OMOnCIOSd5JxqDIkQ7yAJ/pd2Lv35DAU84uANtIQRWTakfETk4IxHrmisGLZFDkU6vaehct5fj3z3A9BETM2shlSeUDtFPLB+I1CY5O+5Q7Et/j5cDtqQeBlFGnnA==;5:p3SWnf471nb1SlxB+jenwoyyuj//crsy1S5j0DZG23oV0ppY0Duk0gC2Jc4ZZgFgNAUw10SaddAVvvpsreVzRq7GZIJ+V7laXcLh1wcDNvdqQuuZAmStZhN/S/6sJckAXPLsGMRLIKkixaZWsB6zvH/tzlyQZqWJQcq+ZoBI9/c=;7:PyQ+nwYhxRUGuMOHFol0mvG5QKFVepnzEMAFqzzbG5zFe9NxE1PIcYep51I4u1c7ywbN6n3hBoGsmiRS0qEgK9Re1+9B0qGq9Wwei7JzLRPl6giJqFwNq89GJ5VdIv/c34eW5pqK9Dm1S1cbiye/G9lAgh15X4SUWBp5A1Kpj2eqzJs7QxRon09gPUHI+QEYTdF3Gl57/UqMOVY3FDuh7GYslC1wSd0Opk8msW2vAnBHp5BvtJUXhYSnUoFpl7Cb
x-ms-office365-filtering-correlation-id: 943f633b-6d84-46b5-52ab-08d61aaadb19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB07413EE9B80F1033C68D00F7FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZARnJGNd0dyejpPpV5785Irccv5gvehGVMb7UUAOtNcQ3bHDq07NeboR+FV5zGHgV4ETByjfZm5v8CjZLOMeGPNL7N1Awz8LMyuEVgfLWMAvEiEvwEjO+fgbAkqv1eXXIBwuQRrmBR1SqKxRJXWtj2aat9zJ84u/8sp3TLndOuajUcwdMGUdXcyf33M5JnmHWywHUiIc5IGyoP0IxB5sdktVORQGp82kYuC9LajRWzwixsQU2p6cDQiZnhbl61yqqsGbGhkMsWS7TWJhi1B8s/8WOLamlpz+9gFXVSASs0Ab9Ekznyxd+OIpye50VKHC85zJ30WVUEFiPxt1n0gaw8f4nZ8K2XmweXZudBJcZzo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943f633b-6d84-46b5-52ab-08d61aaadb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:14.9637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 1cee38f0363a88db374e50b232ca17b9a4c12fa0 ]

When the termios CIBAUD bits are left unset (i.e. B0), we use the same
output and input speed and should leave CIBAUD unchanged.

When the user requests a rate using BOTHER and c_ospeed which the driver
cannot set exactly, the driver can report back the actual baud rate
using tty_termios_encode_baud_rate(). If this rate is close enough to a
standard rate however, we could end up setting CIBAUD to a Bfoo value
despite the user having left it unset.

This in turn could lead to an unexpected input rate being set on
subsequent termios updates.

Fix this by using a zero tolerance value also for the input rate when
CIBAUD is clear so that the matching logic works as expected.

Fixes: 78137e3b34e1 ("[PATCH] tty: improve encode_baud_rate logic")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/tty_baudrate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 6ff8cdfc9d2a..d39b4f18e0d9 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -157,16 +157,20 @@ void tty_termios_encode_baud_rate(struct ktermios *te=
rmios,
 	termios->c_ospeed =3D obaud;
=20
 #ifdef BOTHER
+	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
+		ibinput =3D 1;	/* An input speed was specified */
+
 	/* If the user asked for a precise weird speed give a precise weird
 	   answer. If they asked for a Bfoo speed they may have problems
 	   digesting non-exact replies so fuzz a bit */
=20
-	if ((termios->c_cflag & CBAUD) =3D=3D BOTHER)
+	if ((termios->c_cflag & CBAUD) =3D=3D BOTHER) {
 		oclose =3D 0;
+		if (!ibinput)
+			iclose =3D 0;
+	}
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) =3D=3D BOTHER)
 		iclose =3D 0;
-	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
-		ibinput =3D 1;	/* An input speed was specified */
 #endif
 	termios->c_cflag &=3D ~CBAUD;
=20
--=20
2.17.1
