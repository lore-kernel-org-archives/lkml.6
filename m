Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46727ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C212086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g0kldtku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C212086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbeIXUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:44 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com ([40.107.71.132]:35136
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731986AbeIXUvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2o2NEc4AFx3/AKfhGrHxWE/bNJ17OgEQu9LPWzY+oA=;
 b=g0kldtkuEPJIRa4NBU4xSrZKXk3QtBY3MyTZ+ucQqbm/Z+pE8gqcE5ixKg+x6RryxeZ7JrHOHhH8VkviPB7+Au77O2VmGuynR6Ap2ZSBEuF4vinNT8VLcwRELpdGgAFR0ZvzHyVTeUcfXy/imJAAghLt25EXvyRrMg15qv3q7qU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arunk Khandavalli <akhandav@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 36/76] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Topic: [PATCH AUTOSEL 4.18 36/76] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Index: AQHUVBWk+XX4+7mR1EmRBJljyxwtfg==
Date:   Mon, 24 Sep 2018 14:48:23 +0000
Message-ID: <20180924144751.164410-35-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:JZBcLlQAdcDlodvFHMPx3GK1GVlDV92tA0BzCNf4mc+/ADD7b5zT0EXUrkOzh3VNKJvyjqRlmyCR+fvF1BKtX1IBON6eM94bw5XENh+Y6V29nc1rNs6R2riy9Yqd7sP+oUlTgrP6EkeiDN1TRZrxC0Sen54uF4L9vx30r+z9bOthbAEdQ0b3QInZAg1SEhnhledzd57GMDtrnFKPLm/gJlf7np/pdLJSC3mjNKBzSJyrNFQhSVbqxfEo8LWAXf4c6h5m7bIfXGxg4m6OgGswCdis/I6EBwFHjlA4au+40xsUNKYPCLB3gEVjMDd6udl3Ksr/EgPB2kvPxwtKbPGL67IQHuqHy+i/02Hi799ZWmq0Qc93yPp7k+wueM/fKTiS2Soq5gQnSnh9b7TYNyhJXlbVmemzUpBQvkwUxmk8u8GAvKEE+nF5qChtNMUjeGr8BMVODvpib06k95bLFHOr2Q==;5:G9skSiPfSrpTh0Q+Ou05nd5mdfGPNSA0qfV0Iis6V/VXVHgX0Bhf8anuaeCaI8tdpsQRRN9G7JMFIbdQCI109ezRPn+S7F7sQOZdu2WtXEfOT92VKHBjHWDbrAlnX37VJbQUYmLxdeU0urpgp5/jR9VdPwQGEtvW4CEgSznr+E4=;7:lg6ewm0jSD6hCVFHfaeyHR/o5tsbOGBBhYW3IDRH7qbhk92m4b1mJMfKB3TCVk9rtxj9SKbFzh95l53VT60PNgrz/JuwS6kdOybkyTiPPNJqPQKhsritSqf9ew5k/5lkeHfr/7B2NmfHC20bTpeu13wSB8dW7LXIosejVjWKC8Ebg27qNFKnowEYO80UGqLsBhy2cSqkVcEbpXc0uFeajgufjwmlmHrPBDZ2Q2r15RMNBseofy5pWcVz9qs+Q4CD
x-ms-office365-filtering-correlation-id: 09fca9c2-9b85-4c22-bb99-08d6222cd882
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855B3D2D93776F1A56464D5FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(15760500003)(2501003)(99286004)(53936002)(4326008)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UNN6TumoEXW3DfOiExtXfktXOTGyqdxVPAuG1Wjq38TxWttEXkR2zRXrlk8lOy2HxlAyCxX1oYpMc71zoH+agQHJkLfvFmrAN/oapOLC+JFW25in38M3yPTMJ1oK9i7AckVxvJUBUbwn/zXrEHKYQG2UOvjsmvoy48bbLbGl6R3PSrn0p1JIwztqSkLNIOF8akW7hrY3yOGhSl7gsBY62BxQpNy6c94qBWvUv+OZeu6BOZODUF/4Xqag29gEx7xJWXWZO3t4ni/v6PHwRZEup54O5KEJ58Aehlotfk9FTlOwK1u6e86lsT+oqZbbfRCVe722fPPb/lHALTEi4eFDNQ6ZtlnTS0AMXWkn5sXPTgA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fca9c2-9b85-4c22-bb99-08d6222cd882
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:23.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index ce0149a86c13..733ccf867972 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12099,6 +12099,7 @@ static int nl80211_update_ft_ies(struct sk_buff *sk=
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
