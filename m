Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30587C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD4621104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543784;
	bh=c3O5bgeXW4UWAGgkrSWkrYOLSYce7kl7f15DjdEz0NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A2J/8tNMPuH7EvqNKYIhK3CG9txuyc6m5oPsFO4qQunmJXK7geTQcpckvvDeYHcro
	 0+cEOSvuhzPpk9EkVk4XeeD/ypCM/tmfjx1UkGbVYkA3gWPlFe4eQVWGtXiINPR0KN
	 ka+i1xKeo1tscDK0t22H/Xu3UUIDum9ec9AYpqkU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD4621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeLKP4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbeLKP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6931C21104;
        Tue, 11 Dec 2018 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543775;
        bh=c3O5bgeXW4UWAGgkrSWkrYOLSYce7kl7f15DjdEz0NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/AYI3fYMfFLwY261MBdiaHQd52m7oyF0eMNxIo4YO/c2/ta90le+l/RkRytWEzFm
         9Zxe98bNakEgZ9mApct9eqQsCyulkwl+Mi4kKMit9Z92R2dPFyNyJOJT+nHkgCuI3p
         xai/ou54o2LqwZ0HFe3CgNIrH5PN5WRfyL0730/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Zumbiehl <florz@florz.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 059/118] USB: serial: console: fix reported terminal settings
Date:   Tue, 11 Dec 2018 16:41:18 +0100
Message-Id: <20181211151646.622202718@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit f51ccf46217c28758b1f3b5bc0ccfc00eca658b2 upstream.

The USB-serial console implementation has never reported the actual
terminal settings used. Despite storing the corresponding cflags in its
struct console, these were never honoured on later tty open() where the
tty termios would be left initialised to the driver defaults.

Unlike the serial console implementation, the USB-serial code calls
subdriver open() already at console setup. While calling set_termios()
and write() before open() looks like it could work for some USB-serial
drivers, others definitely do not expect this, so modelling this after
serial core is going to be intrusive, if at all possible.

Instead, use a (renamed) tty helper to save the termios data used at
console setup so that the tty termios reflects the actual terminal
settings after a subsequent tty open().

Note that the calls to tty_init_termios() (tty_driver_install()) and
tty_save_termios() are serialised using the disconnect mutex.

This specifically fixes a regression that was triggered by a recent
change adding software flow control to the pl2303 driver: a getty trying
to disable flow control while leaving the baud rate unchanged would now
also set the baud rate to the driver default (prior to the flow-control
change this had been a noop).

Fixes: 7041d9c3f01b ("USB: serial: pl2303: add support for tx xon/xoff flow control")
Cc: stable <stable@vger.kernel.org>	# 4.18
Cc: Florian Zumbiehl <florz@florz.de>
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c         |   11 +++++++++--
 drivers/usb/serial/console.c |    2 +-
 include/linux/tty.h          |    1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1372,7 +1372,13 @@ err_release_lock:
 	return ERR_PTR(retval);
 }
 
-static void tty_free_termios(struct tty_struct *tty)
+/**
+ * tty_save_termios() - save tty termios data in driver table
+ * @tty: tty whose termios data to save
+ *
+ * Locking: Caller guarantees serialisation with tty_init_termios().
+ */
+void tty_save_termios(struct tty_struct *tty)
 {
 	struct ktermios *tp;
 	int idx = tty->index;
@@ -1391,6 +1397,7 @@ static void tty_free_termios(struct tty_
 	}
 	*tp = tty->termios;
 }
+EXPORT_SYMBOL_GPL(tty_save_termios);
 
 /**
  *	tty_flush_works		-	flush all works of a tty/pty pair
@@ -1490,7 +1497,7 @@ static void release_tty(struct tty_struc
 	WARN_ON(!mutex_is_locked(&tty_mutex));
 	if (tty->ops->shutdown)
 		tty->ops->shutdown(tty);
-	tty_free_termios(tty);
+	tty_save_termios(tty);
 	tty_driver_remove_tty(tty->driver, tty);
 	tty->port->itty = NULL;
 	if (tty->link)
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -101,7 +101,6 @@ static int usb_console_setup(struct cons
 		cflag |= PARENB;
 		break;
 	}
-	co->cflag = cflag;
 
 	/*
 	 * no need to check the index here: if the index is wrong, console
@@ -164,6 +163,7 @@ static int usb_console_setup(struct cons
 			serial->type->set_termios(tty, port, &dummy);
 
 			tty_port_tty_set(&port->port, NULL);
+			tty_save_termios(tty);
 			tty_kref_put(tty);
 		}
 		tty_port_set_initialized(&port->port, 1);
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -556,6 +556,7 @@ extern struct tty_struct *tty_init_dev(s
 extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
+extern void tty_save_termios(struct tty_struct *tty);
 extern int tty_standard_install(struct tty_driver *driver,
 		struct tty_struct *tty);
 


