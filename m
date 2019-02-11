Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD373C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E920838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895455;
	bh=GAQHXKYCus6kzfE8npf8N/mWqU7J1VcDwLbyFb9HHX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hl++O3uhRH1vJ70MwRtoVJ9krTz8r4TkH47/lA+Ra+MvO2jtCGMyIjyaxs4O+srQ/
	 MdYgkptlYdVZrx0C5or+BsTjgGrLebmxw8imm5Pnf3zyGXPALfwrS1O7lz3Zq9QoDi
	 6frlc2QiaV5sf9cGQ7yDc0tEsFbce23TBq0Q4yys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfBKOay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfBKOaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E6120844;
        Mon, 11 Feb 2019 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895451;
        bh=GAQHXKYCus6kzfE8npf8N/mWqU7J1VcDwLbyFb9HHX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQfZ4Ma7dcsZWu+SlO+1dZ8uriaT8NHGLrtmpWgKWcDKv6//D57l+NZbcy/aYzAgi
         mSxWej75F7v/cc8x9hHwTIHBoF1ss9q+dBiji9rHmhtxK3GLH5/XMWIa+zofUamiSC
         wcCNxUqq9QaQ8mYnJVQsz3VvMv3ZLuNhFRtmQw8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 208/352] Bluetooth: hci_bcm: Handle deferred probing for the clock supply
Date:   Mon, 11 Feb 2019 15:17:15 +0100
Message-Id: <20190211141900.404024176@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 28ac03b9ac3f784c2f048a910c8d0a7a87483b66 ]

On some systems that actually have the bluetooth controller wired up
with an extra clock signal, it's possible the bluetooth controller
probes before the clock provider. clk_get would return a defer probe
error, which was not handled by this driver.

Handle this properly, so that these systems can work reliably.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a0ceb..800132369134 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -907,6 +907,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
+	/* Handle deferred probing */
+	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->clk);
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1



