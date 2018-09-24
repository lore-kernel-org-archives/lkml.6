Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F74B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UQ0BXn0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F74B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeIXUyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:08 -0400
Received: from mail-eopbgr720109.outbound.protection.outlook.com ([40.107.72.109]:44208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389001AbeIXUyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b/z8cH+Eq9kHq9CWY/yZADlLssfEARoQy/KblF4b2Q=;
 b=UQ0BXn0KG6qkLdVFIxxfqRq/GeGaHX+dF+Ta4W4JHH2MjXNHYPTrWjm+KWvO54S3xSVhkW0qPFDdGbJ+9k3vanbJ36DiJB2Z4lT7NcuPfQei0YB14xmYT98pCimciUqcn+nofK93h4q/vjBN4/P6uEyLpoR7FB+HVz8y6Ul+ecA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 05/18] mac80211: mesh: fix HWMP sequence numbering
 to follow standard
Thread-Topic: [PATCH AUTOSEL 4.4 05/18] mac80211: mesh: fix HWMP sequence
 numbering to follow standard
Thread-Index: AQHUVBXXaA1CnNnenEelcBDaTiKMTQ==
Date:   Mon, 24 Sep 2018 14:49:47 +0000
Message-ID: <20180924144942.164688-5-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:ewAYihnaVMF8yqK6++7Dd+XZdEbK87RVgVMzRQ5ygEGVuJUB9OkE7P/BzFowtF8/YJniWVni1zj5VRXRP+oMnt9dLs8O1aLDDld/lb5XyS7be+Sw2FHpJh3gMie3ldm1EiZsFlKT1sKVGGJue2XClQZ/r6A+w23eH1EkCCRaPBeCgmBxmJyxb/Ru1fU6HCKy8jWYUj1Aty9wCRxFqI2p8tM1AnBXgjam9CGlGdnHnICUWiEalbfv30KHglQZS1zVnNPFJnaLI8CCph4La2hppxAG5D7E9H6pNeCg36XAAqgKGT7DMnoeu3hZQ7pRM3gDGL3zfbPdSt8LA3naoIz0gN/d6fbo5x9nOVtT0rq5p3SODe6ROmR1M7zgfmfl2LYqrrh+2/upWM3rIWsJFRTer1wXr9cX5ZUwly35Auo1prbTFUtobF6pYVFOrjXPaTBvDItAIczNwu6D4VjNKVhsHQ==;5:VratZyIE6vuhr9uI/9GSXnxpSlIipXp3/tpDTGQeD9OllnMX2+3juT6v4zHGpJ/RObaPiKJGkKtDic+sLR//XKQF6h/+7mBicQzYz76sRz9AYJ0WdHGmpSQs3ffCGZcpG2dZ8fmcGsZ0aLdkQOki9+yJvRulmLOesS7E5fPdcEs=;7:7mn0xs+7/gzyrHvkHJJHDhDTFc822dXpRLjvL8jvaCvK1XDv8NuKMY7SzEdy0/TsG9Mj33/xaI0ZroyvkX0Hwv3wQoXQjpsPFaUA9hYC0BkJbK5GGNdNDN0pEIo0WFBv6R86wAGjuGB9I4zzfluYX5pR0hHkrJRv8Puzx3x9j+GspocYamLlBjKrr19jx5RqVl86pKN8tR+8YN16+sY3wD/C/++vhEGAmPT8yshg2E8Y38C/oFjpMWK3OJT5e/bo
x-ms-office365-filtering-correlation-id: 3a41efa3-a8cc-4380-355c-08d6222d28c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821DBFDA978B22929D60C23FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(39060400002)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: U0N7CE6MaNA9Gj3c9haA9/H7I2N+qWqtFK2LOel5NmKpC39a9i65ZxUXTSOAmywQ9u5R+EEVIzxA+fisl5Mc0LUJmWJFbkRUec5NGZ4OwsuwUPc/5pr5paXg6Kvt9EF+JCkjN+hcCoEkqwJQesPQjCp0Fo2bZD/4hA+6ABBdx4/kCpF184BKcy6T1JW+sVHxcNDtGv3x3rQaEt5MBvLj/G0h/FxWKZGF6enMakkWUgARoY4kD4rlOD8LVwiAycpzRPgUb2uH4F0fhj55IdDK+hLZWULL9YdwPCoZiUPw7y8JC7RWfIcEuDnFPPT1Z6xX6+dBTe8y0HAybpBNpDZZq03h9QF3wXZUYhENVQg6guk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a41efa3-a8cc-4380-355c-08d6222d28c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:47.9031
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
index e68a409fc351..33d5271a9e32 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -552,6 +552,10 @@ static void hwmp_preq_frame_process(struct ieee80211_s=
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
