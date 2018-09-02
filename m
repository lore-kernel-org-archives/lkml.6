Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468EDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A3420855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q/QdYqeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A3420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeIBRVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:34 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:55808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728696AbeIBRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHH/pi1sQZSaBy+eoNSjGCnWWz8y2YFIAJXZ1YGMSiE=;
 b=Q/QdYqeqJk4KQBcFdtRzb0CLt7CoAZZsAo0Fb+DeokJ36L/Cv/97DiUGeCHnQxBCIN/ljxq3zSA8HvSWbkYeKRBGoqPc+h/cIOCOdgYcapjWIwMG7gaBSmFiFbdGayZ/4l0V4G8NJa1rnkqAjk+ZVGhRLWwp6kjVUlFy8EVWUFM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 117/131] ALSA: sb: Fix PCM format bit calculation
Thread-Topic: [PATCH AUTOSEL 4.18 117/131] ALSA: sb: Fix PCM format bit
 calculation
Thread-Index: AQHUQr2fVXyRjvJJEU2mcJcmNAcKSQ==
Date:   Sun, 2 Sep 2018 13:05:28 +0000
Message-ID: <20180902064601.183036-117-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:91oxPVVYUhy/9E+t5FYvjInCQY4V88U6ggzO1ncf4e3B3VMctmLG+tDnb95FPhPqdos0s/EcGDUbiH2Q6wCpP2i0EWkWSwXkGTedvLXCOPxNA8jSLzr+one21u0V7pED7K8fve1mswUr6ionE8e8kh6medqgZKGJ61oUemxCoVevMyy+P3jurcFJyO4f58X5Y4ZDZREdwpipwrA2z7egTv0bv3BRDDun+JRJdTZ5Kd6enXoYlZwAgEshSpL/xY/QGqDuItURpgGBDqTaIfA6kKjo3C8+xCazYwpXPO3sI4iZ2tBePjR94djB2wsmteWWEj/ViXfCdxi3ECu7dV/uWgs9o2L0id5wTaNvSJlEYuEl7Q38OuL1OoKUtfepxZacFksnXBsCc8fQmhdxDyM45NvoEw4qxdowThDgu/atEs+C51Dc0zyLoszyDBNEzaB6AlVzCBY+nFx5BjwmTNKYcA==;5:+OLd0rPtX3fxkasI8cMsoTPVyxKFMgn6kpVsUUYxP6jzyiv2Jru7XimFVk9U1IiqDjs23nmqJpnns1V6kpN+tPbQk6rGVbBDfAvNgZgjnaIsMeZKCKwv7uEUnHoocl/5hZDf2X4T6YfYMEjhvkwdDqEFIxrw/SY6Tno/nzJhnGE=;7:tn5uBz2Eb8POxgaoDnPeXYGAJ2W/onfT8c/AQQ5l+B85GtLt1BdU/jv4+PC7QxyuoQkcGi/w5FFBM3cVuMQrIendPT0olzeUqJ53M1//aOmwtcXO7fbetjTkFUKouWQBEorUq2AkbHxFzYFidlRWRoUsMd3fgMMJd+KxUMLxZpmw3gsFTD/Zgp0F02DAqfa4bpgBZdA0jhEQ4vEMfLrXVf/T1rA+CBZHlRE/YvsgzEJKhtDX7n4i/Qlg16uHbeeM
x-ms-office365-filtering-correlation-id: b2a840a1-bc5b-4b7d-66b6-08d610d4c946
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062996E5BF812653DE9A5F41FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: X1S7l43TncUEljYbn0s45Tubgk6BA6kGTfngEGcX3hFhPaFcVHDpvPsAQPvJRUeq+Y01S0fh7n5KdzJUVzmep0/iQ/tdMY2ujeAO99B9HS0lM56i0RXygrlfOyshcTuo6vcmXr/GvCXe8pn7P7Xbi0kvKgxpelWadsHaCNYd6vcH5Iz7XArfDMFEJHx1tW3zxwjQ2mNn8VpvoM7JcZ5mjZc7iPhso9pjo7LrYwIDIIHNzsi2/xpXZ7Hh7DE/IzK1xWS1dWkIO/Nz1ZZOtji0z97yrGHZzJtm1vt2rZTCSNKKBsrDuqCsEorR6ODyFODC30p/VxNRzE/rg1U9fwEbn0MwjncIUsUPlt0VSXGGk4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a840a1-bc5b-4b7d-66b6-08d610d4c946
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:28.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 55ff2d1ea5487fe131cce399baf4503dcf5cc8e1 ]

The PCM format type in snd_pcm_format_t can't be treated as integer
implicitly since it's with __bitwise.  We have already a helper
function to get the bit index of the given type, and use it in each
place instead.

This fixes sparse warnings like:
  sound/isa/sb/sb16_main.c:61:44: warning: restricted snd_pcm_format_t degr=
ades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/sb/sb16_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 3e39ba220c39..11ed4a6e5bf1 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -49,6 +49,9 @@ MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Routines for control of 16-bit SoundBlaster cards and =
clones");
 MODULE_LICENSE("GPL");
=20
+#define runtime_format_bits(runtime) \
+	((unsigned int)pcm_format_to_bits((runtime)->format))
+
 #ifdef CONFIG_SND_SB16_CSP
 static void snd_sb16_csp_playback_prepare(struct snd_sb *chip, struct snd_=
pcm_runtime *runtime)
 {
@@ -58,7 +61,7 @@ static void snd_sb16_csp_playback_prepare(struct snd_sb *=
chip, struct snd_pcm_ru
 		if (csp->running & SNDRV_SB_CSP_ST_LOADED) {
 			/* manually loaded codec */
 			if ((csp->mode & SNDRV_SB_CSP_MODE_DSP_WRITE) &&
-			    ((1U << runtime->format) =3D=3D csp->acc_format)) {
+			    (runtime_format_bits(runtime) =3D=3D csp->acc_format)) {
 				/* Supported runtime PCM format for playback */
 				if (csp->ops.csp_use(csp) =3D=3D 0) {
 					/* If CSP was successfully acquired */
@@ -66,7 +69,7 @@ static void snd_sb16_csp_playback_prepare(struct snd_sb *=
chip, struct snd_pcm_ru
 				}
 			} else if ((csp->mode & SNDRV_SB_CSP_MODE_QSOUND) && (csp->q_enabled)) =
{
 				/* QSound decoder is loaded and enabled */
-				if ((1 << runtime->format) & (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U=
8 |
+				if (runtime_format_bits(runtime) & (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FM=
TBIT_U8 |
 							      SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE)) {
 					/* Only for simple PCM formats */
 					if (csp->ops.csp_use(csp) =3D=3D 0) {
@@ -106,7 +109,7 @@ static void snd_sb16_csp_capture_prepare(struct snd_sb =
*chip, struct snd_pcm_run
 		if (csp->running & SNDRV_SB_CSP_ST_LOADED) {
 			/* manually loaded codec */
 			if ((csp->mode & SNDRV_SB_CSP_MODE_DSP_READ) &&
-			    ((1U << runtime->format) =3D=3D csp->acc_format)) {
+			    (runtime_format_bits(runtime) =3D=3D csp->acc_format)) {
 				/* Supported runtime PCM format for capture */
 				if (csp->ops.csp_use(csp) =3D=3D 0) {
 					/* If CSP was successfully acquired */
--=20
2.17.1
