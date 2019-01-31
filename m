Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E6BC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8468220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548977044;
	bh=PltFGNgqU0w6HEkKYm/bH09hm7RK9+dGvo/BCfORBdg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IGb6XYlhOBMVz5M/HUvBuN+1hHQenxLxwuy8lfoRwr4Mq300a2KtzrU64r8cOCevg
	 KQRdAenM1odktV2CCdsQjiFirNQdP8WrrJ9WAhSRbAgtSk6Lw4PN/YakyQRt2gnHH0
	 l2AnGhb6uP75K76EjvgU7cG1mNwCYV2JGs7YtETE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfAaXYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfAaXYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:24:02 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D6E20881;
        Thu, 31 Jan 2019 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548977042;
        bh=PltFGNgqU0w6HEkKYm/bH09hm7RK9+dGvo/BCfORBdg=;
        h=From:To:Cc:Subject:Date:From;
        b=lyZgfrVMyDdgE2QQcaXp68lymMkwMZxNhztPFRuDFqOn9AO+1/Qe3hrVYOv8LQntm
         wp8Ow00f3B1RdAsYVXIwYniv9G00/t05Na8fe/vIX00WBTLQN4ablWuaBuDsX5yTAC
         eT/RXAC3ykRYWfuFSO5UqID/xyv/Y1E4un8C1Eic=
From:   Shuah Khan <shuah@kernel.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     Shuah Khan <shuah@kernel.org>, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: Fix WARNING in tty_set_termios()
Date:   Thu, 31 Jan 2019 16:23:59 -0700
Message-Id: <20190131232359.27948-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_set_termios() has the following WARN_ON which can be triggered with a
syscall to invoke TIOCSETD __NR_ioctl.

WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
                tty->driver->subtype == PTY_TYPE_MASTER);
Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d

The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
operational speed during setup") which introduced a new way for how
tty_set_termios() could end up being called for a master pty.

Fix the problem by preventing setting the HCI line discipline for PTYs
from hci_uart_setup() and hci_uart_set_flow_control().

The reproducer is used to reproduce the problem and verify the fix.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..ce84ca91ca70 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -314,6 +314,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		return;
 	}
 
+	/* don't set HCI line discipline on PTYs */
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver->subtype == PTY_TYPE_MASTER)
+		return;
+
 	if (enable) {
 		/* Disable hardware flow control */
 		ktermios = tty->termios;
@@ -384,11 +389,17 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int hci_uart_setup(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct tty_struct *tty = hu->tty;
 	struct hci_rp_read_local_version *ver;
 	struct sk_buff *skb;
 	unsigned int speed;
 	int err;
 
+	/* don't set HCI line discipline on PTYs */
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver->subtype == PTY_TYPE_MASTER)
+		return -EINVAL;
+
 	/* Init speed if any */
 	if (hu->init_speed)
 		speed = hu->init_speed;
-- 
2.17.1

