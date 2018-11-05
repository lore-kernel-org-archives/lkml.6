Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF26BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9B20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeKERru convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:47:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:51137 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKERru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:47:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 00:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="88626745"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2018 00:29:18 -0800
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 5 Nov 2018 00:29:17 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 5 Nov 2018 00:29:17 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.102]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 16:29:15 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>,
        "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Kesapragada, Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "guruprasadx.pawse@intel.com" <guruprasadx.pawse@intel.com>,
        "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>,
        "Prakash, Divya1" <divya1.prakash@intel.com>,
        "Diwakar, Praveen" <praveen.diwakar@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: [PATCH] fix the kernel panic due to wrong use the dev memory API
Thread-Topic: [PATCH] fix the kernel panic due to wrong use the dev memory
 API
Thread-Index: AdR02etIVOQjufWdR9C3OioDFWN13w==
Date:   Mon, 5 Nov 2018 08:29:14 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjcxZDQwZjMtMTMzMi00ZTRhLWIwZDQtOTI1ZDBlYzE5ZWQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMXh3ZEJGazdxVkFuQkU1UG45T0tIQ290c0F2NCt3R0FmYjY2Y1BEZ29LSXVtWkQwRkJjRUJnUlZ4amtNVUpodSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skl->dais is allocated with devm_kcalloc, can't free with
the krealloc. Memory allocated with devm API is automatically freed
on driver detach, Like all other devres resources.

Refer to drivers/base/devres.c devm_kmalloc for more details.

Signed-off-by: he, bo <bo.he@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 823e391..928d314 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1438,7 +1438,8 @@ int skl_platform_register(struct device *dev)
 	}
 
 	if (!skl->use_tplg_pcm) {
-		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
+		devm_kfree(dev, skl->dais);
+		dais = devm_kcalloc(dev, skl->dais, sizeof(skl_fe_dai) +
 				sizeof(skl_platform_dai), GFP_KERNEL);
 		if (!dais) {
 			ret = -ENOMEM;
@@ -1472,7 +1473,5 @@ int skl_platform_unregister(struct device *dev)
 		}
 	}
 
-	kfree(skl->dais);
-
 	return 0;
 }
-- 
2.7.4



