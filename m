Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B98C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33C20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Jm0fijWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D33C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeIBRrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:06 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728386AbeIBRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQztpym2pAbSP6FQ6uCFYuSumJqTrduHiPvBR2YfQ+o=;
 b=Jm0fijWIkEZggMs9qDnEZiDbgyH4p3BGa5r9om4P1r+UdCUuB297//TOAeESySAhvClPo1jAt/4AIH10zzFa+j3Y0M9NMgWcKf7wqEHTtDC6MIJFRSXXb7/AQE3dm1Zr315Wooc31RPsKuMww45V2NASpOhOdDsiFo0lVZVhGSY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 088/131] MIPS: generic: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.18 088/131] MIPS: generic: fix missing
 of_node_put()
Thread-Index: AQHUQr2LGpvgFBOdlkSfJQ6vO44few==
Date:   Sun, 2 Sep 2018 13:04:55 +0000
Message-ID: <20180902064601.183036-88-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:bX6ilNZVn8LlalzHF8OTb7NVNh6e99ZAjuu5KfIILBbyiNYtZVehgkVG9GPy5avSPOb5m4r+zZqgvcZriRGYbgteJJwMvB7HND1BH3T58KfOj9dXKuZBWioDeaP0NgDb555WMP3lZHyl48MfwyYHs1znpfAksxfV2n3UDUgg8UkGZyVzuyygyVbOiqh0BU2IMMd5bYUnNyjhbYaKM594XlmyTvYQrKm1RSpTxEL22QCXiCWQ7LGkkHRT6w1Xt3qwQzHk3mcfJpdwcsDm9TnMvejQ/DgzkvHRoRPl98nzt8paUXEkJOBdMFoLHnupEqV/51b6KqYZl7HBz0BbkFbCMM3Cb9xNSgsmipwz/1laNrvhePqZzaPbolgOVihDlxFPumPZ2+AJkfBnpLYPOxDL/YlAGMKQeYoQqqgr/jI2zfhmuSzXWPAxygTsaQJ3APRJkGfyyCRqFqJON/FFMrSDLQ==;5:DHUrF2FGgmZPi3+a2H4ymZq+iZk4C7hr/hWvrnPMGFhTq52eVSLyyB1C3+zynwIzIFe4fMfLlfuNv1qKPJRcUbeoEr4QUcyc2+pvboJQ83lMahReYjZ+snJtAAKfWRuQgEUSp4Lib0dKQJx6zAi3wtc26apMbloeL9S4qLQNHFM=;7:TipqxebSwXpNoPSHNbR8c7JcDw9w0hV94OpFlyt0MV2+NOdktXx6pTuH2m400MjITo3EymVi5SImqX3pHMrcRlVaJwJDQc3P59h3U7SU/XccTi3nrZCULZfZVooso5UXxtJj+xHPBN7xP2Q532kqGMlJrGXrJjpRAn6BR5mTHDDnJKu/IunlHabHwpwckadGmhL7UsLnXpRgZ1ODcqrW8iA9ns1hKHtSrt+0aMfcFj3yO+xMmO7BWt4lyBSDLWAu
x-ms-office365-filtering-correlation-id: 1f51319e-3a82-455d-ccfc-08d610d4b090
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07415584A0D19BC196E56FBFFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4plDj7w+nnkA+obqpPTBfWbVMFeb5fzxqKrwDyQ0qNNEKgyJoqtoysYD+FrhpgNIcqYesRQqJx8lw5ufNJBs90O4D7ITzCzKWB3V4bm1YIDCtwbGaao5uwQCQd0ozgbRzr5kG3Bkz9VYKNYQK7uNru8gYZvfM6jCc8fbF5Y1c4nZUol3AAvJydDeR5GYsR97lPY4feJUpLtxrQuTINtKJNbvsFqhRX9OGdhit20eKCmYGFNGtPjewhtqY1k+7T8pCc5Vs6lpC6bqO7omSAUUucTvKGToAgQeNNKnhZmtxS5MzcTdcb72uuXKGinJhAkTRAuJvjxW2ujiPHdbxwNEMBDIazuFqAUoVWH6fTlLVII=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f51319e-3a82-455d-ccfc-08d610d4b090
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:55.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
