Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C3C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E4E205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o1jDG3y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E4E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeIBR2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:28:43 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729341AbeIBRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQztpym2pAbSP6FQ6uCFYuSumJqTrduHiPvBR2YfQ+o=;
 b=o1jDG3y1gbl5JOeW605Ug3FYXqcqtVUfu8D/91/gVt/gwFzyJWD28VkRk5basuCXbh/7QfktW0M3Q8JFe6woObZNwoUYr5v95P+k7Q/CSwJgMphwYO0dr9079YPmVLP1LIhPgQo/QGh0tGdtkjfF+qi4YJv6jYMUWilD370Gaik=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 61/89] MIPS: generic: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.14 61/89] MIPS: generic: fix missing
 of_node_put()
Thread-Index: AQHUQr3k4RUQ26rqUkSp+UKhXPfbMQ==
Date:   Sun, 2 Sep 2018 13:07:24 +0000
Message-ID: <20180902064918.183387-61-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:dFA1aAK82cezgTyqrFokva6Qyo8OlWEzCWO0yvYucUD7owGK7y3RBWPEZ7vr5nuHAjXh9lG4Sba5qLcLd7BsyJJFpO2DqhYPH7tybyKAyTTQC7N7sUmxm2hjQEm73eDQxNq04vPqtGGxPQvUUw/ZeRVq8DclMCbKffz2YgH3wRvsf5NAR85tnncqVQMrJjzlP/KqylthfX8p+Z4csS902AdC9PcdSNNev4JD50yJzgM3Du5DbinGRKxAc5TWiRCMdjTf15tvezVEZKNzaTYjhlJVQZ/dFk+EnYuSEAuxiXEUlBsA719RtOtdh626+4MGc3dszYOsduHKHaZF3juoarv0bIOkpnM80hd0LQh8M0rTMIE+ZfFxLOj4BvwupRWtwxzutbjpyMErr0Yedhh70SzBOr3GB+t+fKpnZkfT3HduW2KEfp+iNU7EsjSYFYcrffUuB1oMR5yrXSN1hd244Q==;5:lPweCtTm2VuUxdzyKgq504sLL4XtVEvC04vEBJ+lIckkbsVlcHsmIrlftwTT4+bR3977rgkL5r51F8fShcBVvuAVTruBxvncWF89EdYezI/GjkzSPgcNcjG8BENqrAQE8Rs/kZYTHQBmgniSnCmstAKIq2wxbsqt1rBPH7FFOec=;7:x4HNXHXwnXSQqMXUi2/8dttMyWKO5VPbhD2znp5C3paMgrxOv7vVHwn3hiRe1uFRQsvr1frBCbS2q1J+qvysA2vF98ovpu7cGoX5vs26wa+YIuQE8OwcE/hQl4Md9OYIqTGaK4SWlk74wBOjaBFzcvVio7gz3uIr6GfHA/CGtfdEM9ttgcQNYkn0MVz9kI/6YWzcRvs2/IzzPzx5khN1If9ZgNzuUmnYgkeIx3s5vCdbSamvvDrSVGwTwLmRNrMr
x-ms-office365-filtering-correlation-id: 41464ad3-bd3c-4f29-edd5-08d610d51535
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149822D281BDB3E32FD4C62FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6306002)(6436002)(2906002)(53936002)(256004)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(966005)(2900100001)(8936002)(86612001)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5yXMwWpbTdMdBns4/dYw7V0OjVIwZu5fAOrrj1KlSwmzXITuLbrr7sF2oH5rO5iYTGqwpnk37m6KfIyLv4pB+2ENRFbVntCnbpmOwlUVle6L4SmYb6zpSWXoRnb9LcFlV4dQTKrivzNtxMReL1cUk4b7p2H3yl/VV4zOK2A2iq+6EMGLCXimBXfTJYz8Fxj1Tjs4mX6nLw5P80IpYC5okNnD2YgttHhZIvA5q3TqhDYmVa0QMaDwUyJbqSKQMa5arp0sYuwbIfG8dLwl0V2xErlQ6EunljNUn1gwmxgMBAp8c1txYzx2u4wFP0uw2aijcMzhi51jgvnlrt10LMJgvr9/Tt/CdZgj+Lhojk2J2GI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41464ad3-bd3c-4f29-edd5-08d610d51535
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:24.8858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 28ec2238f37e72a3a40a7eb46893e7651bcc40a6 ]

of_find_compatible_node() returns a device_node pointer with refcount
incremented and must be decremented explicitly.
 As this code is using the result only to check presence of the interrupt
controller (!NULL) but not actually using the result otherwise the
refcount can be decremented here immediately again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19820/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/generic/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 5ba6fcc26fa7..94a78dbbc91f 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -204,6 +204,7 @@ void __init arch_init_irq(void)
 					    "mti,cpu-interrupt-controller");
 	if (!cpu_has_veic && !intc_node)
 		mips_cpu_irq_init();
+	of_node_put(intc_node);
=20
 	irqchip_init();
 }
--=20
2.17.1
