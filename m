Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224GhwUrXLWQur92vuvkBMtdwc3nFJUCJdd8DWacCj0JLtTQavcLaUr+9YAhjv4o/riOqvyq
ARC-Seal: i=1; a=rsa-sha256; t=1517591161; cv=none;
        d=google.com; s=arc-20160816;
        b=GEKQyeajQKAHuHz/Fr8yXDl9Jvoq25V0H4ZB4YscZQfeztk/JPAQnAlFWSK96TB9g5
         uTA/kdqwkoVjwMzDHLkgEkxcEiMepE2dHkevCVhj741qke8ZT5/wPFunWraXMRN8I6hp
         fZ/YBGAfOPLgl8vHZQUzBGn/7YSacnkF3PXgBOBV6BoKacJsWkioWPWRJRmCOwtk7dWZ
         o2rXIGufc0NuP1HUUyn5pI4QiG1Qou8Vbv5VFHx2J9/6+X10oKF2LB8mAGINE0gtFKya
         xf1fDegY+N0Wu0L5GSj7q9fj2LP5asVIA23HDl2s/xUY4g7eI5oFissY+uq02zXQFZto
         WFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fgAnLHaMKxlEMmjIwf4w3j1gi9urPkj5tDiN8nKunak=;
        b=tdKgixnXfuX8mmxr3SsRjP4vWwK9qeXxEHiCOp3fC/7vV6QzrXavzrTWOJ7RhhdFUt
         1VMfRsLDdpSzCeyq/gStgCfuvAjfYq/zkhhbSGKf1ZbDCoY0dEsGuwu1vOrVkwUOKlIK
         vM0eUA1r7Z3wFEKlG+HwKyOgBWr2D/OR8qo84w6TSlp5mDXdVyHmdjQjQOia0f0pkgg/
         J3OY06fTwKBJTMElgGACI4T6QmhrqSokcaVcdYVonnC/oXH85oPNDqEEosXufyHQAyhE
         kUniSzLcM8elCLFs+5ME732sySOkG4Ujn1qGgecZYl/ZBj0wb9pC9K8qxIh/gU2SChnD
         2f+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gaurav Kohli <gkohli@codeaurora.org>,
	Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4.9 72/86] tty: fix data race between tty_init_dev and flush of buf
Date: Fri,  2 Feb 2018 17:58:32 +0100
Message-Id: <20180202140829.336126023@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309669814416277?=
X-GMAIL-MSGID: =?utf-8?q?1591309669814416277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Kohli <gkohli@codeaurora.org>

commit b027e2298bd588d6fa36ed2eda97447fb3eac078 upstream.

There can be a race, if receive_buf call comes before
tty initialization completes in n_tty_open and tty->disc_data
may be NULL.

CPU0					CPU1
----					----
 000|n_tty_receive_buf_common()   	n_tty_open()
-001|n_tty_receive_buf2()		tty_ldisc_open.isra.3()
-002|tty_ldisc_receive_buf(inline)	tty_ldisc_setup()

Using ldisc semaphore lock in tty_init_dev till disc_data
initializes completely.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c    |    8 +++++++-
 drivers/tty/tty_ldisc.c |    4 ++--
 include/linux/tty.h     |    2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1543,6 +1543,9 @@ struct tty_struct *tty_init_dev(struct t
 			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
 			__func__, tty->driver->name);
 
+	retval = tty_ldisc_lock(tty, 5 * HZ);
+	if (retval)
+		goto err_release_lock;
 	tty->port->itty = tty;
 
 	/*
@@ -1553,6 +1556,7 @@ struct tty_struct *tty_init_dev(struct t
 	retval = tty_ldisc_setup(tty, tty->link);
 	if (retval)
 		goto err_release_tty;
+	tty_ldisc_unlock(tty);
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
@@ -1565,9 +1569,11 @@ err_module_put:
 
 	/* call the tty release_tty routine to clean out this slot */
 err_release_tty:
-	tty_unlock(tty);
+	tty_ldisc_unlock(tty);
 	tty_info_ratelimited(tty, "ldisc open failed (%d), clearing slot %d\n",
 			     retval, idx);
+err_release_lock:
+	tty_unlock(tty);
 	release_tty(tty, idx);
 	return ERR_PTR(retval);
 }
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -336,7 +336,7 @@ static inline void __tty_ldisc_unlock(st
 	ldsem_up_write(&tty->ldisc_sem);
 }
 
-static int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
+int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
 {
 	int ret;
 
@@ -347,7 +347,7 @@ static int tty_ldisc_lock(struct tty_str
 	return 0;
 }
 
-static void tty_ldisc_unlock(struct tty_struct *tty)
+void tty_ldisc_unlock(struct tty_struct *tty)
 {
 	clear_bit(TTY_LDISC_HALTED, &tty->flags);
 	__tty_ldisc_unlock(tty);
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -394,6 +394,8 @@ extern struct tty_struct *get_current_tt
 /* tty_io.c */
 extern int __init tty_init(void);
 extern const char *tty_name(const struct tty_struct *tty);
+extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
+extern void tty_ldisc_unlock(struct tty_struct *tty);
 #else
 static inline void console_init(void)
 { }
