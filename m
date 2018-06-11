Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QWVAFdePHlu7BgAAmS7hNA
	; Mon, 11 Jun 2018 15:10:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4BBFA60792; Mon, 11 Jun 2018 15:10:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9023D60791;
	Mon, 11 Jun 2018 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9023D60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbeFKPKy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:10:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbeFKPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:10:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSOT0-0007jk-Cw; Mon, 11 Jun 2018 15:10:46 +0000
From: Colin King <colin.king@canonical.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] cx18: remove redundant zero check on retval
Date: Mon, 11 Jun 2018 16:10:45 +0100
Message-Id: <20180611151045.22535-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for a zero retval is redundant as all paths that lead to
this point have set retval to an error return value that is non-zero.
Remove the redundant check.

Detected by CoverityScan, CID#102589 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/firewire/firedtv-fw.c  | 3 +++
 drivers/media/pci/cx18/cx18-driver.c | 2 --
 drivers/regulator/vctrl-regulator.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
index 92f4112d2e37..eed55be21836 100644
--- a/drivers/media/firewire/firedtv-fw.c
+++ b/drivers/media/firewire/firedtv-fw.c
@@ -271,6 +271,9 @@ static int node_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	name_len = fw_csr_string(unit->directory, CSR_MODEL,
 				 name, sizeof(name));
+	if (name_len < 0)
+		return name_len;
+
 	for (i = ARRAY_SIZE(model_names); --i; )
 		if (strlen(model_names[i]) <= name_len &&
 		    strncmp(name, model_names[i], name_len) == 0)
diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 8f314ca320c7..0c389a3fb4e5 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -1134,8 +1134,6 @@ static int cx18_probe(struct pci_dev *pci_dev,
 free_workqueues:
 	destroy_workqueue(cx->in_work_queue);
 err:
-	if (retval == 0)
-		retval = -ENODEV;
 	CX18_ERR("Error %d on initialization\n", retval);
 
 	v4l2_device_unregister(&cx->v4l2_dev);
diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index 78de002037c7..044e5a5ca163 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -340,7 +340,7 @@ static int vctrl_init_vtable(struct platform_device *pdev)
 		}
 	}
 
-	if (rdesc->n_voltages == 0) {
+	if (rdesc->n_voltages <= 0) {
 		dev_err(&pdev->dev, "invalid configuration\n");
 		return -EINVAL;
 	}
-- 
2.17.0
