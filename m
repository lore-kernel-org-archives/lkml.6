Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BCBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3258620870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="FkM35Mq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3258620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeJKGue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:50:34 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:51234
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeJKGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3ilvc0rJ2XjZMEMDaN2ZQnCF7QSRpIXGI5xFRJWA9M=;
 b=FkM35Mq5Lg5aIqlAArx7XpCrgG887wTdCLc2Fi0cvZ6C285OTm7E8TTh9R1kUOhdolk1EWIsQ7dvDvD4ug6aVdlWBbIU+pyysjLv68K94u16QWVpF1gUk3QjRBBHNm3YUnZOahD7PiRebosJMVb3gRNrlC2bHHMTEALjQVi/XAs=
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com (10.164.166.136) by
 BY2PR1101MB1110.namprd11.prod.outlook.com (10.164.166.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.22; Wed, 10 Oct 2018 23:26:07 +0000
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930]) by BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930%2]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 23:26:06 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: [PATCH 1/4] ASoC: max98373: Sort Digital Volume in reverse order
Thread-Topic: [PATCH 1/4] ASoC: max98373: Sort Digital Volume in reverse order
Thread-Index: AQHUYPCeL2D60O2lBkW/38fOUICgDQ==
Date:   Wed, 10 Oct 2018 23:26:06 +0000
Message-ID: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.56.39.241]
x-clientproxiedby: DM5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:3:23::18) To BY2PR1101MB1126.namprd11.prod.outlook.com
 (2a01:111:e400:5a72::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1101MB1110;6:+Hqo5L/tmt3cdJZVWDJbgXpcRWE3nvKABgsE6tmk4LjRvqUtwI3YDu3JMJXk81+b11mdxpdF87IXgxL38miIQXfgev+LwKR36d+S/kp1sF068Bg2ctZ11rdaSS61mIs+OnQUy/0cxlw1iV0jlCJmMzKVey6eFa2AWLfRe1WvyK86yg0282fph/opWtaOvVpFeLiJawzxQmKsYWtguqvpq4X0NhHz2DD0OxCUXD/Y7NzqViYyD2JB8oogjWx6UJZUYl7vGBTUcm4H1cVHwvz8zpL8G/8WMjCQIZ3TOy7BsuCJIKcU8DNQtbRmBYdwPFpovtP6w8L07rwyJp2G9VaYEkS9818unVfvGZu+oYrPl17EmSAJvTWElsVjxRUQXv5vXfdUc+ODOhFuZPaF9jIVjL/qsmgDStcIuo0kaFpjeqfvNWCmuO2JM4OSjcqxVRJeP2QjW2124XghffdDCWusF+XUuwesqrsRzKqam8aQHuk=;5:eE7P0ywBP4Czr5qn+c5A79M1CsItcq4rMwOnBO5uJLS4dZK/w8kP4t7IgqmnPmBxT3h074feTMsWXobOcDr7exreu7DK5SVfB6Rcwya0B5fV+nDDyr9SlmAGZO45W4KBOyhZzp/Te5/UAXNtU3+RcnxRrspNN3V1JrteoI+rJTc=;7:sNmsMvA8RTsp5wQ0d8fMhUrr0m9yGYwIeHj1K93iXfljZmtwMt7IKq7nFwLEAqoksZEAgz+Kxn9sF9410Nxs27cidZu8CfT9fjuzm3rqg+GppMxR533uFOXIidkPkwQSlMRD4BlmOpNZlz5sOYvF4gIKddXV+SSSK0Ynim6nOFYzVV2HmI8LCekEQksyumNecSkmZ737qS/jzt7OCzHuJtcyUFsQ2clfT01eS8E6kXRoPBCK9GagC5KuZXSIEza4
x-ms-office365-filtering-correlation-id: 4fe14971-8ccc-491d-f5df-08d62f07c095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR1101MB1110;
x-ms-traffictypediagnostic: BY2PR1101MB1110:
x-microsoft-antispam-prvs: <BY2PR1101MB11104EC2250995632375A0E4E7E00@BY2PR1101MB1110.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(108721460000369);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR1101MB1110;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1101MB1110;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(316002)(6512007)(71190400001)(99286004)(105586002)(1076002)(6116002)(3846002)(36756003)(53936002)(26005)(14454004)(102836004)(8676002)(110136005)(186003)(6436002)(66066001)(25786009)(81166006)(106356001)(68736007)(6486002)(81156014)(8936002)(2616005)(476003)(6506007)(5660300001)(7736002)(478600001)(305945005)(72206003)(2900100001)(256004)(386003)(39060400002)(486006)(4326008)(2501003)(2906002)(14444005)(97736004)(71200400001)(86362001)(5250100002)(52116002)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1101MB1110;H:BY2PR1101MB1126.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: ejJoUy0SqtJmsdwHZKN0Ktka8WaRTZHViVTvCv8HFlrAHQm0oopDpVpyID5+cSUCBvDzRrDWQx9jtdRJq21zm6WpnxblJwtwOzptQQqTfeP8H9H22sKPvw9wWqYdgmec+gzKr0ChNs1Be57xMPcragoDtDB6JKr88u+b+0+UMnQTqzVu0BCmpidtT5WHNMOOMZpeiovAj1XMsnQqq+x8cnKX7sV6YuelGONFf9BnrSDRZpchNwz+hAQdx5vSushzzRR7P1LggUkuo737z7LpOk5kpvs/xERZnrFAFH7W8R3c6ZSakFGIcL80Uz9+rAbnMy66M22o3ATE50HoRtvx3DciqS4Zx5DPG8S9CwyNhsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe14971-8ccc-491d-f5df-08d62f07c095
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 23:26:06.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1101MB1110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Sort 'max98373_digital_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 1093f76..bb5ef52 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -454,7 +454,7 @@ SND_SOC_DAPM_SIGGEN("IMON"),
 SND_SOC_DAPM_SIGGEN("FBMON"),
 };
=20
-static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, 0, -50, 0);
+static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, -6350, 50, 1);
 static const DECLARE_TLV_DB_RANGE(max98373_spk_tlv,
 	0, 8, TLV_DB_SCALE_ITEM(0, 50, 0),
 	9, 10, TLV_DB_SCALE_ITEM(500, 100, 0),
@@ -604,7 +604,7 @@ SOC_SINGLE("Dither Switch", MAX98373_R203F_AMP_DSP_CFG,
 SOC_SINGLE("DC Blocker Switch", MAX98373_R203F_AMP_DSP_CFG,
 	MAX98373_AMP_DSP_CFG_DCBLK_SHIFT, 1, 0),
 SOC_SINGLE_TLV("Digital Volume", MAX98373_R203D_AMP_DIG_VOL_CTRL,
-	0, 0x7F, 0, max98373_digital_tlv),
+	0, 0x7F, 1, max98373_digital_tlv),
 SOC_SINGLE_TLV("Speaker Volume", MAX98373_R203E_AMP_PATH_GAIN,
 	MAX98373_SPK_DIGI_GAIN_SHIFT, 10, 0, max98373_spk_tlv),
 SOC_SINGLE_TLV("FS Max Volume", MAX98373_R203E_AMP_PATH_GAIN,
--=20
2.7.4

