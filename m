Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3A5204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8EdfLn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3A5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937571AbeFSOOp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:14:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51246 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeFSOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:14:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id r15-v6so672442wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yiHrwybgDoD6NSTa+4Xvi6OKaWvrnBtV7FJFuea5AcM=;
        b=D8EdfLn0nYXTOflE+hqV5fiz2HL1otIOUF2Fwx1u5xtkT4KeetE0wJahH+T1gK7Z7L
         IbLFA/ZJDPwMpfPOiWBFTR6mwsSiYxOJDG7cYAOE5L+2s1nJCztt3OTrlJok4RYlgd4j
         kYd/vULDRpOJI4+FaGw6aF7Sh6P6BT4stW7vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yiHrwybgDoD6NSTa+4Xvi6OKaWvrnBtV7FJFuea5AcM=;
        b=jHxuWOll3F7/Fm9Zom8/zv2FUNcFE0491qr6Dx3z+uofMxVJdued1TxcstRj/IJDVo
         lL0QYrw89+ABz0oL+0fsGEB6qnqvnToVnSMum91ry9EfBSpat6FjFXUETZ3wNIX9uRbz
         LXdZlCJlKlB5UTgGS4hw0bki6Pau+/rSrgltLEgGzCfN9e1zjZs4ZlkCN7yQxKhZ6uu7
         LWMXUVtaZ1aOG2w6Yx0NHaGWXkqBdTgS7xV1lM+mRJHBBOw1lF6ZFpJW35i16Rm+jeI7
         QmqPbnK/50IEYtkNNSi0Y1TYjGxYpYajKtWHYHbufEct+aGesXQG1u9tgOSOnkzSOKfd
         vThw==
X-Gm-Message-State: APt69E2NOrHZvMsYZpe/wUIQNJm1VObagbGTDOJBkoLzjmWbiLAVShHh
        CJauJYTyt+Xblhxb5gkiN1W9/Q==
X-Google-Smtp-Source: ADUXVKKoVYouWAwUo8dxYCO4PTMJT/PdZked+60itkQaNYiInrrf/350f3tVbiiXBzrANrbTwShOWw==
X-Received: by 2002:a1c:a54e:: with SMTP id o75-v6mr12472752wme.157.1529417682402;
        Tue, 19 Jun 2018 07:14:42 -0700 (PDT)
Received: from mai.localdomain (135-224-190-109.dsl.ovh.fr. [109.190.224.135])
        by smtp.gmail.com with ESMTPSA id 12-v6sm293197wmt.19.2018.06.19.07.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 07:14:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     oliver@neukum.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org (open list:USB CDC ETHERNET DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/usb/drivers: Remove useless hrtimer_active check
Date:   Tue, 19 Jun 2018 16:14:30 +0200
Message-Id: <1529417671-21384-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code does:

 if (hrtimer_active(&t))
    hrtimer_cancel(&t);

However, hrtimer_cancel() checks if the timer is active, so the
test above is pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/net/usb/cdc_ncm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 90d07ed..732ceff 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -967,8 +967,7 @@ void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 	atomic_set(&ctx->stop, 1);
 
-	if (hrtimer_active(&ctx->tx_timer))
-		hrtimer_cancel(&ctx->tx_timer);
+	hrtimer_cancel(&ctx->tx_timer);
 
 	tasklet_kill(&ctx->bh);
 
-- 
2.7.4

