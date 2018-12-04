Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E20C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5772081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYpoiwit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5772081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeLDQBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:01:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42130 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:01:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so12321627lfh.9;
        Tue, 04 Dec 2018 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AfIsjpkJHb43W/ZaV+KazQjDgZpHguTHKABJHXmS4k=;
        b=tYpoiwitTOKccZVDzZLWbWjAwiHqWx0SlN2hEzsHRgx6BXi08Pfiz0Kp1ahO7+ZVyR
         jeLLVJdM5qK3gQjiMihY6b5VOIa403OyPhi05UkouSjqdK8qFxmB+pYW58JQNnQPVoXd
         rANO5r8ELK4Yn22RHuje0u5WZViqJLMUJqxX0EVYJXL6RXpKQgZpofigTUbceRHjaNfI
         +q5kox9N//RkyxnJ+lo3Ez+4iTi5EWjdhtcISnJ6GLy7p2mFAcOgdNcr5fPBQZ28rOBG
         8ljuyjSpSGFH7E+SY93prvKs2W5K9Gt9aLPl2v8SODQ3RrjyI3Z6+oVHkkLTxTSvMUIF
         9pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4AfIsjpkJHb43W/ZaV+KazQjDgZpHguTHKABJHXmS4k=;
        b=VCff88zPNo8+vjT/3Phi4GOV50WaPHL3qN1k/sOgehn4bHJPaa63ei0YGd19zu+aDY
         cwiFH0uVzPqnLgP4P/SUx+gbzBQXZJCUkuTfrPXOs9k9/PKHRJwMe5T4Sw6YCn28pd4V
         gNG5NbdGI0fXVppR2tnHzdWAN9LRkWAPk5doIEccXSfb0ieFSmC9vGHiuiUhI2+sqmAi
         JiN6lmBUDZ869RnuE9OWLtKJLT23DVVMFssYYZoZmCH3T85l7LLk4T/0D9bE64+s9Yyr
         ixWEcR7uThL+lzDYpVeeB0PidzJqttzepvizb+3H72gadNh6DzRGpYZaAc9QmqRL3I2O
         9FbA==
X-Gm-Message-State: AA+aEWa94PftarmXDa/6gxd3RKPZ/sxiRRsEmfnsu+OIs0M2Fl6SGNdo
        WRgDz/m9671Vb5xwEjJm8eJQWEMW
X-Google-Smtp-Source: AFSGD/WuCs2XhGLOhkkif9QXxWD2kLyTmpvXrxmRd3GctHYLZXx9YEptiQUunRXK3bkyMdExfxLgOQ==
X-Received: by 2002:a19:1901:: with SMTP id 1mr10661394lfz.99.1543939270148;
        Tue, 04 Dec 2018 08:01:10 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o17sm2994042lff.77.2018.12.04.08.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:01:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gUD8I-0006Pw-QE; Tue, 04 Dec 2018 17:01:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: [PATCH] USB: serial: console: fix reported terminal settings
Date:   Tue,  4 Dec 2018 17:00:36 +0100
Message-Id: <20181204160036.24625-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204155904.GC18087@localhost>
References: <20181204155904.GC18087@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB-serial console implementation has never reported the actual
terminal settings used. Despite storing the corresponding cflags in its
struct console, this was never honoured on later tty open() where the
tty termios would be left initialised to the driver defaults.

Unlike the serial console implementation, the USB-serial code calls
subdriver open() already at console setup. While calling set_termios()
before open() looks like it could work for some USB-serial drivers,
others definitely do not expect this, so modelling this after serial
core is going to be intrusive, if at all possible.

Instead, use a (renamed) tty helper to save the termios data used at
console setup, so that the tty termios reflects the actual terminal
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
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Florian Zumbiehl <florz@florz.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c         | 11 +++++++++--
 drivers/usb/serial/console.c |  2 +-
 include/linux/tty.h          |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ee80dfbd5442..687250ec8032 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1373,7 +1373,13 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
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
@@ -1392,6 +1398,7 @@ static void tty_free_termios(struct tty_struct *tty)
 	}
 	*tp = tty->termios;
 }
+EXPORT_SYMBOL_GPL(tty_save_termios);
 
 /**
  *	tty_flush_works		-	flush all works of a tty/pty pair
@@ -1491,7 +1498,7 @@ static void release_tty(struct tty_struct *tty, int idx)
 	WARN_ON(!mutex_is_locked(&tty_mutex));
 	if (tty->ops->shutdown)
 		tty->ops->shutdown(tty);
-	tty_free_termios(tty);
+	tty_save_termios(tty);
 	tty_driver_remove_tty(tty->driver, tty);
 	tty->port->itty = NULL;
 	if (tty->link)
diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index 17940589c647..7d289302ff6c 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -101,7 +101,6 @@ static int usb_console_setup(struct console *co, char *options)
 		cflag |= PARENB;
 		break;
 	}
-	co->cflag = cflag;
 
 	/*
 	 * no need to check the index here: if the index is wrong, console
@@ -164,6 +163,7 @@ static int usb_console_setup(struct console *co, char *options)
 			serial->type->set_termios(tty, port, &dummy);
 
 			tty_port_tty_set(&port->port, NULL);
+			tty_save_termios(tty);
 			tty_kref_put(tty);
 		}
 		tty_port_set_initialized(&port->port, 1);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 414db2bce715..392138fe59b6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -556,6 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
+extern void tty_save_termios(struct tty_struct *tty);
 extern int tty_standard_install(struct tty_driver *driver,
 		struct tty_struct *tty);
 
-- 
2.19.2

