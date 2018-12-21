Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7995AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456222190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378938;
	bh=YuSmsb1MKiy+xRvayHN/eGCi5cSU2isKBnRZaWKgI4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETOw27mn5LjGzmt1GTDG1sHhLEKsVRiPpg6+v2oXV58SRGbRHI2GC1GCufG26E9re
	 aII5rbvrsTjKJsJ9hq4CswP8Zlu4pliN/0kIuFvLWAnbWNywEv+VRt2H+cV5d6PUKI
	 F1ckRdUFVYXsLneI8uJfy1OIKL77WYcehmG0QhgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbeLUHzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbeLUHzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824ED21907;
        Fri, 21 Dec 2018 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378904;
        bh=YuSmsb1MKiy+xRvayHN/eGCi5cSU2isKBnRZaWKgI4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZRUviD8X2bO5B5x9jHoSDEHwrApIhGWxahON4R/RCBu06zxeWA2u5sjf0Xgf7peS
         YQEKSADG/fv4b0EJvX/SBWqaI9XOMDvbglFDlwIix6Xw89Qi6JbeeGcDOLZ/LnZEkk
         Hm1qBcD/RnxA6rLIfZYHea1gBs4xR+1Md7eWQILg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH 05/10] rapidio: rio-sysfs.c: convert to use BUS_ATTR_WO
Date:   Fri, 21 Dec 2018 08:54:37 +0100
Message-Id: <20181221075442.17109-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in
rio-sysfs.c can be trivially converted to use BUS_ATTR_WO(), so use that
instead.

Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rapidio/rio-sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index 73e4b407f162..ad5e303dda05 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -290,8 +290,7 @@ const struct attribute_group *rio_dev_groups[] = {
 	NULL,
 };
 
-static ssize_t bus_scan_store(struct bus_type *bus, const char *buf,
-				size_t count)
+static ssize_t scan_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	long val;
 	int rc;
@@ -314,7 +313,7 @@ static ssize_t bus_scan_store(struct bus_type *bus, const char *buf,
 
 	return rc;
 }
-static BUS_ATTR(scan, (S_IWUSR|S_IWGRP), NULL, bus_scan_store);
+static BUS_ATTR_WO(scan);
 
 static struct attribute *rio_bus_attrs[] = {
 	&bus_attr_scan.attr,
-- 
2.20.1

