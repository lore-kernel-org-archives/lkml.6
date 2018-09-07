Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081E2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1322083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LmskFvZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1322083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeIGFOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:34 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728631AbeIGFOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciyE/5GD5XCPUfW8fG3dtLZbby/TpI0RCPFueftICK4=;
 b=LmskFvZM4ZGTCPrqO/UUy+nd2ZTIx94mzGqr1uM1doOkiPUz9e/4iCzEwQsJ2tvw9EQrQgtbeFn7BwnxkbX1MRnR74q+ymzcn0V3ggcNTg32aSkPurHfAEmEPa0tX09TZ/WEjLA3leyfrVQOg1RSyfWspuxE6U1Sbrbw+fYxTuU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 13/88] nfp: don't fail probe on
 pci_sriov_set_totalvfs() errors
Thread-Topic: [PATCH AUTOSEL 4.18 13/88] nfp: don't fail probe on
 pci_sriov_set_totalvfs() errors
Thread-Index: AQHURkLB67M3wOeHKEW8r9PgnkoKTQ==
Date:   Fri, 7 Sep 2018 00:36:02 +0000
Message-ID: <20180907003547.57567-13-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:a6xAlLqq542Galqc7Y5plHuIZJORFzty7uMttDkYafYfEdcNn5/GJ6zjpz57AqEE0274RN+2UX8Ml8AcHv0v/f8QvWxmxWxxtKUmerLzyMVPiyl/3rF3/I5Cluc4BD2sHMh9Sw1J1hPXP3W5JlFAM9ftzAHRXzq0spC78e8y3FHafTzSu36ktYN0PK3C4tOlmv6n8ngVceOG1477jJtNZz8N7oKXLP53W6PIHmC9YJ5KEXGtE1cAS4cTabV+rsj6M5btfh08y2SeYTyXmnpyaNw1BkFLv+E/7mjx4NXKjOEN4yZuJoO8FzsQZfN5VuDxAqajRqmLxuC3o+GSyu0FKzga1maG9ImcmFBiE6+/C88Kj9K22EFSQNNo406uvgP/2V91pO1PIzmzM5yDBGO/eh9ob8ih8/gkaZ4y//Kw4TKyALJ5apXkOzm5EUJU129PlXE6Qq1QJZCCFFgwblomvg==;5:cCjFLmg5vdKVjIQqCLfwfD8rjMRR1VMGGshfR6Kmu4xqVlrRrZJzaYNZdJt5UmXNRNBceBaClQZb8nGvCEzsEK0x8LyI6Gr42ITKctE/7jvlsE4I2UTvKEt/whxB6I60Cz7qVoYlLO2DWAhB5xBMWzGIH9o/n/OF7rD3Ssh0iIE=;7:MJngZXlyw8nmin/zrzE4AEJMYdNd0jKdrBwJRo4epgvI2Gj60sKbvvlr1F7MosamMvQvUVr8uEq0PEQ8zxejj7QiDsRvPE84PnVK7G8hjdfKjwLnsvhaeobK8GBjWnlF7F7EbBDqGeazovDVPKZR8+MVn9OdRdiJ8XSbCTw9zVLmdWu6hRb8RGshgxOylpkImTiEH263hTwEsIHJEOjWwJmqy2pUczsZEyoz2AkCCYkrqr4ZLiXOsRAWZZ9zNpzL
x-ms-office365-filtering-correlation-id: 867ecd31-48fd-4f01-43b1-08d61459e3ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773D02FCF8F837BC87010CAFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(39060400002)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zaw1x4yyakurdrW9kBBXIDCoegyR4Dp2vO4bCoQPqLZBXlQmSwVA86j7fOyDD92bBcjFc0642G3MtjG18FYK1G19H6SXvjIM3UkCjPG+75mnslH8+19O6Tab1QlHvUpmTYr46kmMKF25eMxIxCfJwZsvMObFSjQRlWiTxB4wLDWczmu1xPkyCIJeRUR8iLbFhBfNN81F46enZ30xFnjq1V9sABN/op/fMetI34d563GKk9lfC9t+SQrhoYiaUCSDkRKV6m1o5rtOojn51mqzK/+vcD7cUNRabcxanr8aDZdqDNKtYYeld+2sVHdzdaY5Yp33/52aAtFMrqR+xS2dC4lm1kJdqj9RxmQNqb7hroU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867ecd31-48fd-4f01-43b1-08d61459e3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:02.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 5b0ced17edc5710d4e946392d0f2934a9e07b37f ]

On machines with buggy ACPI tables or when SR-IOV is already enabled
we may not be able to set the SR-IOV VF limit in sysfs, it's not fatal
because the limit is imposed by the driver anyway.  Only the sysfs
'sriov_totalvfs' attribute will be too high.  Print an error to inform
user about the failure but allow probe to continue.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/et=
hernet/netronome/nfp/nfp_main.c
index 152283d7e59c..4a540c5e27fe 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -236,16 +236,20 @@ static int nfp_pcie_sriov_read_nfd_limit(struct nfp_p=
f *pf)
 	int err;
=20
 	pf->limit_vfs =3D nfp_rtsym_read_le(pf->rtbl, "nfd_vf_cfg_max_vfs", &err)=
;
-	if (!err)
-		return pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
+	if (err) {
+		/* For backwards compatibility if symbol not found allow all */
+		pf->limit_vfs =3D ~0;
+		if (err =3D=3D -ENOENT)
+			return 0;
=20
-	pf->limit_vfs =3D ~0;
-	/* Allow any setting for backwards compatibility if symbol not found */
-	if (err =3D=3D -ENOENT)
-		return 0;
+		nfp_warn(pf->cpp, "Warning: VF limit read failed: %d\n", err);
+		return err;
+	}
=20
-	nfp_warn(pf->cpp, "Warning: VF limit read failed: %d\n", err);
-	return err;
+	err =3D pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
+	if (err)
+		nfp_warn(pf->cpp, "Failed to set VF count in sysfs: %d\n", err);
+	return 0;
 }
=20
 static int nfp_pcie_sriov_enable(struct pci_dev *pdev, int num_vfs)
--=20
2.17.1
