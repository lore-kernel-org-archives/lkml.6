Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 58F58C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F449208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuIhBP4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F449208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeFLQrI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933658AbeFLQrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C595B208B7;
        Tue, 12 Jun 2018 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822024;
        bh=b6MqsFIolh2cC0xEiDR+DasF7ff+Rzf/X9TgFgYz6Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EuIhBP4Hsp8kZK0TZAjZ4L3lko4TJP9KgVwtqDbT89oD6KHExlvf/qizmNmZcboh0
         nwPRzE4kNreoBALyIKoGDvmOzdlUg9hbdqVvBxPhpOBj5fKSn/RmNBfaFhMhbbwJLN
         DiV11ZUcv8yUv14YvE0K2mrEvdSxEc+4Vc519uGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sonny Rao <sonnyrao@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.l.morris@oracle.com>
Subject: [PATCH 4.9 01/31] tpm: do not suspend/resume if power stays on
Date:   Tue, 12 Jun 2018 18:46:04 +0200
Message-Id: <20180612164620.851660109@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit b5d0ebc99bf5d0801a5ecbe958caa3d68b8eaee8 upstream.

The suspend/resume behavior of the TPM can be controlled by setting
"powered-while-suspended" in the DTS. This is useful for the cases
when hardware does not power-off the TPM.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c      |   13 +++++++++++++
 drivers/char/tpm/tpm-interface.c |    3 +++
 drivers/char/tpm/tpm.h           |    1 +
 3 files changed, 17 insertions(+)

--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
 #include <linux/major.h>
+#include <linux/of.h>
 #include "tpm.h"
 #include "tpm_eventlog.h"
 
@@ -388,8 +389,20 @@ static int tpm_add_legacy_sysfs(struct t
  */
 int tpm_chip_register(struct tpm_chip *chip)
 {
+#ifdef CONFIG_OF
+	struct device_node *np;
+#endif
 	int rc;
 
+#ifdef CONFIG_OF
+	np = of_find_node_by_name(NULL, "vtpm");
+	if (np) {
+		if (of_property_read_bool(np, "powered-while-suspended"))
+			chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
+	}
+	of_node_put(np);
+#endif
+
 	if (chip->ops->flags & TPM_OPS_AUTO_STARTUP) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
 			rc = tpm2_auto_startup(chip);
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -969,6 +969,9 @@ int tpm_pm_suspend(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
+		return 0;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		tpm2_shutdown(chip, TPM2_SU_STATE);
 		return 0;
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -143,6 +143,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
 	TPM_CHIP_FLAG_IRQ		= BIT(2),
 	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 };
 
 struct tpm_chip {


