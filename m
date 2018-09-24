Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E149ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3562087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GRV6ppGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3562087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbeIXUx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:58 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731770AbeIXUx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgOHig2LEjr3+Fu02Mbuoq5FN5uroW2DhmQAcHwLnME=;
 b=GRV6ppGPsgImaKAvXY8MvcvtxzSoEyr+UXSPPWniD/ge5oYcJU3jZIJ5Ewk4qPWDWUh1K0qNlLMyk+9iLZy2qHGjeLzYbVzUDywwpaYziMjpVFwOIfEFiguFMa+cfefSjQpzBLn14hD3f+MAlz9E81WnxcYyAyNDfVS+Cos5Ots=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arunk Khandavalli <akhandav@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/18] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Topic: [PATCH AUTOSEL 4.4 06/18] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Index: AQHUVBXXSUprk/SZc0SZ7CKu4lGydA==
Date:   Mon, 24 Sep 2018 14:49:48 +0000
Message-ID: <20180924144942.164688-6-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:dI8RDzz9iGVphgIJALftTqKdFLtU3qne6nGloce1qOsdo4U/4iIbP4FLU3Qregv/M43dlBCfCfrV6Agny0vR/I5/ozjSBiwmepe812OEjD3Cny+CW3xbDRHLGAqj5ZrKNR/i/n+0MwCunPq753WTzKmpSw2XMngoeAmaa4lKvfZuFEoMYq0+vc8RzGUFMutGe0ORQX5zzHIlSeZ8YpWbgoLDIPAhXWQJ/sQvn6CWA80/9KX0VKP710/6IYXQVgG1DXQxIdjfhr+G3RvrFEeAIqYO17QPYII56Ji65T1ps/wtlJjjUgycf3Ci5uBqHn1V02xj3/L2cLZUSNdpqocTxd3f47UiguLc6EQOBcvs81o+ClOqdtwvz682kF7RKemWZll0JKQZN2JxGwp6HBPfa35JlfQwBIPvjdxTRdPfGYVU13R4zxPCTEaS4bKYbsifXITucm7A/ktpPPxMUAmjig==;5:UX0HW0/x/Kab33QKXLteX296L1DSlAS+5jAUY7hZGnatbviy6tooYtn33P/5hvJNpnv18JXcNmtYSNDzrIHVKs8QtruA92hgLu0bvJhsUMY79SiSLTjezYtnn+iOmk/nepMoLDKnX7KQ/OQKMBEP935N8RkI7OJ3ERMAxc/V4JU=;7:sqqEI2AdR86ehYePbb+hxWN91h6kk6au0ogzewk07FpZGy4hoTGYT6HusmR79vgupYM5N75dF8pCLsI+jl2z6pX0McWtl2hLbzjcxTczzT/auPKTy3uURGOrBpwO3StajYQgmi5UGfoZZAR+SmLF8bp+iEQd7qRqrjSfB6pJ5/KfPszmJdCEsLxuR5yr0eOwQQPj0vMibamzdeTIrNwvecoOOx7DncnjC0WIkv0/2SEVzCVJWqmIqFZqLSL4fp35
x-ms-office365-filtering-correlation-id: e58b7e24-0c0a-4d30-36fe-08d6222d28f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821B9423F0BB0C256D88C02FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(15650500001)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(15760500003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: u/y4Qqd5ZSgkrTeI6z9B53vTBRNetqyP7ic90l9T+bcTHNK/QBHj+ZdngwgpVsh/4SW6ewzxkJ010qy1KO2/u58IiuAo7YU3K4ojpUwaGL1Z4oG985/tjU6DzGpT+Sxpoex/SBZfaaa+6mzhZkhJgZ7Kw+GZ1V0PvMbbJkXkLK/6Wbi5ouzhpM+g9m7so+54cKNoLNWQ0wYXWk+J5dCU4GFV89HZfukVxXGJIxz8nBVI3eiJ6z6e5FH7nCbgXTQ3l385FO+PtXcKQ84jZMlt6xGtR0nzvONFUejx9BE/9wbxXkgApezEvcUmVWHlAPZhSiG2V5abYe+BuvLs1CjnefIZbghrhWqv4yoaGD6yHtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58b7e24-0c0a-4d30-36fe-08d6222d28f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:48.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arunk Khandavalli <akhandav@codeaurora.org>

[ Upstream commit 4f0223bfe9c3e62d8f45a85f1ef1b18a8a263ef9 ]

nl80211_update_ft_ies() tried to validate NL80211_ATTR_IE with
is_valid_ie_attr() before dereferencing it, but that helper function
returns true in case of NULL pointer (i.e., attribute not included).
This can result to dereferencing a NULL pointer. Fix that by explicitly
checking that NL80211_ATTR_IE is included.

Fixes: 355199e02b83 ("cfg80211: Extend support for IEEE 802.11r Fast BSS Tr=
ansition")
Signed-off-by: Arunk Khandavalli <akhandav@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b07fd8b8b50c..642a78079ae1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10014,6 +10014,7 @@ static int nl80211_update_ft_ies(struct sk_buff *sk=
b, struct genl_info *info)
 		return -EOPNOTSUPP;
=20
 	if (!info->attrs[NL80211_ATTR_MDID] ||
+	    !info->attrs[NL80211_ATTR_IE] ||
 	    !is_valid_ie_attr(info->attrs[NL80211_ATTR_IE]))
 		return -EINVAL;
=20
--=20
2.17.1
