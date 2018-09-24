Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948192064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O/wj5azq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948192064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeIXVKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:10:08 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733087AbeIXUvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+S2b0r/YkNG9gxzOHdq1cAKiOm0xn0VOoTz/2Xek1Y=;
 b=O/wj5azqXu8kSFjZ42sacQWzyBlNvZxjF87Zu+sQPeOKsTkRevAWwowsiPYS7o04FklbN2IbCn3Gn5TYryQTGOisyLBb1x+21Iu/4wNAjbn/8lXM2wzcSefhoc5d3cKI+GKNQHJqyCVK583WuAKLCTwFe4cKSTTjaj5mdJsf5hI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/76] ARC: atomics: unbork atomic_fetch_##op()
Thread-Topic: [PATCH AUTOSEL 4.18 43/76] ARC: atomics: unbork
 atomic_fetch_##op()
Thread-Index: AQHUVBWn8Jjg1tvV70SHOyQh5puObw==
Date:   Mon, 24 Sep 2018 14:48:28 +0000
Message-ID: <20180924144751.164410-42-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:Ki/v3aKL7Npogu23eaIqkyFd9HKDqcPSGAUECQ/frZBrd18WQljjJOjr60FTFQqmJ6XuLqsTDmS4QNADRYE7PkdjcVGVRaDJFclGm5j6MgwulGxmDV7kMT3xOUZV11sazQZB3eblgMiXwdMUjmXTS4Z6WKvxFVqi4BHRKMYrbDk/TewhgN40wuyr46+zWPRjjpboxeeC6kA0JRa4MTFQXUmpLN7icQhIK2ZZbfiD4/ywL1d07X/kuAAVOl1hDbpoy2lJbHeFZiuASkUlORPbkIFqryiNwXk8ARDJMO044ap8mnSFAe9SbcpRBebTDfCSqQ2iYHeceEg8gJMESjW6LctoRs8VQq+nBkGDMvGY82tUBOGdVp9VlxAJrlbv5wlIw8l3lnBDlyqg7LCYUPVKqhsfS2pslHB8nrmCd1eOM/dT1Z4+Y+Z5slhVJSFTTSHBxePifO6xYmZFGLF/tIEdPQ==;5:Ndf+OrcVqSiqbZ1W5n3b612h06XeD35zA1tlQWvuKta/7VBkyIS/NYsyiWFjDVBAR6dnwOupH4hoMGkKeKQGhHpO7WiwmOCag5tWGeYSiPuUae0DIcyuPjDyDjRQtwLH5vSqke6ctv4If8AVTViCiymvDe3xy1N2CyGIs5ad3Fg=;7:GmVJIdSnadqGmzIt38r8cjgEUiMYPV3ks9/07UL5qtvUXRK8QqXRaJbSu+8FopiwCMiJmr1mGvOy0SBs8nmA4QdyCAomCtxpPZdE8iMNhmjgvUMwuy8eGqakkxsjFSvdO89EjsitNqZ7XkTxOqELjQkNMMBG7NWDh8zWnGWKXRKrPVw5T7U8O60y7ie3tAO/sxE8xs9mV3wL2dFymsxBLSM9EqZTIm7psSkAmmRwD/YFEZI9r01TmzpXAJMo3TER
x-ms-office365-filtering-correlation-id: 4b963fde-d6d0-48d2-c18b-08d6222cda5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855FF703D36F35F78BA56C3FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(54534003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sEN1bafe4itZK1LDfxEs7vgIO2E2uskhQ/qU+hV6UtZ78sunkJd/tihT1Tbi79i1qTV7GNbXYa6QdUFRDSPlXljTG7+6ZAt9m0Fme0aKCWnamJeujNLkaFYMLWKqKqIYu2RkMRkjtDZRxIKCke6vocPxtJFslHnQ04H3eEig22IWF76wMduG25korqUXWBUeCDG34FbnZWkEYgRyG9dppAkg4lSjABjwQJkR8o3yrZPjkR+OEZFDB7/cGXo7iROfPXy5WI8rJXEkstGFCMeKvuW3JrMtudMa9B5H1ds5pvAHDC2+gqL3pdpFwttvHDYQ4nVci8MleqJXq8Uu9xA1SRRug4ASXnW1AYTs91hqNVM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b963fde-d6d0-48d2-c18b-08d6222cda5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:28.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
