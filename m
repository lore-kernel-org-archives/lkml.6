Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE743C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D4421476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZCCituL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D4421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbeJQBMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbeJQBMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:12:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B285C21476;
        Tue, 16 Oct 2018 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710453;
        bh=i0Pzy8ldfIlPb8Ga+VFHko846OG8ad6JHn+M7A94Djw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZCCituLpNxPgglCxj3J5rD9qLbUK/EeRoTT9TDFCesUk0HnxrFOHYfPXd5V4FZJM
         M92hfxFjTcsMvEjZJB3A+mjmZdWwUya+tZJgG20yioWAVby7dsssgNVdB3npXuJMQL
         /3TQN9n+knoVb4YnwHZsQA/r7s3Tb6v0j4Uc6v7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hermes Zhang <chenhuiz@axis.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 046/109] Bluetooth: hci_ldisc: Free rw_semaphore on close
Date:   Tue, 16 Oct 2018 19:05:14 +0200
Message-Id: <20181016170527.482259406@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_ldisc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -539,6 +539,8 @@ static void hci_uart_tty_close(struct tt
 	}
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
+	percpu_free_rwsem(&hu->proto_lock);
+
 	kfree(hu);
 }
 


