Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx49v3KOvm3DIy8Oqsx9XRqzJRfhsa5j5FsrdHWGfbFadrPE5y7FCdV4CkqNX93+tA0A8HnD2
ARC-Seal: i=1; a=rsa-sha256; t=1523121602; cv=none;
        d=google.com; s=arc-20160816;
        b=VSgby86Ov7iDrVZ+4PQ4VkO+KGWC1J5ErHL+26GkxGmK7/hJofOmlnLzRUo7Aqw4nU
         czFU3kk71YbyLBM8yuc6wbpq08ohS1FObTyFP7DJyoMdQEKcVqCBvlrt7wa7BiiaQY5Y
         UjdTAdgRRvU/HWwVmSTpxdrppy891vSYQAqnYKgG2YvKnaI8MmsFLmu6me8Rm6lTJo7e
         Fdz+ghBanzr0bAGb3l1CyrZZP4oyVRrzqCall14+sXOHbo1FaQp8TA5fg1bE6d6vLJCV
         2Q5GqaMgJicNFqVef45mzon32vlMLsYPcvO/MJx+ed2jNbxFxvaD6e3LdMqTLnSLCQPj
         IjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KH56Gkfq7vwGQL1Tcvoy6BiLhwaCdQF8Gq5ACgos5ss=;
        b=NXvwQwruAacpLIOE8hZ4NOhcjgCu6TfqvKF5NTxN3tMoJ5TtCkBM+Mj3kVMIvoNxhP
         rc4PfYhLkJ1ypGNJmA3b+MmGb8p/vYkFmsDxRD1QIDIYPG9YEiY0iutIeZj4uhppsO7i
         MJHwqF+H7+4l02x6LPWTw54eS4a3mb8aC2tn73Cg+/JYQKs/r5zoczWxKkH7OQ82Lpl8
         oiM/CHgiXdvBRCOdLCCIGisswM1HF8oH7yaz5ogyykXIX/czQ3J3qYwyHuz7yuQIirWQ
         zYHMUbWDe2VhryI6yTRVNt4A5VpfnMBMnTqbgVPbC4N2BuKthbkUOs3KdF1QL4H+j1aC
         jVkQ==
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
Subject: [PATCH 2/2] tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set
Date: Sat,  7 Apr 2018 10:19:51 -0700
Message-Id: <20180407171951.122759-2-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180407171951.122759-1-tony@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597108757439873677?=
X-GMAIL-MSGID: =?utf-8?q?1597108757439873677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

At least on droid 4 with control channel in ADM mode, there is no response
to Modem Status Command (MSC). Currently gsmtty_modem_update() expects to
have data in dlci->modem_rx unless debug & 2 is set. This means that on
droid 4, things only work if debug & 2 is set.

Let's fix the issue by ignoring empty dlci->modem_rx for ADM mode. In
the AMD mode, CMD_MSC will never respond and gsm_process_modem() won't
get called to set dlci->modem_rx.

And according to ts_127010v140000p.pdf, MSC is only relevant if basic
option is chosen, so let's test for that too.

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
 drivers/tty/n_gsm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2871,11 +2871,22 @@ static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
 static int gsm_carrier_raised(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
+	struct gsm_mux *gsm = dlci->gsm;
+
 	/* Not yet open so no carrier info */
 	if (dlci->state != DLCI_OPEN)
 		return 0;
 	if (debug & 2)
 		return 1;
+
+	/*
+	 * Basic mode with control channel in ADM mode may not respond
+	 * to CMD_MSC at all and modem_rx is empty.
+	 */
+	if (gsm->encoding == 0 && gsm->dlci[0]->mode == DLCI_MODE_ADM &&
+	    !dlci->modem_rx)
+		return 1;
+
 	return dlci->modem_rx & TIOCM_CD;
 }
 
-- 
2.17.0
