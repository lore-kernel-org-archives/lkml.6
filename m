Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9444ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A17B2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cJRlnPvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbeIXVLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:11:33 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732197AbeIXUvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85K9w6hQEX6SNFnjtlNh9vx7eboPfZMX0BGj8dk5BbU=;
 b=cJRlnPvTfassQEYFcsKPzS6tWAYPwLpeJ0gREUAFmNY22tfjKsfc8VRQ+allbC4DqLWMPwnDVCdxT123RthsXcfH5WOD0ivE8DGNzy80ACwfsJ19giJ9Rn/Cd0gXczEzOe4usdPAR40YdpAgvipnz1JC2SVEK1SXUKiUWipqpF8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 38/76] mac80211: always account for A-MSDU header
 changes
Thread-Topic: [PATCH AUTOSEL 4.18 38/76] mac80211: always account for A-MSDU
 header changes
Thread-Index: AQHUVBWlgu/PT99uCUyNJNdutSF1CA==
Date:   Mon, 24 Sep 2018 14:48:24 +0000
Message-ID: <20180924144751.164410-37-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:qolWMARqW5zjoUZL2qdCKXIZE4QGf6HQSvtTJbkqAmVzWzphn3pHRxWW0cT4NMfIXc8PbkuOZ+3SE+ictog3pvzNmc36ng+5/0cUXEtInKnABR0GqKWC8saCyLvqgqpjui+e4G6RfGI5MMafQk/35pI4d5bvCnVKyNy5Qz03ZkZoNHiIXmoVM+66rUy7jRPMUI75gTHZzYOAL8DIRSJ/IKh2neYchWE++4jn6n4e0eTWNqZ/aKKTRMT9zcKXYB9Ze3l/SdjDwXsa9RCMIlK6w34rpsTui2w7tzIZpMQXM/PdzM47XQm7jM+gLaB7NMCu/LRbvAqqgHOd5iblm7oAzklv14Q6oNpm1Lgja/DxuxXu4le5a1jEr7AXRMXxEt6Hr/BOrNOwz6sUMziAvIS1ibKa7OQ3Ykhb/CqPHvn3s5i/PtWpQAvfiR1Hw4nIs/o1kLfh4LBtM3M+lrTPtY7imQ==;5:psWIxGT+pT/eG/hzA/43ufwIljJHPJy+IEatL6RBPWnKB/svoD0vLDPHw9UavzyLSplg7b6z0LJX0bwvQSU057mci/CuPyvapxnTbZvhZ8Hi7DUeyAkSn24YvI3sVnzSd+wl8C1QKuO11TDeXhfMQCc37qrf/FA4zCL3y00m71k=;7:5cFGuuCnFqWI1mTGl9tEU8P2y+bbrmzNKVPfsYZojNNVGF5soaOAeKRkvSdjo+6lnepbkIskQ3QQkqCPgYRxs7LVfswUw/r4UgNLhOcRJWA96Ky0tH8Y2TtUOJChn4H4wxYXOIf1wIGS1BHrS8b0bwTySq26bXoW4aGq6bS5SULVWV/0Va+7pIaOCnp43A1E+Do16N1Byz+erSxPahGOYbcTrfz0x4qoHIsCjJEvPE9oscO74Jx1zGDX6OQYQ99C
x-ms-office365-filtering-correlation-id: e0df3a0e-2edd-4276-ad70-08d6222cd906
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855457383E865A150F34BB1FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sH4bC67AU2WUBwmiq1vZIlt778IMUZmjG3IH+0m/x7wnvquP1ohI9mfHM+pA5Lbodcme2eBkyy3OegEJVcF7OWWkkbQ04VAP/ltN9UJaLLpR+B8IBhyYheknAI3EtYOxClGyjolT1YXwXjeQPqSsSIqPJz4c3Et/WSBv1ACE1x+c1L9Up3SukB5CkcPWwrO1zp7K6IKBukV/ueKfwsIPerUTC5eZr5nq4dpBy6J9zgdHRkcX4AVEMGCiWcH0n7TtGa7n96us/iQuJU4/bd/ACQcD6SjjifcGSHZ8XX3SD5HE9M4v8cq5vt+gcEHl74wpYtqNMlP17jS41/13OG6aSFb1YMOBjFzhYRG/+S0KOWU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0df3a0e-2edd-4276-ad70-08d6222cd906
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:24.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 1aac5e3c7eee..6ca0865de945 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3239,7 +3239,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
=20
 	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) +
 						     2 + pad))
-		goto out;
+		goto out_recalc;
=20
 	ret =3D true;
 	data =3D skb_push(skb, ETH_ALEN + 2);
@@ -3256,11 +3256,13 @@ static bool ieee80211_amsdu_aggregate(struct ieee80=
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
