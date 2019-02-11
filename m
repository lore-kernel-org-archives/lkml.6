Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4126D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896043;
	bh=g0L3fmG5qIHaFyy/ATDr4Vg8DTeLCXnP6oCMpA0GBBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9+C44kBb6v9IOpA5X14qjHnuqbMtERn3os+DhTIGx//Zs4Slu+Tw2GPpfKiqTfwi
	 uqv8Ys2JjL3hXCXDMfnkEk+JbeHtACo7l1czeJRIN2uaNFENEHqKta0l8l9tyzM71G
	 nBjZvKLXkeFGBMZDlsfvIDsJbWBo8DSh3JHQNUMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfBKOkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbfBKOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B6B2081B;
        Mon, 11 Feb 2019 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896033;
        bh=g0L3fmG5qIHaFyy/ATDr4Vg8DTeLCXnP6oCMpA0GBBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uid74dFoGjZjNTenA9OZ+m8PcFGaCEcAARQeR0F9rx29Keeu2W0OHp9oTxQ8AgvII
         y2I9zfjs2mEMMZQYmPw6KowOKPwUGJA11wvvmTKpvyvGjaMwNjsjqiMaRgnRQUT9xB
         1ZquoCoW8cWVPAIZfMeC2RDh3HMCmswlaRtgQAUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/313] media: rc: ensure close() is called on rc_unregister_device
Date:   Mon, 11 Feb 2019 15:15:30 +0100
Message-Id: <20190211141857.072327793@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8e782fcf78275f505194e767c515202d4fd274bc ]

If userspace has an open file descriptor on the rc input device or lirc
device when rc_unregister_device() is called, then the rc close() is
never called.

This ensures that the receiver is turned off on the nuvoton-cir driver
during shutdown.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 8b2c16dd58bd..0f218afdadaa 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1956,6 +1956,8 @@ void rc_unregister_device(struct rc_dev *dev)
 	rc_free_rx_device(dev);
 
 	mutex_lock(&dev->lock);
+	if (dev->users && dev->close)
+		dev->close(dev);
 	dev->registered = false;
 	mutex_unlock(&dev->lock);
 
-- 
2.19.1



