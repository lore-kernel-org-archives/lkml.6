Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136EAECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39EA208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kVVL2KMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39EA208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeIOGwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:23 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729215AbeIOGwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk2Suul3jrS8Wpb5zsWnhrFEoa9+K/XfBkJUwUwcr1k=;
 b=kVVL2KMlX5H0R5V6/PX+Vd6Yjye6Q/H87BEu1VKR/RGHWGXjcl8+08Pihz2k8uaidoWWCOyMPBV2/A6e6YcdEt9ICYEllBIY2P+UiqSy4QmZBlNxgJzMoxltlhTcXDpD3sK+kneqLnK/RQ1zmcrubLD3KaDTZr7Gz9ez1AE+M/I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 01/20] binfmt_elf: Respect error return from
 `regset->active'
Thread-Topic: [PATCH AUTOSEL 4.4 01/20] binfmt_elf: Respect error return from
 `regset->active'
Thread-Index: AQHUTJRU3QqdKRIMjUSo+Eelq+qpFg==
Date:   Sat, 15 Sep 2018 01:35:06 +0000
Message-ID: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:2ueEYRL2o0PCf5nu8wPV56C5P32KtSZf4jcLAgut1izIJcAnF/vNt4zILficwQphuhkb6egyaCMaFVaytgunSfbbHZrabQ78Ebg8ryoOjTUP+GmKFmU8zhqC5ezzvO77vP5j0BZ8hLZNUjUMvHc2QtT+HhLRG3h38F1suUStamcdoK0EGa87OUaes73kCq4AILDEFBQ25ZCvcChPYwGAYa/Uhqswd/k1eNYsXY3koEy/qLmwigPsZypOHCdyB2hnp6TSqkq5Q224dRZmo+1XAZAhOy/qIAAzJcSpsjm0xwIHMs3y9rgnWAWG7yjPkntlwA5VpzygFRX0/o9tnw+UwyvZtnl3bvMqFQYX+1lQF11dLSkmaLonXmKJ2PURN+fzSlsPo5KeX/DKvqiODb42nF5wuNgJHmUm7yk1Yt1DlJITBJ/qMa6i/kDRtE5QmSH+dF3ybKfbzrekOq9Vh3K1bw==;5:RUq9poMsG4K9+wd8s6X+9lqCNpL6ZcG1kyIOlUKmHqFoBVo/KbSbjbpXEfYTAqFL4muQYZeng5xWvxxYQevI2nouFoRW/lJJnxQYx9QQkoL5rCU6fay6vlurOypEqRYMyXeOOFhk6+2yvGBPQ6LwTaogj2FOB0pZgKkyiDP81bU=;7:2K8VDVPW3zwyP2ts43Lf82jMGEb9YW9aDTh5NzwQ5A8V3Ldtg5iSSt24nz2e0zycNcbEyLHTgApHHyD5q0I3ZRnVRfTkDldL5bgi2UNmafxMgSslJKvpRaouXl95JEt2ctmvujalWMVx+JEB7EVKooJzVfHMuzm3jfcUCI0oY6j4KQmpn5oI2S0niSsJWoYaKM6wMKIlaiFk1Og/CilYwjbTBsi88tkqAGjB0RNqQWxTBaNwe7RJmRSuX6JdXn/i
x-ms-office365-filtering-correlation-id: 2e18c4c5-d33a-47c1-59f4-08d61aab7dda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181B64454E4B4AC73908A22FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(14454004)(81166006)(2501003)(81156014)(305945005)(5250100002)(6506007)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(966005)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001)(6306002)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oC831j/NFOhvfm4WIIWV3P+RrUk3z3f9pF3vikMODnDFDitlQgAQKUhRZl+f7PL1JgNitiNdFe64vB5mcxYUDAI7bYOtd3Ln6T5Kim2cnOO5s67xEGnQrHDTTXeG+O5n4gpsbCwPcGypjr9k7N1xODlEg0kZTGL+D0W96batfDLnlAiAcJ2/qNONa4UTo5HFFSqgTAIj8RoT3mpWAfdN7lBPrDcHjXQ3V4591wUydUPLRZe9EOi+owX0m6d3dnJna9lykAi+9oCJHNeekDFLWGSg+jPFypWSjpqH7tNs4YXnNzo4zuTlzpdyi+2QhefjXaIQsl/vOq4sC90G8NmCYo+2LfLR44vsSDqACW21NLU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e18c4c5-d33a-47c1-59f4-08d61aab7dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:06.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@mips.com>

[ Upstream commit 2f819db565e82e5f73cd42b39925098986693378 ]

The regset API documented in <linux/regset.h> defines -ENODEV as the
result of the `->active' handler to be used where the feature requested
is not available on the hardware found.  However code handling core file
note generation in `fill_thread_core_info' interpretes any non-zero
result from the `->active' handler as the regset requested being active.
Consequently processing continues (and hopefully gracefully fails later
on) rather than being abandoned right away for the regset requested.

Fix the problem then by making the code proceed only if a positive
result is returned from the `->active' handler.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 4206d3aa1978 ("elf core dump: notes user_regset")
Patchwork: https://patchwork.linux-mips.org/patch/19332/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f44e93d2650d..62bc72001fce 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1707,7 +1707,7 @@ static int fill_thread_core_info(struct elf_thread_co=
re_info *t,
 		const struct user_regset *regset =3D &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size =3D regset->n * regset->size;
 			void *data =3D kmalloc(size, GFP_KERNEL);
--=20
2.17.1
