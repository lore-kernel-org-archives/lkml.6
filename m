Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2DC2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="orJvgWJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2DC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeJYWtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbeJYWtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:14 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C56120873;
        Thu, 25 Oct 2018 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476978;
        bh=wBNPEWtv6T/j7rurlSdvWIibf7CadOZB8p1sPX6dvwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orJvgWJjo0aJqI86u4keVW7fQV7ALbfhUH8NbFMD6bRFywmkimTcWTmsa3+AqQgtS
         aADRRJ9YwNAZNU82S7WDpGYAg5QhAWoUlyKKBT3c7FXkSiROme7+J41GrKH6df0k+w
         WBbN62Uo72hRnTMSG59FACAgdWUCNHE3Mv5FhaRk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 78/98] iio: pressure: zpa2326: Remove always-true check which confuses gcc
Date:   Thu, 25 Oct 2018 10:14:03 -0400
Message-Id: <20181025141423.213774-78-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit f61dfff2f5b9fcb087bf5c444bc44b444709588f ]

With gcc 4.1.2:

    drivers/iio/pressure/zpa2326.c: In function ‘zpa2326_wait_oneshot_completion’:
    drivers/iio/pressure/zpa2326.c:868: warning: ‘ret’ may be used uninitialized in this function

When testing for "timeout < 0", timeout is already guaranteed to be
strict negative, so the branch is always taken, and ret is thus always
initialized.  But (some version of) gcc is not smart enough to notice.

Remove the check to fix this.
As there is no other code in between assigning the error codes and
returning them, the error codes can be returned immediately, and the
intermediate variable can be dropped.
Drop the "else" to please checkpatch.

Fixes: e7215fe4d51e69c9 ("iio: pressure: zpa2326: report interrupted case as failure")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/zpa2326.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 2a4a62ebfd8d..cc002b958f7e 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -869,7 +869,6 @@ static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
 static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 					   struct zpa2326_private *private)
 {
-	int          ret;
 	unsigned int val;
 	long     timeout;
 
@@ -891,14 +890,11 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 		/* Timed out. */
 		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
 			     timeout);
-		ret = -ETIME;
-	} else if (timeout < 0) {
-		zpa2326_warn(indio_dev,
-			     "wait for one shot interrupt cancelled");
-		ret = -ERESTARTSYS;
+		return -ETIME;
 	}
 
-	return ret;
+	zpa2326_warn(indio_dev, "wait for one shot interrupt cancelled");
+	return -ERESTARTSYS;
 }
 
 static int zpa2326_init_managed_irq(struct device          *parent,
-- 
2.17.1

