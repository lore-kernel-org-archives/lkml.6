Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDF3ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799AF208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T9GCNA1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799AF208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeIOGvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:36 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728379AbeIOGvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzBQkTwTYkS368EtggcGtQNiy+slM29tdwwclIsNTNo=;
 b=T9GCNA1OTOo1+uIfmVu6bcNZNUSJNMeplT8BS87Kqj0EWcIdv0wh2XeU8Y9sLNIfxGfLCG4Vm2O0qw01vQV0DYl8Uqr/6Tjf6odbWsr51AnrTwZ8EzbKAo+AjiQPjVDqFFbQvXgafHVMuQKOy/F7GBcUiS5j6H5nKrPFFLO7Pik=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/34] evm: Don't deadlock if a crypto algorithm
 is unavailable
Thread-Topic: [PATCH AUTOSEL 4.9 05/34] evm: Don't deadlock if a crypto
 algorithm is unavailable
Thread-Index: AQHUTJQ+LnzFxj1j80mKgZnaAFXltQ==
Date:   Sat, 15 Sep 2018 01:34:28 +0000
Message-ID: <20180915013422.180023-5-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:8qCWbiPQc+YY4hQHxysNmchZQxjck7EA1jmkMtVWzEpDhkGKOSGfm6bjwVWfsTzmgljiXws9m2luRjpeU1O1fqgevRIfkmeUTGjvkvVwCPcMSB0GEBYtXEA5RkEYl2fxeJIibPA1kqN74muZ8NvcV8QbnTAGNLeuQ3UAEFNdLLCDy6AfBJ3BnabWLQHix2/Zv1SdLKOIShYPad2/6mG66b0gE+9TNS2nPgYYIXDjFQM1Vfts/FzHQkzTSh99YEcI9b6wk6WSCJMegmKHeictYSYhkOTzxiTyZsRYw+B/xZl9YQs/3y2Xj0b8uZrKwKAm9aXkJvf+q7fWph8kOlAWZobgv9eERDizjBtM9v4qAlLdIqU2lYPGtIo1ylS7eYsQg/TBb0EqiNt6R1W16dx1G+f702FUUrEUqUIKYeDP6RyTMqsmQ5vIfRuDsydoIsy258jsfz54+R/rNgwyjpKUkQ==;5:1MJj/FZdGXR2UvX6jh9ZowiR3w7COD4W29kGain3/XkBHBtZmY5jhXPN4G+//sfcEl2EtLPc7uaZkiLtPXl+0r5hhzLxWCCzJhG7eMkdZ7LmCjGwKkJYi8Yi/XsJeEgMYBuznHarC0LTM9tcPWdJEflVV2r+Vu8IFnuMttlDZhM=;7:xemYCwgaE/KMSlVvE462ot5ymjUSVPda0LjyYgC+H14SNQ7lVFte//ATlEckS10ZzvvaHOnf5gBwc8UC9CX1YYbfAnzmudteR57pI10zHjnabEIw3AhWdx+RFukqFPpyBHBaURd1v2Y28JHlWz/2ULa0B1A71h+r8eK/PY43a6d3FjY1xcCz0sGFF7mhxR9muDOGK0hTXZ7/Bhg8Rb402MyWNKCPLUc2XLdtBR4HosLlvevgrIJAF7DlWoWYfti9
x-ms-office365-filtering-correlation-id: 0a83a4fb-c93c-47c4-1f42-08d61aab60e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A8FBC9BE12628D59E627FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bpDAAqGS6n87/uFmcl/vPv2/lzWSO8h8mu7WgpnJLib6Q4zskQxJCSTZB7dyTusvt1GxIeCJxIMNIq6KfLLYhYMMOF2k/DZalx86c3X67qgj51iuLEYWC2KOwqxn/17NtyK1dhwNMiWIOMxkxYiiS4bUN0C8HQ93XyD7GVg/60FryQmAqNK5yNDzw9mcs0JklXx0DGJBptEgVqJokgbmsYC53V1e408AVgM+EX7pBBczKYuXWNbeoAmi0FcQOOITEXM5ehKKZ+MEm5JZaH5VmBP/X184P47SguJLSsWbjT6j5h1vja1ZZ8BCsByurHxroPt2TtMbE8EXl93Z0iS7E65rioMAqVFHAhXa83WkT5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a83a4fb-c93c-47c4-1f42-08d61aab60e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:28.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index bbc147cb5dec..abf53e67e3d8 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -215,7 +215,7 @@ struct crypto_alg *crypto_larval_lookup(const char *nam=
e, u32 type, u32 mask)
 	type &=3D mask;
=20
 	alg =3D crypto_alg_lookup(name, type, mask);
-	if (!alg) {
+	if (!alg && !(mask & CRYPTO_NOLOAD)) {
 		request_module("crypto-%s", name);
=20
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 8edb3ba6f640..9de26962338e 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -108,6 +108,11 @@
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
index bf663915412e..6fcbd8e99baf 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -94,7 +94,8 @@ static struct shash_desc *init_desc(char type)
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
