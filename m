Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E9CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4B920857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOiYVuSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4B920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeKIIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:14:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbeKIHgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:23 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9807C21019;
        Thu,  8 Nov 2018 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714335;
        bh=1wRNKoTmLwbpXecmCjnfxJuvRxzWvFbGa3IUOorHxb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOiYVuSRHOH7YsxKQEyebncwS48Xo2ASLtUczP+mIkWrd0NUqkXawDlPsR/bFo42f
         ljhp3FTPy4Z+S+tWSvbtlpqq954jwiM+LfK1S7S72OdQBg/nYnW1RGv4AONbmk0iXg
         tFGOsw5FUxR5IjxYy93XAM7Kj0aISisI2TaNAMpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Tilman Schmidt <tilman@imap.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 022/114] ser_gigaset: use container_of() instead of detour
Date:   Thu,  8 Nov 2018 13:50:37 -0800
Message-Id: <20181108215101.164658460@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d2c3ab4445640957d136caa3629857d63544a2a ]

The purpose of gigaset_device_release() is to kfree() the struct
ser_cardstate that contains our struct device. This is done via a bit of
a detour. First we make our struct device's driver_data point to the
container of our struct ser_cardstate (which is a struct cardstate). In
gigaset_device_release() we then retrieve that driver_data again. And
after that we finally kfree() the struct ser_cardstate that was saved in
the struct cardstate.

All of this can be achieved much easier by using container_of() to get
from our struct device to its container, struct ser_cardstate. Do so.

Note that at the time the detour was implemented commit b8b2c7d845d5
("base/platform: assert that dev_pm_domain callbacks are called
unconditionally") had just entered the tree. That commit disconnected
our platform_device and our platform_driver. These were reconnected
again in v4.5-rc2 through commit 25cad69f21f5 ("base/platform: Fix
platform drivers with no probe callback"). And one of the consequences
of that fix was that it broke the detour via driver_data. That's because
it made __device_release_driver() stop being a NOP for our struct device
and actually do stuff again. One of the things it now does, is setting
our driver_data to NULL. That, in turn, makes it impossible for
gigaset_device_release() to get to our struct cardstate. Which has the
net effect of leaking a struct ser_cardstate at every call of this
driver's tty close() operation. So using container_of() has the
additional benefit of actually working.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Acked-by: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/gigaset/ser-gigaset.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/isdn/gigaset/ser-gigaset.c b/drivers/isdn/gigaset/ser-gigaset.c
index 74bf1a17ae7c..b90776ef56ec 100644
--- a/drivers/isdn/gigaset/ser-gigaset.c
+++ b/drivers/isdn/gigaset/ser-gigaset.c
@@ -373,13 +373,7 @@ static void gigaset_freecshw(struct cardstate *cs)
 
 static void gigaset_device_release(struct device *dev)
 {
-	struct cardstate *cs = dev_get_drvdata(dev);
-
-	if (!cs)
-		return;
-	dev_set_drvdata(dev, NULL);
-	kfree(cs->hw.ser);
-	cs->hw.ser = NULL;
+	kfree(container_of(dev, struct ser_cardstate, dev.dev));
 }
 
 /*
@@ -408,7 +402,6 @@ static int gigaset_initcshw(struct cardstate *cs)
 		cs->hw.ser = NULL;
 		return rc;
 	}
-	dev_set_drvdata(&cs->hw.ser->dev.dev, cs);
 
 	tasklet_init(&cs->write_tasklet,
 		     gigaset_modem_fill, (unsigned long) cs);
-- 
2.17.1



