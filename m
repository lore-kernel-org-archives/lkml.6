Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1979C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA91213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA91213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJIX1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:27:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbeJIX1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:27:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1ED98ADE3;
        Tue,  9 Oct 2018 16:10:01 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen: drop writing error messages to xenstore
Date:   Tue,  9 Oct 2018 18:09:59 +0200
Message-Id: <20181009160959.31076-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xenbus_va_dev_error() will try to write error messages to Xenstore
under the error/<dev-name>/error node (with <dev-name> something like
"device/vbd/51872"). This will fail normally and another message
about this failure is added to dmesg.

I believe this is a remnant from very ancient times, as it was added
in the first pvops rush of commits in 2007.

So remove the additional message when writing to Xenstore failed as
a minimum step.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
I am considering removing the Xenstore write altogether, but I'm
not sure it isn't needed e.g. by xend based installations. So please
speak up in case you know why this write is there.
---
 drivers/xen/xenbus/xenbus_client.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index a1c17000129b..e17ca8156171 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -278,10 +278,8 @@ static void xenbus_va_dev_error(struct xenbus_device *dev, int err,
 	dev_err(&dev->dev, "%s\n", printf_buffer);
 
 	path_buffer = kasprintf(GFP_KERNEL, "error/%s", dev->nodename);
-	if (!path_buffer ||
-	    xenbus_write(XBT_NIL, path_buffer, "error", printf_buffer))
-		dev_err(&dev->dev, "failed to write error node for %s (%s)\n",
-			dev->nodename, printf_buffer);
+	if (path_buffer)
+		xenbus_write(XBT_NIL, path_buffer, "error", printf_buffer);
 
 	kfree(printf_buffer);
 	kfree(path_buffer);
-- 
2.16.4

