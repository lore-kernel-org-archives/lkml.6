Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951AD206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAIWFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:05:13 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.105]:44429 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfAIWFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:05:13 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D600CA29EDC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 16:05:11 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hLyJgwYO22qH7hLyJgbHOE; Wed, 09 Jan 2019 16:05:11 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=49328 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghLyJ-0028Ea-5S; Wed, 09 Jan 2019 16:05:11 -0600
Date:   Wed, 9 Jan 2019 16:05:10 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] applicom: Fix potential Spectre v1 vulnerabilities
Message-ID: <20190109220510.GA31817@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghLyJ-0028Ea-5S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:49328
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IndexCard is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/char/applicom.c:418 ac_write() warn: potential spectre issue 'apbs' [r]
drivers/char/applicom.c:728 ac_ioctl() warn: potential spectre issue 'apbs' [r] (local cap)

Fix this by sanitizing IndexCard before using it to index apbs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/applicom.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index c0a5b1f3a986..4ccc39e00ced 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -32,6 +32,7 @@
 #include <linux/wait.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/nospec.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -386,7 +387,11 @@ static ssize_t ac_write(struct file *file, const char __user *buf, size_t count,
 	TicCard = st_loc.tic_des_from_pc;	/* tic number to send            */
 	IndexCard = NumCard - 1;
 
-	if((NumCard < 1) || (NumCard > MAX_BOARD) || !apbs[IndexCard].RamIO)
+	if (IndexCard >= MAX_BOARD)
+		return -EINVAL;
+	IndexCard = array_index_nospec(IndexCard, MAX_BOARD);
+
+	if (!apbs[IndexCard].RamIO)
 		return -EINVAL;
 
 #ifdef DEBUG
@@ -697,6 +702,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	unsigned char IndexCard;
 	void __iomem *pmem;
 	int ret = 0;
+	static int warncount = 10;
 	volatile unsigned char byte_reset_it;
 	struct st_ram_io *adgl;
 	void __user *argp = (void __user *)arg;
@@ -711,16 +717,12 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	mutex_lock(&ac_mutex);	
 	IndexCard = adgl->num_card-1;
 	 
-	if(cmd != 6 && ((IndexCard >= MAX_BOARD) || !apbs[IndexCard].RamIO)) {
-		static int warncount = 10;
-		if (warncount) {
-			printk( KERN_WARNING "APPLICOM driver IOCTL, bad board number %d\n",(int)IndexCard+1);
-			warncount--;
-		}
-		kfree(adgl);
-		mutex_unlock(&ac_mutex);
-		return -EINVAL;
-	}
+	if (cmd != 6 && IndexCard >= MAX_BOARD)
+		goto err;
+	IndexCard = array_index_nospec(IndexCard, MAX_BOARD);
+
+	if (cmd != 6 && !apbs[IndexCard].RamIO)
+		goto err;
 
 	switch (cmd) {
 		
@@ -838,5 +840,16 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	kfree(adgl);
 	mutex_unlock(&ac_mutex);
 	return 0;
+
+err:
+	if (warncount) {
+		pr_warn("APPLICOM driver IOCTL, bad board number %d\n",
+			(int)IndexCard + 1);
+		warncount--;
+	}
+	kfree(adgl);
+	mutex_unlock(&ac_mutex);
+	return -EINVAL;
+
 }
 
-- 
2.20.1

