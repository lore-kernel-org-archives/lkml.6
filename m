Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C5220823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfARJ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:27:30 -0500
Received: from mx132-tc.baidu.com ([61.135.168.132]:58816 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfARJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:27:30 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 8F915204004B;
        Fri, 18 Jan 2019 17:27:17 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, gkohli@codeaurora.org
Subject: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
Date:   Fri, 18 Jan 2019 17:27:17 +0800
Message-Id: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There still is a race window after the commit b027e2298bd588
("tty: fix data race between tty_init_dev and flush of buf"),
and we encountered this crash issue if receive_buf call comes
before tty initialization completes in n_tty_open and
tty->driver_data may be NULL.

CPU0                                    CPU1
----                                    ----
                                 n_tty_open
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
this will lead to put lock on one function and unlock in some other
function, and hard to maintain, so fix this race only by checking
tty->driver_data when receiving, and return if tty->driver_data
is NULL

Signed-off-by: Wang Li <wangli39@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
V4: add version information
V3: not used ldisc semaphore lock, only checking tty->driver_data with NULL
V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
V1: extend ldisc lock to protect that tty->driver_data is inited 

drivers/tty/tty_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 044c3cbdcfa4..86d0bec38322 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -31,6 +31,9 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 	if (!tty)
 		return 0;
 
+	if (!tty->driver_data)
+		return 0;
+
 	disc = tty_ldisc_ref(tty);
 	if (!disc)
 		return 0;
-- 
2.16.2

