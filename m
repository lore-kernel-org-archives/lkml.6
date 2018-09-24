Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5832098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fFMexwmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5832098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeIXUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:47 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730744AbeIXUuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rUeAbkA5kqDjJN1Xo/LyMN6U2UOydqOneIW8oCxW24=;
 b=fFMexwmDa09ntlmUIa25vRVAnoe8gXN8QvfMkGIjO+9clq8grELjvRhzy49mLQO8KVcAQrZWcxHN7n4+XBs3S4MvFEKbcayl7FL2J24MDZNDoBWlrb6ObwsB5m+5QbZLAr3ByYw/9wK4WGkooWg6g60WMw4YioBr4L+Y7+vK6V8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/76] nl80211: Pass center frequency in kHz
 instead of MHz
Thread-Topic: [PATCH AUTOSEL 4.18 19/76] nl80211: Pass center frequency in kHz
 instead of MHz
Thread-Index: AQHUVBWeLjaZNOQBBkeWtbjA6oVJ5g==
Date:   Mon, 24 Sep 2018 14:48:12 +0000
Message-ID: <20180924144751.164410-19-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:mjkrMlcrvEdz+QoJby/GYTWumh6AbbKF+WYEJW9iUQtl0MxeaZP82+P7pm8OKTvacXChpJphI7p/xPAt2VuJaJ5tHQ9w3HA7BBpvUODcOWonBJY9+CYjiWh6+2gsYAWsFpQ6wwxJ14aMWzZJeqUZhMpuziVln5YNdzrM/+rvBRpujer7rmO6MorXkNHau3QQoX27HJyyWNMBAXDNGl6HUF57o7WVxQVuYWBJeiWCAcswDZ79Gkw26iNEA1zRpPaVsggMwK7NCNA+8dWaPvqNEjdqGepZ3O8luGaiMs2KJkzdHUBbwvfP0RnqsU1/hoYG7m0Z+OLrZ0dXtrWBfLgziSn8IJ1bVryjd7yQIDWQ6pskhoGJoWF8B7Fi+tntwokgtYeHWpeldi45PHaHZiNywute7W7DxliPMieec5axoFM/Ss5FkDF5EMTswAq+kRbnqAxnS95YPj/eCbpAp7v4DA==;5:kc0SyWXLvw//8/2DVo4gfP0A8GxdCyXhth/O30pgtygLO+c687X+067vuIxdyUZ25mTmB1D6UdZ0jnNcTFENlKjPVnPX22nYgu0EHxrkYbaO8QUxqNDOsm0QMePJcdyzfPOIIAbbDE4i5RQM854ZxW5AMcmcdpnRXCdZo8R8stQ=;7:BR8Us1KlGGHIAo/cQGpgbdqPjqJ4Xtcy5gSET+LZxQ5Gt2IGLRGzfeQMltaGcPeKkY/BJJUrpuSIk0P+0Jw5E4XZpG/Btlshe+XhwjoAKSnoutHLNB/9dgUjuq7qj8YN5DcBn6zHXqMeEusqTLQsO3ow9QV2hVJJeqcvZQWsVOzCCOvUwZf5YZ17bDtrOxbqiZVzaNbfZByxm23EWrNxaVPrIwhru3zQUKjpDjh8zDQXlvzOdwPeyraMu9rCNMmK
x-ms-office365-filtering-correlation-id: af343816-033f-42ac-ceb3-08d6222cc0ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821B6196FC8313CD14CFE79FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CYZv7hpm/NKyKxucOdREi7muZcV0s/wBnohhqA4vaXFHZBSoDp/9VDOB8HCqdWeCrSpqjPagFboo7fzkQUMnDZpgBF+ZICevHaJq1ji/9s/FfwtvLVhAriCY96io87O/JzCTl4oRjcHxUj5G82JFgT6y5LqmDIMAISPDp8lKPICwXCKkfJrCIO0Mf6Rl40y/ev5B62xNwRSZBwJhPoOMno8lL7s7sD6V1vC/kvogSkCuBG9PEzopw09r54FNA7qx8Q0juuMNMuxjNt18XeKHi+7NnHd5l7wmVj4GjWDx/8bo4bLF4ROWq4aK/hOK7sqGMJm96enlV4ADmXbCk2xv/fYsh8PCOIbJSmsMJls7aXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af343816-033f-42ac-ceb3-08d6222cc0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:12.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

[ Upstream commit b88d26d97c41680f7327e5fb8061ad0037877f40 ]

freq_reg_info expects to get the frequency in kHz. Instead we
accidently pass it in MHz.  Thus, currently the function always
return ERR rule. Fix that.

Fixes: 50f32718e125 ("nl80211: Add wmm rule attribute to NL80211_CMD_GET_WI=
PHY dump command")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
[fix kHz/MHz in commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3f7ffbe6c634..ce0149a86c13 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -764,7 +764,7 @@ static int nl80211_msg_put_channel(struct sk_buff *msg,=
 struct wiphy *wiphy,
=20
 	if (large) {
 		const struct ieee80211_reg_rule *rule =3D
-			freq_reg_info(wiphy, chan->center_freq);
+			freq_reg_info(wiphy, MHZ_TO_KHZ(chan->center_freq));
=20
 		if (!IS_ERR_OR_NULL(rule) && rule->has_wmm) {
 			if (nl80211_msg_put_wmm_rules(msg, rule))
--=20
2.17.1
