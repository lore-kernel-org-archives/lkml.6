Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E67C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB65E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfAaJna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:43:30 -0500
Received: from mx133-tc.baidu.com ([61.135.168.133]:24247 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbfAaJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:43:29 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id 558D411C0042;
        Thu, 31 Jan 2019 17:43:16 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gkohli@codeaurora.org
Subject: [PATCH][V5] tty: fix race between flush_to_ldisc and tty_open
Date:   Thu, 31 Jan 2019 17:43:16 +0800
Message-Id: <1548927796-11348-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There still is a race window after the commit b027e2298bd588
("tty: fix data race between tty_init_dev and flush of buf"),
and we encountered this crash issue if receive_buf call comes
before tty initialization completes in tty_open and
tty->driver_data may be NULL.

CPU0                                    CPU1
----                                    ----
                                  tty_open
                                   tty_init_dev
                                     tty_ldisc_unlock
                                       schedule
flush_to_ldisc
 receive_buf
  tty_port_default_receive_buf
   tty_ldisc_receive_buf
    n_tty_receive_buf_common
      __receive_buf
       uart_flush_chars
        uart_start
        /*tty->driver_data is NULL*/
                                   tty->ops->open
                                   /*init tty->driver_data*/

it can be fixed by extending ldisc semaphore lock in tty_init_dev
to driver_data initialized completely after tty->ops->open(), but
this will lead to get lock on one function and unlock in some other
function, and hard to maintain, so fix this race only by checking
tty->driver_data when receiving, and return if tty->driver_data
is NULL, and n_tty_receive_buf_common maybe calls uart_unthrottle,
so add the same check

Signed-off-by: Wang Li <wangli39@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
V5: move check into uart_start from n_tty_receive_buf_common
V4: add version information
V3: not used ldisc semaphore lock, only checking tty->driver_data with NULL
V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
V1: extend ldisc lock to protect that tty->driver_data is inited

 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5c01bb6d1c24..556f50aa1b58 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -130,6 +130,9 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
+	if (!state)
+		return;
+
 	port = uart_port_lock(state, flags);
 	__uart_start(tty);
 	uart_port_unlock(port, flags);
@@ -727,6 +730,9 @@ static void uart_unthrottle(struct tty_struct *tty)
 	upstat_t mask = UPSTAT_SYNC_FIFO;
 	struct uart_port *port;
 
+	if (!state)
+		return;
+
 	port = uart_port_ref(state);
 	if (!port)
 		return;
-- 
2.16.2

