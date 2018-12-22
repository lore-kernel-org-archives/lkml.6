Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA8CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CB521927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437702;
	bh=8k1BtfsxJfSCK8OUx5QWgqOt+QGS2Wp5mLs9ssrk9Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t0PLrS/NUc5hZDOTCgaqvs58J3Qb9UJ3MlODtCAfPVBbAZ894Z6Rl7ofoOrz79y9P
	 xvmCOkEcW6KgwFTBg0Mj3DV+CEJJ70wDW6pFxNWMZmNUmr8ffayZWlKZEvv91eufbA
	 +tlF4dWyQH2WhtC7tbtR8BxFuUTN1hyXHS/xcHXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbeLVAPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbeLVAPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:00 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BE82192D;
        Sat, 22 Dec 2018 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437700;
        bh=8k1BtfsxJfSCK8OUx5QWgqOt+QGS2Wp5mLs9ssrk9Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBQoCTkT4Gb2Ynm5dw6EFj2ABeblEA4GbnQ88EpmQCd59L5VqjsCNO2Yj+ZDSP6aT
         t/Fovt0Y3j5Fh+nOtKSbNobRRI+EH8zzb585QQt+0GSXsApGnUK0vZHnK9JFcymh6Z
         KVNh8BDGlVfxpSxn2TKSqkPMdjTMIGxBMDsCMqNA=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 01/11] ACPI / LPSS: Add guards against CONFIG_PCI
Date:   Sat, 22 Dec 2018 00:14:42 +0000
Message-Id: <20181222001452.7474-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now compile ACPI without PCI support. If code depends on CONFIG_PCI,
it needs to explicitly guard that piece.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpi_lpss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 5f94c35d165f..4148abcdf9ef 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -534,8 +534,11 @@ static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
 	dev = bus_find_device(&platform_bus_type, NULL, &data, match_hid_uid);
 	if (dev)
 		return dev;
-
+#ifdef CONFIG_PCI
 	return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
+#else
+	return NULL;
+#endif
 }
 
 static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
-- 
2.19.0

