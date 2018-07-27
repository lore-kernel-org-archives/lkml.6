Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1758C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D3E2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D3E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeG0MJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:09:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:15432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbeG0MJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:09:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 03:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="57609564"
Received: from hu.sh.intel.com ([10.239.160.33])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2018 03:48:24 -0700
From:   Chen Hu <hu1.chen@intel.com>
To:     andy.shevchenko@gmail.com
Cc:     Chen Hu <hu1.chen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Subramony Sesha <subramony.sesha@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Archana Patni <archana.patni@intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: always set baud rate in dw8250_set_termios
Date:   Fri, 27 Jul 2018 18:32:41 +0800
Message-Id: <20180727103242.29675-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
We found UART based apps such as console and bluetooth etc. are broken after S3
on Intel Broxton platform. The further debug shows that the baud rate of all
UARTs are different with our settings after S3. During S3, the 8250 related IPs
may lose power and thus lose the OS's baud rate setting. The driver should
restore it during resume. However, Desinware 8250's driver doesn't restore the
baud if the arg "old ktermios" is NULL. Unfortunely, it get a NULL arg from
serial_core and skips this step in resume path.

Andy guide me that he doesn't see other 8250 IPs judge old==NULL to set baud.

With the modification in this email, the baud rate is OK after S3. A local
quick test doesn't show any error. Report the issue here and hope some serial
experts can present formal patch to fix.
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 02a9b995e8f9..82bf46507f6d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -250,7 +250,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	if (IS_ERR(d->clk) || !old)
+	if (IS_ERR(d->clk))
 		goto out;
 
 	clk_disable_unprepare(d->clk);
-- 
2.13.0

