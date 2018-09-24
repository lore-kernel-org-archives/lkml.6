Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A01ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7966E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XBeV+/LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeIXUx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:27 -0400
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:30644
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388381AbeIXUxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cd5itaflCmVni8ASUkKVGWwFN5IwrqkQMvhQ05SOSA=;
 b=XBeV+/LBuYJLDLknVNAL6SiqxT07QaklomLMtv5t6/9Xy9d5bmSnMO0JD352ap1zQ1oxxwFfhlWxWWUJ6s4fgDswHLijB38YIBuGj73rckRQqHGrHaLl94UfDMJFwiaz28fw2/oi9YFnXU66rddwKiNEOoR4cQYT3VAr4lhwOMQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arunk Khandavalli <akhandav@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/23] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Topic: [PATCH AUTOSEL 4.9 08/23] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Index: AQHUVBXL19QalIqrGkS7qTLYPE2iCQ==
Date:   Mon, 24 Sep 2018 14:49:28 +0000
Message-ID: <20180924144919.164617-8-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:06WmF80QBQS4VVL8lzBGQDFJbt4RpNkU5xXWqEGMk/3M6GxYKV85o4flbiRLWnoqpONcSry/Phhc0YQo/aYU5XdiWdipXkeb2FZ1hGigi6AJve7sZjN6u7WWoRuU2CFV9HttF06qXS4uI1UoxApPLK5VUbfvu1KyCZweZqrlwSlR0BHaotjApbb3mPR26tXM+QJDLyGdjPcHaQrYSOhL2Uos2ojd2wlb99D41j9TIzSDCb7CN19+rZaAZkNaIQwbjrCi3vOSQ6LNO/3Qwqoot/a45OU2RFemHfEDBrSvXfYHOQ3DH/DP2zsN19BdjzkBtncdJuf+IYlRlsYtl15DO1M5yTmbCRwu0JTxKhVSFhXr5+a8Gbz8WBObsy/S65K5M5KFDwPrXaXmlkjBekyqWVgzDt2HXfzPYcmfkppxwgKkqLIgPWZ0i6tntW44nWTSzOVbSMpInBlcgp3Kux7Hlw==;5:tKkGAtD4o9GnVX8riqfB73hdyLkGN/rwssClSkxhZLiAp2gQym9YSbwz0Fl01QdNt/mOsx6yYm2wl7gHcychZpM9YEXxAFfk+tKFkI0WiWWDzQiS8kehfLXwASv3r39AwI6sMYBZbBthuwIA/gXYDfxq3HTkbjrqE0dX34PT5Z8=;7:rVsTjEOd7FO8x00wvQoSjvha40zErepcKCOicPBVJGZIXTjVgT8J+V3lDtxVhyC0EVWJu4oY+XfPyCJS8BdLVABIsidQO8r8/GMn4rmo4jwZiJKqy8aEUAzLMWWqbZZyhQhgs8qVO6T1kCiYyNv6K6Q3cXuoVPwjAl0JX1f7eA6D9BhKyZINghoGPAOTyVjc0lZg21U5HYaoilbQ5zPUCpF6PwP+OZTcKYLGOXW7C929bH6fZSBEePbuzz8M9bcy
x-ms-office365-filtering-correlation-id: f48f6026-8451-4cca-6c47-08d6222d10ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01812B9A69F4D262340F929BFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(15650500001)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(15760500003)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: brM86SBALaLegUFr4yIzfgUpvfALqmBa82lB60aAzQX958MFUBzZkrqeGwJXwcoTN76kMJyJdCh/JP3e4oJFJPWeP4vv835oSOHfXlJ8EUHvPuZwrC5wrHI9Gv1Gk8ddsckejlGXaJczZYi6TKOrm3i8SK/OCaeYHy4MORjY2K2hq2APObJHRtR3S6eF13prjqEap0lDSMD4cE3+hqiOhPBNl8+UF3Cd5wYDmmAXydwa6BsZTXByEDkBqKROIH3gxq6T/VH/5LYQdT9+AmObUhwp1Y7a12VZ9QQd5m/bmVCsU7/0jDICLK7PEotJxqxS4J3YEZe4VFnQtyDYFyJUxzMSkY7uU7pA0/krwaiMt/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48f6026-8451-4cca-6c47-08d6222d10ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:28.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 6afac189d20f..0e91ec49d3da 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11148,6 +11148,7 @@ static int nl80211_update_ft_ies(struct sk_buff *sk=
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
