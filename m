Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B92AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389F2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500939;
	bh=8k1BtfsxJfSCK8OUx5QWgqOt+QGS2Wp5mLs9ssrk9Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T0oORwxAu8LOZwYujLZZmQRnFBGjKwFCbpdxVB50NrX6TNvOv8sX35YJSi41HXhU5
	 K0UWzZfGab2REHuqJReHmfgjnZelWnyPDraw1ppcUkw4S3zrdk5e/pSe4i7fj5TGgC
	 lp9H6czMAnXKeZ3wXGB0jDpXI4uKlW+KnTH7NY7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392770AbeLVRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389945AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.9.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EAA021980;
        Sat, 22 Dec 2018 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545469646;
        bh=8k1BtfsxJfSCK8OUx5QWgqOt+QGS2Wp5mLs9ssrk9Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyrgRHkOeC/6rr0m0yQ62RTeyD+BJA2qd08DRqWJl+6MUGqvidFwBEo7n+RtttPk3
         REU7PPMk62i8PwKOmhkmE44+HUqZD9pVYxEdQ7lv9sEjk9GiIC7i1hN40lfX3ShWcx
         kc/jz2d3/8hh2VRWrcQ8aMaRaN/TbGubPEZ1CCzM=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/11] ACPI / LPSS: Add guards against CONFIG_PCI
Date:   Sat, 22 Dec 2018 09:07:10 +0000
Message-Id: <20181222090720.19234-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
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

