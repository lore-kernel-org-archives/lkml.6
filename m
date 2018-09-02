Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D73FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5DC204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E7q2eEj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5DC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeIBRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:31 -0400
Received: from mail-dm3nam03on0131.outbound.protection.outlook.com ([104.47.41.131]:2512
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728146AbeIBRYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHH/pi1sQZSaBy+eoNSjGCnWWz8y2YFIAJXZ1YGMSiE=;
 b=E7q2eEj0SdzhfT7N1OsTivuVVXuWRPmY6NYMlhsGh3IElDzEhum1KxM7LBQvqu0tO7C5m5HbaLqxzYQ5FbMCLAdHMhfQi+aucSERvhNfP/Oxokd/vq1wnC8FxJqAyfo4OidHhGabuUlo18Ppp1RfeK3oxwLHsNQ/h4fX6xZQ07U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 80/89] ALSA: sb: Fix PCM format bit calculation
Thread-Topic: [PATCH AUTOSEL 4.14 80/89] ALSA: sb: Fix PCM format bit
 calculation
Thread-Index: AQHUQr3xjvPbNhQ+D0a1HrCfuTrUfA==
Date:   Sun, 2 Sep 2018 13:07:47 +0000
Message-ID: <20180902064918.183387-80-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:BNoEDYQDsNnitUp507XoINfBRm5+QD8EEOHs3kYJ+tKbk6eTON+SnsRAWnL1QZhSbmvBvJbXlmOKN0cwkLBt8wJDb2ylRzyH5I32mkNrxTAIv1KdYLQdhFJcgLonEHHAZhVZiLoIF3wMJaG/4QMq19g0qmG9ZBjURkF2ODC+Ea1vmoeuSd3DAPMQBNISezj6B45TcF+cExRHmSbldxMgS5wDTMGYQOlj56XU0S+JmPWd5FKstzrTkwYcBXnLO/MfCkeLMVCvHZ2smaqk4ubdXx00hRI5iDv2qGsFm55nc1FXjYW9lS+2ih1plbF7LWg0fY33wtk8/YliEZYQHDarCL7pMvInUqpB/kaohL0ytgCg0YMG1WULcAzh+tMkOCBb/FuJ54WEkEO+NhIdki2TU04WSd8r82QUi81pJ1GqBYFYF6ncNRmGkrw8vp4sxnOBybYOUiBwrynYOsAOgsY3BA==;5:BVEjQlNIFyNLiisMVBMuMijvf4cvcIHQdHJz6ikW7rI/9a3SK24sy3dExjdvFRxDHHYcQ1Zoc1+hpSPF6M85Vdaa2Qyi3sTLE4akWaQ3V4viGs6rHZ+Jk5jPCFwLjMkk11k+MHe7hBx/uX9lCJB7sm+VFv93qCrCpdaw72BmV+E=;7:8EgGIO9fpyj3jvhZXmrN0iJdYgsstKSyaS/o2GrvUZAZ5/HGPqxj/TuNrGPJmPkXCfOLycN+pKwZPPeFJrQPR8nMq89VtAj7FaFM0ILb5qtm2ZoJKikjtlZYdkMQKTAYPdOrfmPetvx+fqZg62qiXtQIPUReQ0+bec85FTjNUJtwkd7te3usd1mso/ALvAyjZhyDSPKMHhMj/OV3mYKJZZen8vVE/8xOjuK7zKTrjFsjUwyuoAEDPoCBSVh3Ij1S
x-ms-office365-filtering-correlation-id: cd522b21-800e-4f88-a050-08d610d535f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB014967B6E56F813D6FFA79D3FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FE+uRl7rT/FfdemSkvW3OE5BzDEkaDtvdcnMk3VbFi0yWJDeZDuDsvNLAoHumVKJcvXIt0KJSmjWd6SEf6W98JVJOxCf79qwJcGGaRNJZO3eiSWJlJpvT3BpoDNfwPJlHS7OPJXAufNq/NxHHWFcObqDHzRhiDfDKvh1odqU3wX83yo2IRUNJd82vLcY+z1IFwopgPRXylkglSAJRS+EsXFuOWp0XSBir5A8rrZ/yVNwDCQPomG7N6UrYp6vP3yJOm6xdtNOyZdqm5V/TPSxLNJfUsJh989XPCmZs/Hil0PqccJGNiH7eu7bPboO8lwcnZ6BdIMVHoypLC09X60jNjUh9JXsJ6zplgX4JGbEXDU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd522b21-800e-4f88-a050-08d610d535f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:47.4795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
