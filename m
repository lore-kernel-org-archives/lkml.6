Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C72C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBE42077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fok79JMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBE42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeIBRWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:11 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:24667
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbeIBRWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW4oXu4rgUgcvEZJcgwWjazypF2xDkPPgBroGVwketc=;
 b=Fok79JMmusGdthvOh+axUnO0lgXs7MkHcSrZSHMAH7mwHoX8H1FfFTr/kDGKYADKXTobxjPXYXg+bariW9ZXZU6zjFIpxcp4gryM4lqib2U9uHbLELxtqtw+WBdcoJMlR6kTV0iIlXvNZcEGP9NyXvUA6DipsS059JKUY/xB+FE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 123/131] ALSA: hda: Fix implicit PCM format type
 conversion
Thread-Topic: [PATCH AUTOSEL 4.18 123/131] ALSA: hda: Fix implicit PCM format
 type conversion
Thread-Index: AQHUQr2lm/AgkKfAl0i/5+NAsNjizw==
Date:   Sun, 2 Sep 2018 13:05:38 +0000
Message-ID: <20180902064601.183036-123-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:rfW5CEV4guhu+G/ZvIvJKJ7nuu2/xokbx0JmZH+tPSQQHK5GlhQbLOX7IP/2eM0gxvqT6MycPt6YtEWxKWOdEfZdwn4sHGS9fL1HADQDjVFb7Y1DczfFXTT6HAZa1Hd4oVH37zNP74AFZekxehzutt/pXc575odBmgNTXlIvnwjR/KEug4gv1/SAyHEItmws3JNWJkrZjp8Wt20Nfs5urvamr8R24TrJbOw6mq1KB4G2B6PJaB808mMngnWknTS+vWtEUSHlEv8B9SdIrJjl1wQ3zqpLim/sxl/j3Q7qNPPI40ChAAB4EmnqVwT23pGMbpQ47TgFMcvZtn183X2cib9wLeQfHLOXZFfUA+4YVIPffl0A3PzMYp2Awy56AI1OkBGEcq+diHpG3oe2KaSD2FuLaMLyHmmW+4BBdgKb90kVdVY2NAkYXooFPccxed2tc7+hPAcsLxZ/KlZJpaY3Sw==;5:rxY5ArBFGv0E2Bw4AhCJ8rKMVs7JQ9kpltcIwSa/5ibvsAgUUNF/hab8A+7VYRKuJeYYm5CNX8cLHhdxBv0n3+VxpfgfzSmAdNyycrBnWHuRmmvHvmpj3V9mQtM8pRk6iqRgOwvkIVxIun1lVeljB/ztjsBOJQDHpvL+jsVZYVA=;7:GnrI/+rEO6TVx9ZQnd/fwn3DWYVAvlOseSh/bklyDNu2RkKEYSvTDRvtpu09YJOk8UYC7euk9gqXHxgDPAZa6y5xQMRKZY7CCcY3+NOjVqkiaSPRj5JdRGnUMSN4tlx29158bWwoEdxQVmu+rzW3E5e1YRYLzbE42PwgbBR0BLN3ft1cFcC9Tah9PHSFkAHHhmKd/nxqqEFHiVvlGHp+66XUbDjgYy+LcBtPxdsWDNGFdburR+O+rjN8/CDlI3A5
x-ms-office365-filtering-correlation-id: f27a8761-4092-4127-2b79-08d610d4de49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629026C455213C1B1073199FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9ZqB7Zm2pcKLS2wuN1DOmGvz2oV4F0JLrF0pTVX2d+i12dhJvDXzttgaRk9rUXFj+eDTZTd50XSUPdHxoc3ICB9kyocr7sG7wOuU5+MqkF4B2Lrmnc8JKA16PgMJnAmKf8YuiEJQenMxBbdsLXVNzjwNnZ/7s1Aq05jSgtLOw7TwcpsqF+R7PB2ebeFcI56aUOPTU4vKbLOGfdIGBh6VRYfKRx5kwSU3EhpJzGb464mplRYOimAqJykjuvOJY44bZjGAoOZzMiPFceL4JswoFBImeUnrmxFoslj1mnm/DAiwCcHz2WqLF8nsGSE2mpZkh0K0Yg56Q4ttkf4kuURPefrS0EndpOR4+5vjjaCMNt4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a8761-4092-4127-2b79-08d610d4de49
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:38.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a6ea5fe95ab4a1a7af6d57429fe3ecde9acf5b5a ]

The PCM format type is defined with __bitwise, hence it can't be
passed as integer but needs an explicit cast.  In this patch, instead
of the messy cast flood, define the format argument of
snd_hdac_calc_stream_format() to be the proper snd_pcm_format_t type.

This fixes sparse warnings like:
  sound/hda/hdac_device.c:760:38: warning: incorrect type in argument 1 (di=
fferent base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/sound/hdaudio.h | 3 ++-
 sound/hda/hdac_device.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index c052afc27547..9bae9088fec5 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/timecounter.h>
 #include <sound/core.h>
+#include <sound/pcm.h>
 #include <sound/memalloc.h>
 #include <sound/hda_verbs.h>
 #include <drm/i915_component.h>
@@ -132,7 +133,7 @@ int snd_hdac_get_sub_nodes(struct hdac_device *codec, h=
da_nid_t nid,
 			   hda_nid_t *start_id);
 unsigned int snd_hdac_calc_stream_format(unsigned int rate,
 					 unsigned int channels,
-					 unsigned int format,
+					 snd_pcm_format_t format,
 					 unsigned int maxbps,
 					 unsigned short spdif_ctls);
 int snd_hdac_query_supported_pcm(struct hdac_device *codec, hda_nid_t nid,
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 7ba100bb1c3f..dbf02a3a8d2f 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -738,7 +738,7 @@ static struct hda_rate_tbl rate_bits[] =3D {
  */
 unsigned int snd_hdac_calc_stream_format(unsigned int rate,
 					 unsigned int channels,
-					 unsigned int format,
+					 snd_pcm_format_t format,
 					 unsigned int maxbps,
 					 unsigned short spdif_ctls)
 {
--=20
2.17.1
