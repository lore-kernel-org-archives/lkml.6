Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqAbdGzzYeSFKB4Oq2GRtPfYjkIbEqLbhsUbFnG1de7idIHr5/g7fKFEI5YIhsP1mMxrqOa
ARC-Seal: i=1; a=rsa-sha256; t=1525116233; cv=none;
        d=google.com; s=arc-20160816;
        b=UgvKdZBjYQfZMR1/NBMmSA3VkE69rwRgurLwMKSCV65LixRKZXSeFP454ak/zL5wLd
         lGxNrKNhHQVLCiShxEQe/FQf7HWKANapNXkr9SsPdBMZWJH+/Lg9ocyVmQNIkP26s+Yh
         zjzIjbJkikGbK02vJ0Jff9vSvKz3zISPzcOB75IL/kz5JdJAkJjPrSNlU9skYQer5bCZ
         EMF3mna8WX7jz4F80+0j8Y0icFGZlPftzB+7nmRfw6+vb63eS06Zr01czDUbYXrI7K5A
         L73uY7Q9urJiKAlhbJ1jv9gcw2W8D3hbd08IsfguAhl0ET5+hF4TzmGb8lpXVvVIpmaB
         Lgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=gOsNHDEwskmBmX+0tfI+d/4f7/mshLTUz9vDrIsITt0=;
        b=xQqwIwQsHEoRx98mgmE60kRxtDZ2XaUss3H1FD1dZS3g8dPRAA8hNCFvVPbtUxkMZ0
         ppXt3gDTxSQfPSqHUIee3673vZ8SyRbGu2BOUBMGlvtDEIsdxmzFBvsW/L/4lTfg2sR/
         TNiLSZyBkLWHBqfD3A2Z+BBlBcHi1p3ZIMqxdmt54LkSJ5cDuS8G5+chC++n5bSH1KSK
         TmLb45XLEAssjHsAjd1+yu52olrqItSYdEQFSGCp8IdKdhSo4upv5zQM7vNuTwrbWSw2
         LZLeqCBc/Q5B8fjLH9efa0G3vREJfpa/au6mjxoZkkbt99EFqfMf/j+stHuT6PVv8EUu
         +OAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB56222DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Alan Cox <alan@llwyncelyn.cymru>,
	Dan Williams <dcbw@redhat.com>,
	Jiri Prchal <jiri.prchal@aksignal.cz>,
	Jiri Slaby <jslaby@suse.cz>,
	Marcel Partap <mpartap@gmx.net>,
	Merlijn Wajer <merlijn@wizzup.org>,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Michael Scott <michael.scott@linaro.org>,
	Pavel Machek <pavel@ucw.cz>,
	Peter Hurley <peter@hurleysoftware.com>,
	Russ Gorby <russ.gorby@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3.18 13/25] tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
Date: Mon, 30 Apr 2018 12:23:20 -0700
Message-Id: <20180430183911.366096677@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200279464606414?=
X-GMAIL-MSGID: =?utf-8?q?1599200279464606414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit e9ec22547986dd32c5c70da78107ce35dbff1344 upstream.

Commit ea3d8465ab9b ("tty: n_gsm: Allow ADM response in addition to UA for
control dlci") added support for DLCI to stay in Asynchronous Disconnected
Mode (ADM). But we still get long delays waiting for commands to other
DLCI to complete:

--> 5) C: SABM(P)
Q>  0) C: UIH(F)
Q>  0) C: UIH(F)
Q>  0) C: UIH(F)
...

This happens because gsm_control_send() sets cretries timer to T2 that is
by default set to 34. This will cause resend for T2 times for the control
frame. In ADM mode, we will never get a response so the control frame, so
retries are just delaying all the commands.

Let's fix the issue by setting DLCI_MODE_ADM flag after detecting the ADM
mode for the control DLCI. Then we can use that in gsm_control_send() to
set retries to 1. This means the control frame will be sent once allowing
the other end at an opportunity to switch from ADM to ABM mode.

Note that retries will be decremented in gsm_control_retransmit() so
we don't want to set it to 0 here.

Fixes: ea3d8465ab9b ("tty: n_gsm: Allow ADM response in addition to UA for control dlci")
Cc: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Dan Williams <dcbw@redhat.com>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_gsm.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -137,6 +137,9 @@ struct gsm_dlci {
 	struct mutex mutex;
 
 	/* Link layer */
+	int mode;
+#define DLCI_MODE_ABM		0	/* Normal Asynchronous Balanced Mode */
+#define DLCI_MODE_ADM		1	/* Asynchronous Disconnected Mode */
 	spinlock_t lock;	/* Protects the internal state */
 	struct timer_list t1;	/* Retransmit timer for SABM and UA */
 	int retries;
@@ -1380,7 +1383,13 @@ retry:
 	ctrl->data = data;
 	ctrl->len = clen;
 	gsm->pending_cmd = ctrl;
-	gsm->cretries = gsm->n2;
+
+	/* If DLCI0 is in ADM mode skip retries, it won't respond */
+	if (gsm->dlci[0]->mode == DLCI_MODE_ADM)
+		gsm->cretries = 1;
+	else
+		gsm->cretries = gsm->n2;
+
 	mod_timer(&gsm->t2_timer, jiffies + gsm->t2 * HZ / 100);
 	gsm_control_transmit(gsm, ctrl);
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
@@ -1488,6 +1497,7 @@ static void gsm_dlci_t1(unsigned long da
 			if (debug & 8)
 				pr_info("DLCI %d opening in ADM mode.\n",
 					dlci->addr);
+			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
 			gsm_dlci_close(dlci);
