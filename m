Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48162C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1931208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0CP2YqKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1931208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935032AbeFLQwl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933748AbeFLQwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:52:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B874208B7;
        Tue, 12 Jun 2018 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822358;
        bh=gMXUWmCTZZLdTKVuHeKQUgA+CgqDW/31abOciPmPt5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CP2YqKd3BUrBwASCLwGuK8sjjfE2Q8mmKPLDBck+5eawCznTh2Pu5oqGNSdU/UiS
         xsnJQUwwtjfbEllNpOAU0RONo/7q0GFt3SDm9a4I0S21S1+I15FO30ByUBbK7Khv9/
         DtPzSJ7GwCtLhgFW4DAaWt9JwXMDLYN7L+XCGEe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sonny Rao <sonnyrao@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.l.morris@oracle.com>
Subject: [PATCH 4.4 01/24] tpm: do not suspend/resume if power stays on
Date:   Tue, 12 Jun 2018 18:51:45 +0200
Message-Id: <20180612164816.651225293@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -324,8 +325,20 @@ static void tpm1_chip_unregister(struct
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
 	rc = tpm1_chip_register(chip);
 	if (rc)
 		return rc;
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -931,6 +931,9 @@ int tpm_pm_suspend(struct device *dev)
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
@@ -168,6 +168,7 @@ struct tpm_vendor_specific {
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_REGISTERED	= BIT(0),
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 };
 
 struct tpm_chip {


