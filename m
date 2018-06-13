Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9EDD3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF90208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF90208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935686AbeFMSTg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:19:36 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:19857 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935123AbeFMSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:18:56 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 11:18:50 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 9FE8E409AB;
        Wed, 13 Jun 2018 11:18:54 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 6/7] vmw_balloon: fix VMCI use when balloon built into kernel
Date:   Wed, 13 Jun 2018 04:03:58 -0700
Message-ID: <20180613110359.109033-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613110359.109033-1-namit@vmware.com>
References: <20180613110359.109033-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when all modules, including VMCI and VMware balloon are built
into the kernel, the initialization of the balloon happens before the
VMCI is probed. As a result, the balloon fails to initialize the VMCI
doorbell, which it uses to get asynchronous requests for balloon size
changes.

The problem can be seen in the logs, in the form of the following
message:
	"vmw_balloon: failed to initialize vmci doorbell"

The driver would work correctly but slightly less efficiently, probing
for requests periodically. This patch changes the balloon to be
initialized using late_initcall() instead of module_init() to address
this issue. It does not address a situation in which VMCI is built as a
module and the balloon is built into the kernel.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6e0b09b79fb5..e9502a56aa4b 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1295,7 +1295,14 @@ static int __init vmballoon_init(void)
 
 	return 0;
 }
-module_init(vmballoon_init);
+
+/*
+ * Using late_initcall() instead of module_init() allows the balloon to use the
+ * VMCI doorbell even when the balloon is built into the kernel. Otherwise the
+ * VMCI is probed only after the balloon is initialized. If the balloon is used
+ * as a module, late_initcall() is equivalent to module_init().
+ */
+late_initcall(vmballoon_init);
 
 static void __exit vmballoon_exit(void)
 {
-- 
2.17.0

