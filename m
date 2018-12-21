Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8442190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378911;
	bh=fJsca7QpwGofdW2eDgslOkt1H5yD/LOf+1IJwsgQQoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLl59W/4cJieip/U/q+hnECFnsGHD9CmNKKCQsQF2PYjfUF/Kt4FH8f2kLFzWPrvI
	 rOcFhTlyMB3BSdz0KG7VgmkQ2IxOuIniq1MtVQPM2I2IKyWuR8W70JzLeX9BQLddWM
	 6OCuzdWimvvlWVuQwIVFIUAUCWBAd72JlwVTBsyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbeLUHzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733027AbeLUHzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11F421908;
        Fri, 21 Dec 2018 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378909;
        bh=fJsca7QpwGofdW2eDgslOkt1H5yD/LOf+1IJwsgQQoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLJCrX872yg9TtxVkiYqMBm1OzledK53KpPc7ojyq5KAmWpf3F/4ZieR2033G8YEd
         RbnaxEmMZey/5b6ha5uR5uYTe8YQbNwzICFjLY3uGVC9AT9NuCQnAk+/dyrJqEJrTO
         2oqFT/ClvqhmX5B5x1VPUFLJal7RD1FX4cMSmujM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 07/10] driver core: bus: convert to use BUS_ATTR_WO and RW
Date:   Fri, 21 Dec 2018 08:54:39 +0100
Message-Id: <20181221075442.17109-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in bus.c
can be trivially converted to use BUS_ATTR_WO and RW, so use those
macros instead.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27ec73d6..f10d56c61a46 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -233,12 +233,12 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(bind);
 
-static ssize_t show_drivers_autoprobe(struct bus_type *bus, char *buf)
+static ssize_t drivers_autoprobe_show(struct bus_type *bus, char *buf)
 {
 	return sprintf(buf, "%d\n", bus->p->drivers_autoprobe);
 }
 
-static ssize_t store_drivers_autoprobe(struct bus_type *bus,
+static ssize_t drivers_autoprobe_store(struct bus_type *bus,
 				       const char *buf, size_t count)
 {
 	if (buf[0] == '0')
@@ -248,7 +248,7 @@ static ssize_t store_drivers_autoprobe(struct bus_type *bus,
 	return count;
 }
 
-static ssize_t store_drivers_probe(struct bus_type *bus,
+static ssize_t drivers_probe_store(struct bus_type *bus,
 				   const char *buf, size_t count)
 {
 	struct device *dev;
@@ -583,9 +583,8 @@ static void remove_bind_files(struct device_driver *drv)
 	driver_remove_file(drv, &driver_attr_unbind);
 }
 
-static BUS_ATTR(drivers_probe, S_IWUSR, NULL, store_drivers_probe);
-static BUS_ATTR(drivers_autoprobe, S_IWUSR | S_IRUGO,
-		show_drivers_autoprobe, store_drivers_autoprobe);
+static BUS_ATTR_WO(drivers_probe);
+static BUS_ATTR_RW(drivers_autoprobe);
 
 static int add_probe_files(struct bus_type *bus)
 {
-- 
2.20.1

