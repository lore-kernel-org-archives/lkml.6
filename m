Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogQ6ySYB2ZfKle4exgA3TS7ikaXXkCgeiUg60pfCjl5IrLcP0T7wB0uZ9Qg9mx2enlGQKY
ARC-Seal: i=1; a=rsa-sha256; t=1525116383; cv=none;
        d=google.com; s=arc-20160816;
        b=TqQK052LTa1NzwDWoNCatLE22ON8xZ9293fnvI3/DwqAB1H9jwZWFxxUzzq30eyrn2
         HxJHHPh1XYnz5tu5nKGvDuZOa1wof3yyuBYSj5fNOyaLtLqtUZdCDcx03Cn1hWxdinHM
         g/XxpJluYOWI9xv2D4FLSB4PSwzjYVTVY+bI89ajU3y4ihPLednCboiLyZKyYMV3bsDq
         iTnXCx7Cqc4+CN1ple2SgnefJ04152cay5Rm1u1xV0a6he+K/pxFQISqYwzmju3a03Ol
         V4MagXpJBdA0iF6IOBQLGen9LLszHLiPAC3YRMA0b782SGlrcDqk2blwSGRatVtnSj5J
         oF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=TortM0bnCW88BCZdhcSOdvTHuZAkzL28nqZ+6ae1ZWQ=;
        b=KeYOFIqNboyviLcldC3NFfED4X6hRxzcltDjQCKxqpMQkVgVRtMpBSvRKH/fcSruwm
         AZZ+hrT1a+xCZd6M8M8n3klPNS/er5ldY0wpDQhw5C6Hbu+zBieVRGatdFzi15NRan6Y
         enKW74go7BiQa7FKrxZ2fNqyxZ69XaSDycWFm1s8dailSzssd/jQi4ImAuPhSPtw6kq5
         9c0k+48A3bLTconiwk1yssT+qEFdHrRDz5hvClGPll5fROuF1VNH4fRbfA6JpK3ud5a+
         cUwXdgUEg2tYP1kZbjR9eqTg5ap6OIwBcI/RcKaTGp8QG548XKjF9JrfmAOqzx18z6VY
         cSQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6971C22DC0
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
Subject: [PATCH 4.9 21/61] tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
Date: Mon, 30 Apr 2018 12:24:24 -0700
Message-Id: <20180430183953.115809246@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200279464606414?=
X-GMAIL-MSGID: =?utf-8?q?1599200437586296086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
