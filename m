Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85329C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FA2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hr3d74qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4FA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeIXUyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:17 -0400
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:35088
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389124AbeIXUyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW3AG7QgxvoBrJaiGsbMiHajtzM3W2Nq74gC4MbAIQ8=;
 b=hr3d74qtID61RRDWq2l5HXlTa9Vpf49uv+OCTqRjqotNpUr+KtOfHPPUxhTikE5z4FoFfJ/rN6O7gVFCSqa6R2w6cOd9HKbf7PxIzUEtuE4EAKH8kuXzjnmCsHvLnJDioDrWeqPAl2dFupQ+ssqw98PJNSP9QZVmlwaEPRlE5mc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 13/18] cfg80211: fix a type issue in
 ieee80211_chandef_to_operating_class()
Thread-Topic: [PATCH AUTOSEL 4.4 13/18] cfg80211: fix a type issue in
 ieee80211_chandef_to_operating_class()
Thread-Index: AQHUVBXZZxAbGhol50KmEEeO0h3Z0Q==
Date:   Mon, 24 Sep 2018 14:49:52 +0000
Message-ID: <20180924144942.164688-13-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:68C2327t1RYgW6ThJ7WV5Jc/lkEEPyE/7KUCxnr0y/U0t6rR3TO4nHxwUPC+MLjntDWpOm8eT6eW4EPhydIiS0fseybBabfB4wBT7isGKwLjSdUpMoLFfkQXvUdIRKbGcrT8cPpXs9nANz50eVf3QlxazSdwd9RJgjXMZrOjvTfQgQoKxLW0xMq6RN8rQLfPTzJaKhrau+jjl1OwZCnqaIA06R0FrahIUuxrbHTji2wn1eqXwhD5triRSuhWV6drd9ZU0DQdROwT1XL+wuKd9H3GPPBSL6GXaxHuDxJZq8iIVEJVRWepN+UqDT4EkeWus3AzvCXL6/Kvt2HTAB4zmHCPQeSu4Vtq8/FzejKqcXRY9yfPWUxj6OM3tYgR9WJ0TfVocbzD6TB/gWSQOZA0v7GwgbqsbTZToBqelTBH3Wj8R7ihKEm/I4PthUPGEepsDJB8NJqz7pk0gzbQBk3Utg==;5:m1l4DcfEcvkEWNM/UHvLfQ1u7Gjz4OWjnF4iUfycxGxWLA2gWQLX7la40BpsCd0jwXAVq0/+mHSAdnkyo8ICPeoL3194ik2K2m11BbcixYFzya0nmOur1+askfdlLZBg3m1QQcXMSLZn/z9RQWhkyZZh+w/hi8e/HG7zJiwHdjw=;7:mi+3RALO2hAFL7WsiThJ5U/ZVuAczjOf2z6jhY+YI0/up4sjWMecZDXHlVUh8gqV80IOI16lWcgb+CqNFQLT/EkDOw6mVjqie3UhC3coRy/1CoAQTzfYGSqSX5cqhFAnMsMXiB1pPlwZeTm2xeiQgzO4IC7df/he147FDMW48Lwhwol5Z1ZnA/M+dfViWjrDeUn7y2LnHiGGbk1/8GZfJFiNy2ViSXo2nq11Af1G06/fyOzLpe3xwB3aQ18rRdj9
x-ms-office365-filtering-correlation-id: 1c8c0342-8123-49da-0036-08d6222d2d6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821E6E4B470E5C67A47E8B7FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(575784001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(15760500003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NOtmoyHstk59UoSeD0JUWgJNVuNiLaPg6RF98NJElRNEXW/iv5dnHZvZI8GgD9hYC0MyUYcfzXwJrJtkAHgwq27kBpPOZqz8/5WS3EoSUCyLgZgmIRPf4+6v5jhzNcdFnpS/HOnoWpYHMrjhRnDDSd7AOilc6zPqLPLPScvzWs6esOu6aGis9MLsafAv2PohAIQtoEldZPNezIyCJiByaBvSqxpsEef2xR5OisLWN7avF0T/W6AJMATw6rWiqkBbO9xKTiEV933LcIx8ldEbYOe9PoWoQ9hhcc2L5Y5ShVcKvhO8i0SLkmtVGiETChRezwyaFXUcy3G8MjzqzgpMS+r6rfBpkrLLF+Ij4cTT+bQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8c0342-8123-49da-0036-08d6222d2d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:52.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8442938c3a2177ba16043b3a935f2c78266ad399 ]

The "chandef->center_freq1" variable is a u32 but "freq" is a u16 so we
are truncating away the high bits.  I noticed this bug because in commit
9cf0a0b4b64a ("cfg80211: Add support for 60GHz band channels 5 and 6")
we made "freq <=3D 56160 + 2160 * 6" a valid requency when before it was
only "freq <=3D 56160 + 2160 * 4" that was valid.  It introduces a static
checker warning:

    net/wireless/util.c:1571 ieee80211_chandef_to_operating_class()
    warn: always true condition '(freq <=3D 56160 + 2160 * 6) =3D> (0-u16ma=
x <=3D 69120)'

But really we probably shouldn't have been truncating the high bits
away to begin with.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index baf7218cec15..1d239564baa3 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1360,7 +1360,7 @@ bool ieee80211_chandef_to_operating_class(struct cfg8=
0211_chan_def *chandef,
 					  u8 *op_class)
 {
 	u8 vht_opclass;
-	u16 freq =3D chandef->center_freq1;
+	u32 freq =3D chandef->center_freq1;
=20
 	if (freq >=3D 2412 && freq <=3D 2472) {
 		if (chandef->width > NL80211_CHAN_WIDTH_40)
--=20
2.17.1
