Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D1ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8036020844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYRlRnJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8036020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeKIHoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731993AbeKIHoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:08 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D03920844;
        Thu,  8 Nov 2018 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714797;
        bh=gcqHY5aIm04UA8dEeIUVGNzUs+UaQ8PEG/qN3PZKjKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYRlRnJbDOeUABcZ3dRd0G7lSYqtyVSbrChsCloRUYSJGf22ZlSfDVzjmj0qpGxCs
         jWgJ6L4oOcH72igg7Cr18kQaMv5Ode9GecdFcXYuyyOFXjfrX4c6CTnf3Tzn7J88zN
         1P0yYOOGA+oQU1pguk0U95FvBooO1t+hQhe+s2uI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 106/171] iio: pressure: zpa2326: Remove always-true check which confuses gcc
Date:   Thu,  8 Nov 2018 13:51:16 -0800
Message-Id: <20181108215135.053360626@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -869,7 +869,6 @@ complete:
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



