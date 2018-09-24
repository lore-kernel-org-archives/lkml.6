Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC097C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B89120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XwdfgGVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B89120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbeIXUy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:26 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732069AbeIXUyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnGQoHfAqG9UBtwu4mR1wyZBUvKCGOjrChCNtIaGNIk=;
 b=XwdfgGVweNsJO+h3ZUDDabiJS2XMJKE8JlVz5Z3Zx5xeGNjB/tYfCbsZtzYkFYSzvMONfhT86uFmvLvtrtpIpAXPl5l/cqdokMbTJwq/hq66iqQzeN8yPffkjhnH5alSs2lrI37exGQUBz3xPI9X0CzoQgcTjoh0VfTKifOcyr8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 02/13] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 3.18 02/13] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBXjsJoKLeXyE06QNLQ1dVqHgw==
Date:   Mon, 24 Sep 2018 14:50:08 +0000
Message-ID: <20180924144959.164754-2-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:/HGm9T7fIe4V0qnP7AWqjAgvaFeZO/v61eF3vNdbmhkJJ9Ha6x8s09EcNpFgreA/c/4KWKIv5DDXjBoGZxGvnA9MVfNdvANgUA8rQnaJHEz6listO9v+Zhx3LolG9Bzp9pm0BtcIKvbzj1EdPqokZh5R/bD6D1I9cdjs8zBzBgE6AdN5ScKH3QY/K640uzGnKeeCAHXEUfYv0hykZh75nFkG9E5LCdN+0UbB2uoq+9vfhBwjZVchgtS2bFBxa8N1YeryNFh8RIgPl4oHDhLAD/F/0/ts6V9zty9l4FjKwxewrDx6hvbaOgfEIraeuVQ/+EEKeOf3TkmrTCNig+8OIuvRboNpJt73Vly+PrZybXqVjhbRg0jWTbjfbDCZZFrHKRdg4YcX9H2lRtRaabLKuUSwP5ZzTNFfgK4ob1omgEZfDYv7pGOyn6ZGHs5Bh79GZDe46M+7dMHIZXBwrfzqHA==;5:eY9Vdon5JdV6XXmg4mG3aGp/hwch5xEJM3p/q3d1DJvMAKQtYWyq1ug73a1VwIplf49GjPaaRwqoAqXIGfgL5qQx1WbbN3b/T9edZ9UhUiG8gUyDEVlzFuqh2Dfx4AtmlNl3TTkrfzOAY9zcT0Doc1oDFdiE/cQh+GZT4aVIy+U=;7:tASSBDV21oXVUGor9z0LADTlf0nFAOM9OG7NCJGjfZrpXvLCT82AgXf7PL7MfGyEo3aapTXZR5Bx/mgq9eVudpgQyA24Z8LPRFkAz1OcTN5hUVQpflCkLgD2OnV9n46e/SRdDMbhYNq8Ix7Vr5t7BHuiYpJyhMDw67Dc+NidJ2A9lI/6vVfiv9ryJ5mSDz1WB83g0fk5tA0QNJWU0J6nr/1JSSlvc1ATInjeXVdQS/0GkuTXX+NEwHhzL9HKbnSW
x-ms-office365-filtering-correlation-id: 31494fc2-9055-4c04-7e27-08d6222d40e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06312176F022E1E9DB427B9FFB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(15760500003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(256004)(86612001)(105586002)(14454004)(86362001)(575784001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p/M9PhPAJ35VLO+te9eOgXWVx0uue4N4xYa4cLzcuMxm09i7YJ6Vbfi38Te9sR+rrkRgZ/ZeTvs1vRDiGlCzYBbutyA2v1G5BsNn0yxpZWx5KGNTyR2hFdvn3oipHyU2/9V8e/hFJ3xYHisDs6rKMAPyN3KnOFV/knkezRVZQsY9wOkmxYJtqPDW/KCsez787ORoqAZgfbhk7p2pITKQHDDTyH/yQrAxIZJkEugnQ7iFkKF1co8NPxEgfz0b8f8q9gfMSWGSizSluYM56d671rXN7Z6iaAIgggIfr9EVzyf0iJEOFp0hZmWIc4DeETC2kVn2uCv1Yu/tZb5ZQf87tbMxWbUoleiuK1XtI+69xfI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31494fc2-9055-4c04-7e27-08d6222d40e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:08.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit 67d1ba8a6dc83d90cd58b89fa6cbf9ae35a0cf7f ]

The mod mask for VHT capabilities intends to say that you can override
the number of STBC receive streams, and it does, but only by accident.
The IEEE80211_VHT_CAP_RXSTBC_X aren't bits to be set, but values (albeit
left-shifted).  ORing the bits together gets the right answer, but we
should use the _MASK macro here instead.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 67943cb5df8a..9db06f642556 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -465,10 +465,7 @@ static const struct ieee80211_vht_cap mac80211_vht_cap=
a_mod_mask =3D {
 		cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC |
 			    IEEE80211_VHT_CAP_SHORT_GI_80 |
 			    IEEE80211_VHT_CAP_SHORT_GI_160 |
-			    IEEE80211_VHT_CAP_RXSTBC_1 |
-			    IEEE80211_VHT_CAP_RXSTBC_2 |
-			    IEEE80211_VHT_CAP_RXSTBC_3 |
-			    IEEE80211_VHT_CAP_RXSTBC_4 |
+			    IEEE80211_VHT_CAP_RXSTBC_MASK |
 			    IEEE80211_VHT_CAP_TXSTBC |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
--=20
2.17.1
