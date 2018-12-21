Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34D321908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378925;
	bh=UGfBCverM3/gkvacUDJ6VnIAzbzOzQQ7f3moUi8nBx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FN/Zd25sdMIzVsucZJ+7kTgsWzzEkiPO7Wm1hNk/HlhoQB3tp6gQuqGpvdu7aJ77t
	 oJYTFKLQeAYBnEfsdBjeoOoDr2lsfo73v+CR4qSQZeHOQDuvs0Qi1OMgeShr57bsbJ
	 6ljaOfKSVTL+4D9lPdETNpLXP3DzCLO1AxHc80cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbeLUHzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbeLUHzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B4E21908;
        Fri, 21 Dec 2018 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378919;
        bh=UGfBCverM3/gkvacUDJ6VnIAzbzOzQQ7f3moUi8nBx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dD0BOFX77inUmVbjFTIAh2tej2lIE4Ep9uHLcAbZZ8B5cHfZkX2Mwi0H0qLKg6WYu
         iVBeVw49oMRxUFKtyjc5LnCtBL7ZPs7wMJFINK2g2DIoV0DWPwJbIrGCjGEW8a5YCv
         gyZiq+zL+xJR1yRHPos47YCaCYW67IaSO6r+D/k8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 03/10] SCSI: fcoe: convert to use BUS_ATTR_WO
Date:   Fri, 21 Dec 2018 08:54:35 +0100
Message-Id: <20181221075442.17109-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in the fcoe
driver can be trivially converted to use BUS_ATTR_WO(), so use that
instead.

At the same time remove a unneeded EXPORT_SYMBOL() marking for the sysfs
callback function we are renaming, no idea of how that got into the
tree...

Cc: Johannes Thumshirn <jth@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fcoe/fcoe_sysfs.c     | 4 ++--
 drivers/scsi/fcoe/fcoe_transport.c | 7 ++-----
 include/scsi/libfcoe.h             | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 5c8310bade61..3c23b2624bd4 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -671,8 +671,8 @@ static const struct device_type fcoe_fcf_device_type = {
 	.release = fcoe_fcf_device_release,
 };
 
-static BUS_ATTR(ctlr_create, S_IWUSR, NULL, fcoe_ctlr_create_store);
-static BUS_ATTR(ctlr_destroy, S_IWUSR, NULL, fcoe_ctlr_destroy_store);
+static BUS_ATTR_WO(ctlr_create);
+static BUS_ATTR_WO(ctlr_destroy);
 
 static struct attribute *fcoe_bus_attrs[] = {
 	&bus_attr_ctlr_create.attr,
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index f4909cd206d3..9edf82efda15 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -754,8 +754,7 @@ static int libfcoe_device_notification(struct notifier_block *notifier,
 	return NOTIFY_OK;
 }
 
-ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
-			       const char *buf, size_t count)
+ssize_t ctlr_create_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	struct net_device *netdev = NULL;
 	struct fcoe_transport *ft = NULL;
@@ -817,8 +816,7 @@ ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
 	return count;
 }
 
-ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
-				const char *buf, size_t count)
+ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	int rc = -ENODEV;
 	struct net_device *netdev = NULL;
@@ -855,7 +853,6 @@ ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
 	mutex_unlock(&ft_mutex);
 	return rc;
 }
-EXPORT_SYMBOL(fcoe_ctlr_destroy_store);
 
 /**
  * fcoe_transport_create() - Create a fcoe interface
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index cb8a273732cf..44536f095681 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -405,10 +405,8 @@ int fcoe_transport_attach(struct fcoe_transport *ft);
 int fcoe_transport_detach(struct fcoe_transport *ft);
 
 /* sysfs store handler for ctrl_control interface */
-ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
-			       const char *buf, size_t count);
-ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
-				const char *buf, size_t count);
+ssize_t ctlr_create_store(struct bus_type *bus, const char *buf, size_t count);
+ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf, size_t count);
 
 #endif /* _LIBFCOE_H */
 
-- 
2.20.1

