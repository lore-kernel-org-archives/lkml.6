Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5DDC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5F520843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+huqxdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5F520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeIDHJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36842 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeIDHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so916996pfo.3;
        Mon, 03 Sep 2018 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K9WSdI4xIWm95WefIAgmlM2Cw4JjRPctJYgLLWJhf3w=;
        b=D+huqxdj0oLB5H6zpdMf3v6ziDrrSw7vKzugFiDWga6u43eI5eNN/AeuWIFSjMThV9
         o+kwP6EcS1+2s4zSPclms+ESo7BcUX+xwM7XTXCiTMUhlXvBUqGdQphSmbym5oWRD8Vx
         ufgvcSMipW2mSpNiGcoJ9rSO8nQ2Z9NXG44kZ60XZmViRjD5s3rrHr2JvPYGHB0PYvrr
         FdZCUz/9fOc+BUUX/stpxBBG0qb0SohURfo3prJ7eDmcIxBVXy0g2U4k8HFyAxsbYN7x
         TAKYgQoLGJG4qUZG4igX5NrV8+v/Cpk31DoUhNJIeSdhMsqONJLWCMpQmWJ3JiGcBkW6
         bjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K9WSdI4xIWm95WefIAgmlM2Cw4JjRPctJYgLLWJhf3w=;
        b=BvIbaei9R3cDyNse8exOo5jC14osv6aD0KS/fZSkBCyvS1tH6O4nzIXRj4HFLFDgpD
         YY+9zzooTGPg50q9t5227Uf8cYTPfaYtgLcui0T2hznGfEc6v1LeFvDr2FGwiNjJUVh1
         00OHE4FFiDNCPDaLv4JaZp4Wd91qQdc9gMm6Z7dIOza2qPIq6itMqqp7ks2Yz5Tqw8Bw
         ALLrTAQF5fu2HGdWSjFFK83G8xPZYUR9uxeJtxtpvrWNEXJkQqAWAUOGMEo9ZYgUz/Ac
         CpjtG9y3m02b1tWH+OIsWAFaQkuReKkd1MUdEHeN9j5Uc8XDc+ea7JaESj34oOwTeII/
         mgIw==
X-Gm-Message-State: APzg51D/P2HTLWDx8rcpqj6uo+VQo/3kuBal4xwZw7V6s+DBsoSHZyhz
        CQadeqfG5a+9HWt9yx8vinE=
X-Google-Smtp-Source: ANB0Vda9K++B22N8xLV0SZkONnEg8X/QNN1vt5G5oV0BkvA8DNalLdyDj9o6GaGtgd/VNljMAEqiZQ==
X-Received: by 2002:a63:88c8:: with SMTP id l191-v6mr29118195pgd.340.1536029205367;
        Mon, 03 Sep 2018 19:46:45 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:44 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 23/25] tty: vcc: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:49 +0900
Message-Id: <1536029091-4426-24-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/vcc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 58b454c..ce32631 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -987,7 +987,6 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct vcc_port *port_vcc;
 	struct tty_port *port_tty;
-	int ret;
 
 	if (unlikely(!tty)) {
 		pr_err("VCC: install: Invalid TTY handle\n");
@@ -997,9 +996,7 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (tty->index >= VCC_MAX_PORTS)
 		return -EINVAL;
 
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
+	tty_standard_install(driver, tty);
 
 	port_tty = kzalloc(sizeof(struct tty_port), GFP_KERNEL);
 	if (!port_tty)
-- 
2.7.4

