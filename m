Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE46C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC57222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897009;
	bh=Zj2DHOpdqQY4xH6knWsKWdJdJP13iv1HURZUA4v0Ayg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLyBGaOdDr01A1PVltlTG9qrWSaCaK7AZpkazSY2hb0tVTa7XmIt2uPg+tO7rVa+G
	 I6wWkWmx0FfBe6ZEHy3hPXeCIeHsp96JHwPPjo5Q7d9MdIXDTHWaJx2hTlCkkMJcHb
	 dC+opNi3lVoPGykNb9zWg/isyIqcD3O0mdd/eZC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfBKO4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388720AbfBKO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F44222A6;
        Mon, 11 Feb 2019 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897004;
        bh=Zj2DHOpdqQY4xH6knWsKWdJdJP13iv1HURZUA4v0Ayg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvxJR47uive2NRZ0VEwOUlSOrunY+k+/gWgFNB0N36cFy71TyN+gmEAvCW8xOr4X3
         U6rrbdgwf9Dhsn3nDQs8P6wP5UMmoWOajnbFzbGv2bNNbqhJspKsNePbTUJKNipsOP
         sx2277jSYokR8vPzQJINjvItO4JuU+ZbD1Oq3QqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 060/205] media: DaVinci-VPBE: fix error handling in vpbe_initialize()
Date:   Mon, 11 Feb 2019 15:17:38 +0100
Message-Id: <20190211141832.732693973@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aa35dc3c71950e3fec3e230c06c27c0fbd0067f8 ]

If vpbe_set_default_output() or vpbe_set_default_mode() fails,
vpbe_initialize() returns error code without releasing resources.

The patch adds error handling for that case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpbe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/davinci/vpbe.c
index 7f6462562579..1d3c13e36904 100644
--- a/drivers/media/platform/davinci/vpbe.c
+++ b/drivers/media/platform/davinci/vpbe.c
@@ -739,7 +739,7 @@ static int vpbe_initialize(struct device *dev, struct vpbe_device *vpbe_dev)
 	if (ret) {
 		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to set default output %s",
 			 def_output);
-		return ret;
+		goto fail_kfree_amp;
 	}
 
 	printk(KERN_NOTICE "Setting default mode to %s\n", def_mode);
@@ -747,12 +747,15 @@ static int vpbe_initialize(struct device *dev, struct vpbe_device *vpbe_dev)
 	if (ret) {
 		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to set default mode %s",
 			 def_mode);
-		return ret;
+		goto fail_kfree_amp;
 	}
 	vpbe_dev->initialized = 1;
 	/* TBD handling of bootargs for default output and mode */
 	return 0;
 
+fail_kfree_amp:
+	mutex_lock(&vpbe_dev->lock);
+	kfree(vpbe_dev->amp);
 fail_kfree_encoders:
 	kfree(vpbe_dev->encoders);
 fail_dev_unregister:
-- 
2.19.1



