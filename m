Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8F1C5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2D208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA2D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935703AbeFMSTx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:19:53 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:19857 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935478AbeFMSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:18:56 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 11:18:50 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8F355409BF;
        Wed, 13 Jun 2018 11:18:54 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 4/7] vmw_balloon: do not use 2MB without batching
Date:   Wed, 13 Jun 2018 04:03:56 -0700
Message-ID: <20180613110359.109033-5-namit@vmware.com>
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

If the hypervisor sets 2MB batching is on, while batching is cleared,
the balloon code breaks. In this case the legacy mechanism is used with
2MB page. The VM would report a 2MB page is ballooned, and the
hypervisor would only take the first 4KB.

While the hypervisor should not report such settings, make the code more
robust by not enabling 2MB support without batching.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
---
 drivers/misc/vmw_balloon.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 496607a9046a..db3cf91a515d 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -339,7 +339,13 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 		success = false;
 	}
 
-	if (b->capabilities & VMW_BALLOON_BATCHED_2M_CMDS)
+	/*
+	 * 2MB pages are only supported with batching. If batching is for some
+	 * reason disabled, do not use 2MB pages, since otherwise the legacy
+	 * mechanism is used with 2MB pages, causing a failure.
+	 */
+	if ((b->capabilities & VMW_BALLOON_BATCHED_2M_CMDS) &&
+	    (b->capabilities & VMW_BALLOON_BATCHED_CMDS))
 		b->supported_page_sizes = 2;
 	else
 		b->supported_page_sizes = 1;
-- 
2.17.0

