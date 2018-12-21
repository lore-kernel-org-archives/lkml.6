Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C49C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7DF21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378941;
	bh=J0psXfa86rOzlA166rW8pNvz6ajlRowQgAtfKrUOEp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xwr12DHMIz6EbM/C4J+rXegkhIVERQuYn1WcMOYGo1s9TiS0bJfL03Q1vu905Qy0N
	 w9HEFIqk3wwupSlxGHb87tLchFk4aWuURzWTlpAtTHVezefi+6k0p0B7GbmMTcARFb
	 hQhpOan23bueoOF85CaGveMFy4QPm91vVzoyjwz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbeLUHzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732764AbeLUHzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F02D7218F0;
        Fri, 21 Dec 2018 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378901;
        bh=J0psXfa86rOzlA166rW8pNvz6ajlRowQgAtfKrUOEp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OD47cnoJPRR+BngQBdx2Lj6oAE825tnGWUXPQWc4/WJ2+2OE+gSI0/8CFLw9rv/tg
         fb8Wuu7PJBqIW0Z/bkMyN/y86shkjSawyB7EmkM0G+QJf9LL+gat951dPLLKiz9vSe
         kFR+jISM7ECYJhwTlEGyLZ1TFguBhK8ZzLCRADGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 04/10] pseries: ibmebus.c: convert to use BUS_ATTR_WO
Date:   Fri, 21 Dec 2018 08:54:36 +0100
Message-Id: <20181221075442.17109-5-gregkh@linuxfoundation.org>
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
ibmebus.c can be trivially converted to use BUS_ATTR_WO(), so use that
instead.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 5b4a56131904..84e8ec4011ba 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -261,8 +261,7 @@ static char *ibmebus_chomp(const char *in, size_t count)
 	return out;
 }
 
-static ssize_t ibmebus_store_probe(struct bus_type *bus,
-				   const char *buf, size_t count)
+static ssize_t probe_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	struct device_node *dn = NULL;
 	struct device *dev;
@@ -298,10 +297,9 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 		return rc;
 	return count;
 }
-static BUS_ATTR(probe, 0200, NULL, ibmebus_store_probe);
+static BUS_ATTR_WO(probe);
 
-static ssize_t ibmebus_store_remove(struct bus_type *bus,
-				    const char *buf, size_t count)
+static ssize_t remove_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	struct device *dev;
 	char *path;
@@ -325,7 +323,7 @@ static ssize_t ibmebus_store_remove(struct bus_type *bus,
 		return -ENODEV;
 	}
 }
-static BUS_ATTR(remove, 0200, NULL, ibmebus_store_remove);
+static BUS_ATTR_WO(remove);
 
 static struct attribute *ibmbus_bus_attrs[] = {
 	&bus_attr_probe.attr,
-- 
2.20.1

