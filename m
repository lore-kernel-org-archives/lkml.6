Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F3FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104D1205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393993AbfAPPRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:17:31 -0500
Received: from shell.v3.sk ([90.176.6.54]:57068 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387431AbfAPPR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:17:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 43CB3540A9;
        Wed, 16 Jan 2019 16:17:26 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cjR6TINRMZv7; Wed, 16 Jan 2019 16:17:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 140EF54103;
        Wed, 16 Jan 2019 16:17:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u2DKbvkraSoo; Wed, 16 Jan 2019 16:17:23 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 93383540A9;
        Wed, 16 Jan 2019 16:17:23 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mfd: cs5535-mfd: remove ifdef OLPC noise
Date:   Wed, 16 Jan 2019 16:17:10 +0100
Message-Id: <20190116151709.1972303-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<asm/olpc.h> provides machine_is_olpc() stub for CONFIG_OLPC=3Dn,
compiler should just optimize the unneeded bits away.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mfd/cs5535-mfd.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index f9d277ff4aaf..2e77b6147baa 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -112,22 +112,10 @@ static struct mfd_cell cs5535_mfd_cells[] =3D {
 	},
 };
=20
-#ifdef CONFIG_OLPC
-static void cs5535_clone_olpc_cells(void)
-{
-	static const char *acpi_clones[] =3D {
-		"olpc-xo1-pm-acpi",
-		"olpc-xo1-sci-acpi"
-	};
-
-	if (!machine_is_olpc())
-		return;
-
-	mfd_clone_cell("cs5535-acpi", acpi_clones, ARRAY_SIZE(acpi_clones));
-}
-#else
-static void cs5535_clone_olpc_cells(void) { }
-#endif
+static const char *olpc_acpi_clones[] =3D {
+	"olpc-xo1-pm-acpi",
+	"olpc-xo1-sci-acpi"
+};
=20
 static int cs5535_mfd_probe(struct pci_dev *pdev,
 		const struct pci_device_id *id)
@@ -157,7 +145,9 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
 		goto err_disable;
 	}
-	cs5535_clone_olpc_cells();
+
+	if (machine_is_olpc())
+		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_c=
lones));
=20
 	dev_info(&pdev->dev, "%zu devices registered.\n",
 			ARRAY_SIZE(cs5535_mfd_cells));
--=20
2.20.1

