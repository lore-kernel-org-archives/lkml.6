Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D6EC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B7720882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7bvI1Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B7720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbeG3ABs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 20:01:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeG3ABs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 20:01:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so802247wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7RC4Vj7QqvT3awHXNjKpq1wj3R0ios9S4af+iLQ/i8=;
        b=k7bvI1Ljoa+rybMrz5Dwez7Tr7LC07r457WtkpDOC5DlXCzdx4Tz0T516wBt2J4z45
         yZwfEr0mHZfxLumFB9WOE9SOIaTAOgHtik9nQWXHpGL8Xp6ZcXGoqY/n/GZXNSmE29Qg
         zhsfNcln2q7utubsuimT/37EQNXpe5hqoDSOOprXsnu88OagEneh1/0RmdseWHpWajcM
         gZ8/aHlyHde6DheCMxzo1tt84ykfTqZEqoaLqKlGHGhc4atTlkU84ZcLA9eHhBCqAizm
         gIM4f7FH1nHJJFtvumZclkYL0pJoEYXbSs4QW4SEljcAwUp6xv+04r/p8JNPSTls0m1Z
         lowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7RC4Vj7QqvT3awHXNjKpq1wj3R0ios9S4af+iLQ/i8=;
        b=m9mGds6Vw6kuzwFl4LYMtV/jcMsqxo9NIMTw2g9yfYXEW5ipo8nrGEoQNyq4auLyKM
         HSpJWH6sLMP/4WYseDyYnty8x0KCZqeiovbMsqzq19BIoTeSVz5xc8SxsFSWhe8tbU8R
         l4SWiyQZbMTa3bGadLv6Er2a5O9MTRblUbLvweHpuTrZk/Z63CmY6D0w2iYz+1ar3wJQ
         4YrQyOcQdIL8h0xpbQW6eYeTA+bDR+Zeha7SE1Bhay5FyIQWsYcwfI5xSl//M3Z/bO7p
         wa4BrYKEvp9L/QszfD3nSCs4lT3xmM26fLoabWSxdX7YHeUSNEXZm8NyOXnqWQd6T6ym
         SKNA==
X-Gm-Message-State: AOUpUlGdHTGIWihutJd8lbzkB/t9Pb/8qVg5tBOLtsN1hQ6aKZTRcRZw
        KFF186SoMsh0MRFZaLAiqAC1fnWp
X-Google-Smtp-Source: AAOMgpc2di9Ql/6ewTqvCtA6+MJ2jPHTjZUsq6qw0YkBd9Yrgw+azNZsGdEm8UFxd+mP8Gy4EaWeEw==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr14800137wrf.206.1532903381617;
        Sun, 29 Jul 2018 15:29:41 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id a12-v6sm9267643wru.61.2018.07.29.15.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 15:29:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 9186F6407C0;
        Mon, 30 Jul 2018 01:29:39 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DnEgbgjrwuMf; Mon, 30 Jul 2018 01:29:39 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 28D806408DF; Mon, 30 Jul 2018 01:29:39 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] Staging: octeon-usb: Using defined error codes and applying coding style.
Date:   Mon, 30 Jul 2018 01:29:36 +0300
Message-Id: <20180729222936.27608-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
References: <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced -1 with defined error code EINVAL

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
v2: Apply coding style to function cvmx_usb_poll_channel
v3: Break down function cvmx_usb_poll_channel
v4: Return defined error code and applying coding style for function calls
v5: Fixing wrong patch applied before with typo on dev_err and applying coding
style as suggested on v3

 drivers/staging/octeon-usb/octeon-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index c9fbff93bed4..dd73fd48e12e 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2587,10 +2587,10 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
 		}
 	} else {
 		pipe->next_tx_frame += pipe->interval;
-
 		cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);
 	}
 }
+
 /**
  * Handles channels halt in non DMA mode
  * @hcchar_chena:
@@ -2629,7 +2629,7 @@ static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
 		 * Channel halt isn't needed.
 		 */
 	} else {
-		dev_	err(dev, "USB%d: Channel %d interrupt without halt\n",
+		dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
 			usb->index, channel);
 		return -EINVAL;
 	}
-- 
2.16.4
