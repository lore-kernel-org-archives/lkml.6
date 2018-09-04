Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4256C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F4020843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZRQSv09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F4020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIDHJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42581 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeIDHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so879184plq.9;
        Mon, 03 Sep 2018 19:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xyGQJoxJuf80yEKrzQZlMJDHZF2IdzTQKqa/0pjxKR0=;
        b=RZRQSv09uLpehuYeYRJL6n4Q+9TLDbL6dSMtuVoLpRQUlGaoKC3kWqooJlxuODUJWT
         EfjyJ3kJ60G5cT8s9NZDTPSizeufFEfjWlruXgokm32X0iCT3eu9lIo5jqhhH5+ttbeO
         GR3j2lN9B0dHCi0a56lQOyIemsWoT6FS3ziU66qQQnWt5CxPVv+CRiwV8/5xjBAfCN+8
         XKr1tmgwZrB3BOblVlZXxLpY9jNPvVjHjOMnJxXeoFtqkuPtIlfPB6dJ0/Ha+jz2RNed
         0qisgumt35KtA3dl7ef1Qhb7b3sUxCto3o2Q/KnL9k+Z5JRMzfkUcFPyurjUKkr1etDU
         5blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xyGQJoxJuf80yEKrzQZlMJDHZF2IdzTQKqa/0pjxKR0=;
        b=nLpkCvJpVCkg65xUvEdavQSEqm6tlfO4FYELnmHrM5LAIHVG44Mymk48sqiy0qJ9Pf
         UqqbrV2RJhD8jC1dC+NTQQ1Zrr7GC0hkeRxTZQepm4Ss0+5aQTdBBd00HFfupj7lNudS
         m5yt4uJYMaOvzhUHqlzruaiCzjGt3gT3MDMRXZS+SRYkatGaW+5s5qSAK9hapF4wUJp1
         qiwGbNIri4NmP3N5/jbL4Z0oPVfRWfAYL+2oTsIJR/o5yiobB06JLAuV9xnrtRdHixov
         /SJcqEtCIw09B/ajTfAT8uAg6lOFkvgL6SoRQfmqHOE3YhaK7JGIQEzrGJtPJI8Og7TL
         pApg==
X-Gm-Message-State: APzg51A6Z3KX7PEOP3Eo3XCXUyheFN7jFUagVGjgbcZRHqELfloyznbp
        QO8uqt9U4GaFahHKCbgibEM=
X-Google-Smtp-Source: ANB0VdZmMidsyx2NWPQtHr5RHUY52+IJB6tCqYbLEiuS9YcnTq+cf27rQdkbGX1mUppJOaCVTPM1HQ==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3-v6mr31483472plm.0.1536029182110;
        Mon, 03 Sep 2018 19:46:22 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:21 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 18/25] mmc: core: sdio_uart: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:44 +0900
Message-Id: <1536029091-4426-19-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/mmc/core/sdio_uart.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 25e1130..b727186 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -731,14 +731,11 @@ static int sdio_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct sdio_uart_port *port = sdio_uart_port_get(idx);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0)
-		/* This is the ref sdio_uart_port get provided */
-		tty->driver_data = port;
-	else
-		sdio_uart_port_put(port);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 /**
-- 
2.7.4

