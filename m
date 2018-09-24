Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8455ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731832087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hk1hb5HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731832087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbeIXVAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:00:52 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:44640
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729712AbeIXUws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9V60/vRPnTmL6FryCHsO/ZMVfDdDG2MaszTeB2HPOY=;
 b=Hk1hb5HRF5a2eQeMq6vxIYuL2btvzYdh928fv+vQhFj5lr6HnzzgEA6mqDXpDDE/CpqNtzDucSoW0wlBtcd0F31dLb0IIIyeAldDt5wt1L/6mt2FpYw4/iGiEQKaDW6TbSlCoAkkhRjJNqvBirRDijcUSIqezMhdlK7cUZVvezM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 17/36] mac80211: always account for A-MSDU header
 changes
Thread-Topic: [PATCH AUTOSEL 4.14 17/36] mac80211: always account for A-MSDU
 header changes
Thread-Index: AQHUVBW8yTxXszOMF0GwlMXkFy835g==
Date:   Mon, 24 Sep 2018 14:49:03 +0000
Message-ID: <20180924144851.164533-17-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:JMgWpJGAyuxCul4PDS1e0Ce9xUCJ7WtwDUP0nBLGEfWsOBKvh1mIKG8Z+oIR7otWZRgWN6SBY1Vgxqm3pTStIpaCOowfHsgHeR8wmNTOqaSUvsgCqB0hs3UzvpaXbzv/1HNiwvlGOT5BwGafbGCJjKgQnSpHDtZ9wmPpa03D4ZmtMXXsTMbLrusOLwK1cFsXSt8crL1hYcaFDP8DM4IqOQqjdZTcp75oDMedugcfY7/bQBnp7NpH9jG7ysJDDaVjFVrG43WVKXR6mPBsHn/tbQQEOfhuITM3Gmn7uLflhNf7MzZuHCPJPNXFBVigWH7QiJ44xEGGtDg5RgulfySPL6EFxRJidB7DpaCu5bSOkFKFRvT3f/WYuQxGfcV7wHi4T8oBZh56OvLmXE4cm7gq4iM8Mx++/WZ4RqCQo41QXRiRAEY61HYR9Pa4C2DiY+rz3JZTckJWAKu2RWQHpxUkYg==;5:q8oxvdjhsTE9Wp0FNU4DDlB2k4EyNemGD3HZr1ZnClOVpJ48R6CUc4svTv64KXS5L/YgPuWLCGI/et3OJFT/aOHLfbpOkuwilHnxarHSsz15Ts29HnNOD+BxGfqgHIlfvTAKN6pnzmkeVnV2uRh87qiflyWCgUnwh/M+4CVKvzo=;7:q0ZM0tkKJuDnRERywePqcS5Dg86z2wCFY8NtNG4Uv0FHkuDQDW/1YorYCGct8w91ebrcxc1W2L0EGHCvaNrmjGrxmCRGp/vsLdFtpsIjix6f00YhEeoS6oUhYzFxf9ZnTU1RK3C7W7YsGhFza+JrMe4aroSJ/WOD24s7fcUd0Nx8UOdcgsQaIUrzdNNk2X2kmy2w1BC+1rJuo7cJI33+yDTbi4axY5Haf4Ql4vLUnAzh2FTOtIV1yJ5AhFOO+7cg
x-ms-office365-filtering-correlation-id: 7b48d83e-6438-4408-ac34-08d6222d09d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01812EA4FD29C6B3621C4363FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(15650500001)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sKg/MN74JzGHYylTt1jB9Nr0urASINUaIf7utq9GxkNQtuWAgfmKFUV4fneMxxeDht2jI/B5g1m/vY2bFAmJqPn7+luIcgTZRQxKf3ZXplSqn1BLmC0nWTF3RgnREZ2B8GAzaaMsuo9lYW7qzoAYcuGh6L/X92o99vHPCTSiCEHraj5hU9BsIcnh7HXZuv2Lzxn01eZBWIPPFBjZi/UT83aWzxTXLYgHsaAot+drd9mfU3o3MFPjhKBc3TgkoxS6RgSqy8ukK3suHfnZrDzjwXz6JXvL+8oMimgG247PxF1UU+CnSt/tVRTHClw6zrqqqZ4RsBXSs6PKGuqmskIZFweY1NpR0xlUnpdzdqABD9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b48d83e-6438-4408-ac34-08d6222d09d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:03.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit aa58acf325b4aadeecae2bfc90658273b47dbace ]

In the error path of changing the SKB headroom of the second
A-MSDU subframe, we would not account for the already-changed
length of the first frame that just got converted to be in
A-MSDU format and thus is a bit longer now.

Fix this by doing the necessary accounting.

It would be possible to reorder the operations, but that would
make the code more complex (to calculate the necessary pad),
and the headroom expansion should not fail frequently enough
to make that worthwhile.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/tx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index fd8dafe73aec..8320282ec3b3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3188,7 +3188,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
=20
 	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) +
 						     2 + pad))
-		goto out;
+		goto out_recalc;
=20
 	ret =3D true;
 	data =3D skb_push(skb, ETH_ALEN + 2);
@@ -3205,11 +3205,13 @@ static bool ieee80211_amsdu_aggregate(struct ieee80=
211_sub_if_data *sdata,
 	head->data_len +=3D skb->len;
 	*frag_tail =3D skb;
=20
-	flow->backlog +=3D head->len - orig_len;
-	tin->backlog_bytes +=3D head->len - orig_len;
-
-	fq_recalc_backlog(fq, tin, flow);
+out_recalc:
+	if (head->len !=3D orig_len) {
+		flow->backlog +=3D head->len - orig_len;
+		tin->backlog_bytes +=3D head->len - orig_len;
=20
+		fq_recalc_backlog(fq, tin, flow);
+	}
 out:
 	spin_unlock_bh(&fq->lock);
=20
--=20
2.17.1
