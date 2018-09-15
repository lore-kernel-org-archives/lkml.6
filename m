Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BC9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D08F21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nUO8UPgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D08F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIOGqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:46:49 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeIOGqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw3DcTXqhAyqMWPEyb/BP73Lp0K1xInekXWYMLoaoAc=;
 b=nUO8UPgf+foM5rOCG5KhtvlQ8/z1WIIZgAimCI759XIiEWUGiGo6PoQutqzOIr1B0wvY6WkeNxibWRuWsKWPeWo/GmeMsSdoFQk9VQXOkEi03fQp4xu21dvDqYnbrAdQKh4RtzFaoO/D30AWXB1cCk6T+kIhzK876+/GU8khGgI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:48 +0000
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
Subject: [PATCH AUTOSEL 4.18 01/92] binfmt_elf: Respect error return from
 `regset->active'
Thread-Topic: [PATCH AUTOSEL 4.18 01/92] binfmt_elf: Respect error return from
 `regset->active'
Thread-Index: AQHUTJOX3Gl1zAloekmFBEeAfLsirw==
Date:   Sat, 15 Sep 2018 01:29:48 +0000
Message-ID: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:9mxEAd+3t99jruaEcrN7cF+4/PdgMZP5Z4pyvEqMzq3I5ed4dtclznLpyN2FNIKHJYRFT7xJY8mpdzl50yWfYyL/sjveJwBZV9dnc45MOeDfHzAnh2pByHd5Mxhw5pJ/mGu0EHnpk8Bz+t7P64cWYT6ejug0p/zY9bU93XKtlCOe5vasUDlyhT+aq6sENJZqBkYdC09yiioW2APEdABIm5MvMi5FJdVc0Lswst8W69y57v5pCCtLl61YtkpmF1vI68Rf8dLp00CQoGE/npaETVqsasFvYVhAmIayRn7h4sK8Fne/lF2FHlxcwFObelbJOavgy3DBmAjCVdnO9Ys102ohz7Ew6zshW4PnEtJkZNZtISPI2z6//8LZW5YgFoNR8m4mAHmwUTAIhNEX1oCIw1g6OC3531nOc1D8F01O4rcDO0iT+84V3Fnf8+/Bol1+c1pS9SDhH4T6DW7E8fvKBQ==;5:0oBEyQ/WngFdHR670LI4IKSWYLS/UpuqkufH33aR2wCSqtPEEma7hKnGoa4q5V78K1uwd26KJNx6dPtMQM6xlZ0Td8YNNUcW6w1KVICF39iElQot/YcS0nMEr9RNR/iUJguzzpu7GVz+D8vaQruX06p0vj1WazWVuG2F1gE2XJ4=;7:a9r7JFb6RnkfHCq46KVwCOJl4Ih7QgpQesSSETIKfLPxG2LZNO/q7mFiXKznIpteDqehNnI6xiyLYbmBVSGV6rVHp/uCR+cZRblGunYQ70ey01jklfING5n3mGdi0t+R0pz22i7Nu/JU6GTWObVZsGx9p4MuA4DCRKnaj8E0lY+4xB9aUYGA+Xch9g4wRLtmx9Ir6iims66ex+2TAWAdTUTcw/BR0O3ppRtFNXwlNgiFRCO1fX92Qk+tHqAvOm5E
x-ms-office365-filtering-correlation-id: 6bfedb47-d03e-4837-2350-08d61aaab9c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840FF3C44475F7BD653B478FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(478600001)(3846002)(966005)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6306002)(6512007)(305945005)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: iLJyjjfV2xXxe29qjREhlWAYbELlylsNP87aW9NJxpKO8Iaq9LwhM353stWAhRRvNMTR9FG6ovZYyS1cuhWfZlDTeuah4YN8lena+cUiDd7+Q02RQteFOaEirF62HYxpnTmiEe8vBhzE07xSscYlM4LXKZ4k7E0LhSeE1xOR3ZiFNTZl61f0ovEaCaJXSAn4iVHiSGWIftMZI7zwixivFxSIE7iWFc2p7+8vs7VcaXf3Sex82BsE0K1nD0p8UU/jgQzTtlY0JfjEGrwhVahQWQuE+fuW2MWfmpgWgvDwqhho2/INGhLL+Wi+JFfBrhuKJwk63mHIRdbEu3ltYtdEtiwTf+96Sesq/V0E6/2+5rM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfedb47-d03e-4837-2350-08d61aaab9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:48.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index 816cc921cf36..efae2fb0930a 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1751,7 +1751,7 @@ static int fill_thread_core_info(struct elf_thread_co=
re_info *t,
 		const struct user_regset *regset =3D &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size =3D regset_size(t->task, regset);
 			void *data =3D kmalloc(size, GFP_KERNEL);
--=20
2.17.1
