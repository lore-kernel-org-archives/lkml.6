Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E01C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C982F222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895901;
	bh=1ilPmTGcTLD9FvivOlIe+ycuAiaRCVd7TJ7Ozhw5+EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqXuPSu44qzzkYtcSOpGO0P8M+kXqnlfFuy5B6ybdU89gE9NZObVkMcLvagDk/Mp+
	 RhGE2dpkAPs68uh5E2D3SeZYfXDakG9u3WfoRT9Y2dTbDRxNl4u96kfuPO7mCB18nj
	 vICsFoRUrJ+a6brMeVtSfNP5BqC2CAKtFGZ99aJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfBKOiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731641AbfBKOiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D60B20844;
        Mon, 11 Feb 2019 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895897;
        bh=1ilPmTGcTLD9FvivOlIe+ycuAiaRCVd7TJ7Ozhw5+EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxz1r5atRpFZ4Ypa0WfAleiuUoaqgYdG5lkqjoRxeUi0IcviCFTU/qo12KfFRJ0/Y
         5TcMrLCy7LUwCiXz5RkzwpIbu652+bCpWUVjcfqdvXPIQnIzytb7IrF+U4LIlNyl1z
         BYxQlpcW7QvnfEarrSAIWfVa5fTc6lyDcJo+ZYbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>, Zhang Yu <zhangyu31@baidu.com>
Subject: [PATCH 4.20 348/352] serial: fix race between flush_to_ldisc and tty_open
Date:   Mon, 11 Feb 2019 15:19:35 +0100
Message-Id: <20190211141909.329117127@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit fedb5760648a291e949f2380d383b5b2d2749b5e upstream.

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
so add the same check.

Because the tty layer knows nothing about the driver associated with the
device, the tty layer can not do anything here, it is up to the tty
driver itself to check for this type of race.  Fix up the serial driver
to correctly check to see if it is finished binding with the device when
being called, and if not, abort the tty calls.

[Description and problem report and testing from Li RongQing, I rewrote
the patch to be in the serial layer, not in the tty core - gregkh]

Reported-by: Li RongQing <lirongqing@baidu.com>
Tested-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Wang Li <wangli39@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -130,6 +130,9 @@ static void uart_start(struct tty_struct
 	struct uart_port *port;
 	unsigned long flags;
 
+	if (!state)
+		return;
+
 	port = uart_port_lock(state, flags);
 	__uart_start(tty);
 	uart_port_unlock(port, flags);
@@ -727,6 +730,9 @@ static void uart_unthrottle(struct tty_s
 	upstat_t mask = UPSTAT_SYNC_FIFO;
 	struct uart_port *port;
 
+	if (!state)
+		return;
+
 	port = uart_port_ref(state);
 	if (!port)
 		return;


