Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A5EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43A920837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fGpgUido"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43A920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeIBRci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:38 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730387AbeIBRca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkbcwKQO3+cnVqJHL12xsiPxLRvRnKQ5wzsA5SwdPj0=;
 b=fGpgUidolhRBJeF067uosZaWjz+Kbq++Lp1ZBNlecRZ4SjnRZquWJhSQp1W1LM65OLEzfMeHguNwMyVAH0IPcsRlRHjBBvGH83qRrNUwyUpnpFg4sORQ/L25DJ0Vsakstj0IsuuJb9p2TUTn/weXnMKun2ekkOJVFq8iGAjgfXA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 39/47] ALSA: sb: Fix PCM format bit calculation
Thread-Topic: [PATCH AUTOSEL 4.4 39/47] ALSA: sb: Fix PCM format bit
 calculation
Thread-Index: AQHUQr8muYbAgeFYOEO4zxRlUyh8jQ==
Date:   Sun, 2 Sep 2018 13:16:26 +0000
Message-ID: <20180902131533.184092-39-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:1prtDeBFdQH64HP5LwV7snX0bNOPBxrmxTzJSp3XFf3dgygdrS+VTnn8W6T59CnAttCj30QJcR1o9JIdaPHLrZLUfMupQfjJsSOhD1U8OctEGdnAU0IkyWjuQ0r0GHZbjWd+qf+2QSY1rukNQe29CrvUs6FCltFK4Auw/bwy2DHcn+274PlLw0u3CtuIG4sQv2NIbKQOTYjeF9+8Wqo3CiMBFxKr40xx4oPoVd8JVDtKl4HtvYV1/7+0We9rvtLgiehIEARVhVoMbHY4PoSXg2aSdBZ/biUb/j2eUCLJ79xphtge3xyaCRXehGHwIKuXNvWlqroO6h30uqB+DnVMUlvFFgDBWcuhi7NpsBSTY98+hJERknDgotV4GXZkKB9uM+codW5eYOWR0iXJ5JNULQO3p/z4V1b0WqeIVbDr9/4xlBZCY+5AvWMqBET+s06jIflPRpJSuTTB9nj/UF8EoQ==;5:vmHTgZZjdh1PAMOef2lMpkGXls4ibyut7OYHzC8p+JSESMlZJx9ZSsW8GoDvQAF/UQ66s4NfQOC9mCHKAoWwY4DN0zI0Jr9yVBd7mXMWTueolOXWPBYSelsQUX+7Tx7tTJJWTJgcDLLlde5faBh6roT5JOTFayNkJlK3B9y+chI=;7:MrsyBrjZJ0WyxIMdI//I6dFOF9adZ5G839y3FHHVSBkNAY8L3ylR1jaX6SmbpB5KM2UWKIXCJ5tc8dRrXN6xuo6l3cl7e72telvP6ao01AvUjNzd+vHpNoZsT3H3wjvFXqqvoe+ASpZzualMg2oxGeNXoNCPnMnvY7JhKmJ4c0CjChrErgBMu3Rn9Zj5OoxmRaBeDBZhHgt5iAi+TxQVJwWN7EsYSCkNKEDhzbiLRyvSUluRDAhkOPEnmUW863m9
x-ms-office365-filtering-correlation-id: 3899fa0c-cef7-47d4-f920-08d610d64c77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01673F90A527CBFF4B74747CFB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aExjzeIiWzD6/eA9y8o2wDh7YeftMBNsL8LGk/XnX3nsXSPPo8hxj4TzenILGRhd3lRiDKEHrnieXV0QGx7tgNmdHEItN+qyKjt3ZUwVhzvk+WFX2Uoxn8vtx7hQrGqZOknfDAvzZFPK2y/xuQaTEvcK78ZnN2hobjYvnVJtIH1xd8IiHiWjrlou+s3ihr6Lj0psZoI3OE36UnnXGSHOcEbYtyHDzk1vuh2sd204E4Yeo24KSG1W5TJnHVntBRGrUoDnECs3DzC6AeaghC35MD4Ai5lz3uUN9za0YZKGeLyf53Ui+ekF3fMxP2wYf30hQw4mrHlhtSpzfAV9WDqm3xZryb6xrb5Ib1yxh8pTgqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3899fa0c-cef7-47d4-f920-08d610d64c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:26.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
