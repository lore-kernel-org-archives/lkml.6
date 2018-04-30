Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpnCZUaGMVVuYdP/F/nj5+hUOtiAjI2dgVdbNqHTNz32WgzN+UqJG48tjRPU8QbbmeqZzr5
ARC-Seal: i=1; a=rsa-sha256; t=1525116489; cv=none;
        d=google.com; s=arc-20160816;
        b=zmCoOBU4h0+ZXqZloSyxL9zYcfL8QYlSs9DFcLWQDvS7x98qw9vJuQkNYxRdtAYXbm
         5AicnYi0Un+9mewPOqdUso2KOlZaRqEfoUgjiDT/MF81Aw79LS23HYJefL6R4jeJq60q
         TKtri1pzLFxgsvBI+ueD+qqSVHyt0IhLnzS8iYhNB6Ha1/I/tSXmvosFa1Ueog3w79vE
         FTrDbfaD+VoB/oa+8yK0usz6eKkKxZuQPyW4mlONtyowDpyE+Gtv1NgGOvHv7hfTfz4W
         s7yUn8HEYxfGKq+BqQtrbcs00ciRhizPfNEA7I49/BEI2dqE6SHZwY9uGsKz43z3zmNj
         n/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+C0rQve0zF3Md3alzfS703VWhHOfbuDQ2BTC55lprKM=;
        b=YdSPIvP5HdfT2sgy1eddIamt2hA9WDOBJoinTgymCxaPHjQElbPgmSQv+bOLb0p87/
         unjnpRfZfFFGDVl8/a5WTGkpbU5VAMsvNyzmkZuurqEpUWA+UwLjdit6e1pqXPE9zVfH
         jpuqc5NZgwgFi8T7aYuwJLV+54L8nfeGraD8ZYW6HBukLi1XLwTi8W0k2KhXQvvLFT35
         Rd11DiDXxnyEjeBj+mW73nYPD0MGyZLOCTqfNOUKhPI/H0wFcUThB0oNRaeIM3QKFgj/
         36cqnFuxmHLy5BW73U6JKisanYzK/S1qYp+XjHLBT0aI27YeWZebed1O0HhM1Cj2uqvM
         thCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB9C22DBF
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
Subject: [PATCH 4.16 033/113] tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set
Date: Mon, 30 Apr 2018 12:24:04 -0700
Message-Id: <20180430184016.459739950@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200279987877864?=
X-GMAIL-MSGID: =?utf-8?q?1599200547715276741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit b2d89ad9c9682e795ed6eeb9ed455789ad6cedf1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_gsm.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2871,11 +2871,22 @@ static int gsmtty_modem_update(struct gs
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
 
