Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0CEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B8E2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378917;
	bh=l37aqJNOKxj4jj6KYPCR6moiZ8hIl9Ypibh5fz8YXss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IccwSi90QFp9JzizxHQj5qcBasestDANo2v8iMvpc98dERdwqkxmLVnSK7S6/B9Ot
	 UftT6SICHLqBrefx5KIgsXQbGwFrVlENUDcZoVEXMABQlLNjarSfsqm0+e2aHoYbjf
	 7QUcbeZwRWiLUs0jq/XPrgGs5XZ0OqsjGho3V6EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbeLUHzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbeLUHzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F41821908;
        Fri, 21 Dec 2018 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378914;
        bh=l37aqJNOKxj4jj6KYPCR6moiZ8hIl9Ypibh5fz8YXss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD/Rds6GahO4OnDak9qUcYispzLapbGi+cswsHosF4azQGZ0er5EPDFlOpBZ2YIov
         UuWaMJWhB6csKuQm1phJ4Igag5Zu0ZCCJvsHRTlJC+0wg1l1fvXWRX/pMbJKKs10gM
         q5nG/v1Py93ER5/pTtM+15iDA6QPOK8lnEfT4leU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 09/10] driver core: drop use of BUS_ATTR()
Date:   Fri, 21 Dec 2018 08:54:41 +0100
Message-Id: <20181221075442.17109-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() so drop the last user of it from
the tree.  We had to "open code" it in order to prevent a function name
conflict due to the use of DEVICE_ATTR_WO() earlier in the file :(

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f10d56c61a46..575bd6d752bd 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -830,7 +830,14 @@ static ssize_t bus_uevent_store(struct bus_type *bus,
 	kobject_synth_uevent(&bus->p->subsys.kobj, buf, count);
 	return count;
 }
-static BUS_ATTR(uevent, S_IWUSR, NULL, bus_uevent_store);
+/*
+ * "open code" the old BUS_ATTR() macro here.  We want to use BUS_ATTR_WO()
+ * here, but can not use it as earlier in the file we have
+ * DEVICE_ATTR_WO(uevent), which would cause a clash with the with the store
+ * function name.
+ */
+static struct bus_attribute bus_attr_uevent = __ATTR(uevent, S_IWUSR, NULL,
+						     bus_uevent_store);
 
 /**
  * bus_register - register a driver-core subsystem
-- 
2.20.1

