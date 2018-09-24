Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B665ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A5B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hnOVWj9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A5B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbeIXUwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:55 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:27262
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388354AbeIXUww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+S2b0r/YkNG9gxzOHdq1cAKiOm0xn0VOoTz/2Xek1Y=;
 b=hnOVWj9scacc01B3DoCNhZkylvzJ8zqOKzO6RWiXm2fdAyejm/ovkpHPup8ooQ5FoaC5xq5vvInd7e5R34+8FHiVj8K4R0S1Ba/UzXuf7e31ILEMd4QMAdao4yISA5aq9J0Lt0lO2Nbd3q9j+3N3j7LVeqfSyIitx3CZqndekZo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/36] ARC: atomics: unbork atomic_fetch_##op()
Thread-Topic: [PATCH AUTOSEL 4.14 21/36] ARC: atomics: unbork
 atomic_fetch_##op()
Thread-Index: AQHUVBW9dD4N1IrGDkaLzqPXQGN5Zg==
Date:   Mon, 24 Sep 2018 14:49:05 +0000
Message-ID: <20180924144851.164533-21-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:7wfJyXmii7XGJZKESJ+tL59jd0NKgJB8PwK0jnNkOXH8nOVogYjVUjMyunz47AcPtdmPklYwKZEAda/jIMxIbRaPqYQsRpGaLBuqDW8zeQyPhm1DpICO2kJRl8I13BTcZ/lC5XSBrbzhGbcucMcDafnuP8vyDkTkBFG886zJAkxSp+utob92AgVZH84HgNeDZKx+NkdhPJbNEKVDsHxzc5qgZUNWUnUkNtVaMp1gTZ2N8KacpWIFqzzNKruoH7GyXOglrLgYFvyKTyRF6v4W1Cg4wRo9z9cLmvosizHodkm5jFrPpI2yYwNXGvc1aRmQFZjmlds9mxQOQsXEgzXNPc/ysodyDfAY786l3cNpdNFdal7W/RJVYzYbwWEt+R1qyHZeBuUT4Xg7CgNrcGIOBOC+KUpJ0EXhLFLs4f89mGTdI2Lpz5kS3/aiimib3WFcbqkhXZJWR5kwEXjAjUmQYw==;5:ENPQTd/DvKwyRxLtEhFiy6fFUt8tFIoInigq0KdgaKfRVx7c0Q1PZSjl2EHhTtF/DxGKm4n1hCvj+WDU3XYoFY6ZvbDIyJiPTxvnKKzx0A3khXfB4xtkM6t9OlofEfYNt4xVuXiGnCVVxB8bX1SDjbXu3pz5B1RdDBgZY9ICG4o=;7:OAcg6UsSL0m3H9PPLsA1xoJxocYhgdhbBFn3YpnkYUDGXvbT6TfTiYqGfWhrGp2GiHPIXvE3a3Q+MQhGcgPDWr8TiVvYXzpSM9lzO1b9Q2BGIexi6aSKD0TTsLAS8ymu9EGzvPcOhuhH/vQpvUpGHbCatifd/oPe0iU5w0x1xMfiA90D8JtQ7Jfdxup+PzT6ZR+Jq09XjokUzt5vPRAeKUIJG3i+vG3uu6dcd8XuLUldXIWiDjk7kXcivg0ksMLQ
x-ms-office365-filtering-correlation-id: e3726cff-69c1-4e56-b05d-08d6222d0ab2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB047065569473A1F36729A74CFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(54534003)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 02GM9Ap+e1trXZv08SuzLMHuYBJZYntF+RPqWjsyUCWShUdbPAvjSQDvJgT54F0r+LaHLooUkPfQeyYxSkYu2J8bfCJnj7f1QIv5ilsKGt8oLqTDcB1T1mGGu0uMpXnxetO+PofsU+kBieAcl6WdYi5d1N0xVg5fw7DbTo3Xqa3AkNBvwRD1K9B8eSCdiOvUmDkWRr4UU3lInhKjtx9Kkdc8gRSnSb3ICEimzBtI7jdl00UWD9vmgtm+Q362lx7cau1Afz701LlDzbuXn3VdhxnvYfLrVV1vs+DPG5z4ceasYnhPPjM2AxIItE1qjFt6nbgZiIdBUA09v7PtE7+iay4XwkEyAD4A24IfSqmrQQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3726cff-69c1-4e56-b05d-08d6222d0ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:05.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 3fcbb8260a87efb691d837e8cd24e81f65b3eb70 ]

In 4.19-rc1, Eugeniy reported weird boot and IO errors on ARC HSDK

| INFO: task syslogd:77 blocked for more than 10 seconds.
|       Not tainted 4.19.0-rc1-00007-gf213acea4e88 #40
| "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
| message.
| syslogd         D    0    77     76 0x00000000
|
| Stack Trace:
|  __switch_to+0x0/0xac
|  __schedule+0x1b2/0x730
|  io_schedule+0x5c/0xc0
|  __lock_page+0x98/0xdc
|  find_lock_entry+0x38/0x100
|  shmem_getpage_gfp.isra.3+0x82/0xbfc
|  shmem_fault+0x46/0x138
|  handle_mm_fault+0x5bc/0x924
|  do_page_fault+0x100/0x2b8
|  ret_from_exception+0x0/0x8

He bisected to 84c6591103db ("locking/atomics,
asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")

This commit however only unmasked the real issue introduced by commit
4aef66c8ae9 ("locking/atomic, arch/arc: Fix build") which missed the
retry-if-scond-failed branch in atomic_fetch_##op() macros.

The bisected commit started using atomic_fetch_##op() macros for building
the rest of atomics.

Fixes: 4aef66c8ae9 ("locking/atomic, arch/arc: Fix build")
Reported-by: Eugeniy Paltsev <paltsev@synopsys.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: wrote changelog]
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arc/include/asm/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 11859287c52a..c98b59ac0612 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)		=
	\
 	"1:	llock   %[orig], [%[ctr]]		\n"		\
 	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
 	"	scond   %[val], [%[ctr]]		\n"		\
-	"						\n"		\
+	"	bnz     1b				\n"		\
 	: [val]	"=3D&r"	(val),						\
 	  [orig] "=3D&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\
--=20
2.17.1
