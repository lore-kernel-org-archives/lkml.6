Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B355C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B43320652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EgL4ByXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B43320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeIBRd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:33:26 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728698AbeIBRcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRrpAhkinkQREQi1h3GTBse7aXP/LzYmnsQ35dfmvRY=;
 b=EgL4ByXs+pEcjdunoNaglhji4R8y2P+efPrYQLCXH1n56rWCInlkatdzRXW7KCDwA6tViHXoNfXpy7Ou3EjyQgDSI6U2wtMnQx53bQH/tFPRfdZzpaUFd2BF19kYdav7fkx2yL73jA66Ik5mCFHhDkuFG0WekVWlt62rkFAi47U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 42/47] ALSA: hda: Fix implicit PCM format type
 conversion
Thread-Topic: [PATCH AUTOSEL 4.4 42/47] ALSA: hda: Fix implicit PCM format
 type conversion
Thread-Index: AQHUQr8o95Xkykg7T02ye55B8bpHKg==
Date:   Sun, 2 Sep 2018 13:16:29 +0000
Message-ID: <20180902131533.184092-42-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:4FlTqEV9BIqTvgOq10shjx2pvrsdxRkUE2YbFktYO/uwcDGon635sf4wUit/qxYJE5RB/GOikNj3EbEKm/pnUUrY11QS1oaHAKxRuxiJqrcI0XdJ8t3GVMjktikhe1zzDEoeQ8FxUMmfWL7WWa9nfHeUVV0INmFsY1BjRiWBYZKTGcFhzPmhYwfVMPicznHBzMvkWTZRZouuCKMRLy4J4UrNevPv8UU0O5RtgcwJ8vT3oxGcSVMkhh1DcaupK6TS1fHMvw035PDZ/kePJaQjZsyA6bkEthU5PW287qJ3ekNIBvdfBK/5S0f6pK6hamG3IqnYnsLMYJutit6S2bQ5I9n62H9MU6/R2WJU/xix5XRUlQLC3O1MSI47z3cs1EnTqV4b5WX1ETRihK203Ws8LEUWB4Bt/SgG8T4T4G8LF48t2LsIIxR4momts+kqzr1XYt5vkY3WvKrggwUOn4htJA==;5:4ciDtW424ssEW3KKlUiNamo/0kgV1qG3mNwjKBPGbA5VApPEmq5lzOYOV9gvmOo7AFm/I2s8RrQn42dT8ELHXG2nLJJQ7G6nAMRCOsD/5eBjTY9xEDqcMTk7YSnW9iJ64HvWUVUJFzu+GEvtkFlbxfYxxW3dD3LdAj3jPgXizVQ=;7:/5m1j107QjRCJHLIaSaZP+e7iUPJa9z3dXwYU8pMMdvr6Gfj3CDE4QDVZ5yqzrMTn71DIRcMBl+fvYssvaSUHQM9UT0HqH6MYv4ucOWu8RnDN4QdO0oSs7r1ftZQt4HBXxXTA3gNeevGj3C9a1WR0a7fj9PGJF3wv4K1Xef9J6sMJZs39gY1P6KbzmIFPdM2pi06D26uDcZIobsH05eAB7/VKLPAVjBmXKdLPijmz15A4cMGANhbE/rwapQ0zuu0
x-ms-office365-filtering-correlation-id: a50e70cb-2b37-4c4f-47cf-08d610d65f11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016728A708CFCA120F6AEC2FFB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Sb3x9qJIh9SvDinQeKOpEKLBY13zUfx8Jbxxn72GnGCf1w2u/RiKtFj+Ulo/+RrOpGvlWu1N2EtOCIwamIMWfGQgazlITGh0ECw+pFzbzz7QbZwhfAMnKvlaPWzzZGVPujbpHOASgW0VzZ3oWRjqrmK8tVWwzXI+NERZhDGB2fMgOi4hOUdVJXf0ZSzjrXb6RErhzYFAjYlCxNSX8l6lVp51UVR65zXRdPuJgSNDZQ3bt3OdkCi02CRcboEZdqJQ/MLl/wlZrqGiqgE675l7Y1eqgZ3377wQrLxPrYEDisxFeBp7lI90SZD1wshS4vOrtkrC7ox7Km5Z2BZ3XUixrp+vwXSFeX9ePa+3pPcaCOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50e70cb-2b37-4c4f-47cf-08d610d65f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:29.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index e2b712c90d3f..5afe0e3d2553 100644
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
index e361024eabb6..f7e31b1fe8d8 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -745,7 +745,7 @@ static struct hda_rate_tbl rate_bits[] =3D {
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
