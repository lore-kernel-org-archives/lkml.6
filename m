Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx49dOlFnBcE5ZGsvNOkLw2SJ5UZbgjWK9M2lxZykHEt9FN7r3XDieF4+VWYY644bI7+ff88E
ARC-Seal: i=1; a=rsa-sha256; t=1523121600; cv=none;
        d=google.com; s=arc-20160816;
        b=RvoB/Q2RyV3NI8KbX6GymbHr4Cb9pwI/TJVmSey86BT/3V6s9128yIct+n20aUPYKn
         Jsu3pRnCGSCyeQR47n25QvGf9SrErhnIS2TKmOcDw/DAy6usMrrobcYvP42MGLitkLok
         7WedE++Tj0fsP9j3X7mjd+VGAU+7c4jjc1Ew8paWl3I2UN9N0aB8knRlsimhdzMd9tfh
         dbyOzl7Y68Z3pRDnNuL9TRr1Jwn78E/4ejj+4L/xDzaNzjD3iH+QljsPtJj6tUucoYVj
         NCdH1slkyT2z1b5s+wXoQLHMgGKRkNfSPc4TJD0fh0JzgFDn5x/NrjgDTy5Dnn8g/FPM
         In/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WKu6Tl7gGEMWDYU1H1shkE+ojWwmE/QZ8MJzXV/DYxs=;
        b=x4EVlWJoc21o7amL0wjO5pIND+zkVC+wgF0D20OZ20JDmt8LvQgIYv1aEHzlcB/kCP
         FKEJ7FGeWOiMq4LGhkztRd7mVqJzscsXJa0PnnCTkkv/4kijUy76kYuCkTMaijjxmc3V
         AzeYAMHAjwJEz7tccKo8VfpvPh3TunAehjzKshWjcX1oxj/QVKPodk9m8+KpGt/2s3H6
         G0IMlkiwcKLuSA0BJaBNEAtRyw3o3uO/RglcMySLuifUzdWuj9pPQKkdkaZV4tG6Pg6s
         hTroegzpjPcwJTw0eY6o7o0+Fr/TDtyFDFg5agFYknBKYJXIxr/NWniOqz7V5QFyUF8L
         msEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
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
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
Date: Sat,  7 Apr 2018 10:19:50 -0700
Message-Id: <20180407171951.122759-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597108755036082132?=
X-GMAIL-MSGID: =?utf-8?q?1597108755036082132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/tty/n_gsm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
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
@@ -1364,7 +1367,13 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
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
@@ -1472,6 +1481,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			if (debug & 8)
 				pr_info("DLCI %d opening in ADM mode.\n",
 					dlci->addr);
+			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
 			gsm_dlci_close(dlci);
-- 
2.17.0
