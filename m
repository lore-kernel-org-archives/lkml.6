Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DEEECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7208921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O3XCVXow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7208921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbeITI3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:36 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbeITI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xevxpSBj+1lsyKCdV3jqfxzXAh8uGsruSg/ju/ebkBM=;
 b=O3XCVXowjryr+Xarb2e/GsCYPeArIIVRLS4BhRAI4fkR1JswZFhSoRI1OV2pKo+NS7ZsLT8dyk5LT4Ug/I3hQ/8buAe/9370Pg3m2/nO8/bpBuy4uefeaGlpRT4U3SEA+/sr/vsZRIKOc5tzrBlmSbwEe7v+wb2BidIXX+YZeV8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ganesh Goudar <ganeshgr@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 41/56] crypto: chtls - fix null dereference
 chtls_free_uld()
Thread-Topic: [PATCH AUTOSEL 4.18 41/56] crypto: chtls - fix null dereference
 chtls_free_uld()
Thread-Index: AQHUUIxVoqNRTgmOIEG25NMb5irK4w==
Date:   Thu, 20 Sep 2018 02:47:55 +0000
Message-ID: <20180920024716.58490-41-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:h60YzVmOV2M284wzidKckoJmGQhJjr6aDjdVzgKeTfhI7DRvJhbTQwlraDXqEhNWheDe2ACaAOba/UWdB0LhNHVbWmTJjnT9Lhzeb7n+Pi5Idz/WE/Ae7Fdjiw3pQpFG6hg6sPALkEct3d3ByHYXNHMRufWGJD1TtFmmxdcJ/7Fk97VsTYvK8+cJ37wg31TrXvrwjwNMa62OiN1ltozG2vZ9+TG6o333wf5oADoEVKllsdgo81933jfyBMc0WFDs2xazdK0EKQzyJP4uR6hlYe5wL8l7TApUFmmuiRurUBMxBvMh/6u4DiTsPNr/UPgiB7qRWd4g2F5QmjgExrnnlKCyKRowwdNysvMKvR8we/tvU/qFKAwHBkEQeg9avULMzc4DSXY6QrEkVx+k3NWd1H3FNb+qZ5QGVJJ5fRlz3tCjWAfU3eHOmdMksCwc8WrTAEbVZpm+Jv0ZzEObwJqz4w==;5:iaZdAoE2AgQCXXl2F4DcLsyAf/x4qrfsc7D10jFeXgpYLpZtVoBpAgjHk2IWucZbD8JLQJ00NwxoU4KNW+gMb7yjwLOJlbJopJIrLbhTKbKD/8WyGho9f30Eb7p/jCPcEF7Gr4Yz/81FoN+5HJZ9mf6yGTFau2FOnlJHhi+J2Dc=;7:SFdjD2AuPgcrxwhsHDe6urIABDfN/ID6+4y/YMlLsJWgJ195ERpmKdwk5jjDRPvRxO99QxnvNGrqkNFcKWSPIfqPwVMBMo2fUkiDH2SROTIdFPouD9oT+VczUiUo/ZIl0oJ0jrC2oi6IQp/TKb6t7u+oCJIIrKOtNwRtx6O+hB6ffCegVDem43UsW3DUd8CoN927zKjLK/Txiu1dzMfnVxMVpXNCpl334yVhFktjdG+G2hJ+O7UumO+diNls/0y/
x-ms-office365-filtering-correlation-id: 1728e81b-e6b2-4226-55b8-08d61ea38934
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165CF857B86365B96C09E22FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(575784001)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 18mdvVTsoPt6D9lTRUFTazVlX2I4gLKdEdALfadRQn4MO8VBNhy1uDcNjkLENaSE4R0RZysT1khVZvccSKsY7dHhz0ATmuNiuCnkUhwnGqV6EE1TtMbY9FPulKRyaXqSZgEnH6Ri1cUityydbqxZl66h3x5XvwZYhkQNtFHFyJLDyz++45ziP7RtJXXcJA4UeEvtYLTnvOmsmgBN1oXF+V8o60LMvq1yUJj8egO+gSadltl54IXCL84e6L/LY1mNkQmlNu6ji88gNyfKMyE4I6mN3fsSCIw8M+SyY8MNduTROjO+DBnlDOBJY0rFxxX7Eb+AA4J8YY+SVerrEd8m6v7ac0EpqioBskYNOlTWQEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1728e81b-e6b2-4226-55b8-08d61ea38934
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:55.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit 65b2c12dcdb883fc015c0ec65d6c2f857e0456ac ]

call chtls_free_uld() only for the initialized cdev,
this fixes NULL dereference in chtls_free_uld()

Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/chelsio/chtls/chtls.h      | 5 +++++
 drivers/crypto/chelsio/chtls/chtls_main.c | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls.h b/drivers/crypto/chelsio/=
chtls/chtls.h
index a53a0e6ba024..7725b6ee14ef 100644
--- a/drivers/crypto/chelsio/chtls/chtls.h
+++ b/drivers/crypto/chelsio/chtls/chtls.h
@@ -96,6 +96,10 @@ enum csk_flags {
 	CSK_CONN_INLINE,	/* Connection on HW */
 };
=20
+enum chtls_cdev_state {
+	CHTLS_CDEV_STATE_UP =3D 1
+};
+
 struct listen_ctx {
 	struct sock *lsk;
 	struct chtls_dev *cdev;
@@ -146,6 +150,7 @@ struct chtls_dev {
 	unsigned int send_page_order;
 	int max_host_sndbuf;
 	struct key_map kmap;
+	unsigned int cdev_state;
 };
=20
 struct chtls_hws {
diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/che=
lsio/chtls/chtls_main.c
index 9b07f9165658..f59b044ebd25 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -160,6 +160,7 @@ static void chtls_register_dev(struct chtls_dev *cdev)
 	tlsdev->hash =3D chtls_create_hash;
 	tlsdev->unhash =3D chtls_destroy_hash;
 	tls_register_device(&cdev->tlsdev);
+	cdev->cdev_state =3D CHTLS_CDEV_STATE_UP;
 }
=20
 static void chtls_unregister_dev(struct chtls_dev *cdev)
@@ -281,8 +282,10 @@ static void chtls_free_all_uld(void)
 	struct chtls_dev *cdev, *tmp;
=20
 	mutex_lock(&cdev_mutex);
-	list_for_each_entry_safe(cdev, tmp, &cdev_list, list)
-		chtls_free_uld(cdev);
+	list_for_each_entry_safe(cdev, tmp, &cdev_list, list) {
+		if (cdev->cdev_state =3D=3D CHTLS_CDEV_STATE_UP)
+			chtls_free_uld(cdev);
+	}
 	mutex_unlock(&cdev_mutex);
 }
=20
--=20
2.17.1
