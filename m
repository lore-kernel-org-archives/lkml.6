Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeCROuB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:50:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41772 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbeCROt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:49:57 -0400
X-Google-Smtp-Source: AG47ELtOpTJMRxRJp1Lgy2xTT2ljknldKPKXJww5xWuI3kkhsu4ijJ0lBZswHYmxiT6vBPhn2olkpw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: laforge@gnumonks.org
Cc: linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] char: pcmcia: cm4000_cs: Replace mdelay with usleep_range in set_protocol
Date: Sun, 18 Mar 2018 22:49:57 +0800
Message-Id: <1521384597-23195-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_protocol() is never called in atomic context.

The call chains ending up at set_protocol() are:
[1] set_protocol() <- monitor_card()
[2] set_protocol() <- cmm_ioctl()
monitor_card() is only set in setup_timer(), and cmm_ioctl() is only 
set as ".unlocked_ioctl" in file_operations structure "cm4000_fops".

Despite never getting called from atomic context, set_protocol() calls
mdelay(10), i.e. busy wait for 10ms.
That is not necessary and can be replaced with usleep_range to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index cd53771..56fc671 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -530,7 +530,7 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
 			DEBUGP(5, dev, "NumRecBytes is valid\n");
 			break;
 		}
-		mdelay(10);
+		usleep_range(10000, 11000);
 	}
 	if (i == 100) {
 		DEBUGP(5, dev, "Timeout waiting for NumRecBytes getting "
@@ -546,7 +546,7 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
 			DEBUGP(2, dev, "NumRecBytes = %i\n", num_bytes_read);
 			break;
 		}
-		mdelay(10);
+		usleep_range(10000, 11000);
 	}
 
 	/* check whether it is a short PTS reply? */
-- 
1.9.1
