Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794420811
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfBFRyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:54:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBFRyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2C8BC065F8D;
        Wed,  6 Feb 2019 17:54:23 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-124-222.rdu2.redhat.com [10.10.124.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA105D9D6;
        Wed,  6 Feb 2019 17:54:23 +0000 (UTC)
Received: from laptop.jcline.org.com (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTP id 9E66A7045B06;
        Wed,  6 Feb 2019 12:54:22 -0500 (EST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_ldisc: Initialize hci_dev before open()
Date:   Wed,  6 Feb 2019 12:54:16 -0500
Message-Id: <20190206175416.4627-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 06 Feb 2019 17:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hci_dev struct hdev is referenced in work queues and timers started
by open() in some protocols. This creates a race between the
initialization function and the work or timer which can result hdev
being dereferenced while it is still null.

The syzbot report contains a reliable reproducer which causes a null
pointer dereference of hdev in hci_uart_write_work() by making the
memory allocation for hdev fail.

To fix this, ensure hdev is valid from before calling a protocol's
open() until after calling a protocol's close().

Reported-by: syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/bluetooth/hci_ldisc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..4918fefc4a6f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -207,11 +207,11 @@ void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
+		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		hu->proto->close(hu);
 		hdev = hu->hdev;
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
-		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		hu->proto->close(hu);
 		return;
 	}
 
@@ -616,6 +616,7 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 static int hci_uart_register_dev(struct hci_uart *hu)
 {
 	struct hci_dev *hdev;
+	int err;
 
 	BT_DBG("");
 
@@ -659,11 +660,22 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	else
 		hdev->dev_type = HCI_PRIMARY;
 
+	/* Only call open() for the protocol after hdev is fully initialized as
+	 * open() (or a timer/workqueue it starts) may attempt to reference it.
+	 */
+	err = hu->proto->open(hu);
+	if (err) {
+		hu->hdev = NULL;
+		hci_free_dev(hdev);
+		return err;
+	}
+
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
 		return -ENODEV;
@@ -683,17 +695,12 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 	if (!p)
 		return -EPROTONOSUPPORT;
 
-	err = p->open(hu);
-	if (err)
-		return err;
-
 	hu->proto = p;
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-		p->close(hu);
 		return err;
 	}
 
-- 
2.20.1

