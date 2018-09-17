Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D661214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mYzidFpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D661214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbeIQIdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:09 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730904AbeIQIdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXQkUHB0Mo46vdBBPpJB+F9PBtAubCevTnRm1MizPg0=;
 b=mYzidFpFW3ZgHKRPC+95RGLGowXoL5+h0Qky2n8GywZAJ9LyW655lrlBN1pUxTvklq8jr9ApVK1dJfAFwMQ21XuxVYaecsOhG4gyzDUe06uJFsj3f5UnDR9B1FcpfEZjBH7D8toGlOxlExrE+bvStlskNDZNWiNq5p79s7vxCwQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 42/43] nfsd: fix corrupted reply to badly ordered
 compound
Thread-Topic: [PATCH AUTOSEL 4.4 42/43] nfsd: fix corrupted reply to badly
 ordered compound
Thread-Index: AQHUTjNBGnlG1HoSqEy0QI94vgsYXA==
Date:   Mon, 17 Sep 2018 03:05:14 +0000
Message-ID: <20180917030445.484-42-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:Sc3/VK44zk6JxKHA/PXeYyHd7g1zlA9NEfdL1RjW0AHgpgByXIwOd59m6D6rNuDCG10VCiWUIqexVtrlBhqgjoNH7YtPBmZc3p1o7Ie4iyo6IFXA1bOFOmGAA9nxr2HAWVBF7OD8wc/Z7Wd2mdnvPCG25RNuWDIkukj3SZ9goLqF7NbswTxtdciaEhGoVzPub4ZkaOY/7G3VoRVIIQTjlkq7n06RqjZEw5slmzT9bdb8+c3EM5MaUI4YZAJIY506dTdE/m6YUXeOB1ArhvRO7ViYn1gwb7fSioNITExwa2QXAkOEIPFiUOHS616hd0l+IoVZUOSl0rwpj8vbRGYAFaJk/VHYnLs2hk5nwezYCvB0Gfp8xCCtDY4xy/yNgD5C9NRCJwglqON22Y3AJhVXwjc8A6memA6euS8guEaMbwMjsbh8eBkysaFUc3VZUU0QKHObzuenLNmvMOV+JyV0Tw==;5:7ZI2xtULcwvwOtnnbzCBEeV7ZoSC1tmg7KgRX18MaEhTbt9F2r9gLRWAUDWWpekFc78TqQ9My9Ewtqp6U0WCNNnDf3EbmV5nnaoB27WolwGjIZrn7XUDRjt6BYjUItJ5hieF1tRjSf5UyCEpbh6RoCAIqEcyJqI5X8hTFrqhQXI=;7:Gizx3b1pLW9JBdUNnfqCUYdetcyzfAPX+xQf4p5cKj9qSYHQ5AeraacNDsbjVhgnduzipCxMAsPvCh7qyIbJDN9lJy88S0JZXwGyw85UMnXK43MqfPiBmZ0WZmku96ECz8d4gaH41Y9S9BhpKgYdkDfEuqVok3Rq2VMXtCag1ADeYQwRk3yxA/Rc/IZFSXqtXLHd3Fs0FrAZuxwHCbur2Bionq07zCtXMN2285o/n8dnGzXMqAaLWPMimQm5bB/Q
x-ms-office365-filtering-correlation-id: 36aa7c2f-37ea-4420-f4ce-08d61c4abeaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839590A5693D195B5D5BCCDFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NoW301HjdzeeuUUB3Q1Jc24hp33vBK86jzF7KRhcu3dYKB0jm16SCEy8oFjWxWQxQ6CBpjLGdt2iu0jlL8wlNQPW8j4BkWY7A362XdDzBX3uTNcr8N6z1Q1TTwiOclcWUTR7X/dYR0uA+ToP0jv9KFcI64K4sCuMYI3youqxN5IsoMBVCQKSqUUYRrdP708KaRP592u31aaJeYJ59u3G+RSsOU8zzV56XW43cmIoaG72WJnZIgEA8A9CV/IaKN4UJM2FQgV6U2gtbYU+iEBOhBoecW3RbKkO76D35kpih/SKa6C/a8ySR0qnmoHTbTIEDYbOoxtsEfrZuNrAcsz7qA6jMWadcJeL/mMFMNyFmlQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa7c2f-37ea-4420-f4ce-08d61c4abeaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:15.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index bfbee8ddf978..c67064d94096 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1632,6 +1632,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp,
 	if (status) {
 		op =3D &args->ops[0];
 		op->status =3D status;
+		resp->opcnt =3D 1;
 		goto encode_op;
 	}
=20
--=20
2.17.1
