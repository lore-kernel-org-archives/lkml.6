Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE35EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE42217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549212509;
	bh=Cg6Dt507I75jmhcvuq9Fm5n/Qm+RVVtIJ85prs4KG6M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hB3ChDL9t1nVGkgwUfe8TahRPGUNN3YP3np6zWbuUCH5YZkNIpG237tXkKqXeWAtH
	 Aqo16suXKlYoaNvtb/2KqXD+eAKumO/p8Mtlo7Ovm5soKo70wDYfY0iADE9P3dQtn+
	 CkgOSzdIqEDOgt6JPSYRGpnUSEP0f+2FBwIug0I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfBCQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfBCQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:48:27 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB1321773;
        Sun,  3 Feb 2019 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549212506;
        bh=Cg6Dt507I75jmhcvuq9Fm5n/Qm+RVVtIJ85prs4KG6M=;
        h=From:To:Cc:Subject:Date:From;
        b=MrtyF7zZrh9obhqWWwjjihLW7/bjc5wov/J/2wJiILkSPw7CGeEJBYLJlwCJ+5S8s
         DRRCszsjm0NEItATSW+cs7Eu4tMXTrNIJy9yJCoRn81Q5d8zcziplRjsQZrPjmb38S
         uaj5NYh8mjtJ8Vl1S27ZymUNcUeRL2Cp9a4WEpsQ=
From:   Shuah Khan <shuah@kernel.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] bluetooth: Fix WARNING in tty_set_termios()
Date:   Sun,  3 Feb 2019 09:48:25 -0700
Message-Id: <20190203164825.9621-1-shuah@kernel.org>
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

Johan Hovold said: "The problemm started with
commit 7721383f4199 ("Bluetooth: hci_uart: Support
operational speed during setup") which introduced a new way for how
tty_set_termios() could end up being called for a master pty."

Fix it by by preventing setting the HCI line discipline for PTYs in
hci_uart_tty_open(). Looked into keying off of tty and ldisc ops, and
couldn't find any that would be conclusive. Checking tty as such clearly
tags the reason for rejecting the request to set ldisc.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Cc: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..a3d313fcc0f2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -480,6 +480,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EOPNOTSUPP;
 
+	/* don't set HCI line discipline on PTYs */
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver->subtype == PTY_TYPE_MASTER)
+		return -EINVAL;
+
 	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
 	if (!hu) {
 		BT_ERR("Can't allocate control structure");
-- 
2.17.1

