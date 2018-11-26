Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8022089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu5pjX7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8022089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbeKZV77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZV76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510E820645;
        Mon, 26 Nov 2018 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230372;
        bh=Rcy/ACfKQ6TajDXJlT/RXg9Kq3AX1Qp9M1AAcnlXc+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zu5pjX7h594sdiSNyg6s+EhdJ/5KyL6IcpCew0GVIyAc2U1Z/vIPlnyEdEJzdIdu0
         KQXl5F5g/GOb7M/1QIOa9iN+1B40/KeJtn6tguZvIE6ntBYZgQO9P1d7oZBsKtJt08
         ZOGVLvQpelHqY5hDjRT97kMbcapEzTZApH7GrVDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 110/118] gnss: sirf: fix synchronous write timeout
Date:   Mon, 26 Nov 2018 11:51:44 +0100
Message-Id: <20181126105106.149092316@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 1decef370456870bf448a565be95db636428e106 upstream.

Passing a timeout of zero to the synchronous serdev_device_write()
helper does currently not imply to wait forever (unlike passing zero to
serdev_device_wait_until_sent()). Instead, if there's insufficient
room in the write buffer, we'd end up with an incomplete write.

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Cc: stable <stable@vger.kernel.org>     # 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gnss/sirf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -83,7 +84,7 @@ static int sirf_write_raw(struct gnss_de
 	int ret;
 
 	/* write is only buffered synchronously */
-	ret = serdev_device_write(serdev, buf, count, 0);
+	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
 	if (ret < 0)
 		return ret;
 


