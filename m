Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD869ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FF721476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dyxURCDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FF721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeIOGtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:39 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIOGti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZztS8UPZhAd5qS+eiuYKdZMvDrdYN0zK9wBG4qh/tQ=;
 b=dyxURCDGaCYVN/068tlnFdbK79gtoJdBcUcutSbvnPLbE50M3pBFhuwJWrBIGOvf65jJVXYn7Z3o3LUSgpZfZUxyO2mkFT6RfHC0jZ/KoaoCwxxZLAkeIgf4CyuMpIrLWyXBcuGAQ4TztE68t4PwQ2hW5Jr6UcBUWzFa9Z7v658=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/57] evm: Don't deadlock if a crypto algorithm
 is unavailable
Thread-Topic: [PATCH AUTOSEL 4.14 09/57] evm: Don't deadlock if a crypto
 algorithm is unavailable
Thread-Index: AQHUTJP5ScVZgrYlV02RVhSe8C0p7A==
Date:   Sat, 15 Sep 2018 01:32:33 +0000
Message-ID: <20180915013223.179909-9-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:r8Kdce3f1ztwWF4u3vusOx2gy/6oPBiXV/rGqxgt7SiDPtOUWwwtMf0fCQ7key5GJJmLQ2Be0ndI8M1Ta5VPyCwQa+9WegzpssnuqgjliP95bA9Dg7n4JC++aVukaD7HgeEL/73u50DTv3b4X1arZPBbh1krgYiAnYe4nGPmdJ7Y7+JgyIVTjgKm0P2I/tmgun6NcqEAOH6+/qk+knz8rGe+ApdnWSzxm7LzFvBDvQKUHPLS9rVgtTv1wkDmW91Omiawsh3MP+FOBtiqOZDZ6WEwly6LnIQs2Qaq2ZJ4K5gCt5XyTuq27zqmMQxfAQw8J7v6/eWmix06v1OI0WjSLHZ2uhJeDJ4uN9CcpTfOwf7kOiwSyj4Au4u9+z3EUuAf2eyjp48XxGB9ZxAGGQaSsvRyPfqkCyRW5Ta09Yu1s2CetVtfF2+0GQ1MDXrJ4rxdHqm0PYgUJyJBcBs1dMeP3w==;5:zCFeMVdOKrydlduA/vYBRnUNU8I1PdigUvYAMoSJfvtIu66et7wqThNdmVr+wNzkFiLq4Hvm9MiUcp9wBNbiHZnkqHlQXkr/SvtwARUF7UaQlllj8Jh1OhqY0gPuK5f0xfDtReIByI8XxBwoLAYv/MzEwEEGNvio/rsCkgf1UQU=;7:OEoo4scLnPDUd0MA1xRrVKtmSr87/NYBmKZHNRKz/sfOoDqXWwLsVwszHXXhFVliOwiWeEGhNi+n5DqC1K8cMl23UuB3I4t555mUH8VuZlMqOArU33aSj0NM1JVaqyjudkRzC2zKrDsY0NWepyFLJ/csB1SBgbCiBpn8M0l3N2o46wyJHuE5jm0b1mPp/HNUqZUD5ODGX9k4Jiglq58VUtK7JqnfM0g77/4ZGjlGBJDDfP7kZLqRd7BIGSkzHqHK
x-ms-office365-filtering-correlation-id: b8e04a31-565c-42cf-9dc5-08d61aab1c32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117386B4B860901347BB066FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fIn4r6PbUuMWTo+RF5YWJ3DwKbRd529DSB2pm5puWc80LqxBSt1tU22oPpKBhWHTcb3fziTVXwo39elfqcXxx7d0kHBL5qd8IbD3L7S40mAaBsCA1xN8AB3nS14D7b5c7TIFr8gW6I0c3SwrB6kH7nzvzU889vdRcDZjBOHN9Kj2Dq9qT6Ao6GDew6/VBy1PbDgXFFyjoCyShjtwhaegIm7bF9RuYSONKhLJlJz1vSD0eg2rB6bXO99acjGQQXQNiio2sHERai1RN2AdYcm5qWEr+YBYZyZ2o+9RI3uwOn42W1HPxLPFVm0d68qz5zAbVtZXmpOaDujKVMHSMeQJQbis2d60c9xzG/ywd64ajL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e04a31-565c-42cf-9dc5-08d61aab1c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:33.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
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
index 941cd4c6c7ec..e485aed11ad0 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -215,7 +215,7 @@ struct crypto_alg *crypto_larval_lookup(const char *nam=
e, u32 type, u32 mask)
 	mask &=3D ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
=20
 	alg =3D crypto_alg_lookup(name, type, mask);
-	if (!alg) {
+	if (!alg && !(mask & CRYPTO_NOLOAD)) {
 		request_module("crypto-%s", name);
=20
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index cc36484d29e1..de96913306cb 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -111,6 +111,11 @@
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
index 1d32cd20009a..ee9c3de5065a 100644
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
