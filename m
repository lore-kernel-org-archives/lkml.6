Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ABDC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0168620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080080;
	bh=QpxeUCL91y1ZEKuF+zecWgI4jYSWw4fLojKE5+NJrgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWtbAxD9qG5iZFBDTpZjPvMJIC7TCRDZKuM2cW9788XiPTuDngJYXFF0l8saz4F4a
	 wz/j8ChnHVAmFC66re57u1Fa1uHMJZZniRrAWMerq2k3M+e5kD4XuDLas5ExOlTtsC
	 z0X5b5OhS5cfKUAX6h0/NXG+4RYvRAdMlYdMUafs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfAUNwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbfAUNwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:52:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BBE2087F;
        Mon, 21 Jan 2019 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078725;
        bh=QpxeUCL91y1ZEKuF+zecWgI4jYSWw4fLojKE5+NJrgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNhNfWEwDhLbDHlMD0jYB9DJkUmu5qNqQdKMZ1/z5SvsntS7qZiQhGaodQKH++aRE
         RFKRptuix/Lr20KWiwMBVmxp2mkkmclifXzp3bYMLe0echvVvG0Ys7aS237FtMyPQV
         fiVqjNBXgdGQSvVC/3xG/0Iqiv1Txq2c4rAFfEF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.14 04/59] tty: Dont hold ldisc lock in tty_reopen() if ldisc present
Date:   Mon, 21 Jan 2019 14:43:29 +0100
Message-Id: <20190121122456.957681790@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit d3736d82e8169768218ee0ef68718875918091a0 upstream.

Try to get reference for ldisc during tty_reopen().
If ldisc present, we don't need to do tty_ldisc_reinit() and lock the
write side for line discipline semaphore.
Effectively, it optimizes fast-path for tty_reopen(), but more
importantly it won't interrupt ongoing IO on the tty as no ldisc change
is needed.
Fixes user-visible issue when tty_reopen() interrupted login process for
user with a long password, observed and reported by Lukas.

Fixes: c96cf923a98d ("tty: Don't block on IO when ldisc change is pending")
Fixes: 83d817f41070 ("tty: Hold tty_ldisc_lock() during tty_reopen()")
Cc: Jiri Slaby <jslaby@suse.com>
Reported-by: Lukas F. Hartmann <lukas@mntmn.com>
Tested-by: Lukas F. Hartmann <lukas@mntmn.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1254,7 +1254,8 @@ static void tty_driver_remove_tty(struct
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
-	int retval;
+	struct tty_ldisc *ld;
+	int retval = 0;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1266,13 +1267,18 @@ static int tty_reopen(struct tty_struct
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	retval = tty_ldisc_lock(tty, 5 * HZ);
-	if (retval)
-		return retval;
-
-	if (!tty->ldisc)
-		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	tty_ldisc_unlock(tty);
+	ld = tty_ldisc_ref_wait(tty);
+	if (ld) {
+		tty_ldisc_deref(ld);
+	} else {
+		retval = tty_ldisc_lock(tty, 5 * HZ);
+		if (retval)
+			return retval;
+
+		if (!tty->ldisc)
+			retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+		tty_ldisc_unlock(tty);
+	}
 
 	if (retval == 0)
 		tty->count++;


