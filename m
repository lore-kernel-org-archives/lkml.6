Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B67C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111C820877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="abbmuZ70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111C820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeIXVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:10:18 -0400
Received: from mail-eopbgr690114.outbound.protection.outlook.com ([40.107.69.114]:33005
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733047AbeIXUvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUbxC6GvPd1lNeKrYXEWCs8VEiYOgWcCl5b5PBguONg=;
 b=abbmuZ70yQpp4NNfWunDPOWorNrCApL9XcuvR2yvL76+zeOkT1ooHqsGoqxW1P+79A5bjSAdFj7Moi9ese06IWlENSvC6TT7HTBKusoqDqvhf4DhU2svN8jUNrkkLiwuuvo1DoQziWkfx1pZXZTGl3YgGa7A++Db66i2BjEVQkU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 57/76] mac80211: fix an off-by-one issue in
 A-MSDU max_subframe computation
Thread-Topic: [PATCH AUTOSEL 4.18 57/76] mac80211: fix an off-by-one issue in
 A-MSDU max_subframe computation
Thread-Index: AQHUVBWsaGEcPk2+oUKI4o0vodUqSg==
Date:   Mon, 24 Sep 2018 14:48:36 +0000
Message-ID: <20180924144751.164410-56-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:AfKce4EZQ5wEn1jKwsajvh3z5HHr519NDYFe1hHIngqw8dXgtd/Tgsnq/ni9/pjnVBSxSm1PgbL5l4rNlwh+Sj2emoAqIj2ZU3YEAUX24HCbffsaDOSIPkXU0BfF8P+fGSaFJOmnUhpMTGPPD9bgFeFDueUqGnEvdXqEqHmnINxU3a+4iQ+9Te+Jn/Oe6A3ctSNY+eqKZtLB5OL8ExnDuLHwMxXGx2muppW3GroWijapUo951IxIa+ZjX9WNDGpgspsf1PKfTcSowe7N1UzXHsIXKNsAG+j7zJtcgi1pehNsek5YliXsjwN+hdFy3FJSODqowVcn6fX4iaYioz3LkzeeK9WUgGd92n+N/dT8EQdTWMd2esKi2T9IJRvWBLmRjiWbUT85Wp+SVvJxpMRz7zGEYRDdFDaaCZ31x+6wLSKtMpxmgEvaIiL8PMFWAQUEOiPj9Irqs0rFXfzkmEj09g==;5:Ofhz5/yhwvKk2nQvnK1KgzRL4reMmOWWfyPnCQJxUwxYVJ5Jx7QM+X25RTPJ7d47bNQuvAfUaew60oqbj9tq3SRHTxH1GzBGBb8ddMsolCAWsKFxhRx0xi0D9uhlUZHUJY3fqxCSJuJFI/zNL9Wm5uCOnLzmXvOnvCxKjsFGrSU=;7:HmQ1ig1dGlvNuRzYQJcvRChdvPsvHXB9YyldkHECdx0gy26ON0Zu+240C5dwNK/zPfz2/1wzvrx/4XI7rrT0SFkNRx2CaRREmv4L5gctW3y0Bau7DxR0MgxsITcbpW3sf+bEhxa14RhkwUGS6QU9g9ACi+eBwVZ6pCHlWcS2LUQweUGcT2LeSRo25UmH6sKoIuZ9iTM0yYyOIFnQo8QcJjWCFLlR0VFBGQKtB1u7InYxAfRwFiHKZBA6IA2Qln3N
x-ms-office365-filtering-correlation-id: c5c3cbeb-123d-4c3d-fc61-08d6222cde0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744125E1A4D19478EB50377FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QbJNoly5brhpLjEU1UQxojLrQQLWhxkFgwrNjofwpxBIVbZyes/WXs5H2NMcR1RlMzcgEbv79ADhLB/LVMeZdNHe/Vk0Iim51vYN/lK5r2iKijDbLMhA/w3CmP/cmoX937kez2ghkYGiYDn32Ac5ZgkxkOraqChJkD8dnK+pciQKUc+ShxnuyDqIC3SJW2VSf99uPLTGecAVUk5OTjV49w67ekbC51kVLCwQZ0Oaxs4z3AadJTHZwqMbNcuY9cfTnJBHDfJPeyNizr0sbkDl4aAMiPoGCoqYWTjBKOmqqpqW3cbAC2o4wYmiJAl+7LK3P3aBfY4hjHKpp+GamUxeg7lgKNCxvl/6atS44aAdJYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c3cbeb-123d-4c3d-fc61-08d6222cde0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:36.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 66eb02d839e8495ae6b612e2d09ff599374b80e2 ]

Initialize 'n' to 2 in order to take into account also the first
packet in the estimation of max_subframe limit for a given A-MSDU
since frag_tail pointer is NULL when ieee80211_amsdu_aggregate
routine analyzes the second frame.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6ca0865de945..9b3b069e418a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3174,7 +3174,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
 	void *data;
 	bool ret =3D false;
 	unsigned int orig_len;
-	int n =3D 1, nfrags, pad =3D 0;
+	int n =3D 2, nfrags, pad =3D 0;
 	u16 hdrlen;
=20
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))
--=20
2.17.1
