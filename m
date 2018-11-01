Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE08C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E33B2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KjscmW90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E33B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeKAJfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:35:43 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com ([40.107.69.122]:21680
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbeKAJfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ2o60m7gpvHzdSg1JF76OXxJu+7zkEF8KMPq/rFGVQ=;
 b=KjscmW90fOBi8DXjl17XdZgWd/RmYL7EAQ5Zl1EuQzMELJupD8qpyQ7VBu3jMxKr+zJhb4c0afun2h2GD6DORKf2B85DEcQtVYoci/z8K9LB2glY7QP/k4m9wwZ3/6UDaax/sB4E4IYob8zNh7jjTgZxjZCxpaO1jkvYIcz9rY8=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0192.namprd21.prod.outlook.com (10.173.52.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.2; Thu, 1 Nov 2018 00:35:05 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1294.009; Thu, 1 Nov 2018
 00:35:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH 1/1] irq/matrix: Fix memory overallocation
Thread-Topic: [PATCH 1/1] irq/matrix: Fix memory overallocation
Thread-Index: AQHUcXq7SA6G9rZh3EKUDa9NxVMDQg==
Date:   Thu, 1 Nov 2018 00:35:05 +0000
Message-ID: <1541032428-10392-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR0101CA0026.prod.exchangelabs.com
 (2603:10b6:910:3c::39) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.159.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0192;6:r4hSUwoM/yGlZq8erb3jz1OTbETwRt7UV1ov8pTLjubQHrXRqgAPgX0qsGS3VS0507DP3RWbOH43covFjoZC7I23z8KNlbyL424oFaMwyiglS06SylNkjxpisjtUXaVLEziJ3TlauIGFAborGsM4+1/9FtrzIK/XLkJm/joBpqrHNCVuKI8KiPi1/uPIbtbXheJBdRuTfIOJLfrq4J5ff2HjzZP8dM3mbAubrVZZmPGObL2k4asIBj2zY8rDOgqlQexcSGLdaPJOZNL7qX5dGPnpQ+hfHiMhZ7Mi44LHpRi5LeUMexxQAU7DWkS+tAMxJru9khKlIrLtfZrVr2SL9bQZrFl6+JIOkDsRsvX4o1YQeLlUcN6bpIabHR/KTzcYgVeyN93bLfk+W407QFzgWlU6j/Ovc6XGY59COhvI/84jSxtz06cox8b/RaU/XwgSSfDrOR4dPZHG/uOs3nipCA==;5:RhPF4TraXFnbRexKDpPwjebr5pAdEdMcibnQ+9KkS1oAeMkL64SNWSXhRFsOyuluxRR8RMIVtHNUjWJl8gnNMxf1/YssPv+SSGJCJk5Qr6hX6Rp0pE7/dWk9VJ9VmJiYEKyuTj+KUGqsZ8Wf+3PfP13bnsLyJ67NWGGy9tqYvLM=;7:fAcHHEZUObzlCFaqPehOxcqckJIXh3JIU7CiyxLNPlknq7WeWWn+GgIST0zMzM/+zY7l9X558V7mKOTieO0GFjFi84oM+g9MkHRburyWHdJkZN5bqaObOfmeBFBJeIKbrmeTt+h2BTc4LZW1fgAoEA==
x-ms-office365-filtering-correlation-id: c033b77a-9f83-4e44-799e-08d63f91dddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0192;
x-ms-traffictypediagnostic: MWHPR21MB0192:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB01925C3D6FE81CB941AE51B1D7CE0@MWHPR21MB0192.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0192;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0192;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(305945005)(2616005)(6486002)(7736002)(6436002)(476003)(53936002)(486006)(6512007)(66066001)(26005)(81156014)(81166006)(478600001)(386003)(6506007)(97736004)(102836004)(8676002)(186003)(99286004)(10290500003)(52116002)(8936002)(316002)(2906002)(2900100001)(10090500001)(22452003)(2501003)(5660300001)(5250100002)(14454004)(54906003)(36756003)(107886003)(256004)(14444005)(68736007)(105586002)(110136005)(3846002)(4326008)(6116002)(86362001)(106356001)(86612001)(71190400001)(25786009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0192;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: phb3YXEgdQBeDll4rEgQqD+IsaalZw5w6F/gG50qlJYDBrS6KFY3Pit6BFAnLGhZIvPwnZJF42KVnnQ3eMp1s2f6kq/uVOzkv1lpFl0+hNfOOgMzJh6rUJG1SRlTL0sPjJlDsWwWZ8NCyP5dW08ZqdNIs837ara0IsALxn/XmqjxCKCVLb6oYpyVLwW5LZiGcauljOzYlQKLPhdP36C+1XIdqT0nmjYNr/Iq+hV7TyVwjfQiu0Op4i1axvnGVioGA05JhPD9qV6iaq1dMCL/R6SJN4g/kMCzyStmbkP+TAeJYDY+i/BLhJYKDutj9lreUN1e+OuL78ndMo3ei0w/mHPnUFaIwO5e6gfJrV9FgRQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c033b77a-9f83-4e44-799e-08d63f91dddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 00:35:05.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_MATRIX_SIZE is the number of longs needed for a bitmap,
multiplied by the size of a long, yielding a byte count. But
it is used as the size of an array of longs, which is way more
memory than is needed.  Change IRQ_MATRIX_SIZE so it is just the
number of longs needed and the arrays come out the correct size.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467..1f0985a 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,7 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
=20
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS) * sizeof(unsigned =
long))
+#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
=20
 struct cpumap {
 	unsigned int		available;
--=20
1.8.3.1

