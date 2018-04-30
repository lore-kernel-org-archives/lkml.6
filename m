Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr4V+9WGcZHg2+JSU3bXBq7ybOgK85FyrFfx2F9CAW358fBZkpBVXgqep5/yzSAv/P4+jFY
ARC-Seal: i=1; a=rsa-sha256; t=1525116488; cv=none;
        d=google.com; s=arc-20160816;
        b=emM8GPerdp0AuYKBNwBVYjZntBiMKfMZx7WvHa0UpJyeFvoZUFBZskHJoTRYj9cb8p
         EHkmhV1i8t8iM2fUO0LxBFrJFagWhPD7bxX1KSlMk8wr1nmSy0w4Uas6x2uVVV5hIQBf
         2PMpaOuzJKBFc9GFLF/I+2T55xJ/T9y2RIb09zgbL19749ye6LwWVqi8w5SwqOVY9EO4
         GI4YSgdAehiS7sbH5qR6Hd6RVenn9XrP6lDXdBpK8ejg9yn9uiVrFtVHWnsjE2RxJOzD
         VTXn6g4ytqxwFWUG4e+qLLv1appOeZc0zc0EidKXHWhIer5djMIXiSkTDsx7PncqTmti
         7zcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=wamp1KwJq8UlRhrfZiaArOMQebtGZiq2TMg/V3Ycxso=;
        b=T33mrTxolR/gtFgie4JSc47JV0qqphwPp57MGnPThwQrlcSaHFIq9i/YvD/u/0FdL0
         ps+yJ1SiewhDj5HHRGcE2gPPIt1IX2GisXG198R9IUL6XvwS9SF+0vIwe7VB5hdGN5+M
         VNVvAMTBx7ctM+znzcV7gHcL2XvwM8ujv1ZaJOkHVNv7VNr50JqxcMLihW2iRfRpbCr3
         iOGRl2ikqZ3vVWaM9taE0en0OP2Ap/GU1uIEZi+phyD2bw7ZOAlV5vsXtrHQ1rQjVLD/
         IuXDEi3VOZE/hi6jI8xT462AB3MsrHS2OvXOEwhlFMVKeb1oTswWxehwE/ky5t2lFayT
         AYpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA1C22DCC
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
Subject: [PATCH 4.16 032/113] tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
Date: Mon, 30 Apr 2018 12:24:03 -0700
Message-Id: <20180430184016.419612744@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200279464606414?=
X-GMAIL-MSGID: =?utf-8?q?1599200547144923105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -121,6 +121,9 @@ struct gsm_dlci {
 	struct mutex mutex;
 
 	/* Link layer */
+	int mode;
+#define DLCI_MODE_ABM		0	/* Normal Asynchronous Balanced Mode */
+#define DLCI_MODE_ADM		1	/* Asynchronous Disconnected Mode */
 	spinlock_t lock;	/* Protects the internal state */
 	struct timer_list t1;	/* Retransmit timer for SABM and UA */
 	int retries;
@@ -1364,7 +1367,13 @@ retry:
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
@@ -1472,6 +1481,7 @@ static void gsm_dlci_t1(struct timer_lis
 			if (debug & 8)
 				pr_info("DLCI %d opening in ADM mode.\n",
 					dlci->addr);
+			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
 			gsm_dlci_close(dlci);
