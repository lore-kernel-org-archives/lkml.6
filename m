Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B476C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE132086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AlNBPa6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE132086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbeIXUws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:48 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:44640
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731114AbeIXUwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYulSQtn8lMbPnmZEULGfMDGOJTuZzBSk6Kcub/tuzk=;
 b=AlNBPa6xfVGyTCooAjSfjXm90WtpSdSihgXpPUubNKxpUXjYY/ogYD0W1E0wXUIkw8qjr3FkfkMbTqJzGbs58r4EvRnetZjN20IlQR5QXhzp5sGtCrNyPmcTM9nK0BdzYT+dZBgH9ExM53Fvm9EAQ7nXXOEmySKUy+6gbs6Qi90=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/36] mac80211: do not convert to A-MSDU if
 frag/subframe limited
Thread-Topic: [PATCH AUTOSEL 4.14 16/36] mac80211: do not convert to A-MSDU if
 frag/subframe limited
Thread-Index: AQHUVBW8qLdAaKbzq0OScIuzgpnuMw==
Date:   Mon, 24 Sep 2018 14:49:03 +0000
Message-ID: <20180924144851.164533-16-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:VMgQ57dDOtwRMIXOVicp5mZszicYpKBaBQR13TfGSaomv4qxTEuaV5K2Sq7oYn2rD0hxkpnJAYI6P8NEv/lH4qVXTiLYuI83V/kVvPf8zqxBJrWN5rHWG8I+U/v2GwA6EGj91XQ1LYYLfW75nhAja9vOArgH4kdQmmEZJmeB2DNfXBYEQEMu+qRAXLnlAWpFv5A6tv6VmSmMAyFmsIF7gm9VypUsXQHPAgC897EzVXxrBgcGzG069USJTKhaYAlgJ7w1dWBR3glGb/ghYJlioaJiL4uYzN9a7KlIjc6bEl5MUuJndp+h0Pu+mckW/C3sPGiZQK52tJlE/7Mlm9zmi5lG65+h0MYsBLWK2gPteqIjljGdWGmkGhrvR57ELwf8RlazqZYxJiXdA8+DQHPXqadSoR/oa/9xfflyHpmnruhJrtIn/JpvyRhHMyoXlh3rVmrLTeqZ3JGZCpwkPMn+Dw==;5:jf9jeH7Cdnrv5FXYuk/6jsbleXy2E+NqKCMhBz8PNprqzg9+ae4I2tY7WVedZYLFuhKsDLr4S2naCjLFwS9WV3WJFVwx0xNjvSafpNVcXmEiqiMkxuDARQvU1IIpGwjRW8oBgJyZtFRaB97HfaCBXoRbIZCeLpqBljQwSxJvE3w=;7:9q0W34qJb+Q8Y3FbpyzylhAyw58kNSe+4UN7kVvLkE/vXc9xQW0rQL6PStw+6HyEF2fy5ZhDMAtKS2FMZ73L0OXwGv9XpGpeCQxg7DsGrA1fMcRiZlOIHirPrcFxfxHRvpcz+gAPLXGpobSJrFL4KWLTi9QXRMa/dYhlGNkrKnvVG5olmEyR0tbmPpSqajV8KQnlunU+xBARe/ZXs9PB1Co1/mdVGs8NWoYUOkSD3+rKZja19x9vGtiMfnOVuUOI
x-ms-office365-filtering-correlation-id: a6c15618-d174-4e8f-ca21-08d6222d09a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181DC6889EDC68CCA404AFBFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Uvd7FSJzd4e+LAALc0RirUCcOGfBJIJpqfnbfxb/P7XXJgZuVvGZbF7YzGnefV5fJEGMYqrdUUTxRZOZYETPrkhbDIGsm1IEd4VJ+VleVL1x8WIwO/pQG7S0JnXz0DzACuOkq4ytxL1wQKRkkNK2NYhtl05g2oCLYWGU1ffT3W4eUgv/P0O1nzS31Xm00ksP+fwKGKQYF9hmq7V073BWedcQT9doNvxq66bB4z4c+W/j2DmcGbBJa50GHaEgb2i+9xnp0kFLKPm8gdXFjwhFlThDh4zG56uQsRHOnfLhRdkkEL1rXwmXklYvjPrKCamI/6LL5VgbZj/wiSbi9353kp5eVD0czcQjRVbJCWHVlLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c15618-d174-4e8f-ca21-08d6222d09a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:03.2173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 2064234500cf..fd8dafe73aec 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3157,9 +3157,6 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
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
@@ -3175,6 +3172,9 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
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
