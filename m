Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC29C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F0205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RvzKlfVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061F0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbeIBRb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:26 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730004AbeIBRbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkbcwKQO3+cnVqJHL12xsiPxLRvRnKQ5wzsA5SwdPj0=;
 b=RvzKlfVetcCabokCwZUttooZUYfiBpz5hq0DdH8lRDRgDNrhTrxllUPf9rWPRNbsjEZQy8j+wx9cAjZXy8lQQKNO9Wy1PKyNp6BPRe7A+RS7K8Is3R2+14KMBV8z0o75F54WCJzDhcr8EX3AynouwlhSQeo9Au+OmsqVQlF5gDs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 53/62] ALSA: sb: Fix PCM format bit calculation
Thread-Topic: [PATCH AUTOSEL 4.9 53/62] ALSA: sb: Fix PCM format bit
 calculation
Thread-Index: AQHUQr742TDtcS2qE0y4qKQQGPcpVQ==
Date:   Sun, 2 Sep 2018 13:15:08 +0000
Message-ID: <20180902131411.183978-43-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:le8sNU9xg9GjmdPfcaA0aIwnQ/QdmWR1EEUOPb6iL2ulrWz1N4qc08f21qWrMHRPeMMQOLh2MsI1ZmZAmR+Tv6SyOeL0X6YtS4ddfGaZwr+DdG4V70zdgkPEv7PldtxQ0HIGizGEEt53wLN0yG995ePitKLhBDqhve0TacZM70mCRdig1dW+XCMacjmjRcLbrzs4scSSmhqQxsNdXUZRcJp2FkgbU9sYk5/zkv6vMjym/RDreBq8ioClldKDzV4JGSzITQsI50U6mJvY4yntSg00PI9+08dDa/g5hLM3cXce5o41fovxWDhwTvmpm3eiFzh7erw2+X5FBA05/aYDVOVrw58JF1gH8hBm2PKkPz1Km/7xTzlPpiF3Zp6pUbpALKe5/JBuJIdZbgS+XTseIdorIlQ1YS6yACUm+3J1ul4YZtYSK59zlWhI/4+aRCKoAnGTcudie0V3hXuITxehKw==;5:lujFBzRcsbU5XYDgGXoNJlfc5XTCJkoFb1Cowfo/CC/ndGCiA5l5BE7oPzWhjA40fWJi4qm76Sh443D4JxT7c6nxiRMmMihUWMhRH3Mc9yLv26KPJrh88fCHIGkH6I/eSuHU+G2Qzj4l7EuDjFaAhbMR3uR+vBYsFfuNEtHb5Xk=;7:gplnFoz1E7BXcmfRJgJaDnrfdTkKj8ECXw/1wzGwek9XWu59V4A0ZRdQaDjp/xQJmdMNm6pwJgvOQWcJtTE07d8lrY9bFXzABWZVt/K1zF7I34jP9wDTO6BmGlTZMjiaWMHwHGUs935Gc+1DRxdfUWBH1au2/N1w5CaKxOhoAA2Kf7MjK43sb5AgzU6ergsnPhN4Cd5/8xP7ucsyb9P/WVyfnzMqJaIlaBt/RSi62MpS38bS6Z8DLwJn4owBprRy
x-ms-office365-filtering-correlation-id: b24fdabd-ee2f-4431-de0f-08d610d6291b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01840334DC0F68075FAC78B9FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GfQ9we0HcSZ1Qc+TLwDfxwgJu+yeQKK03blXTcVR1yYGyz0Xaaj0GN9/vEC9qo5SwMWQ/vi9o1OjOGLxr4yu0fJqXkgQGkr28oYow1VsUc6bsAJ/KWW1UIyjimMVpb/limJjUv2DjIUdhULy0xBgh/UGr0NG6MJiM1cVi0VnC8HntUT9tNBozy3e9Htjj1MLsfPBa38BfGMK2vptojt1g2144rBA79D6rbLL8oy09Dn7gD8NTYxGpylcTO/M4ccCh0h+ExlmLrZ1e/vRgsDBk5KV/cwbc6xEYWf8bgzWLMDC53oLNr3r4n2Y4bCPriAzSfhsIG3xRzZUVQaQyPOh7nHttFd94up/hyoQxOKBY9U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24fdabd-ee2f-4431-de0f-08d610d6291b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:08.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 8b2d6c6bfe97..218d4193791a 100644
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
