Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D949ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3179214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aLEsqHFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3179214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeIQIeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:07 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:35136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730845AbeIQIeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/MhC0gGHuoxohUduNEeC2Ip9enlTlEgMQZRiHcwU8A=;
 b=aLEsqHFPlFUKF4y6SnqmYcrvCVyuU3rdoZQ74NMPDv9jSeJjfl9RH/TfqtGY7rUiQjqI4f1Jrfy4Lta2N27gfC68Ogd3AnGm3NSZ7CdwFjGBjjpWLdQERFDTekg5lUSGRzcn6XYcA3bdG/Dlq6FGD66Dkk3UnbFyn3fFQqqR3Eg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:08:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:08:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 29/29] nfsd: fix corrupted reply to badly ordered
 compound
Thread-Topic: [PATCH AUTOSEL 3.18 29/29] nfsd: fix corrupted reply to badly
 ordered compound
Thread-Index: AQHUTjNZ7Vg+1KrcxU6uVkLQosihxw==
Date:   Mon, 17 Sep 2018 03:05:55 +0000
Message-ID: <20180917030533.592-29-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:qakbLKnJH+ZGiz+kJAcT0DkKFtxfblrifsNeRB0d6DTuiL5hRLqM1R9lPOM4uDFyxdUQC/kFFyx2TTLv1k4gtpuU6S8u4hjaoNlGH/HWD/sYUOLxFws34CZJxwwm9MYPQYLUEdVPhrUUn+xoPW/+jiEqsVZIPCj8C6GNVuV5g0NoiVHjfnn2s3bHX25E6/x2hQm2kaTGcUxc7lwDi0zrfAaeoWOzzLXvhGqAXWmtLjuPDgbebxurVsenYEqu6hlS473bE+oRYUMkUOulQlxI+2iltEmMbpcu6kZCKajWdTftzmfnVCS1auVQmWCyfi43pIa4Idm+rmwzpEYZVUO130F57Ud6HSDc2x5tf4rjBiQyDzb5QGcy38h8TiYUrd2fAqF87N4PJci7Ta3cj6o+9x2sB4yTZ88icJL/wb0u9o0LMxWFFcuKkkE3raTDuz0XE6cSYgs+AWcA32xMG7MVdA==;5:CrfcdtVxnS8gDB4olgVmwhbyTlvwHP1HoxTmB98rBMVg0kUNSNozaKgkQBirwLOARZo1/oV6/ZR2yiDeovYmzj7QiNHLusGk8NJFE5Q4uEEX3dPY4yO8j4Cr9Sp188pQWOio51SYfdaPWnb23i7PHfMJ3TIE8GZGiLMx9vt1vF8=;7:ck4jcWhCGMf4suN8Owhr8PBLtvOr5DpFxg+9b+OicXM1B+dlwjZoI8JDHgIZur1Hg8CyU+fC56nFO6sMFgU/T4g2cUI34HwvI5zoZNXFqsvTxunwc7MZb03WQ3Avce/IVs5J3VLwGPFh++fWQZnDuElcPBFsPY4b8GI270ab7H9ld0CkpzAZhZpi5+eJ/Z+6gLrPLiKQwWRb2g97HWvWqoydHsqZTJ7s7k8vfOZJ2JB+Ay0NMzRwePai6vYh/6+Y
x-ms-office365-filtering-correlation-id: 22dfb573-5cfb-402d-c6cc-08d61c4ad79b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821264343F5057230A7B172FB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(256004)(2616005)(66066001)(6666003)(2900100001)(4326008)(107886003)(86612001)(5660300001)(3846002)(575784001)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vI6rMF0tKfiua6toccPI9LRthkis+jrJnpug+EV+qMdx084OFwD7ltJuJOb8cCud6u6+92aszZzc6IV1zoKGl3KiSRlxLbI8M8HLMQc7+7WM8EKDlRWytktIrBUcTMOvRz3pSoEJ+vl+R5UkWXWtFiLQMHXoWsVDdSSFjLuaFN3VK/ShS8c5gb4U5D8gdbwNIKOb0MIT+eN8GoQ/mVXLKzrgRg8emI1poMX0ovGaYGF5kmHRz8dxZOCEy3F+Qd9xop0rYwhNXOpSh8P4IqS1Mj7yjU3S+uDhTN1Alyor5MaRw384QCtLiBZxFwQC+CwzAYNQDn5HunT7d/+U/Oyrl1s8P8ovVBcMLnMHYuL066I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dfb573-5cfb-402d-c6cc-08d61c4ad79b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:55.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index f6429b3d89e2..fb0bb5b2bcd8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1347,6 +1347,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp,
 	if (status) {
 		op =3D &args->ops[0];
 		op->status =3D status;
+		resp->opcnt =3D 1;
 		goto encode_op;
 	}
=20
--=20
2.17.1
