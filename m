Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AD1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C42204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E5lQOfHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C42204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbeIXVNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:13:18 -0400
Received: from mail-eopbgr720137.outbound.protection.outlook.com ([40.107.72.137]:26497
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731104AbeIXUuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVen60AyvGStRBHKh2OhR7Vaur0La88yPOnQMg5fqzM=;
 b=E5lQOfHj0O/G/nt1vGJecO6RjaP5lGqXRPmjj55TRHS+shGvBEtnxp91HXG1VYRQRZYWZeW1tx6o3OLPBf8o66GPxzDsyBmI6RWKvsXoKVDmRAI9iRH80hyfTntDGVBv+MzZeOv8QLjtGomyen+dMV5yAENghdpB0J/MdJjhHlA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 22/76] mac80211: mesh: fix HWMP sequence
 numbering to follow standard
Thread-Topic: [PATCH AUTOSEL 4.18 22/76] mac80211: mesh: fix HWMP sequence
 numbering to follow standard
Thread-Index: AQHUVBWfNxknJdpcgEOm8xVsf71qNw==
Date:   Mon, 24 Sep 2018 14:48:14 +0000
Message-ID: <20180924144751.164410-22-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:Wsvprirv57duaj8XLvaWuBGHCGhg2Vsgu7cd7NEL8rkrmF+KUo7/aLova89W9YE7oJfnR+bRr5i1WIVIrFn5k2saSNlcuxqJr+rJ8Wq2gzFUOXKzygU+X81M37mDC58tV7d9Of34yiE8sErU5u7YHE9w1VPKZSGwZ20eiRKJ1PzRG686yYbfxDkGJIgOTh1rywO3J+lWVHoRYAMRRAkFfbVKWsbVcpm5FJkAYDDl+7kRflNRIhpC1oxpZdi7xKsnGuk8sxdw0JnK8VrmDmjq8U5+fCUgOUCli18ygY92jkdxSD6SLPq8XZdKGDyYCEVBe7t79u3chFKRIq/5Pye0R1NrpyssTvH7RQ+aZt/ZlEODXUOggn7LjOoCTLj/JyAkEzONczZF5ADy8MR9dssAMK0aA5M9sSdFO3zoK+8o63Tu48Fzjj8jZ3YbEZ6BJqVJaI0A6eRNWW+TlUCSasMoYg==;5:AhtAvTDbAIOHMR8zwtLAwvBqYWpM8tK1xau79VN/oXQik0qaJHR9rch1gjsZjA+WccpQ4UEHlQJ3PnrQcEG4IKshCREPZmVfl1QFW/Llq6eKi/NGnOTkg5ZrUI1Pv3KkUXBlvVM6sqAWjkZo75filnfBgvljhnGEGL/lqBZBEz4=;7:Qk/+abSpFQhBgLlmXcz/rKmqKIujKUcp/ppTjY3SFi+IPaGig/7qh1KAIiZ/69sxNPmER2UGEKZuXPR/AJFLs9LQedxpag7rsrUFAUFEWyKPEWn/3Jx2WTKyrjMGhAuWkY3cJMfiaDZ6vCexh9fuNcM4FBSmWe1zqi71B+gb+Z0aLOISwkRy7apfJEFiDLFqjRkeBckHw5QFSJYBrmHJ0GYwskPDMGeQbl2e/Rsblaa4iAlTADEGIKIbkVKsm4sm
x-ms-office365-filtering-correlation-id: a484a2f7-8498-4b2c-f65d-08d6222cc1d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821C2DDC2F1E79207B570C2FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(39060400002)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0UKm7l/x09qxQUZn7VxdAX1fMd4bVPEd044kAVjJmVQDKvMufBNMYaCA5VrcbxBpm3nxvIU48iazcMO7Uspw5eG9uvkpE1djt9wUnVO4VQB6eeKYmPPpFK0p9kOVbD9vSWl5pzjAlw+HoEp5/rI387CKm1ekwqqWFV+FGkxbNa4s5JMoehoicrWOk1V0gWqVLIkZnSH7Rs6FjzfV0IQOPiqfZx1KIWB/fO1cYx6gu9YVWg+0e0JvUGSBtATirPeg5X18KYUG8A0cv5RZ7V8UUPt2FYKgflgbcmaciF1Qn6qEuxwk9k9mFNkj1iOdJlr50kxEMycYRPPZZ08bmhU8r38LCPF45cR/unAbxixh9G8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a484a2f7-8498-4b2c-f65d-08d6222cc1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:14.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuan-Chi Pang <fu3mo6goo@gmail.com>

[ Upstream commit 1f631c3201fe5491808df143d8fcba81b3197ffd ]

IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
If it is a target mesh STA, it shall update its own HWMP SN to
maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
immediately before it generates a PREP element in response to a
PREQ element.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/mesh_hwmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 35ad3983ae4b..daf9db3c8f24 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -572,6 +572,10 @@ static void hwmp_preq_frame_process(struct ieee80211_s=
ub_if_data *sdata,
 		forward =3D false;
 		reply =3D true;
 		target_metric =3D 0;
+
+		if (SN_GT(target_sn, ifmsh->sn))
+			ifmsh->sn =3D target_sn;
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {
--=20
2.17.1
