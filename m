Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54929C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9D72077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YeoetoN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9D72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeIBRhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:37:19 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729401AbeIBRb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqtSfdcHk9mQLuLTbQznC2PDcmrSDf96lNAqqtV4IkU=;
 b=YeoetoN7RSTUCUZxe5PwbdY9tsaUggtZSOtxdwNHoFM+NiuiPKIKe75F5L5hqIMzv6t1ty1FcjxsSWRT9dGo1ITrcS5n3qZO+Nm7jU+ckjWZlyKxGe89cLjpDcMpLTZNdqT1Ama30rdr9jRVLc9g8rRG2mz4ST3USPhg361th00=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 56/62] ALSA: hda: Fix implicit PCM format type
 conversion
Thread-Topic: [PATCH AUTOSEL 4.9 56/62] ALSA: hda: Fix implicit PCM format
 type conversion
Thread-Index: AQHUQr76i5DfQhJbXU+nKUaogRHQRg==
Date:   Sun, 2 Sep 2018 13:15:11 +0000
Message-ID: <20180902131411.183978-46-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:29G2EisBiDbe6HHclnGrTa/Zn0yCGtxlQ2XHNHoDBtfzPYz7MZBJi+teDnvSF7IP/dl8m0Ic5k44J+cMg0f7U72QMgr+zAV5kEl2Dp+IKbEH/U+EhKtf7zP+DSda43ybAcAwfFiuwK/1A17eAOADrjtJsZeElELvXnjviNuq0ikeWZjbRWCubYrP4EP92PTAoUcR897r7DQDqrOTwOU+kUQom6pmuJTpm37neOjL0rVUv5kzsxgzAD0/boqonExOEDlkGFTsDElh9wv+wx9VeXaugbrqwQpvxQosZTHc34rUYok7z3xGlVslUYeIJ+9BYukfCvBG1SuVj7/HDdGo00E4jLPl8eU4P51s7Jt6K/ywTmPJvZ6CC28ptet4ksLmYJE93a1qelqY7KGI1jRclbIqdJXhldrCMW0cCZod5IZc2erw0s1vyw/XhnuaV9Xjurx3iDtEkkWiE4R+bKU9Ug==;5:mhHRtD8lDhPKzcl0UuK50TTk3a2WgiutlsiCjcwADoPDnH0hJP/S6hBIvY3Xd9LqJeQq4ljU8V09f1JhffpHHcZ7vUeyqZh7lt4K+fT2gCjfv+nkQwa9cfEQL9QJxPrZvhBcI6Llwb5B5dEo7Dto+zz8ObQBvaDI/0kIiaECwTo=;7:nL7/Ho4wbb7TpiJxjYMLpzvVjv6HxZITICtgr0f9UZcj7FsVDBr4Bh5TD7GFUiD2C42SscfcUcSt/79umlNxPWk/D4b03Cckwtihwd093MsedZp5oOvO0oXBgZsizBpg8Lsyf//5bRB7IL83aC0i1QJ+0AGsP47dIQr4ttY8D8Tj5AUJctTW9TVtRviwUNI/jIBk04mBkQjyFBx/S1reuLq9XmRv513IciAZJchwQliNq9jVLEZyrPVrNvhoIhsj
x-ms-office365-filtering-correlation-id: b3da637f-5a85-423f-20e7-08d610d629c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184C2E1B87F695F8E0B3CB6FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0CfppdVin4cPTmNqcTcYTO+2KxXu0ILh3xNXBcEye7CB13dnNaCCfui6+8W4Njfa9FPXfcJwUUJTRy8XS4nB2/6lopFtviz1gA1n4VQGGXIr8JjfWRghEofuFlOlRih9qKzenu+W0s+5O6pGClrGwcCgQ3TlZbhiCGYpJ7X+o+1o/85492Vr/SGRyJcUV6ph7I/yhitmZnJr6ZDOF2SJE2HjVNft6ge/HoYZvZLaynoyHohTeANp4vMMqhnh2W3CZ08HkiuFA1HnBUuHPC39dy6Z+Ui2xSgcAFYHrBc9wJNyk+U0F3DwscZEIRLijH3DOq4WeCVfZ0IqygVfm7fvtYxRD78pEWjRGA8PcxzUxxs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3da637f-5a85-423f-20e7-08d610d629c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:11.4614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 56004ec8d441..4b93a9c1ae87 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -9,6 +9,7 @@
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
index 03c9872c31cf..18509478d4e4 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -759,7 +759,7 @@ static struct hda_rate_tbl rate_bits[] =3D {
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
