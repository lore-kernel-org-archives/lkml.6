Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FECCC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7920879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078939;
	bh=BPo/BOGj/ioXB67XrTTeURLxsdTnp5tGJljFcx8auHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WCwcLlUO1pI6Ab3e8/HE8GXlaw8uoR3G/8f03wxneoQAwXj+yBJEcYSkh84cT2Uz0
	 Iq9FOjYDuxeyYsLR1izfQ0HcvAvweDRk3iGBpvZddCBh9/KFACyRZGa6K+RmLYgaHz
	 OWKg57VKWEERAhMGpQt40PoUpbhGkEWft1WGFLq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbfAUNzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfAUNzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF3520861;
        Mon, 21 Jan 2019 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078930;
        bh=BPo/BOGj/ioXB67XrTTeURLxsdTnp5tGJljFcx8auHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXvlMYb1zG9p770w4EUHlXVr/PnV1kMNro83ShR5vmWkgV01k4QCOfzFPDOzFQoi8
         8IoEktS4PO0km3RTBX4Ojd19PRXmLToQ8TsXbvN+0VcobB6WrHaQ70QXzAnJNREqoK
         6IQ0d1KR/WhTKqbafDgwKS1fvDMpGgLH+fEiU9kk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.9 04/51] tty: Dont hold ldisc lock in tty_reopen() if ldisc present
Date:   Mon, 21 Jan 2019 14:44:00 +0100
Message-Id: <20190121122453.967865420@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1475,7 +1475,8 @@ static void tty_driver_remove_tty(struct
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
-	int retval;
+	struct tty_ldisc *ld;
+	int retval = 0;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1487,13 +1488,18 @@ static int tty_reopen(struct tty_struct
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


