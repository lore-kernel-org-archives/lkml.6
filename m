Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC78C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD75208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReC5YhSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD75208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeJEXZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbeJEXOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1442147C;
        Fri,  5 Oct 2018 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756085;
        bh=f+Kzb/JybvnSz7+nuKSCIxMFmS0CkgGdsQ3qOJbrbzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReC5YhSlKDKEOSOestLy8tQ2RasyjGew9YjfJhH7D+kHiNq4Wg/qeGkuCRfm1pvLL
         +uoLgyJXlP9XzM9dBcEFWuRFupgfrOcoUY+Nft+rwDsdABc7pPL8QLleSkcGi3nfg4
         cuSYsGiWuXtOVOOGsFVXg/Az41uE9Gb1kJR0aXfg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hermes Zhang <chenhuiz@axis.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 22/48] Bluetooth: hci_ldisc: Free rw_semaphore on close
Date:   Fri,  5 Oct 2018 12:13:58 -0400
Message-Id: <20181005161424.20521-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

[ Upstream commit e6a57d22f787e73635ce0d29eef0abb77928b3e9 ]

The percpu_rw_semaphore is not currently freed, and this leads to
a crash when the stale rcu callback is invoked.  DEBUG_OBJECTS
detects this.

 ODEBUG: free active (active state 1) object type: rcu_head hint: (null)
 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 2024 at debug_print_object+0xac/0xc8
 PC is at debug_print_object+0xac/0xc8
 LR is at debug_print_object+0xac/0xc8
 Call trace:
 [<ffffff80082e2c2c>] debug_print_object+0xac/0xc8
 [<ffffff80082e40b0>] debug_check_no_obj_freed+0x1e8/0x228
 [<ffffff8008191254>] kfree+0x1cc/0x250
 [<ffffff80083cc03c>] hci_uart_tty_close+0x54/0x108
 [<ffffff800832e118>] tty_ldisc_close.isra.1+0x40/0x58
 [<ffffff800832e14c>] tty_ldisc_kill+0x1c/0x40
 [<ffffff800832e3dc>] tty_ldisc_release+0x94/0x170
 [<ffffff8008325554>] tty_release_struct+0x1c/0x58
 [<ffffff8008326400>] tty_release+0x3b0/0x490
 [<ffffff80081a3fe8>] __fput+0x88/0x1d0
 [<ffffff80081a418c>] ____fput+0xc/0x18
 [<ffffff80080c0624>] task_work_run+0x9c/0xc0
 [<ffffff80080a9e24>] do_exit+0x24c/0x8a0
 [<ffffff80080aa4e0>] do_group_exit+0x38/0xa0
 [<ffffff80080aa558>] __wake_up_parent+0x0/0x28
 [<ffffff8008082c00>] el0_svc_naked+0x34/0x38
 ---[ end trace bfe08cbd89098cdf ]---

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_ldisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 963bb0309e25..ea6238ed5c0e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -543,6 +543,8 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	}
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
+	percpu_free_rwsem(&hu->proto_lock);
+
 	kfree(hu);
 }
 
-- 
2.17.1

