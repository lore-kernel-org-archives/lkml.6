Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A880ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EC4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eHD6KBGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EC4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbeIQIbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:06 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:27472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbeIQIbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKdb0HSUSiDWe9f7Rn4+acVEdhwuAeV0/eXqqtiabcg=;
 b=eHD6KBGx/OgHhljGmRC0v5CXwbBpFR1dDHOmnmWDW7zEOx/2KFdicZAtTxDR44iwF3RIMMQOTUNL6TyagrG+bzwJfppKbFtr6dJ7gT5HtllUSpWK+kcfrRs0eooPj38jzk60hsBFYidJscuIoGarjb/NMEbxjW7/yjGKP6bydYc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 12/57] s390/mm: correct allocate_pgste
 proc_handler callback
Thread-Topic: [PATCH AUTOSEL 4.9 12/57] s390/mm: correct allocate_pgste
 proc_handler callback
Thread-Index: AQHUTjMPbg+6/sRMm0aKTt2cJumWVA==
Date:   Mon, 17 Sep 2018 03:03:50 +0000
Message-ID: <20180917030340.378-12-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:6ZfldTmtl9IePW9QgU6sLwv7Tlsj16rY4c+R4XfffIBKr/60ElWQc89NNUR/gIuEl+lXhR16g3aJ7UayFjUXvU68cOzINbengL+nrf360Cp1ayU0znd7ZBJc3nVJc6cQuiGFb3u/HMKo2SqsA7EHIfRyd5dQW6H+1kRrqK//CR9g+0W8NOyKTjF3hDQXUNRQR0UD90C68jMHGkVwKME1iL8a1WVVXISpiRN+vH68lN/c22wchKfHQsGsoOCmgKuq/qVQPqthoPNT2jQieQKdHyeGUtGxv4pVtQoywU8D0IhGszWvlPEtjo/b3VF8A1sjwgTVj6j2uhTXcATw/CKCmbBCjthAiJbaQ3l8LuByMy8GATRxWZkV6J0eLJ+tckxFUdkZGFQh+/utQ9GMjyc/0XPE3RBwj1+zkcg8XcfGgTYDik0+v3badYjJ5Q8I3+9KCzhGx8b4BEZE9ukZcb77iA==;5:VTEdwitANzLfppjooGSDiksZB70XfSVJW794wIoHLlVQQb9yf3BBkyzIxzjhU8F7C+SecaDc1twnqbhHfJrrfGlYlkzwWDVAnz/aPms4/mEqbxcx9oENeGG2kVL7WTMCpMyNWgxQohi9+7Djax4fs2ul+HNm2Y5qAmj9hENG+Q8=;7:NDzcou5CPe55cnnBWosf78A1GtIV1Skf4kwsDEuoAaf6AnoIvhakdwTQbghM1kea+NMgF4RM0Vn+aJIo4BNmS2+zIooxBzpwqo7Jq47I0+3vxUag2EQc8vgoR3NM1o+yrayYTz0xSgQ3URj6zaFFKQ61slDzuJp3jFDkKJh+0qStZHRQO3yLcuUydK2oUm84U/NO/63Spl17/CPLYw/a++7YbJAQ4W2AjZPSoHSeKTsRYXMpxAhMghhmtn9BY7tk
x-ms-office365-filtering-correlation-id: 76e90452-a325-4a4e-8d5a-08d61c4a728f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01208CF562FC055CC7C27AFDFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AwCfeuebsQ62tKB0sFvd4s8+ydEPoeUoJ/TiDF7q/1752UPoq02yFKhvfG5FYabM4S260g3EMS9aCiza+3YyDHSTucosL/sRP2ZKazlpRFmZEj3Z56xKQCzm/96/P9UDmg1OS8LczZO0Yfjoz2PqRt4qLMFNRgggXf9uk3qWKOg95g7aMB+2xBU9vqlRl0zCnP2UbNRNjCFEwKNS0GArvWu1f8+aZyuRZzNAmtiE9oGu8iVOUmbLcSRS88kXin175s6UnBYrb+aowukUS9EjdeHobviQ0LyKEwE0SmV16plM3MaRpEVPs4BeiD5WZHyUff4f4jPhgGFEOvMJprE1JllaDIeNnbOS6IRtO3L9vd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e90452-a325-4a4e-8d5a-08d61c4a728f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:50.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 5bedf8aa03c28cb8dc98bdd32a41b66d8f7d3eaa ]

Since proc_dointvec does not perform value range control,
proc_dointvec_minmax should be used to limit value range, which is
clearly intended here, as the internal representation of the value:

unsigned int alloc_pgste:1;

In fact it currently works, since we have

      mm->context.alloc_pgste =3D page_table_allocate_pgste || ...

... since commit 23fefe119ceb5 ("s390/kvm: avoid global config of vm.alloc_=
pgste=3D1")

Before that it was

       mm->context.alloc_pgste =3D page_table_allocate_pgste;

which was broken. That was introduced with commit 0b46e0a3ec0d7 ("s390/kvm:
remove delayed reallocation of page tables for KVM").

Fixes: 0b46e0a3ec0d7 ("s390/kvm: remove delayed reallocation of page tables=
 for KVM")
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/mm/pgalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 995f78532cc2..781a044e1702 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -26,7 +26,7 @@ static struct ctl_table page_table_sysctl[] =3D {
 		.data		=3D &page_table_allocate_pgste,
 		.maxlen		=3D sizeof(int),
 		.mode		=3D S_IRUGO | S_IWUSR,
-		.proc_handler	=3D proc_dointvec,
+		.proc_handler	=3D proc_dointvec_minmax,
 		.extra1		=3D &page_table_allocate_pgste_min,
 		.extra2		=3D &page_table_allocate_pgste_max,
 	},
--=20
2.17.1
