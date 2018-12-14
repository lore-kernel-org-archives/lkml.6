Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DF5C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9863220892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790488;
	bh=QNUdkI9vkEgU9ZOaJXfWKLjG2I5QINYYI9/obGYZXNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dui4hi0qoNNfrdCnQL+ZInWF5fEM9gRN7dJMrK6a/V/TG3/s9e40uM983lPFhX+sa
	 UhVIVn5JVubovg93eQfKF1eKZyW21BmVgWRrA8KxwB+uPPbjmpMxFNP/g9Jtu1XO8a
	 7GBq7GGXugaQ6PKmqobVu9bkBDz7D9kSeL1qJ3hs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9863220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeLNM2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbeLNMLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4360F214DE;
        Fri, 14 Dec 2018 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789461;
        bh=QNUdkI9vkEgU9ZOaJXfWKLjG2I5QINYYI9/obGYZXNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtpjb1GD/pgvmNY0clYn53Tfk8fvuVzEm6KI0oZE9AvFrbACtF5F7cROHHM7zPkui
         7rs6n3lmq8SMC5J3ThM5X/5sPXUvIN+WS8l38ESPWCUjDVJL9UOnvwaHkJW9a5gOkk
         CmVsEZR0BeU5gS4O2G8VwN25+fU0/++1cJLyButU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Bellasi <patrick.bellasi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 72/89] ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value
Date:   Fri, 14 Dec 2018 13:00:25 +0100
Message-Id: <20181214115733.231713591@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



