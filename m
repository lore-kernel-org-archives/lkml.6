Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7727ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884592087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e0T5an/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884592087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbeIXUya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:30 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731967AbeIXUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv4ewO0RPQDWr+SUqUAeNFiOC1ufts808vM1zKjgzD8=;
 b=e0T5an/AAgtovWeqY0l2MwxJt9+CgIveV7AyjZvLVkCv9zNNUUkTbs151dv1uUk9oI4gG5mzJxi5xczjQXcMfTdfsDHCFcyn+FUFACHtmfIRH0VmzTMWspz//VDDU+e0VzilgRYzRufdxfUxZ1yNQNCrfHPuV15Jk+3d5RmMOyA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arunk Khandavalli <akhandav@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 04/13] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Topic: [PATCH AUTOSEL 3.18 04/13] cfg80211: nl80211_update_ft_ies() to
 validate NL80211_ATTR_IE
Thread-Index: AQHUVBXjTHnKrmqTMEivwsPMevkjPw==
Date:   Mon, 24 Sep 2018 14:50:09 +0000
Message-ID: <20180924144959.164754-4-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:vhMS/6dYbcz5s3Dr5gGGuRJK3Q332ptvq1XdZEdReRwh4MTJ/qNxeldKOH/mLU9Y9F1gh0sNoi+V43GK7ZxjPWZOeQIPNoUdt5f48yDrZzC/049lsTQOeDYoAW/nCcisx4M/Xg0VtY1XT9Upxfb638BpwlcHdWbqnOPm3O4oJNMol7q8EZl7UWFZChUeVVL8YgVny2UvaB7z2Vpf3hk52STPvE0xQmHlFWCKcr396jrG9TDfPsgeViEzfQ+kkE2isQ6fZBFvUdDljvHNcL15LgreU8yxpXvdIdRC5gEVfAwYmuMOWfC+gG/LxFm+38s+kKLgumaC8zpIrLxDxE4z40reaTZ1DfeLG8FXqOd92KbWm4V+BvBwVK+7ryoTzOiA/2++RX/9jhRnkJsxdfNRGb1oKjyQ37eoArlEWXOq/mM5HowUAOmg0+UbI5yCV84gb4Dm/yZiCCU73OKCEz/Fdw==;5:w8/o3a09QwetkCJZlw7V0SdRvmp/gwOZBfx0sQSBvNHY7bXk4QUeacUcHBHxfY0Itff6wEwsm0uWV8Bs2prnzxt/iIStqm6DwjAjB7d/qflUmJvZm1AdSD6IrWFmBzrdU4mHs8pdycS7TMcEYhcv4ZZXH6y5/cQI+NLWgLyy++Y=;7:5L4m7H2M5OnFoqJoZ7zVGezaI0uYU5PoWP4dlm3vcmnS1d2sQ/oyA8758N5h77bLfplc4A3+mTQMdIsZvCpB9HhMXHaQnUp5UT23ao64EmPrzNbpvVoPDmBgSPNzg3eT8HeDDB1H3SUlR+TwVp7+AFRWTT6iu6xASfwtZsKof+0zivQAMeB68NOgxnKqCkAFazvsMggy7EyzwPYYnnzJbtmNmF1pNgftgT6LjsbFt5S+UN1dbA50l6ll8H2Hcb3F
x-ms-office365-filtering-correlation-id: 1261307c-0553-458e-aed9-08d6222d4152
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631296B48FD937067B99645FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(15760500003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(15650500001)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fDy9qpb2ts6Jfi945oRIa3SzpNQuhTVKOAaCu5sYFuHbEdmDIxlIfLJqa2HKakSIRxSWRo3ZA364R96PooB9bMWYCxQmheMZ4v2HvpTr9PXxnLAE9NDQaqOGTKcryOSyX/vmxTeQqefB+sSLMSJoGUbZO9pGcEzbw89Kye2GrQH5iJ23a6dcHDrBnger6ROSH0Y41rOx1jMSXXKvlz/EbEo6bLhWtAhvGw23MwxiaAc523uIbSMv6szxgosQP/EF+mNTpMYhJrZf4Guc6yFy1zTGuGYB/F3t/MSmWhEPLR40kAhicfZ39Q5nkYeCVoLHtTd4MeLfdVnQXojkVouDzPDILmcRY++64dPOOggc5v4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1261307c-0553-458e-aed9-08d6222d4152
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:09.6450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index fefc9a4d3592..2e1633ac93f7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9223,6 +9223,7 @@ static int nl80211_update_ft_ies(struct sk_buff *skb,=
 struct genl_info *info)
 		return -EOPNOTSUPP;
=20
 	if (!info->attrs[NL80211_ATTR_MDID] ||
+	    !info->attrs[NL80211_ATTR_IE] ||
 	    !is_valid_ie_attr(info->attrs[NL80211_ATTR_IE]))
 		return -EINVAL;
=20
--=20
2.17.1
