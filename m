Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A316CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544A3208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HXu4ql4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544A3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbeIQIo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:44:27 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730502AbeIQIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isjVzmhYcl9Q0JkMb93eS6B+bxChjtJd6xrs8WvvjwY=;
 b=HXu4ql4uQ1UoB/53L/re4/CSaBDN1wOm0+/XiyURpezW7rRKM5cFgWuNR4h0vesTcSAuKBryvLi6NfqGn7Xz/Z8k98ySop08Q6sg2YDVof+5GaLQmMc8K4xEdjxu4evDPlQA9ubEuvU/Myqt3Y37FGaL3K5DP/+cWPxesojW5cE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 81/87] nfsd: fix corrupted reply to badly ordered
 compound
Thread-Topic: [PATCH AUTOSEL 4.14 81/87] nfsd: fix corrupted reply to badly
 ordered compound
Thread-Index: AQHUTjL6d+EDv6aDWU2b7kuktPixAg==
Date:   Mon, 17 Sep 2018 03:03:16 +0000
Message-ID: <20180917030220.245686-81-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:tX3ITfpoCWyQsJO88Y0O9ggm0E5Yhs1CTwtuqcQpZXzqDtSwcYl4FDyAcmJIcXA5Vz4oeNloUhO5xGNWX5U29jFG4YMEjB60suBzTvylBbPMKOTM527q86njH1iKI8RSHpgDV/vE7VpC9D9/8H/gXimJRuVGXJCXJ0EgeNQr3Ab+uy9N0rT1Fh6pcOBGJZrEWiJ14RcpfYu+0JngayXV34ZAt3o6gc++kXtYL2AfaNQsVuihCquXjUAm3YciL0+GV6jPRIZ5NTfBaMmfLd6EkHqJzn7VWEjRmAx8ECFnK3efbBxkfOdbrmdddhsqOu7ycJUfuPoqwnterVncuDz4SGuO89r4bUmPO0bOytlWY81+USPtatHQu+3NqRz8wPIYQ3MeWNGdicblYy1Sc10vOn+eU50Ry3uKXUFOQw+F4+kphn7u0H8fivUi8nn4kLNvvpGkwWpbSImzch+FOPadXQ==;5:s70DyUPlLwdntX8L0jMzMuF5RrESA8Xmxm/Mmh5q2/9vsXCH1dBq+ThMxGSmy5OUby0GwEmWCQvIys0GNN0AXE0j5RKV5OlGqaiGC67kgX1Gk5wyamMuJZHLE6pEP2PrRshKlGGJ2MP+Rvx0emD4SdqOMSQ6Lq+ya0ezWwLDRb8=;7:2wxIzmh+jja6AG3s9EQqFxsNvAwpQzQW+ube5baD/a/wH2x2oRpBmvRcDhHeTDB1Auvxt4aq9QDMwDw85wmKG+gJTldIXdUPVbMMHT3/6UJBgObD5/lA/KNMqvc5jdTE9UrEzy73yQ0DWYo507u4Co66YC3LRwz60Sn5kNSozje6zKfYGZ5f2eUbgebueXZdGZBAczBy8XKCuGDd1+cqlYv00fZz27VaOOpHYZbqOA2cJIs9cdLeIzwTOx1q2sfI
x-ms-office365-filtering-correlation-id: f7cca4c2-b73d-4986-9ffd-08d61c4a5cc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133061DE48CBDFEC0DFBB46FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rPPt7yQbScJ5VQbPMPeB0VNOLc9PwJ2rjok/45O15j5gbuQ1Nqwql86isWyghYfPyDJvm19jfnNJ+rdzLMaAEA3vRpzdj/NbYjfGRFQ3GAweoUmw2BdI21IvcFFa0Npi8g3tEQKtnGYscrjIsle5Aaij49jj9WZiHjH1g0f/kPBqCTF/jHGfQbkRGhvk8ueLYt1YI9WhBYXDJ6c4NszXnJqm7p2l6cos4JaiIvlFnq45aqakH7nE7LPXOvhsBkp55TrvTbU4cGDhPJLbYMDOveZBxE2U5RthS666vU7I02rn1pzd1BDDUhmPZnh25UxGn8JOcPKaZMz6mi1/FpfZfgsrBnDKoSAFEChoBpYr4II=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cca4c2-b73d-4986-9ffd-08d61c4a5cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:16.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 5b7b15aee641904ae269be9846610a3950cbd64c ]

We're encoding a single op in the reply but leaving the number of ops
zero, so the reply makes no sense.

Somewhat academic as this isn't a case any real client will hit, though
in theory perhaps that could change in a future protocol extension.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5b6ff168d11a..6d16399a350e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1725,6 +1725,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	if (status) {
 		op =3D &args->ops[0];
 		op->status =3D status;
+		resp->opcnt =3D 1;
 		goto encode_op;
 	}
=20
--=20
2.17.1
