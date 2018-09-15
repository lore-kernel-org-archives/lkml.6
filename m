Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD500ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0B7208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VqatAyKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0B7208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeIOGtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:50 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729202AbeIOGtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmzGB/CgRXL4YQImT/EBgQZx1vhZBisQMSvn8qMjpkE=;
 b=VqatAyKFNJz5JytoMukeOlE9CrGfmjnBDY/xvohqpl+pd6wdLeOLcfXTrQ2mDiVNb/bCD/9g7sFuaJ0er//T1HOsDTyA8Q9PqDE/IJQec2e/YkKbwqtI/G5DeXa8uCzr2qdkPoET82uRYmlJ2ePxa9+BpBf2vvKV9gUvuCdINm0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/57] tty: fix termios input-speed encoding when
 using BOTHER
Thread-Topic: [PATCH AUTOSEL 4.14 24/57] tty: fix termios input-speed encoding
 when using BOTHER
Thread-Index: AQHUTJQAx4frFvcH6EWyL9DZyhT46A==
Date:   Sat, 15 Sep 2018 01:32:44 +0000
Message-ID: <20180915013223.179909-24-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qAArlnjXhZhYtF05BoV5xzEohVcLXmU8towuTSkGFSCIBRbUszOvvIBlKo0mgQQbgHtXWOrxQxieV+/Xlxayd496Kkm96tU7+gT/swtugWsMt0afZ3rswEzSYtTjBFndsocmRLvEVmHezK1puqYBj+UxaD47TDFkDCVwyNHrigqbU9hOcJ44WbDlz9bktry/TeF2C0LFNb3CVwc6Xo+rZnFVBJz/6KffTBs4WVvog8AhGM9MPc5qjMoRdiVH5NlmgeOYNpIhdhJqyEyeQlxorCuzXHuwme71spJK9M/Sy+Ro3tdum0t9Ar81aInkQcJ3UVqDjpu3DVX0ljGofDf00Tlj+2xPEDVSAlFFrr48EainV9Ur5WdzzjhC4ZIqVZ0/tmO0bA10qprH1GnkQ7w1LIJtX/mcWBNhOMzDuRJO74CnpB8WTLYA3DyTZlVkVXuCV3X6jtdxQ7EsFEQ2z2FLfA==;5:H+UIu7BYca0RNjq56tzCCABgqFmH2kHeGH5x87l30A11oxAxTsNCpYRMF9Q+XW51QhQX7jPXYf3fJ48R0V6xo/haL9QMtHKTO9vqrJUPbVmf8FYVxQrG2w0sYtyBr2XkFq/WS3kG7BEoaJz0L3WYCYNRGyz10kqvz6s4/dxCsDY=;7:+ZKzlYS5hAXoxTPpr6QNCaZvjOkTwZdzNUftWrrTDZa4G1ANNYcK5Ide7oWJKPyJd5GH+kc3TdzZeg25tOvkLzRH0ei7ytl9TQKX4OBnTdYQDimL6J9bm/v7HPTAnH5MpHMGBv8rGnB9EOvSudRWQjhlBfjoeoIlbIr5LlD1ayx3v6ZmtE8O7Fmrk7UezaxJKfIsTgf760lUk3l+3lwYQ7wsVzqOY1F2GXagh+D12yOMFeIUs0szoR1kYGYhxwFV
x-ms-office365-filtering-correlation-id: dd8fa801-a503-4d97-9bdb-08d61aab231b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822968E66AC3A440C5310BEFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BSYFPDCDYFKYTtybDWfV5VNLkKESkRcr1ZqRWM9MTn9nMJdEYoZNViuNsjhVS9amgAEolZTyhTXnnNiSkm6ZQj3nQl2BHG1w5dIQ/Tdp1CRSpH/FmOEIu8N9btIq6jrO3mgyZAZ46/2xQChjntwAFqwdysgq3zP76A4EKIaG20w+uwItuSz8FNIEocF/NhcCo8x4OV7cYGVUrUQgGwLVTP9HPJWn7dL5nGJ1y8xmeAuuGb6d5Rn61G0GLgQTSKp1rsmKQ+FTyScJhv+VIhnpxmb8jXJOoWJ9UHStGA8nicfoEuPa811XVclXJlaVDvVGBVcjmuwHZcT6Wi+w2Fmi72RiuQb9aSqXXcO4rFAhUe8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8fa801-a503-4d97-9bdb-08d61aab231b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:44.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 5c33fd25676d..8457bb941e1a 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -156,16 +156,20 @@ void tty_termios_encode_baud_rate(struct ktermios *te=
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
