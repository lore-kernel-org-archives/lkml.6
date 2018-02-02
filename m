Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226I4LVH1eo/9cqk/fqTQxTZht4vrNCW7x7Nree518Mp8kcWIuujW7A7G1XCOBvpC9S/VA3w
ARC-Seal: i=1; a=rsa-sha256; t=1517591611; cv=none;
        d=google.com; s=arc-20160816;
        b=aQOtZdGfws4f9go4LIL+kzyyiMqSikENrBZVmjoBJREXl7vDuFIz6rt+A81TnwkG1d
         9xj2ZFyjgANjP32d7sz7s68i2M5Rm5Az081xvDQDgdKlv+BxiOVL2n0yimjKtG/AJ2Gb
         Fk4r7/RQyFV8OA5EkGGTmUhuFYmGUPR7ClyBBVz+TcDGsekFPZyhsP/6U9xn6+KE1fx6
         4/ctVhrSe23PlhjwXtEYUNowGcce/jjMPMfqsjmi8gBJbx4ySbYl+diVD1TbdMG70oOx
         iN/Os0GA3trMdeV9IdFI/ccVMGXI11C9O4T54iZ0gnNgz032MnsbvB2Mefrn2ucz2UBP
         wyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QckJIdYkP+KEaS/eTbntgvcdet45nLS+cxSDBeRUSdM=;
        b=Bwxjfd0e7yPdyuULjfO8r3Mnh5hS4+PuzNJsp/rji9jScDEx1DFTeztCQw+YGYkMYA
         qNkdzvgdKNXEwDQE10x0AaFH2V+YvAOMM4uXE7WDDZjk7cbUwy2uDmaKIb7pDj/XJibU
         CGtIqOm63fA566yQ1+NJgrWxayrrMIRkKHQTecJchz6J44QfeGT1ugfSO67l0yDr9mb8
         59EGPNPoEYbJkkS3eyJwb1/p14LC0/wirHhA00Wzc9d1Ynk26SCcRvFL1tlIVye7T9ar
         ak2V0afIDPbOgsR3spsGEhcF3poW347xztgyz7ZtsHyuGFzXD6md45rCrjdoeL115K6p
         jcDg==
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
Subject: [PATCH 4.14 132/156] tty: fix data race between tty_init_dev and flush of buf
Date: Fri,  2 Feb 2018 17:58:33 +0100
Message-Id: <20180202140846.343544987@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309669814416277?=
X-GMAIL-MSGID: =?utf-8?q?1591310142071551924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1322,6 +1322,9 @@ struct tty_struct *tty_init_dev(struct t
 			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
 			__func__, tty->driver->name);
 
+	retval = tty_ldisc_lock(tty, 5 * HZ);
+	if (retval)
+		goto err_release_lock;
 	tty->port->itty = tty;
 
 	/*
@@ -1332,6 +1335,7 @@ struct tty_struct *tty_init_dev(struct t
 	retval = tty_ldisc_setup(tty, tty->link);
 	if (retval)
 		goto err_release_tty;
+	tty_ldisc_unlock(tty);
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
@@ -1344,9 +1348,11 @@ err_module_put:
 
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
@@ -405,6 +405,8 @@ extern const char *tty_name(const struct
 extern struct tty_struct *tty_kopen(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
+extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
+extern void tty_ldisc_unlock(struct tty_struct *tty);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
