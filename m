Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7CDC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCA4204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Te0Wcf/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCA4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeIBRYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:49 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729682AbeIBRYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1b5uPxAv5ro1SIkjtLRHzTnLb9Hi9CHHZjLRpAqiz0=;
 b=Te0Wcf/8yWghUtN4A2SDqF6mmdV0mk5jeHjldquihXaB0nwaxAvIIn8J05xiqyJfDT5eXAijzLO3yAsG3YOJpKay9E6dqzVCb181kYH8CPjOYu4TX0w4bjJkaoVi8pz+xfvgtYqXpX9vmhGFhb0AaguuBaOs7WLuTnOKuw3cyQo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 83/89] ALSA: hda: Fix implicit PCM format type
 conversion
Thread-Topic: [PATCH AUTOSEL 4.14 83/89] ALSA: hda: Fix implicit PCM format
 type conversion
Thread-Index: AQHUQr3znBSiul011kOoJ3ZMIeaCSw==
Date:   Sun, 2 Sep 2018 13:07:50 +0000
Message-ID: <20180902064918.183387-83-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:pzyv/Zvyske0LJxVm3G4AM/A/e3k/jk8+hsuVPpZZLpuLKzotUx2vjfAoSW8g9igG4jKSbXq57XPeBl2r/QJZAD9DBx6EAC0etEVyhrhSBfvijDKf19GR8gsvYzaQ7WCbQCVQgWTjVYUt241O6UyCHzd2MrMBEfp+njFn1NDojCL/mjzbsBKzCIJl0cbMXW+kZnXhtlPp52lGY5Bna0m0dXEdioL/namtBZHcM2YLVbwL39WIrEsRkjvFB6Fw+ZIembtqTf/SSaeryRF/7DED4I/glak7NiAIOl9dfIEWyR1K6HP0A0SdhLJexZIgi68BnElu9izI36MIHta2iOqHIBk0KHzq6073gEDvQqHZ7N9HWMRFFwHKxcsJQYJcNOSmJqGxCeqJp3mEQD9eRVjJExPDJ1i4pICvMk5HvtKp+/SWpyGV8sAXg7nGvsyRyJXJgWho5MYDfBgy9HPLK5qcQ==;5:r8R+SR1IEh5oq91eCsWVG+R53AzZYc8YiEIMOPmuZ3Idra8SFac2US86uqA+4H611UG8B7YcL8aEzKFPHI69aPFkv8+AG1EkiZIxHMdmeZDhYF4YnjdxPIAjLh5pX46ZpalaXhfOltRJrCLYZJCkhahHb+WJb/zDeLSK0udyRUU=;7:dBAFIY7ReNxzcfnCiITSJylpwfDXZHaaYnG6+lJDNFK0H5X+UwTcJtN8J9mnN31oNuco9XjL2Ad40T8amJM4PdsaC+8edoFlD9RDl0OZZqkmpMG0P7JVLzs0YQPGmb3kLjhadyaRZSAnsjoP8qsZ8BnWLY4gd/Stq3bSvAFtFuAfp8Oxh7r0eTV9RmO/VFZ/jrURUF88GMKJ+KCeApyk2eSCPBNauv1ijEm1+I700czS2WfDU7z1ssr4YGFHPzDm
x-ms-office365-filtering-correlation-id: 35adcdb6-a2cc-45bd-7476-08d610d539f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046968FB474A2F6D94E47A25FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2fMuzHoPyqBnAEyuStd5kcGMYsyZ63S64LCBX8zBFG79vvU2ClSxM2PiYO7EROh5ormBYhyfTzXnjl19Bg0HA6BQcxNOI7sqhEXjhqkTt7Gz9KCyJICEMkO/WWIFW+93aU2eZ4ZlH3MjYcLidaJLW4R951V+OZhbUrRyfeYjNHbt9z+piMvQkWVw2TqmXYRvCUOncBqHwuYvzGDcchwkftTRa19HYXYL7sckYEmhNxXwnADjihpbsiEuwbIb9cyPJm3muMRsdLhwfhMRGKqC5k8stdVggoKNuA3BjIV0fHAn8zpiEw1KrYaAFkgK+xH0Iv1dfFtb7U3k9yM7tJOFgAVxuOl2B2a8R5NI1vIBH94=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35adcdb6-a2cc-45bd-7476-08d610d539f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:50.5751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index d8afd8a5bd76..851277f43092 100644
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
@@ -133,7 +134,7 @@ int snd_hdac_get_sub_nodes(struct hdac_device *codec, h=
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
index 19deb306facb..b0e7843e7a55 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -760,7 +760,7 @@ static struct hda_rate_tbl rate_bits[] =3D {
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
