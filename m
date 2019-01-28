Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A2BC4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988420881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9zGyJh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1G7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:59:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35784 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfA1G7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:59:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so7591529pfi.2;
        Sun, 27 Jan 2019 22:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PPMteN8p8+yuCViHNNM49LqdtRO2VGHUxenNraKRdGo=;
        b=L9zGyJh9Y/e3HFRUllXUMPl1KLB83+oaZLPctuxJbbLP62ZUBeoUcdCw00vZDzSt7o
         IUBxOw+uP/qUcBoyFNsg25949GMQZP9Qe3oSVnWP3NUnY9fzhOlpHdNNQG+Csh5ygskw
         455UK8pddgzYHwPoo+rsf961yQdcCa3jTlvHDwLEj6Jzt/M1PwpTP6R9LBEO29pSss78
         2Ke+yKTseBHwA/zrwiHTsCmILjahbTnoMQq7CbueS9+fvvv/T6Z9zaetvqnz711UFW6d
         ZwHXeq1IENod6Sf1uB5nAY4gwTLUfw2wqwju5xp2AmOG1DTzNvJ/aGObRjFi/cfGilHP
         zzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PPMteN8p8+yuCViHNNM49LqdtRO2VGHUxenNraKRdGo=;
        b=aRmJt8/DwPs2RE/BgPXt8sXt4JnU+C+8nJeCzpG5AljRgoAJwwCu5+QGKsR+ChI7EW
         8LpdOfUTxA4/b+r7s/tTkUKD6A7Vx3yBT3bSyvltTrUv09jflw8E6PYOHI3lw0alTS1X
         mQ2Zz6cByV755ohTsYnrJ0oS3T91V8WglDBYbcB5wvoXsTST+xk4R5QiQmmUYqbgeZK4
         1lIAC503IoBRghH3Mnt2eng8jnrqZFx64MPSoOkT6IyhE58vRlxqWOgwv4Q/J3MS+MRF
         jeRyVH4YNxtpiesV76YM/i45eGf1hGsbWoib8CR68TKGKtPjv+me7XZWSTKvWk2nwP+A
         jzGw==
X-Gm-Message-State: AJcUukenurRycqMJtjyKJLYKRMKzOzocivOz3zSUS92KXdtWLkMXY00v
        iF0AxXD2TTOItttPoWPGo/M=
X-Google-Smtp-Source: ALg8bN7PoREnNrhgCSB5zZWTAwI3mkjj9oUmxSTAFbhqJ2NrxtYHmhy+VBGoaoK8+cDwx6IfbZx4AA==
X-Received: by 2002:a63:165e:: with SMTP id 30mr18830259pgw.103.1548658755709;
        Sun, 27 Jan 2019 22:59:15 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id r66sm50393263pfk.157.2019.01.27.22.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:59:15 -0800 (PST)
Date:   Sun, 27 Jan 2019 22:59:13 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Add NULL check for tiocmget() and tiocmset()
Message-ID: <20190128065910.GA14959@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tiocmget() and tiocmset() operations are optional and some tty drivers
like pty miss the operations. We need NULL check before referencing
them.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_ath.c   | 13 ++++++++-----
 drivers/bluetooth/hci_ldisc.c |  5 +++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index d568fbd94d6c..076700a1e9a8 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -94,11 +94,14 @@ static void ath_hci_uart_work(struct work_struct *work)
 	hu = ath->hu;
 	tty = hu->tty;
 
-	/* verify and wake up controller */
-	if (ath->cur_sleep) {
-		status = ath_wakeup_ar3k(tty);
-		if (!(status & TIOCM_CTS))
-			return;
+	/* tiocmget() and tiocmset() operations are optional */
+	if (tty->driver->ops->tiocmget && tty->driver->ops->tiocmset) {
+		/* verify and wake up controller */
+		if (ath->cur_sleep) {
+			status = ath_wakeup_ar3k(tty);
+			if (!(status & TIOCM_CTS))
+				return;
+		}
 	}
 
 	/* Ready to send Data */
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..9f88a8563cf6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -314,6 +314,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		return;
 	}
 
+	/* tiocmget() and tiocmset() operations are optional */
+	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset) {
+		return;
+	}
+
 	if (enable) {
 		/* Disable hardware flow control */
 		ktermios = tty->termios;
-- 
2.17.1

