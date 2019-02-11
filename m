Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53712C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E0C222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895002;
	bh=qelTkmlH1hikdbUzc9HrblC18LJ8w7DphAuN+cxG2sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=guXW/GjOHL4celSk0dltC0+CcPpRQNTT9gDwL+9PA1JzYmbG4JinmlA3vFlrf/3SO
	 obODJdYNoHsisq7Daa+lpcFmSQYUStZFxh+20v2Ry31fXJFTPo+0ZbmHufoP4jIjWK
	 kPUPXOwV7k+rqpUC3EbZRcchCiXQU10YsquwU2hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfBKOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfBKOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C32E222A1;
        Mon, 11 Feb 2019 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894989;
        bh=qelTkmlH1hikdbUzc9HrblC18LJ8w7DphAuN+cxG2sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wK6Hcyob0iC2d32nJqMDzeyrwOeHhiyKtJ8X3rrO6B6LvGgEPl626HVYmGEr88pgU
         +v9Y1GdJnUt92PhZSMZcjDwYr/rbwT94KLLmrL31bt/JouTYoFoAr/2IwvWICEmlof
         Z2zKVSIrigQmxH9BDwMFqLA8IiEDvFnhzVIMprk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 055/352] scsi: cxgb4i: fix thermal configuration dependencies
Date:   Mon, 11 Feb 2019 15:14:42 +0100
Message-Id: <20190211141849.687479113@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



