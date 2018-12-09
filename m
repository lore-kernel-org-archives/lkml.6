Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828BBC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5146F20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5146F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeLIWN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37992 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbeLIWN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:56 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73P-0002ic-Eh; Sun, 09 Dec 2018 21:55:59 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003FT-Gc; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Nicholas Mc Guire" <hofrat@osadl.org>,
        "Wei Xu" <xuwei5@hisilicon.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.646975569@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 042/328] ARM: hisi: handle of_iomap and fix missing
 of_node_put
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit d396cb185c0337aae5664b250cdd9a73f6eb1503 upstream.

Relying on an unchecked of_iomap() which can return NULL is problematic
here, an explicit check seems mandatory. Also the call to
of_find_compatible_node() returns a device node with refcount incremented
therefor an explicit of_node_put() is needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 22bae4290457 ("ARM: hi3xxx: add hotplug support")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/mach-hisi/hotplug.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -137,13 +137,20 @@ static int hi3xxx_hotplug_init(void)
 	struct device_node *node;
 
 	node = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (node) {
-		ctrl_base = of_iomap(node, 0);
-		id = HI3620_CTRL;
-		return 0;
+	if (!node) {
+		id = ERROR_CTRL;
+		return -ENOENT;
 	}
-	id = ERROR_CTRL;
-	return -ENOENT;
+
+	ctrl_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!ctrl_base) {
+		id = ERROR_CTRL;
+		return -ENOMEM;
+	}
+
+	id = HI3620_CTRL;
+	return 0;
 }
 
 void hi3xxx_set_cpu(int cpu, bool enable)

