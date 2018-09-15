Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D17ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64EA208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LLPsm1h0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64EA208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeIOGyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:54:39 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729892AbeIOGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ubkg34G/H9zadlNBBhn+9jQxDYnnW1QDUX3YT5kWQQ=;
 b=LLPsm1h0fZNxH73BH9VwfuVbcyCIpmAhvy0Wf4oyOdK8FpmwdqHrtgPy5qI/0wN5pPSkFZR9Zxfae9dQpg26rMUbnnYNi0FascnxVbRgXx2Tmm46Xi33LWrwfRemuqDSglrkZimOgJTrcb/OoOJx9Z8RBmQtl2aNfOnmWfZmG54=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:25 +0000
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
Subject: [PATCH AUTOSEL 3.18 01/11] binfmt_elf: Respect error return from
 `regset->active'
Thread-Topic: [PATCH AUTOSEL 3.18 01/11] binfmt_elf: Respect error return from
 `regset->active'
Thread-Index: AQHUTJRgSsUrs9b7EEWbo8y+1mpXhA==
Date:   Sat, 15 Sep 2018 01:35:25 +0000
Message-ID: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:El+gdnsjyNafulY/ROAj6hr0C4qi7g8xoISdDNoCJ4a5fo8+EoqyAxgk4Rc/+wNOJyNRtAZ4PqOeCRUzG7I/bmWRlClZLofde2qfv6+9DS70JlAMu5jsfLltmkgUnHD+34oRq6g2N8K1PSy3YK3mqgBwSFv6VggtMsV3DV+hXoR2GkK5C8jh5PperLHRlfgeTPlx9fncm1EW8AnSIpzF64Y6rMvBQzTktKb1uG27sN016gYLn2nYuRthXIkzMVVojIP606CpRt7UTSXwpqE+tiyh659wGBPCOAU6VGDNBOZ97UKwJXmWBm2mmtjgb27fm+uXYXNJZANT6fFfo5QY2vSM1tMx30c2qOPWJD3a7PmNET/6VnZkeaurFBKlWWwOY3Wa8iZLVKHFSSCJuRUni4UWnA0o79504l5eRY+njoNzcnJ4l/ju5GMjUAzCg4a8TyFMeAN7h9ELJqIuBh/oWQ==;5:qNOaqfTwUmTH9s6p3O3aAh+bU7ETLBoINZ5a7m9YnVtnr1SgTsmJVgabqrwvL+o7djWbKQVv623KJGSw2hkn6U8i4/qVdVK/mgktgeTaVajzWwXglCPFZHaQ+Ib9PNhn/5l04EfSKM3o3Zyvc78eTKEOmDxu0HdIDzkYYR2CSH0=;7:OjcHnc8QGCVphrmOTCZaF3ot3FKWZIl3qXsO8cCj+rJqFrVQfEnP33I1lMertRmEjmM47RYMZuREMkS03+mfwx/gvAlaPoIVC5YpkiztGiDnZRpKykGw6fh5KKNhKddX9+eJJgZ17aEhNP0Wd+kT22hKZhrj2xto3Mq5lQOXnlV9xcbY4NjIiuS4XGCO9RV9/kAaPGR48JMVkJKIjJ1pVWT60OThjnjg4NQeP1Zt2CKkbVnZ14ZppncCzCAupt+r
x-ms-office365-filtering-correlation-id: ee6c4d20-b0f5-4855-4131-08d61aab829a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB028080D4FEC7EE5D015C1B2DFB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(966005)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6512007)(5250100002)(2501003)(6306002)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(2616005)(476003)(2900100001)(486006)(66066001)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8zEiLwFFjAsEdAHUxVVgFgY1SgmoctZB6oLpECe10q/uGodFo/ZTx/YE0CCa+HhqCXFrWsswVdv0jcThLLks+bZTbv+gPnt9kbdDpmBpuQijLe0fyFMMeqOQWxp3XPdWvGPZ48Jt2T6rH8ti7wJgd9T5P4bxEZPpVTUFJvzhm6hBMwwpoZ63mm6DOB68p8vlTaSQ4yksfTGyEed2lUPorvmsfyxbVeuJXwHOAj0fYxVo7Qj59MWtuv1IL93LZ2ifiWQMqkzZLRJPAQe58uuCvTVM4ERNLBp7QTTm8AbQ39bzy9svYt1B4TEB+Jv3zC8J3JcOHIlWZKF7YXuwJlI706uB+eK2OPEf7pG/0fxtswg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6c4d20-b0f5-4855-4131-08d61aab829a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:25.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index e39fe28f1ea0..c3b57886b5bc 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1552,7 +1552,7 @@ static int fill_thread_core_info(struct elf_thread_co=
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
