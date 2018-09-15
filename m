Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E7CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9648E21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="USVeSvZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9648E21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeIOHBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:01:03 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729203AbeIOGtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT/TDmfOutQMkEgTrGNTbv6HG68fFM8GTOBNpTM5fYk=;
 b=USVeSvZpUWZwmx2LN3uRAsJviZDE8RR483YTRohpeiDuwnzvXPAk2ljGquPBqJji+l/Cay6GVJ91gyq0SEc9kG6siI6m4Qlonb1o3LObiubClATfsTnvIo8T1Y1gkSYsYU1UquQSSCZApiL14szhxXCbq2aeEhfZwPx6YjSbQSk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/57] ARM: hisi: check of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.14 21/57] ARM: hisi: check of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJP/3yhJ3BvKnkmDyVKTQWi7Qg==
Date:   Sat, 15 Sep 2018 01:32:42 +0000
Message-ID: <20180915013223.179909-21-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:ePolG6HGxKsO6DnDG09KrRNDSQMYW25cQ7Chu894Nv7SfMbzKh1b/0nSyLUuzh7iAFW+a3fuONCevK1zv79+E+N+5ckkHLxzQ4H2yBTqjonVwM46Bv/B2488hscsMBK4Oh0zX+d475HywoMfD04YOtFyU5i7KvsCylkGA/rtAgQVINzB1jCtRc+FqJCXMGmibcLCOjKQgwvjeYXT1LzDa1K7+I7UBBYtYN7Qil3iyqi9KjKpxSUFA2Z+5jYFXyP+6q6l79Vs5oAMsSlI1Ef14ZgMlwE3QRtK6Az/cEhWr6f+w/EYzeLneXCWYLYgYBz9rI2Ec2QDHcGng/6+DYB/Xheazpy0fi5VJ0n5oZ4dLA4nQyp/36S1LZbrMesAt+nxK8Lw9SttE8rWrIvBKvmeNOlKmij7ZSlMFk0TtLWg0ygaeg2UtvcwKzOkUe9ORhheO3ykaKEDovw3nE7uqIcH5Q==;5:8BfojLJ04howGdGWjxaladhj46u6YyAcKgJByxjtNrVXCgaYQlwNlt5VTlkt7dAyQt9Qrg6uNnbbVLzC9e0XMxSjmPXllTTOhX73NBpJTDgSudO0b9k3GHLNHDez5ZGD0Hqc/xO1ea53x39NxcTIsZooVrLb39uPXo1SZgs7uHI=;7:5fWdnDKP9qXfZa1Vj7boBFQ6W+EqEtVfRIu812al/U3WFLiFGBc3As56WeE0aEb0VUT+sm+hSlBWQ8ZFKObe+QKHMzXTuT2M4x21Rqf9zTPRJIusRf04S9M+F/977k5RFZhVVKZsM9eQUQaXILDX3SmPwh6FrjoEqJ8kIChnCL/yR/Q2fiV0WyvwOHmIhIpBXA45HVQF4SZj1yX5by8LysY+6wxXR2kNHBPwmClPsw7Pf9+bvEdrU32AvG2xm0Su
x-ms-office365-filtering-correlation-id: 3f5b035e-8d5e-4439-5f45-08d61aab21d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08220E5D9F18DD8AD305B3ECFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LIJEWZEZSl7V1TGnJKwgQt8x2uf+hnEJ9FhaBHTD5Hf9XVmncMYkynM0ZaCI3xkwZZkQxPiHUOBVc+9BiuujmIKtFwQHVqZ4+ypN/swuGkAStkJMytB1R9NLy061OVORIrbJ8IYiK/nzXUC4ibTb38ghpPgtjtRWieHfb+H19QqXIdwgdKEkOJHEA4i5sXeocvmIIZy9AFPF2yRgcHifYaj0idgn9kbEJkQxpgrb2s6lCKDRa0TdJvuKXoohG+TH6EJFuotpE5E5EZFcSqRdXF+BPI23YEZ3tCeTd6fgMDXQ+VEWjHeRW4ZPnq8caI1n41yfO65jCF/nSXQlQbDavhknBZFe6ZWZBtwop3o3bnI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5b035e-8d5e-4439-5f45-08d61aab21d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:42.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 81646a3d39ef14749301374a3a0b8311384cd412 ]

of_find_compatible_node() returns a device node with refcount incremented
and thus needs an explicit of_node_put(). Further relying on an unchecked
of_iomap() which can return NULL is problematic here, after all ctrl_base
is critical enough for hix5hd2_set_cpu() to call BUG() if not available
so a check seems mandated here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
0002 Fixes: commit 06cc5c1d4d73 ("ARM: hisi: enable hix5hd2 SoC")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 32870560b280..909bb2493781 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -180,11 +180,15 @@ static bool hix5hd2_hotplug_init(void)
 	struct device_node *np;
=20
 	np =3D of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
-	if (np) {
-		ctrl_base =3D of_iomap(np, 0);
-		return true;
-	}
-	return false;
+	if (!np)
+		return false;
+
+	ctrl_base =3D of_iomap(np, 0);
+	of_node_put(np);
+	if (!ctrl_base)
+		return false;
+
+	return true;
 }
=20
 void hix5hd2_set_cpu(int cpu, bool enable)
--=20
2.17.1
