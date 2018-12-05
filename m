Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B2D2087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y4mLgFZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B2D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeLEJql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbeLEJqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:37 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271152087F;
        Wed,  5 Dec 2018 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003196;
        bh=P1lbBHUoqy0KgDF9ZV/4+l8tvYppUBPCfFbo6hNVeKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4mLgFZpNvx/Mjf+IbBm+x5JJcxlW5asM8XpXVVa3QTQ3NK12YVsmAR2LdDtoAXwE
         PjdZ1H4ccr3l8949sactV3g+bmcZBvCNHt0AXOu5QyVyOaNi+GdE/aHy3U1mj+m+iz
         m1e1CfUmHQPeXTp4GKNxrXm/mVZyzbDizVdikpkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 61/69] ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value
Date:   Wed,  5 Dec 2018 04:42:39 -0500
Message-Id: <20181205094247.6556-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit ea2412dc21cc790335d319181dddc43682aef164 ]

Running the Clang static analyzer on IORT code detected the following
error:

Logic error: Branch condition evaluates to a garbage value

in

iort_get_platform_device_domain()

If the named component associated with a given device has no IORT
mappings, iort_get_platform_device_domain() exits its MSI mapping loop
with msi_parent pointer containing garbage, which can lead to erroneous
code path execution.

Initialize the msi_parent pointer, fixing the bug.

Fixes: d4f54a186667 ("ACPI: platform: setup MSI domain for ACPI based
platform device")
Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index de56394dd161..ca414910710e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -547,7 +547,7 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
  */
 static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
 {
-	struct acpi_iort_node *node, *msi_parent;
+	struct acpi_iort_node *node, *msi_parent = NULL;
 	struct fwnode_handle *iort_fwnode;
 	struct acpi_iort_its_group *its;
 	int i;
-- 
2.17.1

