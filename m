Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D26C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB71214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e84IHb7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB71214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbeIXUxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:30 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:36480
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731755AbeIXUx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSDHuxbWfx4RNIhwgREYUBPaQRP4csY3XNOTDIV0s7M=;
 b=e84IHb7fZ457U1QwLb/NpAWJrQNfODrFExRLlY0oZwhwZlspzCcAkzwUittxOYyNNzA0TOkQ1vEbFB1HPo8uCQnanGS3zHXUgMCupwCPVbKmkz2HonHi3NvzNAqV7jOO4+LpV1bgIseAdo/hTIhrNQEfveUR4Vm2vRTr7Kl4Pms=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/23] ARC: atomics: unbork atomic_fetch_##op()
Thread-Topic: [PATCH AUTOSEL 4.9 10/23] ARC: atomics: unbork
 atomic_fetch_##op()
Thread-Index: AQHUVBXMWG25ukAPDUWAHHmI07DtLg==
Date:   Mon, 24 Sep 2018 14:49:29 +0000
Message-ID: <20180924144919.164617-10-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:bKxsq+mbs3pg7Rw7LL4YoNvUl6SGIJ5+JRZg/o+mbX8+0tSp6Bj/SABD313gacqbBeWXBH04Wr/ZfMB16Y3MncDbrgVz+uSXxGjhd9XIdpSKyKY5CkeNVTHXR4Eu8ZzPNQIGVdbOiBKQ+cl3W9so1jeYfHV4WomO0NzQcSvZJMaG9bqKWjVzPQPDYLn/NOFFNsvU7SFPTRRqzRtHaiN2/V4lnREBcSVHKOJrnqYJEVnT4FlIkbrZTyFp0Tn6yVRP1e8KsJYdhG9rp9uuR6b0rnsJt9nmbxhEFkZYomsr9Pyp9n9JqTYkeBpD4ndxWhEeYKmJmBKt9iTOpuNOobz9bAvEexiFFXYfruIm7pr3wV01+K4GjYH5vo/3wJ5XneZIq1sA14eYRC2z4MKZOnjfQ0tPQPUe349XKcZpF6TGYgcDPZlX1/dRT2bkCi3mp7Cy+xjSdLooHqIi7cLOFPICaQ==;5:bkdUrwspkL/GZKMBnhIPn1/1o8fDmiB9N/IjWZS8Q/O7AO5mzm6bi9HZnW8oKFSxR9Hp9gv0YhlYOFLLlkZNxVtRksFKuHfyYR7ctxJAXA6iRnhxCr7uo2xApR5qUO61m/8yCrxSYOOyuT+OZ/L31S4IQyDg2H0PJoI6n1jwSfQ=;7:hks9LZ4c2GKYmH2TOQSDFXfDk4ykmGM6gVYaOW8gHbYzeNhFT7bb3Ar3QqVPoZwqdivPOSln2L8mjACalOo2U0a/LYcZvauntVSZ3m2C2Ghh04SCrRpE9bqxrefciKKhIqhqS+LCBH0nPnVxBaq+N8Dwwo9owONyADuYvYNt0MZISWYHR4w10jhJk9EjXYGFQ/1Zjf/Yjsjd6u6cy7DXD27azrMH59EA7CbjiMrEB4WGy60ChWeyiNmdVJkPfVAT
x-ms-office365-filtering-correlation-id: 85c5a1dc-fc48-449a-cd56-08d6222d22fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01811BB359CC6FC58B485779FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(54534003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c8YxLTFAxx775f2Zpl+kmNLRuN6GfxHp51kZ38xzJ7Vrt2RqDRec8AXhH72jaQn2HzQBypu1KLL5uHPy6VogbV2aYHnSNq5C5fyr+FRf3DUyVSRMLgqPtVpQ/5x+fLvac8Qq8ZnfouBsbfnBNmADjIuUZmA0rVcapRQp/ZzQU3b+5WWiOuyWy1WPI2aTqB/Tgoicz7baJLX8m6Y7loTXuL9LkcZteD5/Drt80jZ9nS40ctUHQ4XsAtbnwmOctK53ZPqJ6RHr96ZA3AZTIu/eMZAKSh8GQyPqQk+AH4ZoBCYkAeY4heAybTZ/L2UpPvw9I5yo6nlYOJtcpg9ANI1Ry3fUeTv1aoMxIawLh/lKSBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c5a1dc-fc48-449a-cd56-08d6222d22fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:29.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 54b54da6384c..49112f76710c 100644
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
