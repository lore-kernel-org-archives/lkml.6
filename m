Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB7FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15F321476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PbkmNnCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15F321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeIOGxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:53:22 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:53808
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbeIOGxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JLJWhoiqieJeC+ygac2Y+LSd5dVt0lZSWQPH7AWkmg=;
 b=PbkmNnCER528MC0dAddhZ7/ceCv8dv96JrwH9lhT/EMRS1w28vvnOcdfegv6tAvnL5qiS8g/b8zPx5FQRZMVipB3Lq7HlWXIABIqFwndVPK2FzsedhGBk9Ak3BkG3ll6sPxBfQ1Vw6lDWfRUXFe/NB4XI9DzhK1Cfdm6WdBBAxQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Timo Wischer <twischer@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 09/11] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Topic: [PATCH AUTOSEL 3.18 09/11] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Index: AQHUTJRjX1jKWmj0jkeavyHWgNxwGA==
Date:   Sat, 15 Sep 2018 01:35:30 +0000
Message-ID: <20180915013521.180178-9-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:0xh2gvikRN05eH0GpUqv+pPybWNRPakGSIvW/MPW9VQ/qIUX9p7IBvAv/sFYJ4hU5KA/uMq022PHLXlcH0hYIw7UztTUPS9sMaEkZ2VGd+iMk7GjJeZjsHS/GW9f7+5Ow3WgCaoN7z71F+CpCtacOxd1LOysCM768sUwlTE0gbP3ypETVmXhq95adbR2MW2uFqHYHwSmM/o28eIGt8pu1uad5l56cgDI31zBux3zPAmrB4ftAwA23fHPpviiyLLug7KVQgx6Ir8NCPeOgIlaXJpUusDdCTPSYjP6/4LHK0/C4RadW1chP2fDSSGVLz4rqJu037l+7B7gQk1HHn7jtEgKHKEgn0wQgOZ//B3zvOux/P00wpCvosfgCUY/h0MNWeriQwQFnP6uffieMMco8Egn0inIee+/uZKT5BA7GezNwN+i8lTN9/RX2eMEUoOjkv255B1fbhM7/goAAnG5Qg==;5:k8A86IFAoq8RFI9ajbjSwB500jSSifa3gv6NTlTfJLrnWcqjc4vss5rWsHZNnpgQKEL5lJFk7y0tYkSZyd9BD6dQmSLOXScd4694hOSr5erIEnUiBlwtKreV3CxOsq1H4ZZXFlITiib2+8S2dXh0+Xv5qCojRR/MjInNgennW08=;7:dzaWH4OIIh5ceauSoLtThyVf1BZ7nDQAZrtskVk/dqYsrzTzeRxiC33ZlpRanquBdjyZZOnM7YkRDwy6aG56gHekkBDLLsDH8yZ+6O5iXLDYalpsMyL9fRh9fNFjwaIUm8Ht9KuLO3xWSlnL6CM/xvUucIf7oGbamoxjeEICLXAGfllDiyYLfM+714eloHOoIL4f7p3V25guywSwmqPZ/1l/czoSUvJe7y87YfimGz//Kt81D4rKWiUSSVSr7EAE
x-ms-office365-filtering-correlation-id: c24ef3d1-eeb7-4f21-9ff8-08d61aab9744
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB028074419A084FEBBC0764ADFB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ha/4q6UbP7FDm3oQwiItkwz8e+ZINGZXU7HSI+PIxMt3qAXvtVHwlXRMpvKxP+py4gflunzeKP8TJsXEtFA5iLMT2vMOQCoPWQdXrBGxJQywCVena5mEqBOddD2S1K+C1NMr+qghUibyZYI6EzxwJBjQFeScn39d/+j9Bg5f9Wx3IFB/eTpl4hAWM+yjLB/O/EJJlbBjPEaFXcwGpd56jIQfdlnBcKjZSD6ljdr6L2Xrci96UttxKtRs9bGX1759AAynKvjZzmx2sTsiKx3/lrgh1OZ9vQH39qGfZdk+QJFv/y8wxdp3MK+mINyKzpZN81l1At1dJxRVCnhMtyxEtm1eD6ZCvkFukiEbtFfiAuw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ef3d1-eeb7-4f21-9ff8-08d61aab9744
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:30.2067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index 8f04ccc44eee..25d4d20138fe 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -714,27 +714,33 @@ EXPORT_SYMBOL(snd_interval_refine);
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
