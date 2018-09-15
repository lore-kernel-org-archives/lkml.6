Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71053ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD12208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NvMkJ5qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD12208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIOGqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:46:54 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeIOGqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpVVfNhRG7ugKURAMYHgKv8aLT9/CI8T3fAXa0M1Axw=;
 b=NvMkJ5qqiMGMegfJFCpIJCsooEgHcth4rp+55ae7QwDYQV72h9eHVJSYvrM+dbUjI5bKVM1h9oX5HB8rrqTfBkDWvNKMTlgLiax+l9SJBbi82ECMcUEJrvCRw8H4Hx2h3t2w2Lm8VspA0xw2d/gTKugbtkLq5N5plLzTM28VYG4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ronny Chevalier <ronny.chevalier@hp.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 04/92] audit: fix use-after-free in
 audit_add_watch
Thread-Topic: [PATCH AUTOSEL 4.18 04/92] audit: fix use-after-free in
 audit_add_watch
Thread-Index: AQHUTJOZ47uJ8tbYO0+TXHiwwLk9ng==
Date:   Sat, 15 Sep 2018 01:29:51 +0000
Message-ID: <20180915012944.179481-4-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:iQxZ8rS2chwidpm2647As3L8+BqR2wz04faa6+QV82ynrOAw43CHvbcu3cxFwGhMSAc33oZEfff1p9tfuSfxlqV4xib20f8Nbq4o41N6xaFqkSbkCgOg9wNXjo6GHuFGATotv1l+/+UFn4MkAS/KpSZBsKRVTq7XQgmWIHFZo/WZly/tnaKJQdhfxt6lRCgeHpUDGQVjUJme53hte6uNS7DRayAmxJ6wja8Jo1wiOzvmOPEo8Hkm4bOOBqjH77h/Tgq51757wKo2cbPAlH0CTIyUKHz3jr02fzlaNI0/mZsRs/lPEXkI/d1z6ThiaPHBx3CEc1RDgB6SftcmdXfzkMSOby516gIa0yAH3nKVqgUXOKNofeQ1i6gJnNNMvZYgHxOgvfnaJNstAOwQIbvyWoibQVidkM4FZFcqsosLeY55wN4cCwrCye6n67IJ2Cflv/u68npqcpy2A4tAJuNCAg==;5:dq7ouXmWKSB9XS8skcEVsF489n8MZ8TFg0q7r/q2VWiMzRccHlOFZOVeZhXMm2M185zFK3Rt3tyJCIhuQAcb4r8+JgnS7Co9Y5YrSFvmMA960KJdUzkSo6iodozNDr6Z4vEjD1KrCnFxjODKahXuweewe2reJ8EAq7S5yXM8k2c=;7:lmr7Ngpyp0XczHkxW5LOqakrzVQqej44ZReKlih/TMQH/cT60Yf2JmGwpvUgMBrSKz4Po4AYw8+nkyG17pJmQklMOGpttz07W6OOZVaAueVqtjpIP7GD83FGRvov2q/AWnTJcHJ5oB4S5Ng7cHFabWSx6Y/Iu2QhQ6riZGEN8pGYn+YF+EH/JxSVCE2Wb0acXxiS/fl5CdAXlxGFMUBvc/5dlmR5ggzdz81Et5twLV9GJC+lM0X0fW8nXR2gJr6V
x-ms-office365-filtering-correlation-id: 7bb15392-b322-45f5-0bd2-08d61aaabbb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB084046D7D076F0BB19C59076FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(73583498263828);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(5024004)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(551544002)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4+ylZtUgEv3JgraT3PjmmVdy5hDhtJSoraDt6xfzAZKuoYJLeVK15az8g6xNFSpoVAMoZuhHCBovmO4EPNNVCkAdhPRbCVmQpa8ptejefUmKLUPzKszbmigfCEIw7sPHR7IieHVVA+mlpcq8WHhPulHGpfUmUPAjlA7OJ5g38pj6epEP2jHoXW3tPvaFiuRvX3TsajQbQlaPI+20X7hokrEkExkmTlYDgECoXnYGRX9z4yju5HmGF9STG5HJqb1OBtAHZJAfl5p7sBEvXDjl2yosXnTY6XPnONDTmYsIyxmOcTVvHw9eIWcUkcd4c4hrd9GaezQb0P7qpIMoQ7UO4OzKIziIGtNrsWmDWcvrl1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb15392-b322-45f5-0bd2-08d61aaabbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:51.4639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronny Chevalier <ronny.chevalier@hp.com>

[ Upstream commit baa2a4fdd525c8c4b0f704d20457195b29437839 ]

audit_add_watch stores locally krule->watch without taking a reference
on watch. Then, it calls audit_add_to_parent, and uses the watch stored
locally.

Unfortunately, it is possible that audit_add_to_parent updates
krule->watch.
When it happens, it also drops a reference of watch which
could free the watch.

How to reproduce (with KASAN enabled):

    auditctl -w /etc/passwd -F success=3D0 -k test_passwd
    auditctl -w /etc/passwd -F success=3D1 -k test_passwd2

The second call to auditctl triggers the use-after-free, because
audit_to_parent updates krule->watch to use a previous existing watch
and drops the reference to the newly created watch.

To fix the issue, we grab a reference of watch and we release it at the
end of the function.

Signed-off-by: Ronny Chevalier <ronny.chevalier@hp.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/audit_watch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index c17c0c268436..dce35e16bff4 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -419,6 +419,13 @@ int audit_add_watch(struct audit_krule *krule, struct =
list_head **list)
 	struct path parent_path;
 	int h, ret =3D 0;
=20
+	/*
+	 * When we will be calling audit_add_to_parent, krule->watch might have
+	 * been updated and watch might have been freed.
+	 * So we need to keep a reference of watch.
+	 */
+	audit_get_watch(watch);
+
 	mutex_unlock(&audit_filter_mutex);
=20
 	/* Avoid calling path_lookup under audit_filter_mutex. */
@@ -427,8 +434,10 @@ int audit_add_watch(struct audit_krule *krule, struct =
list_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
=20
-	if (ret)
+	if (ret) {
+		audit_put_watch(watch);
 		return ret;
+	}
=20
 	/* either find an old parent or attach a new one */
 	parent =3D audit_find_parent(d_backing_inode(parent_path.dentry));
@@ -446,6 +455,7 @@ int audit_add_watch(struct audit_krule *krule, struct l=
ist_head **list)
 	*list =3D &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
+	audit_put_watch(watch);
 	return ret;
 }
=20
--=20
2.17.1
