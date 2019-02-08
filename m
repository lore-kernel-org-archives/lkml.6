Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1A2C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006D721841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549667174;
	bh=1I7YXQ9OMI0R2q5KaU8/kaxb3WP0bqSIy1fzgUvUbiI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=t/t22UdlHcg5x9f4EDAP5yGJTiSRMJo4zjtS5IdiNe0skXGlt/b98C4bbKlMjVVp/
	 FPOgO4zCmZvwbFJlUuW+vk7chwgyLuGntXvqJOeoJ5JPO9fendwfxtZVQOXDLW/1B5
	 3A/MUvi3cfKugkDuGgN7J9mfpQeGXR993Ie6mXnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBHXGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfBHXGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:06:12 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A072196E;
        Fri,  8 Feb 2019 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549667171;
        bh=1I7YXQ9OMI0R2q5KaU8/kaxb3WP0bqSIy1fzgUvUbiI=;
        h=From:To:Cc:Subject:Date:From;
        b=HYNSCaKJnDg8OaAjbwYMt79X3qWjpA1RPN3vid3cPyHHYJwPWheV+sAnZLto1D9Ak
         Wt/S9YR3I++n58NofKm7eUUrn1knNsB2x6LjCV/oQZWle92KwMFs7UBIVJta4vpLeO
         7qLTRFz6ZMgXWxDgLd6ptQzfXqpnbEFVf2Mc1pCs=
From:   Shuah Khan <shuah@kernel.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] bluetooth: Fix WARNING in tty_set_termios()
Date:   Fri,  8 Feb 2019 16:06:09 -0700
Message-Id: <20190208230609.23926-1-shuah@kernel.org>
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

"The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
operational speed during setup") which introduced a new way for how
tty_set_termios() could end up being called for a master pty."

Fix hci_uart_tty_open() to check if tty supports set_termios in addition
to write and error out, if it doesn't.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Cc: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..087ec2268744 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -474,10 +474,10 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
-	/* Error if the tty has no write op instead of leaving an exploitable
-	 * hole
+	/* Error if the tty has no write/set_termios ops instead of leaving
+	 * an exploitable hole.
 	 */
-	if (tty->ops->write == NULL)
+	if (!tty->ops->write || !tty->ops->set_termios)
 		return -EOPNOTSUPP;
 
 	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
-- 
2.17.1

