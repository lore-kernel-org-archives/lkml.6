Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AADC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6AE208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544835801;
	bh=axETaXZqShzOpC2KwehXL02FzV0yWfAqT5VBHcQcOOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oAprFFfBR4638oTJQK+04VSZTj+GOtGrcSGrJpctw4QBI8YuXYkkgksB3/XwvOIDj
	 VYetCwwozkPZ5pi+Z/c1GpEJrDUjsHUkjopxlEMsKpFYBxIZu/oNg33cGQPsHw/hCc
	 Wj6rQqE8+oXVOTnNItPUrZcVGOIKUZFaqoLJ4UB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeLOBDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:03:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbeLOBDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 20:03:16 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.30.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B84208CC;
        Sat, 15 Dec 2018 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544835796;
        bh=axETaXZqShzOpC2KwehXL02FzV0yWfAqT5VBHcQcOOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUH3UlVhYU4IE41pyh4x0Lv2SUxNqPqmk2QPaMCfUiz0Q+wwWcAPq6Bphm3MvWcMh
         FYYHmfLqLQVlzTW4tue8+zsSeTePEY4xxuM57kxYmrRc2cljajlSeK6AXfaGV+hkpX
         sBT98lRkCdBjtd655tDzi3mKZ64ALERM1YxfltLU=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
Date:   Sat, 15 Dec 2018 01:02:47 +0000
Message-Id: <20181215010247.26101-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181215010247.26101-1-okaya@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/arm64/iort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..d0f68607efe6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1437,6 +1437,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
 {
+#ifdef CONFIG_PCI
 	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_node *parent;
 		struct acpi_iort_id_mapping *map;
@@ -1462,6 +1463,7 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
 			}
 		}
 	}
+#endif
 
 	return false;
 }
-- 
2.19.0

