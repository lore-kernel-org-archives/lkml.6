Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382552147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I8nKCVUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382552147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeIQI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:37 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbeIQI2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKWNkIThq2HAbKEQD88j9HTL6VT6zjPyFUgdZT/dsyo=;
 b=I8nKCVUw14/Gj181XNA+nvjb6OI725xr6NsoPpAmzWTsD7t3OMtXl570w3uMdaczNexWw+kH6ETFzupNaIRd7iXc0mlc6dG38kcsE+yWoVjZjHxXAtRrGILB5qLqHGLMRR1fVppXwH4vEn5GxfMO+7STUr+7uplmZAvQzFUQOlY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 121/136] nfsd: fix corrupted reply to badly
 ordered compound
Thread-Topic: [PATCH AUTOSEL 4.18 121/136] nfsd: fix corrupted reply to badly
 ordered compound
Thread-Index: AQHUTjK6kCmR/wD1j0S7gmnKBaQCHw==
Date:   Mon, 17 Sep 2018 03:01:27 +0000
Message-ID: <20180917030006.245495-121-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:uDyT+b/Jkao5dvxZw6hB8h1XYOwlMa7u8REOvvB+uY9UZgZG0Sf4dTKcRuHG6Kjwg31vmH+zTa4F/nIbe32qNXT3KtDbbscgdxTgj0d76GuAb38gW4pBkHXKlsi5BzM38FenwENyvsrOrQZqZ7UtqCvSLD/MbL57louvzcLj//BtmYjRO9ehYhT1/v5LOB9jovRlMAFQzTYl23RnouZS+Y3W2N753RYA18/96m9/StskBXemOOVugJwnExmSuhQAdbIc8idf10f/c20uM7YMdkq/8hzOhz91/hvBOKcwxiAYmzQBOumIGr60tDYiNTANPh7Ws9JaZ1OgL8Gj7OB2dlKSevx7eXq3rRRrtpfd1Q/Pme1rpaunWB74tb4eU9uP3bgwx7XFx1hwAI+MhUu7ImEMEZC5ARqCG95Vt2XbWQSK0WPIKQl7KPvUMGm/DVIEsaF+O8WhPdef42lGUfoFug==;5:9rOzULh9/3kBtnPrk+pOs11OB66QJRvS7P6OZmbkBUZqTsWCdv/gWnFDpCwzspOiqkV2UpMf3uzLSzurUz2Bkzuli8cYzGZUHD+pRqlBPb/2wNlP5g5Us52HiTcC8p98ygex9I+O1RBZpt4ttzwO2mAOveCS42XTWm8Rgn0LA+Q=;7:TNVm4Uk4g2mJGUbSBNvAgJK6+i9cAsXLq5iVy5tgjbt67dOvrDnQcMz7c5Kj0qHtQTtRntJuc4LNr0MsiQxJpgK0DTKEHGJJrcrUZgh+8SFSlTTd3IBHUWuqtDemNFNtCI+vkjhycqtW0kyElPE7ozQ35GwPMVLkYBIQs70UOz3G+oSoOlw1TiZo2DU2vbTsu+Xy8vheXjhksDQ1535r5UrVv5PLXmFmqO6UJ4p4Y4zyfF2M9id/s0tr6RchA5Dk
x-ms-office365-filtering-correlation-id: c5ec29b9-8ef9-49e7-8de1-08d61c4a1ef1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB011842D1D91AA8CF06E1C981FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1EaLup0M3wV2N/4sj5w0Nn+0hCh2Jdary6RG8ELoYyl35l5u+mlI8w1dPGQ7yq4BjuVtDfjhiOPcdC/T/wDIt98LyWqJCpTFOKinH7Iiu0A7uBsXZnZCdR9eRbXd7T7y3/4jVNpaCt6d180/xoY5V1CjGe+lbwAAyCiPTfitO+a5lXWmF6tpfr/wpMIsgbm35iYZLjO6moVPuYqhx8kaiPALWyg1WJCS7qV+ooWwCMUXDwE9/epaygZw95KjovODoGlan4mUSfQAj6pRjHg/PsFbobzkHGlmXb/4txw7N6MKXW7O7510H4ByNCQehTojjligPAXHQP8VlIQiEJpqeObJv0hC8KOMhiAaoD0e8n4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec29b9-8ef9-49e7-8de1-08d61c4a1ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:27.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index 5d99e8810b85..0dded931f119 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1726,6 +1726,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	if (status) {
 		op =3D &args->ops[0];
 		op->status =3D status;
+		resp->opcnt =3D 1;
 		goto encode_op;
 	}
=20
--=20
2.17.1
