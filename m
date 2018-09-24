Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D1AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FED21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FED21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbeIXS00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbeIXS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 544E61094;
        Mon, 24 Sep 2018 12:24:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mariusz Bialonczyk <manio@skyboo.net>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 100/173] Revert "cdc-acm: implement put_char() and flush_chars()"
Date:   Mon, 24 Sep 2018 13:52:14 +0200
Message-Id: <20180924113123.428471393@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit df3aa13c7bbb307e172c37f193f9a7aa058d4739 upstream.

This reverts commit a81cf9799ad7299b03a4dff020d9685f9ac5f3e0.

The patch causes a regression, which I cannot find the reason for.
So let's revert for now, as a revert hurts only performance.

Original report:
I was trying to resolve the problem with Oliver but we don't get any conclusion
for 5 months, so I am now sending this to mail list and cdc_acm authors.

I am using simple request-response protocol to obtain the boiller parameters
in constant intervals.

A simple one transaction is:
1. opening the /dev/ttyACM0
2. sending the following 10-bytes request to the device:
   unsigned char req[] = {0x02, 0xfe, 0x01, 0x05, 0x08, 0x02, 0x01, 0x69, 0xab, 0x03};
3. reading response (frame of 74 bytes length).
4. closing the descriptor
I am doing this transaction with 5 seconds intervals.

Before the bad commit everything was working correctly: I've got a requests and
a responses in a timely manner.

After the bad commit more time I am using the kernel module, more problems I have.
The graph [2] is showing the problem.

As you can see after module load all seems fine but after about 30 minutes I've got
a plenty of EAGAINs when doing read()'s and trying to read back the data.

When I rmmod and insmod the cdc_acm module again, then the situation is starting
over again: running ok shortly after load, and more time it is running, more EAGAINs
I have when calling read().

As a bonus I can see the problem on the device itself:
The device is configured as you can see here on this screen [3].
It has two transmision LEDs: TX and RX. Blink duration is set for 100ms.
This is a recording before the bad commit when all is working fine: [4]
And this is with the bad commit: [5]
As you can see the TX led is blinking wrongly long (indicating transmission?)
and I have problems doing read() calls (EAGAIN).

Reported-by: Mariusz Bialonczyk <manio@skyboo.net>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: a81cf9799ad7 ("cdc-acm: implement put_char() and flush_chars()")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |   73 --------------------------------------------
 drivers/usb/class/cdc-acm.h |    1 
 2 files changed, 74 deletions(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -792,20 +792,9 @@ static int acm_tty_write(struct tty_stru
 	}
 
 	if (acm->susp_count) {
-		if (acm->putbuffer) {
-			/* now to preserve order */
-			usb_anchor_urb(acm->putbuffer->urb, &acm->delayed);
-			acm->putbuffer = NULL;
-		}
 		usb_anchor_urb(wb->urb, &acm->delayed);
 		spin_unlock_irqrestore(&acm->write_lock, flags);
 		return count;
-	} else {
-		if (acm->putbuffer) {
-			/* at this point there is no good way to handle errors */
-			acm_start_wb(acm, acm->putbuffer);
-			acm->putbuffer = NULL;
-		}
 	}
 
 	stat = acm_start_wb(acm, wb);
@@ -816,66 +805,6 @@ static int acm_tty_write(struct tty_stru
 	return count;
 }
 
-static void acm_tty_flush_chars(struct tty_struct *tty)
-{
-	struct acm *acm = tty->driver_data;
-	struct acm_wb *cur;
-	int err;
-	unsigned long flags;
-
-	spin_lock_irqsave(&acm->write_lock, flags);
-
-	cur = acm->putbuffer;
-	if (!cur) /* nothing to do */
-		goto out;
-
-	acm->putbuffer = NULL;
-	err = usb_autopm_get_interface_async(acm->control);
-	if (err < 0) {
-		cur->use = 0;
-		acm->putbuffer = cur;
-		goto out;
-	}
-
-	if (acm->susp_count)
-		usb_anchor_urb(cur->urb, &acm->delayed);
-	else
-		acm_start_wb(acm, cur);
-out:
-	spin_unlock_irqrestore(&acm->write_lock, flags);
-	return;
-}
-
-static int acm_tty_put_char(struct tty_struct *tty, unsigned char ch)
-{
-	struct acm *acm = tty->driver_data;
-	struct acm_wb *cur;
-	int wbn;
-	unsigned long flags;
-
-overflow:
-	cur = acm->putbuffer;
-	if (!cur) {
-		spin_lock_irqsave(&acm->write_lock, flags);
-		wbn = acm_wb_alloc(acm);
-		if (wbn >= 0) {
-			cur = &acm->wb[wbn];
-			acm->putbuffer = cur;
-		}
-		spin_unlock_irqrestore(&acm->write_lock, flags);
-		if (!cur)
-			return 0;
-	}
-
-	if (cur->len == acm->writesize) {
-		acm_tty_flush_chars(tty);
-		goto overflow;
-	}
-
-	cur->buf[cur->len++] = ch;
-	return 1;
-}
-
 static int acm_tty_write_room(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
@@ -2000,8 +1929,6 @@ static const struct tty_operations acm_o
 	.cleanup =		acm_tty_cleanup,
 	.hangup =		acm_tty_hangup,
 	.write =		acm_tty_write,
-	.put_char =		acm_tty_put_char,
-	.flush_chars =		acm_tty_flush_chars,
 	.write_room =		acm_tty_write_room,
 	.ioctl =		acm_tty_ioctl,
 	.throttle =		acm_tty_throttle,
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -96,7 +96,6 @@ struct acm {
 	unsigned long read_urbs_free;
 	struct urb *read_urbs[ACM_NR];
 	struct acm_rb read_buffers[ACM_NR];
-	struct acm_wb *putbuffer;			/* for acm_tty_put_char() */
 	int rx_buflimit;
 	spinlock_t read_lock;
 	u8 *notification_buffer;			/* to reassemble fragmented notifications */


