Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058C2174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2058C2174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeHUJwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:52:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeHUJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:52:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2DE4D7F6;
        Tue, 21 Aug 2018 06:33:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Hu <hu1.chen@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.9 22/25] serial: 8250_dw: always set baud rate in dw8250_set_termios
Date:   Tue, 21 Aug 2018 08:21:36 +0200
Message-Id: <20180821055126.054971239@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055124.909865464@linuxfoundation.org>
References: <20180821055124.909865464@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Hu <hu1.chen@intel.com>

commit dfcab6ba573445c703235ab6c83758eec12d7f28 upstream.

dw8250_set_termios() doesn't set baud rate if the arg "old ktermios" is
NULL. This happens during resume.
Call Trace:
...
[   54.928108] dw8250_set_termios+0x162/0x170
[   54.928114] serial8250_set_termios+0x17/0x20
[   54.928117] uart_change_speed+0x64/0x160
[   54.928119] uart_resume_port
...

So the baud rate is not restored after S3 and breaks the apps who use
UART, for example, console and bluetooth etc.

We address this issue by setting the baud rate irrespective of arg
"old", just like the drivers for other 8250 IPs. This is tested with
Intel Broxton platform.

Signed-off-by: Chen Hu <hu1.chen@intel.com>
Fixes: 4e26b134bd17 ("serial: 8250_dw: clock rate handling for all ACPI platforms")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -235,7 +235,7 @@ static void dw8250_set_termios(struct ua
 	unsigned int rate;
 	int ret;
 
-	if (IS_ERR(d->clk) || !old)
+	if (IS_ERR(d->clk))
 		goto out;
 
 	clk_disable_unprepare(d->clk);


