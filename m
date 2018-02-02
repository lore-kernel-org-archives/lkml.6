Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591772-2-6660058998687747180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591770; b=hx7w5dGVhiBogBj2TCFKw1VoiTqzneuCzT7I52pFTzNz48F
    5Yrsnwg3zHekU03/d7ZY29Q0a+6uuqllSQx8Daii05Jy1dY2mwrO6J/QMaYo2GB3
    uiV5Iu/aPiCytU9dmvBY7jCxErwu1se0vBj65vCzRMJnfp4C01TzYNEq/eZHej8L
    NYXNtQp2uJZJX5t7LrtWY5DZ1vFdiUCSsCRL4Le2D5G/qf/j4bfZtD99q1xtYfAE
    DNse4jq433mtyhdUj7YEWwacyv2hWZN+JwpLn8V+WimTPknjOgttDBIqRbhf+8K9
    f+rK7W9FbyyAAHWQ1oxETpm0sDFNIZrxxK54ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591770; bh=VG9GHemGnP6g5k1g7LE0HvXHHS
    aq20Gs3aAonRZt0xQ=; b=vgM7zUwhhmVypcUlgzGvL+gaXJm+qUlaAGRNBC+c4h
    rY3fjqcuPqxzcFU2aedMLhSgJwu23gQ8ookrMAmN79YaJkxNUrepC25PG+2Dqqp/
    cCCVQb1X+ZLkgE6CjlFtBnkq25JD/uB+3e1ShKdjtxn5EJP7jqnBfU4o4r5l9Djh
    lMeC6Jimt1jxO7veGNAd+29VufdIu2aXgIYm8xXVBMvylYq1FwmqGNW4nk3FZ51O
    A9n1PU998iPhFH1g4ZhPsS83TQ58C7eOCmtqHdOCHhY4Cz34bDcEtBTtpEbpSN5y
    EMaQrl5yxbsAx67RRzF4Q/oqefDJVmL+grPRt8EjuzJw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeBBRP7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:15:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbeBBRPq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:15:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>,
        Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4.15 30/55] tty: fix data race between tty_init_dev and flush of buf
Date: Fri,  2 Feb 2018 17:58:48 +0100
Message-Id: <20180202140829.255840067@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1323,6 +1323,9 @@ struct tty_struct *tty_init_dev(struct t
 			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
 			__func__, tty->driver->name);
 
+	retval = tty_ldisc_lock(tty, 5 * HZ);
+	if (retval)
+		goto err_release_lock;
 	tty->port->itty = tty;
 
 	/*
@@ -1333,6 +1336,7 @@ struct tty_struct *tty_init_dev(struct t
 	retval = tty_ldisc_setup(tty, tty->link);
 	if (retval)
 		goto err_release_tty;
+	tty_ldisc_unlock(tty);
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
@@ -1345,9 +1349,11 @@ err_module_put:
 
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
@@ -337,7 +337,7 @@ static inline void __tty_ldisc_unlock(st
 	ldsem_up_write(&tty->ldisc_sem);
 }
 
-static int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
+int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
 {
 	int ret;
 
@@ -348,7 +348,7 @@ static int tty_ldisc_lock(struct tty_str
 	return 0;
 }
 
-static void tty_ldisc_unlock(struct tty_struct *tty)
+void tty_ldisc_unlock(struct tty_struct *tty)
 {
 	clear_bit(TTY_LDISC_HALTED, &tty->flags);
 	__tty_ldisc_unlock(tty);
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -405,6 +405,8 @@ extern const char *tty_name(const struct
 extern struct tty_struct *tty_kopen(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
+extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
+extern void tty_ldisc_unlock(struct tty_struct *tty);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
