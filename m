Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BDA20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762203;
	bh=m9fdeNZRLMRbJHxCMq7mE8GBUwTAQ/fUg81CaIGxtRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEQ6M1gVNz0bQvrpwZIrEtwR/T1kDK/gYKoCjuBiAM+tHDcg7t/sbUEkBgSwtw0aJ
	 UAQC4EFcmK72lCQ6HG7jvGIAzgKsGWn/pKLqclQDYZgPSYHYRZKWzmbiZjBIZ0ns0N
	 OjejpEch0QuNLucOh+8uvxA8aAPckn5lfBXb3l48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfA2LnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbfA2LnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 423E020856;
        Tue, 29 Jan 2019 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762197;
        bh=m9fdeNZRLMRbJHxCMq7mE8GBUwTAQ/fUg81CaIGxtRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqAbTomPGRVVTkp0TIPwzc9Ax7nzUDLr/fYh4if1MD5QgLnWHHl9cpo5AE/O3PERQ
         1RnF/OQ/HPC8L46PydZo6NJJvG1OiRO7n9HfcdXx7wKCV0LLkq8M+qY05vHaNQ+diQ
         l3u/7k3BhW6AwyjQXdb981T+G61URRk479E1uYTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Camelia Groza <camelia.groza@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 006/103] net: phy: phy driver features are mandatory
Date:   Tue, 29 Jan 2019 12:34:43 +0100
Message-Id: <20190129113159.909710200@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camelia Groza <camelia.groza@nxp.com>

[ Upstream commit 3e64cf7a435ed0500e3adaa8aada2272d3ae8abc ]

Since phy driver features became a link_mode bitmap, phy drivers that
don't have a list of features configured will cause the kernel to crash
when probed.

Prevent the phy driver from registering if the features field is missing.

Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
Reported-by: Scott Wood <oss@buserror.net>
Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    5 +++++
 include/linux/phy.h          |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1917,6 +1917,11 @@ int phy_driver_register(struct phy_drive
 {
 	int retval;
 
+	if (WARN_ON(!new_driver->features)) {
+		pr_err("%s: Driver features are missing\n", new_driver->name);
+		return -EINVAL;
+	}
+
 	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
 	new_driver->mdiodrv.driver.name = new_driver->name;
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -491,8 +491,8 @@ struct phy_device {
  *   only works for PHYs with IDs which match this field
  * name: The friendly name of this PHY type
  * phy_id_mask: Defines the important bits of the phy_id
- * features: A list of features (speed, duplex, etc) supported
- *   by this PHY
+ * features: A mandatory list of features (speed, duplex, etc)
+ *   supported by this PHY
  * flags: A bitfield defining certain other features this PHY
  *   supports (like interrupts)
  *


