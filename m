Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E912ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A71E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nu4kx09E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A71E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeIOGv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:29 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728642AbeIOGv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H/uDpkovNTK1/cXE576YTIXjSF6/wLraM9HKgIg7mI=;
 b=Nu4kx09EjiNxhi7rXgg+tpo9fY9Al1Mj/yidacUHEHW1nAV0hHK6D1oHD2X8FzIR2RZyKmTQ7vSgUz0tavX6LygfzyvCEEIeXFbnXgjBxZse79zdNAgD/lGRpvgvhypIDw6WyWn2KUU5BL/o7ygAbqcWMkuqWQL8jAg+JHSPPoQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ronny Chevalier <ronny.chevalier@hp.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/34] audit: fix use-after-free in
 audit_add_watch
Thread-Topic: [PATCH AUTOSEL 4.9 02/34] audit: fix use-after-free in
 audit_add_watch
Thread-Index: AQHUTJQ9PK6/5lQUIUe4pIolJTdvhA==
Date:   Sat, 15 Sep 2018 01:34:26 +0000
Message-ID: <20180915013422.180023-2-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:YVJvcg2myhnVHj0mTPYlUQpNQ7LXV2XZEFLK3nu7hu4SUVDiv5FW24rIvcSiMKM8nZMdcunTgTXHF+ptj3nbRzaLHhoX2OEfTXGPrUQbkQ7eXVfFo4cYgFX6gQfwHyMBSyaZYifxW0JVBAV3dnmKSyDdGHsfalT/Phif8tcKg6U9UgH/mlzk4hJsOToTetpZxU2RYBErkxWSfUYuPd8TjKvW9vv9ym860w4alaMXuouWECqj2Im2KopM0DmekeH18RkqUAzQ7c01ixrhMyinG/VAkBxpQRb1Yb1CraB+MJhJd2UHKFRanIIjvzE1bFPYhAIC0TMgtIdBajiDcPkjdD3eyc7AUO4m5TMqN/L/aLNRqC8xNUd8443sRJXT6T2dpHygzfSLD1Pqh//cVrBL6GcJ8loWbakQGv4/llsg8n4qN3zuDTQD6pQ0hK4J1FHcVu1F7BwjwBJCZ2T7hKyXWw==;5:+aO6Le+zuUg9q8dy0647RzSTg8ise5x3uw3ox3Tb9qsvzt0gA+vdrkIbYEp1R5jgQXCGl7rWcUKipSTC2kpHlsKX4HjidSE2Tvu+vePY+SJ/YUkkHXgEBca6Cl9Lkoy5U+Lr4GlFOzdKKtuz0M5+md6FEGWZlHK8tbD/061a/cY=;7:MQkHhyB30EypFFRMXj652ZwVSeeoV3uGTABdf1AWJWH6Z9p227AYf/GoFzvnKdZs4m7c2Q0he0u7eqNEdSLrR0BZhHqVksEIjDWOzzVvyhR5cpIEFBTgMcO/i/UMrqyfECOz5AmnpEz4zf+5LQi22t4Tnf2uhSNrql42HaREpIIkKCll7yk3pDPcjuy+FEIDfVsHddBpGhoOCjZZ6N5J8J4HzMnRJVkntQSTxZQuD8ZQgnZuZFeGiZCo28bzqmDn
x-ms-office365-filtering-correlation-id: cd9c6fb8-a2b4-4333-90c6-08d61aab5fd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855CF170C187D0DEDFBA722FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(73583498263828);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5024004)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(551544002)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UWNnVMXOVfTGi2mCHPMjBvEs4G4qGtsovSxUV914V1kyETi/XCYfWmDjzE8SWG2TqomMGb8iyRG3xP3yRAen2ZLUi47Ubpxn2oJJtWjwAFlekfkYLhhRLtZ4+78UvITp5qbDXT2G6wXY47p63/Lc4WEsvRQvqbufywlI5V/7zcKucssU7qqPP5RzYfncvord+gSuRmZO7JrEME2DqsWlgxOr23MI2aI2mThrDdUulQOEjveBCNyaGmYbOFbjuCQ5Jlbyoy4QCtqZIcxfZOHprBBbO9a7LiFUfF8P4E1XkusAlUgOjQV7DXIhzKNFnHqjPywn8UgPAfK8BoLdr3zFOmzHEkdiO5pZK4yy0Iz3uI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9c6fb8-a2b4-4333-90c6-08d61aab5fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:26.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 690e1e3c59f7..f036b6ada6ef 100644
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
