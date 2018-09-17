Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15262ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77572147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S8/DR1tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77572147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeIQJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:01:45 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:33973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbeIQIZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsDMNuM6L5GZCS3AVRHqRBa+LTwF9eaDukpEcI5RmKI=;
 b=S8/DR1tOx/50OkQAxANMEn2FmCjpueA4tc1uCV2XRuf/dgigcp1cm8OAmDY+9cK1L4yXG23QzU6HC0T4B/Y/kaU2aHZ1qfwyqDcU/4sLI9YOHh2BxUsWMvQv0Lba0FOlAku+Bm09fn7Vario5kgIpDP8XVmm1E8ZtiCjuaY2NZQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 023/136] s390/mm: correct allocate_pgste
 proc_handler callback
Thread-Topic: [PATCH AUTOSEL 4.18 023/136] s390/mm: correct allocate_pgste
 proc_handler callback
Thread-Index: AQHUTjKVTrI5uybbfEeiZSGJJyj1kQ==
Date:   Mon, 17 Sep 2018 03:00:25 +0000
Message-ID: <20180917030006.245495-23-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:i2+zCQd5QP+yL3wWEDIwqqNa1Ei89oil+LRpyADqpCw2ZDo0tzpKvxHTnGi6bOkEniLP9g+PW6uYfo4B5ScNuMHsRkj1Y8xd2lEuYlQu9W7NIg3FYpEIRmyip74fdPyFipOYHioVEolXqaeRDZatM8D6rmf+RFf2FzFRNr9vsFUDsBBgYkdw0rLTZlmvRPVovFkDYdufVObsLToAiDZu2R9PBwEWBmjL95kmETUKmBIgEdxMGCOC5LRLQqd89DUBco4vJL0N2e0iLb9PTp4mFKWK2Vxdn52eq5F3il+smYR8koPyzS1l2GH/eqOG9fAbGNqQt5sVX9NiQhB5pZMMXVO7X65FZxscsUQHSodLc7TQk11jHEmaHdkGsr3gm+WuFFuh/7mYyd61ubJOoiRSSl1Y1KTfGPabFpl5TYkdN8qcGbHOI1u+QhOQ7Lk1C0IGMwyM2lE9VXd9yOnWfCCoPA==;5:mkTOHAjJJGl51dSJX8nlIPsUbtf4hfSE/2PjBYFL6Mky6qbdb0HRmZrGtYIxXBOw60TUYiIsP93lDXU1NYRkb57JNH+WP6fnrW6ENowy0QQKrGlY8ZRI47vkKhyu7MfrDd+nIYytvN9rSpMfzuVWjyyonsugO6APRA7NfHC8gok=;7:BhZaBBLEYsyijkeyjUfnqTGWJ8jUtaTG8HzHMBxPrXQeySBBI851E+sJHW720RujZ4pEqEDInQfaMt7mrnRFhSKkAeCQpC89ErSVWRCSzYE6Gc9nUDOYY/Ch16WnnPzbwWKdFF8NJbysSwO2UrV5YP84jUaUaoU/esBQ9j4aZUC3H+UhwnQorItfadP4vRXX0EmOdcidVNgM3yrfwpvSjjzloD6H6oZCNW/BoHv+9EaoXdYMuCoz7nSrNixtseDR
x-ms-office365-filtering-correlation-id: 3a600100-57f7-42dc-8673-08d61c49b852
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB02778D86C9BE4179BAE7D314FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5bJdw+7aEscO/ltUnPYWUsauMDbu0A5nylsfcIAVowo3ihSc0Yy/1uATJJY6T+pVaFBbTxQs+tbBXhjNILP/eP7hRLDTYTWxOJLUMt9sUSuSl+ihKgNbwraeiAQevZo32Zzlt9xdpoPUJ7yTd3YkwZzhaC43ctj/4RiA/V68zI8p7pLkk/gumdt2b+EiaoYABJKsgi9tx97JacNfeZvlwYcqyH1wWO6voK9qaeHJxuKPcSKhCxTb8ALEkSzOiGrhwdpMT5vAIEGGTrJ9Wm6f09FuGPULVdGNdhjk9EFKdO2AM0zvhWzcMs1lEn7eO/GUFWiCddT1lbw/iEBqm3+bvc15JtWsO09GjvAweJeviSA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a600100-57f7-42dc-8673-08d61c49b852
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:25.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index e3bd5627afef..76d89ee8b428 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -28,7 +28,7 @@ static struct ctl_table page_table_sysctl[] =3D {
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
