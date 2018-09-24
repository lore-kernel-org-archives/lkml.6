Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67DB2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jIqPLdnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67DB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbeIXUvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:33 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731717AbeIXUvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/djrg3sDgLflDo5nFEL8QEnnZ0hf8B1s3ke65UkqwA=;
 b=jIqPLdnnTR2wryiJBHzLOlyI3L426VytBlmYy9HpSrVWHDqfXgre9p/+p98JbtgDr713nHBkZjze16HH/dmjkOwFjX3nlZKnqTQ3fGKCbVrYi7syNqS+LAvUqnu8nIncm7YDo0/ue2sgUE4O5naqwzRkFCkGAUVH1O2qMrS2mSQ=
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
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/76] mac80211: do not convert to A-MSDU if
 frag/subframe limited
Thread-Topic: [PATCH AUTOSEL 4.18 37/76] mac80211: do not convert to A-MSDU if
 frag/subframe limited
Thread-Index: AQHUVBWlOfeG0X6p2kuiAGJ7mccBJQ==
Date:   Mon, 24 Sep 2018 14:48:24 +0000
Message-ID: <20180924144751.164410-36-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:bgqh62ha9vNfLg4/U/o34J8xDssQGuPPCf0WKKOMO9M0FVfzGQB002p6Zh0GD3sy/gtCw0Iv3rPpFJdvCtwAC6Huf8Qs+Xmcp3w9wHvg+fBdQ8a5MUn5meg6SEch3D0XCT+XFiuZq2dGDnLtH4N+bEU9fCtN1PtlKgsDWBq5+tudVTDrVCcRbdNdptKjy6/jrSQwHnBK1Vbkpgha35L1JlwKfXkfRIV0HJVYBLDLOE1w1AOtr+F22wzxCxHZDjuSEK4cwNKivTeCcIgsxJU1f3tAJHfLWv/nC9X6le9Mq6e1Z7C6z9V0j8Oiq+awmeFld9G3imqTKi2OMOaCnYKX/j4ULNGs2Q3fqMlbZg3dRBv5YBTHKlmw0nh15/sh/l6gxcCF6RioH0J9jMx9//83gJ8fopY+tGQc3enzOupjyS3fq4C2II2o4rLFrO0tyUrPDen7VJtZG6qog+Q5bJ35iQ==;5:YKJt/yNJjlBA815AHU2giqpJDC02LEpFArJ3d0s1qQ/m3F9LyR6QDVBuGsfttHH3vsRq2yp6tAfb7DUr6djqwqfl0hG8N5YB9mczzA+hBdLeVyS4CRopXY18D0JTgrwED1vZKjjOnkWfOAINflONd8saZZnWzKfIxO1x7QKQn4A=;7:azRg3OhuJpwSVEQGG0PD8AhA42RHPO7C8o6sg0eV0pXQz+QKwpE2XrITXxjE9LxunWyR3hzY82Ol/KSNnGxSQsQgbudW2x0iSZbsUfzlYjHD9CWHGA34rsLgc/Wj84oGFr8j7LebAGlX7/xjTpyJf1pawNXsK4pJXhglwXdxeNwd1KYbjvLo5vJRv+xForSYGLLlZEehhxiJpOPvlS/pXGbyjRIYStabwAgINKQizDipLxKtZ/MgbCkTFhBuodb8
x-ms-office365-filtering-correlation-id: 89fd998c-0442-48cb-4a8d-08d6222cd8be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855B3FEDED4B4C8E3F2259BFB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SgQuMHcGbQuEO2laxbC5jVtNSKihwFrYc/JB43G1MA9hVhSRF/nkhztcWNAX32pUvIE/oAIcWmY6j1VnlfOD5KlMK6dZZ97Ki5XM02AGTk1qjm7jluF6KfHN6DoyNvEuXB28X8AZAg2yA/V2VwOfX6F2RG3eRWBPYxO9fDp2IyapZDSr9H98hSiGhHnu3kgLEicX8x3HDiKaUOhqgPYxGdKZjpWbKI9pTX1taRYCeXmRrcV7M2Et2FVs1TcaX/LstK8xqvmdAOVkPkxO3LT8JjTrr+3nE0JsUoyqK2b1+9cJgtsqVY3mAZrAJ+8VsP8l3fSPak+7026ydu+tCjR6VdFuJy9LMuSz2zfomPsW9PE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fd998c-0442-48cb-4a8d-08d6222cd8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:24.0770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 1eb507903665442360a959136dfa3234c43db085 ]

Do not start to aggregate packets in a A-MSDU frame (converting the
first subframe to A-MSDU, adding the header) if max_tx_fragments or
max_amsdu_subframes limits are already exceeded by it. In particular,
this happens when drivers set the limit to 1 to avoid A-MSDUs at all.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
[reword commit message to be more precise]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 667a73d6eb5c..1aac5e3c7eee 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3208,9 +3208,6 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
 	if (skb->len + head->len > max_amsdu_len)
 		goto out;
=20
-	if (!ieee80211_amsdu_prepare_head(sdata, fast_tx, head))
-		goto out;
-
 	nfrags =3D 1 + skb_shinfo(skb)->nr_frags;
 	nfrags +=3D 1 + skb_shinfo(head)->nr_frags;
 	frag_tail =3D &skb_shinfo(head)->frag_list;
@@ -3226,6 +3223,9 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
 	if (max_frags && nfrags > max_frags)
 		goto out;
=20
+	if (!ieee80211_amsdu_prepare_head(sdata, fast_tx, head))
+		goto out;
+
 	/*
 	 * Pad out the previous subframe to a multiple of 4 by adding the
 	 * padding to the next one, that's being added. Note that head->len
--=20
2.17.1
