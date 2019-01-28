Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C3521741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690358;
	bh=JRQOS//J0mJ33l4hDdReKyFJMspCjMv/lFBUUKZBNw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EtdhUoyzXsuWnYgWKW+SXFnqRY3uqOh29IAIuRzCJiw2UpIse84YDfQOJ96K81Ybi
	 ApyqGVPWgGm8yLsmTs+XGijFSEjQmc2vmswL4VJvPg7Mr2LZm7CCcXAP3BpNmCJNtC
	 skCazdp4+O/w09KEfioYqM/IKE6WbtJ17hFHd84A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfA1Pp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfA1Ppx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479892175B;
        Mon, 28 Jan 2019 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690352;
        bh=JRQOS//J0mJ33l4hDdReKyFJMspCjMv/lFBUUKZBNw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8mwT5n/YSTSQpMq+DcoC2xidhrwJWV3SQLTNxsW4QhJTS64M7EuoICpTPp6W2Epl
         IOf26R23NetX2IqRJTbmzlq+IRQRGM2aFc3/AOlhF9MN/SeZClyl5CI/DhOBu/yCtv
         2Sosj54z0muHhbgmt9AK11UZsOoosRQ/m/WvWWps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 061/304] scsi: cxgb4i: fix thermal configuration dependencies
Date:   Mon, 28 Jan 2019 10:39:38 -0500
Message-Id: <20190128154341.47195-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 8d0bb86e2cf6c96d88c3de56a2a29329872c454d ]

I fixed a bug by adding a dependency in the network driver, but that fix
caused a related bug in the SCSI driver:

WARNING: unmet direct dependencies detected for CHELSIO_T4
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_CHELSIO [=y] && PCI [=y] && (IPV6 [=y] || IPV6 [=y]=n) && (THERMAL [=m] || !THERMAL [=m])
  Selected by [y]:
  - SCSI_CXGB4_ISCSI [=y] && SCSI_LOWLEVEL [=y] && SCSI [=y] && PCI [=y] && INET [=y] && (IPV6 [=y] || IPV6 [=y]=n)
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_init':
cxgb4_thermal.c:(.text+0x158): undefined reference to `thermal_zone_device_register'
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_remove':
cxgb4_thermal.c:(.text+0x1d8): undefined reference to `thermal_zone_device_unregister'
/git/arm-soc/Makefile:1042: recipe for target 'vmlinux' failed

The same dependency needs to be propagated here to make it work correctly
with CONFIG_THERMAL=m and SCSI_CXGB4_ISCSI=y. That change by itself causes
another problem with a circular dependency, as we use 'select NETDEVICES'.
This is something we really should not do anyway, as a driver symbol should
never select another major subsystem, so let's turn that into a 'depends
on'. I don't see any downsides of that, as NETDEVICES is only disabled in
rather obscure cases that are not relevant to the users of cxgb4i.

Fixes: e70a57fa59bb ("cxgb4: fix thermal configuration dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/cxgb4i/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb4i/Kconfig b/drivers/scsi/cxgbi/cxgb4i/Kconfig
index 594f593c8821..f36b76e8e12c 100644
--- a/drivers/scsi/cxgbi/cxgb4i/Kconfig
+++ b/drivers/scsi/cxgbi/cxgb4i/Kconfig
@@ -1,8 +1,8 @@
 config SCSI_CXGB4_ISCSI
 	tristate "Chelsio T4 iSCSI support"
 	depends on PCI && INET && (IPV6 || IPV6=n)
-	select NETDEVICES
-	select ETHERNET
+	depends on THERMAL || !THERMAL
+	depends on ETHERNET
 	select NET_VENDOR_CHELSIO
 	select CHELSIO_T4
 	select CHELSIO_LIB
-- 
2.19.1

