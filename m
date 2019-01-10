Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E33C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CDA2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpUkk7gO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAJARY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:17:24 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47045 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:17:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so10467631qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=qcc0vpPwlj953Qdb+Xr4syq8PvGm8X0FWC3fECLLsco=;
        b=EpUkk7gO8LP9EZD/RPXcBb0ugDtO98RYty44nI7wqwvlkuvp9J56zY/T5WhEhzOjLu
         Oo9c1257iH6VrPDQzY3Oy17MVXzF43J6lpxFXj81qyapfA2WCyllb5qrgiBS3PbnuZtc
         q0CiIUPDVo1ZZpm0z4J0u0n/0S03OPqwBBBMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=qcc0vpPwlj953Qdb+Xr4syq8PvGm8X0FWC3fECLLsco=;
        b=ieL1JMrBFXmdHsintgukzNeA1Tf47b0M61yG/tqSwO1+jtu/rzd9meoGBBdcgQ5Ham
         +VVk1oXwacdkA1UtVgNMQtBT47oxVdyial/pTfu64luJGFgBy/UgsxVcW/taG/6NSj1J
         TYg6xCbNFoXvlpf9DSBlAWzHtvE9sgZZMzsh1SRBcEDQU8teJmPGcld2YvozRakXzA67
         9NkLbHkxYdsKIvY+QB+jK+2vByTDLil7dZwWdCEuj7b6skOXbJSdSJME5NGYo78ilEM7
         Z6nReGEMBJ/xDnB0bk+hNSwlkVaj7e0i85uke3RdG5xeu2UicyJ5zcAxzQFkEbxGKHJj
         0y5Q==
X-Gm-Message-State: AJcUukfjrMuJloVXWatL4Zcplm0QSy9k3E/9yDIkpE0CWVtwdL7f4DSn
        SE1MZDtj0gy6qQbzfcpFjZiZhlXTrMk=
X-Google-Smtp-Source: ALg8bN5CUpLHj5LPWAChAUasVgIaXrKEXNyanMUgirIt0NyJv4UIGDpm6uD9Wvj1bu+mOZG9dzd3qQ==
X-Received: by 2002:aed:2558:: with SMTP id w24mr7626698qtc.183.1547079443457;
        Wed, 09 Jan 2019 16:17:23 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id d199sm33404852qkc.76.2019.01.09.16.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:17:22 -0800 (PST)
Date:   Wed, 9 Jan 2019 19:17:20 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/6] vcs: restore and document initial POLLPRI event
Message-ID: <nycvar.YSQ.7.76.1901091915030.2635@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore and document the forced initial POLLPRI event reporting when
poll() is used for the first time. This used to be the implemented
behavior before recent changes. Because of the way poll() is implemented,
this prevents losing an event happening between the last read() and the
first poll() invocation.

Since poll() for /dev/vcs* was not always supported, user space probes
for its availability as follows:

	int fd = open("/dev/vcsa", O_RDONLY);
	struct pollfd p = { .fd = fd, .events = POLLPRI };
	available = (poll(&p, 1, 0) == 1);

Semantically, it makes sense to signal the first event as such even if
it might be spurious. The screen could be modified, and modified back
to its initial state before we get to read it, so users must be prepared
for that anyway.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1d887113ff..160f46115a 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -140,6 +140,15 @@ vcs_poll_data_get(struct file *file)
 	poll->cons_num = console(file_inode(file));
 	init_waitqueue_head(&poll->waitq);
 	poll->notifier.notifier_call = vcs_notifier;
+	/*
+	 * In order not to lose any update event, we must pretend one might
+	 * have occurred before we have a chance to register our notifier.
+	 * This is also how user space has come to detect which kernels
+	 * support POLLPRI on /dev/vcs* devices i.e. using poll() with
+	 * POLLPRI and a zero timeout.
+	 */
+	poll->event = VT_UPDATE;
+
 	if (register_vt_notifier(&poll->notifier) != 0) {
 		kfree(poll);
 		return NULL;
