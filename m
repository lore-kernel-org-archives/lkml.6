Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5667C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E73D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YIS32osQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E73D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeIGFWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:22:31 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:44004
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730534AbeIGFU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTBS0LSBmqwz9m8WGph0upc88iyGYafWd5sAll66TTU=;
 b=YIS32osQpXIlBsu/5UMf/ePBG1u/+i/GMZZUuz6gVD2oRFjhB6N2g6BNyOO8rSECcZ8/194Z/BubnMBaOusn5Egq0w5sGvFEnD7jsWUGDPTbhkLqlraC6H7a44Hvh/1dpbUjH5aQlE69m6nCUXJFnXsI5z7vFH0QdxKoM+RaP00=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 01/19] ALSA: msnd: Fix the default sample sizes
Thread-Topic: [PATCH AUTOSEL 3.18 01/19] ALSA: msnd: Fix the default sample
 sizes
Thread-Index: AQHURkM7ftl+1OV04kSgrjh7/bx+eQ==
Date:   Fri, 7 Sep 2018 00:39:27 +0000
Message-ID: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:pGI++0uMZqmbZwLVG41LX9QCM7Dob69sAYkcwUQ59GlZmYbXrn213pYW5KXO1rIN5UtZkYtYY9n63sjBZCGoi/ZIE+fYM2W+wHg5iP+s+dN4OT1SzLxdibFooBcIbbkRyJJGsaiQjtpaOIt9XghORsCpXU8EjmmbKFbw3Z5yIM6SrujhUt1uwTJbVM+N4C+mFZCnncXt/GhwEfYzmxaPNVkzhhU5CvKyDlUMnlhR7d3IU7XH4C7zQmMnz53hIWdgJYuNoWvNSGfVmleZati79fOorLNp7l8KjhKWPHCsn90jsJxiJuwgL+mJlTMlV0sqkALYrpu0gieYEfD84M7Zujf6+56cw5VhSVePgPlJXcvDsW6xPc55Pz16c2dgjbHLZJ6F6/rkDFsNBOXXopjYgnGCkCP1rBm5k9kY3LbknNZ0Hju44Y24s3MRGASn6/Gj76S5Y0doplKprnjM/es8lw==;5:ff4u5fsjYvrwZYRwcKApAVnmfq6ILoLpBXQP6BfzUSLmYR+U5KmNn11xygxBwb4HxcHXfdQ4CS0Gb56XCMg7bOvjqIafSvr3UunVTtRyjElTyY+CwhPCZQd6PSAkpS4XyjFrLPMFd4CHK0qcsuoSo4SB1Bdr8V/FwkmG89Cw4uU=;7:OZJMjFJgtaitEpTAibixuovq5O6AXARu4PAogc4LY7+zjotz+Js1BrDaNzwCWD6mJjIBMMWZfkLpkNAkRIiiFopJs1EOEUQi5ywzMkWZPBXhEnS272Y79gw1jE400XTS98OTJBOWNGJKgynQInzPqDwrVErb40/BfYNteUxUisVbjZcSurVMul1HZbg8PMSkHVQVS7MvjFxJKYnQ8gm7rQiQN/g2es0XcRVf8Rjmc7XFfHQXD7fcOME1rOUAu/uK
x-ms-office365-filtering-correlation-id: 25ebfbba-ef2f-43ba-d8a6-08d6145abe00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822271948AB8C2E7EE8DFC9FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(107886003)(575784001)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YVaOirUQSwH036l7Foxy8b1wiTBfJFjyeX1ZrExb/+FrwOQZycRYHoODunYnPQr6Uckx4RJzzXzV8/F3VWCtt3iDEJD1GBKA09oz9AVYEA39O5xAxIhAdBG574ztJRoiZA6BaC9aIdLVVSkoLibMgDGHD+qQ7xw1aNnZ0PeTAE/X2UzYZz0FnNY0Sie55sZ7esDsdAHTdXKEvx1qaApIof2/+xCe9MYMyUTuywb7VXzopWhl3JqqnRN+6i29Rp8EqcRAVL3bALc5aOaC8YHAyWdTtHk5/GLG7CnsHjTGcyeg4eKCFPuEMZOsJup/g7CGIxIknfeAydZc0ht98JV3EkYvAmELR+5qmkfoWSK7XjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ebfbba-ef2f-43ba-d8a6-08d6145abe00
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:27.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c500f9ea139d0c9b80fdea5a9c911db3166ea54 ]

The default sample sizes set by msnd driver are bogus; it sets ALSA
PCM format, not the actual bit width.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/msnd/msnd_pinnacle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.=
c
index cf70dba80124..741714332365 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -82,10 +82,10 @@
=20
 static void set_default_audio_parameters(struct snd_msnd *chip)
 {
-	chip->play_sample_size =3D DEFSAMPLESIZE;
+	chip->play_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->play_sample_rate =3D DEFSAMPLERATE;
 	chip->play_channels =3D DEFCHANNELS;
-	chip->capture_sample_size =3D DEFSAMPLESIZE;
+	chip->capture_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->capture_sample_rate =3D DEFSAMPLERATE;
 	chip->capture_channels =3D DEFCHANNELS;
 }
--=20
2.17.1
