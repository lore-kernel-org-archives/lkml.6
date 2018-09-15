Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38241ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B9021477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WKtlep+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B9021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeIOHIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:08:48 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728089AbeIOGrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWTkG6GGjIBt/d/wjx/wwMGo3qY9tP0cVNaMaq5pZQs=;
 b=WKtlep+Zs99LG2SMwt+DPTsqEaYZ40QdVKdsgO8gZDxblU/0hjo9nukK9DAy8nMI3QfEG9cHKwx/1dLMY/3sf+auhSPErhDuLidDL9AArVTm+JxeXV2PhbxreavDeFa+9MBtcJPcPgXcEiJYxTtVjdAYluhwXS8iYuNUwcqvy9A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/92] evm: Don't deadlock if a crypto algorithm
 is unavailable
Thread-Topic: [PATCH AUTOSEL 4.18 12/92] evm: Don't deadlock if a crypto
 algorithm is unavailable
Thread-Index: AQHUTJOcYgk//jcjN0yMY8tKEH9PpA==
Date:   Sat, 15 Sep 2018 01:29:57 +0000
Message-ID: <20180915012944.179481-12-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:jZ0Tl8XiwWe3Y5tFZk5z4icO4vieA4K2Zi7s7wgC6W4J5bEpy3qFP0eIWXMLWokMS9UxKwziwWryyQhDhOP51t3syQeFkmqc97UXoAkYxIk7PNciTPfyyBCFUy3BIp4hxb+/NnKfR7oicZr64c5XHASO385LwjqLTXABPwge9YjRA2RHDn4L6znBiQ9hnsOCg7Y0Q6j1WYhxYOgNVdHdN3uZZbyIMTkjS+ILeY7OVKHB1v8VryNhWOXRj1iZKZgPtfS36CZRsLEBPeGzAoogKg+YsJOtwNtSMV1CkcKx4q8T3m/hhDOdeoMUNQJYv3sa8YSSbw0f3tEIhdQpztvRjFIFGv6skll6MagpwhclaIFnWvj9fulPr+1YyzzD0zNamfO+fWjEbq1w6Rp85mzCjORXTNShPcijX1NfRodjcJ+clZkqruZdg40DXdW2/3UP03Q+9uprqhhxNU6Cfrh3aw==;5:ErCNNX0SyuP4pW+bMwNVs4E5lwXmzO7OSXqmqyugpixxFGfRwrQwN2G3Q/XJgCDh6F11mx3j/58bRAC9wSijnrmE80UpIkXIXd71KS/yMHLaSrf7gNY0CKCGTGoVNjGMhwlVaYjSPGKKt2Fw6EwkY6JRpB8ah9dqiS5lQBJgH8A=;7:h2YOCyFK/jYU2ZkSeur10xsP9E1YSZgs0QX0CDWLEHWyfBbZemhSCXwVXTYoe70FNVwdj9Viyu37M1HDy6fOT8n527bRMIIdNmWDmydJbkT/Z3dpoD1OGwq3cs9cmTr0xfCXqBFbrAlys/Uq9fKRq/7PH1wVf68IdCoL28V8I4eGQVYrFMoSivVHGdLiSfyFXl1ftKT4ITfJJvZOH0vNC1z2YtFOFELHVJwKKabUQJR/aLcyQXtNs0fihMSETqg8
x-ms-office365-filtering-correlation-id: 270c9547-aa16-4a43-e285-08d61aaabf1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840629B229AA8253B083FFDFB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2odq31lPCtBQGcd12WGBcFFZdtX58vkngWtRYc+1KtGFZ4q6D6n8Ovp39Qyywi89PjCxeDRZm1Y1V/jMWIgFT9Hqr8LH958XM6C48IochYnTl1hitfDgl3wWFztqlRZdZGXgixWz9GDLGumNV+IVnH1sX3G/9Rju/94NbGQv7bZMOExa2fVBGf54MXrwGBxKW2rVteJtDaV2JXpvv8Tb6MSyuQ6WdmNKVT50NC7V4QQkPW+vh8u1RB843omnY2ax6Q0a1XPjAgCqNhTJWq7cIGx+3RgnlMwCSadNyCevWThqy8XKzkeIIrm7D3oZuwRZKD0F1Bji8QqMdz9zPhXiYrB/3VnhUBCZHdmoCtBxf2Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270c9547-aa16-4a43-e285-08d61aaabf1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:57.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

[ Upstream commit e2861fa71641c6414831d628a1f4f793b6562580 ]

When EVM attempts to appraise a file signed with a crypto algorithm the
kernel doesn't have support for, it will cause the kernel to trigger a
module load. If the EVM policy includes appraisal of kernel modules this
will in turn call back into EVM - since EVM is holding a lock until the
crypto initialisation is complete, this triggers a deadlock. Add a
CRYPTO_NOLOAD flag and skip module loading if it's set, and add that flag
in the EVM case in order to fail gracefully with an error message
instead of deadlocking.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/api.c                        | 2 +-
 include/linux/crypto.h              | 5 +++++
 security/integrity/evm/evm_crypto.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index 0ee632bba064..7aca9f86c5f3 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -229,7 +229,7 @@ static struct crypto_alg *crypto_larval_lookup(const ch=
ar *name, u32 type,
 	mask &=3D ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
=20
 	alg =3D crypto_alg_lookup(name, type, mask);
-	if (!alg) {
+	if (!alg && !(mask & CRYPTO_NOLOAD)) {
 		request_module("crypto-%s", name);
=20
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 6eb06101089f..e8839d3a7559 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -112,6 +112,11 @@
  */
 #define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
=20
+/*
+ * Don't trigger module loading
+ */
+#define CRYPTO_NOLOAD			0x00008000
+
 /*
  * Transform masks and values (for crt_flags).
  */
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/e=
vm_crypto.c
index b60524310855..c20e3142b541 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -97,7 +97,8 @@ static struct shash_desc *init_desc(char type)
 		mutex_lock(&mutex);
 		if (*tfm)
 			goto out;
-		*tfm =3D crypto_alloc_shash(algo, 0, CRYPTO_ALG_ASYNC);
+		*tfm =3D crypto_alloc_shash(algo, 0,
+					  CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
 		if (IS_ERR(*tfm)) {
 			rc =3D PTR_ERR(*tfm);
 			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
--=20
2.17.1
