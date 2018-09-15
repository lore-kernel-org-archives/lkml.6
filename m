Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDEECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADA921477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ch2IOpkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADA921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeIOGwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:32 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729865AbeIOGwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQux7lQxEs9iSg+V0R4RXrGOYibRjSc+MHw1QbPVXhs=;
 b=Ch2IOpkgw7GMScAZyaR2TpCYdx9dVaakaJvueA6ORl8TyzQvTOAj7HHW43xwyTlfr6mdOEATlKa3/ZLr6xbqfdYcKhRSaEoUA75T230fdGROcyHkXSSji/enbef823h0/nGgkZpD2QCBqXjsJkroT0pw3KlTwy7jbmXqpC88BUo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Timo Wischer <twischer@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 16/20] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Topic: [PATCH AUTOSEL 4.4 16/20] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Index: AQHUTJRZuDenlugjPU2YgwVfrpvkow==
Date:   Sat, 15 Sep 2018 01:35:14 +0000
Message-ID: <20180915013502.180110-16-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:iKcrIW/jN5aJJQ3Tthub3tGL4SPfLaYp2BYoaxv5d4Ya1kKrgo9y12PVn3IZxT0s8aA5dp9N+De5l9bQqKm+x9Ohlaz02VJrdXsrQS4uJ0ZpDOxGnSQuKakxsdwpDzkXBgUfVFhFYyOgZ8dT5/ucVBA1ciU1lw91nRQ6hyxneA7DVykgJQQ4nCL4ADOPPcGyFjivZFraWRnBb8rV9se2Kc0U2lrP4/t3S56zdIznUl41ORPNYqlnMVnacDzbaH8Whz3ocnXnAbERV5DElL74+8WfDu5rkvthApBkH5DNN97afqSodF+f5Q/w2wPEjfkhvZ8qyYoW+u/urqVIbllT3ODfUd5zEqmS7qkgpoQHMVj/Uka8mtLGFu1gAwAtvTBdVrSXhlrrsMe+P2sX67cffNqETkw6SCLS6kfpxKa5jmw4dGNc2cmFQTOQyS4NyLt3UHwruEZ/uAH4MpDyPdsJaQ==;5:Idwp7trCiz/cIthUyDjLljflIk40TLIHbSrmVDf0WMP1URvzFB0HRkCHOcnraJcaz6NgCiO7aHuCSplyYlSz9Rbgo61+8DAqcwi0K06sItLeePf3D0z7xR+OEbBqh2Xl0Y0AMtU1LBaUNlMB+kSpOt/bTxih6qb8jUR+RzDkfK0=;7:p30WpYpwphbR01c4IyMi+n7+og+ciyGju2e519fPK62XFedXoHBSUfi2Zsw1FJIKeNG5Rcs2j7tLuxPFS2O1Z+IXZN2WCRLQG/X3IPcarSd8iBEJvy86kl2Z9xCNp5BT6b8cUg2N3PVGOJ56USoaJa4wzwpwGmkOmTQW+U5vEtwhLfaMV6tRa8YjY1KxfKIZnAkyIwhETFzWmcJDqtW1JE7wegvN4mUKoIL/1os0V0W/Q6bXpu0E0zabi3KildAL
x-ms-office365-filtering-correlation-id: ec675f6d-3fa9-4b0f-4075-08d61aab8132
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181393025B00F0FB60C0A88FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Px2ITHR4AJBKaOQFyc74vz4ZwMjXzn+WFHQtQK6Ti/pzNFqQtwz7jL2gj50743ZMESRRwOZrP48TjB4AlZt3KCUkk8r+Swn8rnssTrChGWL9kSI7aF+agtgkAl9PmR+zQmsxnqhzRtY60F2IsxLP+Ij8EZf/z8K3Pz2fATu0zAwqeaxChrUfAv3O+fLvW624g4Y6DRRjB5EfMm26xFV79EG98MVqxWPiFurNdYUv9k7eNTSZzXf0z0JWFcHtMd+2Z4d429zfTYHiOjiYJY2Aps1ATZ64bXWNRNmSL3S1M8PayqazBy3aGS00UugUfyVilgF+WotEC9Cgt6bsSPo9rhH1NdspgSdUXRm081VYF98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec675f6d-3fa9-4b0f-4075-08d61aab8132
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:14.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 4c145d6bccd4..5bc7ddf8fc70 100644
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
