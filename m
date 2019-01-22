Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7CEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F0720684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167264;
	bh=xiQaeRHzgaae2MnGqyHq2QXKoL9k9FF497FB3myi43o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OjQsd5PA5sQpHa9KqlYSMMjLqGRU/CISieFXuqTjIeHHd+8IhW0YZ5do9z4WMwnn3
	 FI2qb9pyY2L48aPj0Ymhx1RBeNxQNswENyHioK1bVsc6LMNMNv59zVO4YnlzU7UIfH
	 bmpcoJWR9GDi96a2QIrGZCUKJ3tA6MnHDMcHUgKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfAVO1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbfAVO1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:27:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3891D20684;
        Tue, 22 Jan 2019 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167257;
        bh=xiQaeRHzgaae2MnGqyHq2QXKoL9k9FF497FB3myi43o=;
        h=Date:From:To:Cc:Subject:From;
        b=Pqefch3IT5uZS9t8Tf+oulocDuMsGK4OScmIM1TjT+j9Hat9wn8k8biSi3lck+UKt
         rZai9kmwTBWfhDoMhvKT8nMXMo7I0E3txEOWd3l6ipxawSaFKA8PG3+QUUJrDt6qcT
         Xrte6rBA605Enqx7tJYBvSY3p2syD/OFJwt7o1V4=
Date:   Tue, 22 Jan 2019 15:27:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2] SCSI: fcoe: convert to use BUS_ATTR_WO
Message-ID: <20190122142735.GB18225@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in the fcoe
driver can be trivially converted to use BUS_ATTR_WO(), so use that
instead.

Cc: Johannes Thumshirn <jth@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Made simpler with wrapper functions to call the "real" show/store
    functions, thanks to James for the idea.
    Removed the EXPORT_SYMBOL() removal line, that belongs in a separate
    patch

 drivers/scsi/fcoe/fcoe_sysfs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 5c8310bade61..c3dcbdc3aa64 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -671,8 +671,19 @@ static const struct device_type fcoe_fcf_device_type = {
 	.release = fcoe_fcf_device_release,
 };
 
-static BUS_ATTR(ctlr_create, S_IWUSR, NULL, fcoe_ctlr_create_store);
-static BUS_ATTR(ctlr_destroy, S_IWUSR, NULL, fcoe_ctlr_destroy_store);
+static ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
+				 size_t count)
+{
+	return fcoe_ctlr_create_store(bus, buf, count);
+}
+static BUS_ATTR_WO(ctlr_create);
+
+static ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
+				  size_t count)
+{
+	return fcoe_ctlr_destroy_store(bus, buf, count);
+}
+static BUS_ATTR_WO(ctlr_destroy);
 
 static struct attribute *fcoe_bus_attrs[] = {
 	&bus_attr_ctlr_create.attr,
-- 
2.20.1

