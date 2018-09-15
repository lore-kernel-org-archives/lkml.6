Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCBECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0088208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gbDQwQFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0088208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeIOGvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:51 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729750AbeIOGvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDpyaVneI3F829nae071zOuuqdJ+6QNKuTkUpGqPEGg=;
 b=gbDQwQFj/empIGnk+YjKDbnyS1w93PLMadTMrwF/R0CEp8K5SxRcCDPYnXbC6LzKrWdE3PQ7jn0/IIytZ2QN0OJJ/GsJDp/AMHKMCLSmMtL76uJPAwA7dTi4KwBASghmqjMMYxvmr731RNwMWgBzjoX25M7Elqf3Wk8BRqRi1Zw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Timo Wischer <twischer@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 27/34] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Topic: [PATCH AUTOSEL 4.9 27/34] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Index: AQHUTJRGxR63/PPzoESU0iC41jJrmg==
Date:   Sat, 15 Sep 2018 01:34:42 +0000
Message-ID: <20180915013422.180023-27-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:4odwblxvjqhPwB1BC2y0dkK8TPS7hnzmM4HqYRIeZ4bVAA7ge/jz0nRxoBPmoXKi5bbTNr4dwwwp08X4Jx0BSQRPBD1iTyfUBjs4kAPIkNc1bpYKRxEYV/MKHSjWD6DTvyA+9AyDmp3ZRDrv+OBlt7u0qErbAmfpKji7WMUGi9FN0hbAMxf/2wGJTw4yqcTh4Kx9RbPao7f6UEHGFabDLQ18vDp5MWArcdASUvrdUy32Gl5XbycSjVbOIUmeUicg5kkpmJQQOnYL99p2mbDZiNp3nphsok1KXMFI3Rg93qIiJwcCapOw7ytFpjBBs8Z6H2e30+mUKPoRDHfTwB32FjrSbs6o027Xw8LWTj38pCteY/9LgWiZmcqrUozNCNv7tuyC8K4gbNPqyGjVzDB1apCr5yb0PFKrpAvPIiKqKCdxy4Hu21UlJicd8pIFP0eJoew4O47680Zal6X2YAs5pg==;5:q105C5hHCloqvElwamjtQFzk9nUkYtqll6iPCOt/3XTLfqwe3axwDq/1gyw/PsEdtO8Sks6SSpadqyQ9JiSeWXgkz+4TlQ50XdbBQ9xW4nl/pN8+5YyXadLrKHdp3iBVbN4w2rQElu14ia5hsFXQTBWx6R8hwS26DDWQ4E7Znic=;7:jD9Au8saU9WFjC6O2vwR7R6JTQCZ9D7mwx2ni9dJfdOruEng8CzWIN9puivmxklggbGFjKSD7v0ntYDm3k+WSv8zRw5KVUjufQ4l3eVga9dd2wXfqWKBrBFJse6AgN+72IYJgnE7/avBOQ6MOxnUvBjR/RAG6Np76BPaF14Y8l9PNzIuGM4auMLrfFQDWyN4kE7TKXJYLzIj3XOsuDwdGhoy8Ufgu7I3TT+RePiRjjOiAIJ8rgVHgrjlI+kW1zUS
x-ms-office365-filtering-correlation-id: 5874813d-13cf-4ca0-d0dd-08d61aab6966
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB082372488B5E0B05554E4205FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qeJ3TEVj7fZsIICbRTZPb8a0FaQHV3t1WlgZD8wN1wBtqx2EKCDCPgI7kh6qk6yH9Hxr1TA79vP8CGlwD0MvvQ+SITm8Yb1sahLPuaK2a1/NRJ9xdxlu4BmccRv5P6HVFXYpiSsrOaIp18e8Dd6WsrB4kZryqaV2XNacyAXIiO/JKa133WpON20HDOphOs4+sQTXbdV/x8njNF3qrGtNgo2OrT5mFGtvxaeRXegol3GAzVyQs1COiDBDMj/LaX+fjMdt+G6Fs5cDw+uvbOkn7BOc9AIYXWm85SAAlIvmdY+0CWRWur5ZdJbM8MYrGR5V/DxPOL5m1q8C1LqzLLD3ExYLkUjoJeMwsjV5WvmA6N8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5874813d-13cf-4ca0-d0dd-08d61aab6966
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:42.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

[ Upstream commit ff2d6acdf6f13d9f8fdcd890844c6d7535ac1f10 ]

Without this commit the following intervals [x y), (x y) were be
replaced to (y-1 y) by snd_interval_refine_last(). This was also done
if y-1 is part of the previous interval.
With this changes it will be replaced with [y-1 y) in case of y-1 is
part of the previous interval. A similar behavior will be used for
snd_interval_refine_first().

This commit adapts the changes for alsa-lib of commit
9bb985c ("pcm: snd_interval_refine_first/last: exclude value only if
also excluded before")

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/core/pcm_lib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9306604f5070..f57a58ac7ae0 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -648,27 +648,33 @@ EXPORT_SYMBOL(snd_interval_refine);
=20
 static int snd_interval_refine_first(struct snd_interval *i)
 {
+	const unsigned int last_max =3D i->max;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->max =3D i->min;
-	i->openmax =3D i->openmin;
-	if (i->openmax)
+	if (i->openmin)
 		i->max++;
+	/* only exclude max value if also excluded before refine */
+	i->openmax =3D (i->openmax && i->max >=3D last_max);
 	return 1;
 }
=20
 static int snd_interval_refine_last(struct snd_interval *i)
 {
+	const unsigned int last_min =3D i->min;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->min =3D i->max;
-	i->openmin =3D i->openmax;
-	if (i->openmin)
+	if (i->openmax)
 		i->min--;
+	/* only exclude min value if also excluded before refine */
+	i->openmin =3D (i->openmin && i->min <=3D last_min);
 	return 1;
 }
=20
--=20
2.17.1
