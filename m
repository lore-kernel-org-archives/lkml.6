Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FFAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34A6206B2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AraBekCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34A6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbeIXUup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:45 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIXUuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRvkMbgKUVQmKRkKHCJcG7WU9TR1D8rYusZKYAz3Qds=;
 b=AraBekCr/Ulijwakuu1XpTnJioM8f44Q5cdRV8YW/9zbcmvh20B5xvNNcxNML3SdVEusLxF88PO7ofohpjR0XveEpV1wIjxzMp/eT/+MjQ/MDhjHJZ4BSWnTxeHoZp9DKXHWuLm2EclYs8UVvVcNgwvv7M4pATXrJgryZAzomxA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jinbum Park <jinb.park7@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 17/76] mac80211_hwsim: Fix possible Spectre-v1
 for hwsim_world_regdom_custom
Thread-Topic: [PATCH AUTOSEL 4.18 17/76] mac80211_hwsim: Fix possible
 Spectre-v1 for hwsim_world_regdom_custom
Thread-Index: AQHUVBWc4iDYBAIhKEyZ0ErT27mchA==
Date:   Mon, 24 Sep 2018 14:48:10 +0000
Message-ID: <20180924144751.164410-17-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:UHdtgr14OYYrfIpnJhs//7/MiU/q1nRezRc1QRDsLVyy/UWCQcN4RQe8MxxB1QEFSX4dHz8Bm7dGGCDwpiNM00pI0nKM6acmIrGE2N9FjNDqXBV64N4xsYe861eyKNgFMeepC9HmxdoT2W7IevZi9HkdMBHu1h7yQUNEmdq+Bi6aXyd6Fpov63cKRCtZXWGeZojNGAx3ajQegl/yjRkKguVz9CJhgwWANXjKE5+Iig286XE35jPVBXQxDtIXx5B4ezoW5qpa4GQmfK4CM7yX8QKPVHfLbnm7j6q/NvAZJZiMglP650rhokifsW9xAYIFh6MyzIL8dMLFV1u3k84muyL5+Awy+wEsUZ5jz35/kAx1OTXq/pZW1n4xKzu7sMXqOuEYPttBe/MfnM4KCUuYpf8JxAaYbytxWQdq5i8n/eOpC+fTHPfImpylqWZ8sIIunVybfbb81mtcaZBg0GwasQ==;5:r9AkYsORsm+zsymyaKz9j4vAz4DKc6sFjy3vq0I2g/yyCtfSNkQOV6pyEpZWxSeZBRLp1c7DKaw+qAFVesFtX6T/+6mbV45i87FeVoN5eV2+9xuDK5CzkeYn+330ht5XB6bzxxWiUC8ibJQ7CLzVEvrBg73fVsT36A4Hu9X+wEg=;7:5NA6dHr0U8jKMfady2a7N2y2zDlFVgCTSeoUA5PMG85eRw/15gKnoShQ6lHK5I4nqD6qfLs7hw4TGHE4He7vuQE2oznSe8FPFm0jO2LDmWBDvOCYaZnZQATd7oK9RopYZLYzdQ5P2Jv10U4g2BhjyEJCVKb7VQwTmjcLk9pekYSXuDU3qEEd3lPfPY7Z24x5ua47oMfmy7KAfBMcMcCYnTNYDk/HXIISYVPNG0gPhNd/tuvEclbBvYvjMclSsQEx
x-ms-office365-filtering-correlation-id: 82fdc23c-ecfb-4ef8-90a4-08d6222cbf50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821A70022D943C24F24530DFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(166708455590820)(85827821059158)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(575784001)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(966005)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6306002)(6436002)(107886003)(39060400002)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: k5MK56l2EtY7bjzri+jKfoaV9mn7OJJVNygBKHUTTIbWMeHLg7wMC+ph9S1MsPP98SpzAhv/zuLYWv1W2UuGJzYFbVn2HSeo5bMD+ylKZWddXUP4GT6P7uLRN5W5UsxjqWwTl6fgTk1vyfDvV7Yiy3Ro+nyzWgpzj2QGfaLSj9Czr4KEnRVgUJidVouQlGJqvMR2XyQ9aHOTcXHj/ir7T6eld5JVD7jRhTaGSJafVIDoCI/QNtbfTxzzviEm3fBGPUNDW4NpwBSgK/AmqKQ3DkpgcxvWoSMXTe4LdbKnW2vQZ+iMJNQkblj6rD1M716GT+S+um3saDUdB20y9yG9LJvEAS6Q9dBhTKp2S3bqZ2M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fdc23c-ecfb-4ef8-90a4-08d6222cbf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:10.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinbum Park <jinb.park7@gmail.com>

[ Upstream commit 3a2af7cccbbaf2362db9053a946a6084e12bfa73 ]

User controls @idx which to be used as index of hwsim_world_regdom_custom.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of hwsim_world_regdom_custom,
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @idx before using it to prevent attack.

I leveraged strategy [1] to find and exploit this gadget.

[1] https://github.com/jinb-park/linux-exploit/tree/master/exploit-remainin=
g-spectre-gadget/

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
[johannes: unwrap URL]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 7d0b460868f9..80e2c8595c7c 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -33,6 +33,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <linux/rhashtable.h>
+#include <linux/nospec.h>
 #include "mac80211_hwsim.h"
=20
 #define WARN_QUEUE 100
@@ -3229,6 +3230,9 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, st=
ruct genl_info *info)
 			kfree(hwname);
 			return -EINVAL;
 		}
+
+		idx =3D array_index_nospec(idx,
+					 ARRAY_SIZE(hwsim_world_regdom_custom));
 		param.regd =3D hwsim_world_regdom_custom[idx];
 	}
=20
--=20
2.17.1
