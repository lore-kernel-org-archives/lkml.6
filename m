Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72E520672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDOVcX/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72E520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbeKZV75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZV74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C7120645;
        Mon, 26 Nov 2018 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230370;
        bh=advodw+5iWFCmAj4eQ7U9bIGeoP3OKlSgjDGEhQKeiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDOVcX/AG+KiOkldXfmNjhCEIrE25EGP4ZhDoV2DdzKb6oq3CpXHKVOw91C2eMUej
         WtXdXXWGfChJQ5gRIGyLiMHcFkVCacyQEb+hXOlkM5Y/8RNP1xOixca66CwtN3tz4b
         PgefqsbvqMeymGM+z7aZ1b0WuWZ1SavKDAdDZCf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 109/118] gnss: serial: fix synchronous write timeout
Date:   Mon, 26 Nov 2018 11:51:43 +0100
Message-Id: <20181126105106.086743620@linuxfoundation.org>
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

commit 56a6c7268312cba9436b84cac01b3e502c5c511d upstream.

Passing a timeout of zero to the synchronous serdev_device_write()
helper does currently not imply to wait forever (unlike passing zero to
serdev_device_wait_until_sent()). Instead, if there's insufficient
room in the write buffer, we'd end up with an incomplete write.

Fixes: 37768b054f20 ("gnss: add generic serial driver")
Cc: stable <stable@vger.kernel.org>     # 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gnss/serial.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 
@@ -63,7 +64,7 @@ static int gnss_serial_write_raw(struct
 	int ret;
 
 	/* write is only buffered synchronously */
-	ret = serdev_device_write(serdev, buf, count, 0);
+	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
 	if (ret < 0)
 		return ret;
 


