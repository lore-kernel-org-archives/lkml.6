Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2ABC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E0F21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="pxvo6bXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E0F21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbeITF2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:28:23 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:19617
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731661AbeITF2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8C0XcCyuzvFWOj/v+Q0Ek9QQBBN7HZQHE3u94LsZL8=;
 b=pxvo6bXLmSr/QeTqkKByLZPz89U3MWyc4zcX6k8rA29ybRhIM1AxGS4xT5PqHZXMOy/34Enta5B/7fqFX5N9L6DkVSFG24QhZPFQ67MPfsv5KtkcIuVo2A43F4q4IwYGXvTM3u+13v9bdNOfOHXn5N8xwMLow4pBfCN8w2E+2ug=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3788.namprd06.prod.outlook.com (10.167.236.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 23:47:59 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::eca3:1c00:bc20:bc48]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::eca3:1c00:bc20:bc48%4]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 23:47:59 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Russell King <linux@armlinux.org.uk>,
        Todd Kjos <tkjos@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ARM: amba: Fix leak of driver_override attribute value
Thread-Topic: [PATCH] ARM: amba: Fix leak of driver_override attribute value
Thread-Index: AQHUUHMynf/Q+zpWgkChZri0urm0VA==
Date:   Wed, 19 Sep 2018 23:47:59 +0000
Message-ID: <20180919234721.16042-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR14CA0039.namprd14.prod.outlook.com
 (2603:10b6:903:101::25) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3788;6:bgju9PBgKTZvEEx5sObNCJXysvS0TzCpSFuLWOAN5mxiOMzA03/Ks3LGuYPsQj+astc3M1YOiCsp3CuNSd/sFitPzfk+wzf82xzzv9S1bAZ99vDBlO9JQ44OapQug2p6f3S2LoV/ldcyuVbqaG4j42hGdmO4qR13oz80ce17UF34A9Co6MvNtR3y+0sO2GUvES2O+RNEPAVd4/ZvA9XovN+LQUHKwZOlMO81vlx4j5FQ0eGhEecwh8WPVWHjh6eFYm13NfMWLZWInK8j/cmQzFDMyB2tNRxXt2YXumnk7dIBUhGqUtd0VZM1YaZ9pJLt3WMLiyACrX5o8IIZ0uLtSNUiHEv3sB/+zqpRNPYG6cBdKcIJRceO92uB95BggxG4PwJsGVY/77w+oMuSUWhsZFVRC0Da24MbMoq8etWcY/4Gdvl9mdrPtmEyl2LJ+PL408ZUZj2s8bp3eCeAlbNEqw==;5:FmFM4TAH1gbXHCZfrBxFa7ePTkdE9o2p2q1CdqXng+QJ8C+RmNIbpAV2UE1IzYgVTSPtBNPAdCamummilUA3ekRpgerw6sq/fFg0KbETiRKinxdajYL610NEiWNgXL//p4v80jCNVLaPtYFIhOkLcXeU5oJm3Wk9MQAGgyj/wiE=;7:v82e/moh5ZmAmDr46TjtPY3cPehaC4aO6ghszf0zlI0gkZVNSBV6yR8kp2X8+4jodOQCZuGfX2PuzPy22CxqkUys53wzkX9iDkYf/DI7helSAK2GjwrUMbE0tcfWDuQdfmc8Qhk+s9UelIwO2koHM0M/dVuUYamPQ+v07bCqsaiSHqeddlvXqHejk2lGDepGzsXsDLD92O2N2DR7/J2/FtE22XrykUZFpH56Auv4YZruIek5UhI+qzrklb+gGVS/
x-ms-office365-filtering-correlation-id: 7c314246-279a-46a0-648a-08d61e8a5442
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3788;
x-ms-traffictypediagnostic: MWHPR0601MB3788:
x-microsoft-antispam-prvs: <MWHPR0601MB3788D4CA3C4795B647B3ECDAD31C0@MWHPR0601MB3788.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:MWHPR0601MB3788;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3788;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(186003)(105586002)(305945005)(86362001)(66066001)(478600001)(53936002)(7736002)(25786009)(14454004)(6436002)(2501003)(3846002)(36756003)(5660300001)(6116002)(1076002)(5250100002)(256004)(106356001)(2900100001)(6916009)(5640700003)(8936002)(2616005)(316002)(476003)(6512007)(52116002)(81156014)(99286004)(486006)(2906002)(2351001)(1857600001)(68736007)(54906003)(8676002)(6506007)(26005)(386003)(6486002)(97736004)(4326008)(102836004)(81166006)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3788;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LadHiQ+zMXLcYMBsHRyniC8FXtaDYoCGZk0QzZzvpgAFtjXw5WNWoAVIq1O+xjFElhdFuPf5l9z2/FtWQupwFDnjzpH/wYZU/T4ytlR/8vExByLQwGBiwDIzFUCwO+PoyvIZLWsbXi9nCQCUBLhkA5RXlCwg/GOmUqRkAvmPMgdVygZ9BG6QnDzu3vFY+1MWNE/Pj+gxKM23tIBkcXFUDISGlxO+PMR5uYdoeJWSjj2lXAoTM7fgBu2bOq4npPak+w/+Ys421aWa8YTtQH7xEyBEhTjZOhfZiOYzUycEwjnyFFZuxEInvqc7wjcN0MBwAWuBG6O4Xlh8uLi72UDjqzBFbG6pljSAqhpyqse587g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c314246-279a-46a0-648a-08d61e8a5442
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 23:47:59.4266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver_override was set when a device was released the string would
not be kfree'ed in amba_device_release and thus leaked when the amba
device was freed.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Todd Kjos <tkjos@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/amba/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..ff3cb96526bc 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -347,6 +347,7 @@ static void amba_device_release(struct device *dev)
=20
 	if (d->res.parent)
 		release_resource(&d->res);
+	kfree(d->driver_override);
 	kfree(d);
 }
=20
--=20
2.14.4

