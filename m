Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49khQYttFo/gYCsJnjRf5XEaq7JjIygQsOGGyD1lgeoUz8P9HlNiSiKdayYOPa7I1Iu0AnD
ARC-Seal: i=1; a=rsa-sha256; t=1523473477; cv=none;
        d=google.com; s=arc-20160816;
        b=Wai0A+1u5V9JFBOL+4FhcxVwAmr7GLMmEiwoPm8tHDRGaFiQV/h4HGcTvRwMjBaMBr
         3t+4gcfV/eHX1noiyMbn946MJKQOtZEyPrH6ZBjUgOT4R0++FTISIYdBi/klD9Cc3dm3
         a3GuLU4xTAIeEStNFF91Ci7Vn4z2ySVf+tNQjWG1lO22oNzi2mgoipUn9trLhtu6vsRX
         jzAD/DMfd9fSeSH4F6bhA4pQrX7CFa9kRGzi45Onx6a50qf17tqE4Y9SZgcsbAdJo0hz
         23k5di75G/0MRSo710CQwI0T+fE2+Ps/+kuT3DkX73Zwqs03e7ZjWIRF5nnbhJ/u2aw3
         r8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2dxGFPh7M2Vb1Rxw1xeMJ3CxIZbDtbisAlTsUEghCnc=;
        b=g0lNqvM5qdj54dswZovBrKRjmZ90mRyo0I8MuESefCs+GfadUEg95cDlp4N9sHEnpG
         mrdY9lu8OvuLWwJ/gu8/HNRYUA88voHEjmUkD2hYsPYMC1Nwsi3uzVk9d8zERFQMEjZp
         5b4bod4Nv42iyLARsAqOW2FzKNiI8ADgWzmDDWS5HljIQkgIgjKr0zNX313D8Fy+Ujc3
         CAqxYiqO59NG1ltwWarLfJ2qfVwwsV/zGKeo7mpP+cviTu9Q1wGGstoJwHpObkesBPYL
         UXJMGHnpQuMW19M9adnE/aW8mqSm9zwJDhoA+j4esAw8/kJir2pWpPT9wMtBHP9GG1Qg
         kVZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Alan Cox <alan@llwyncelyn.cymru>,
	Jiri Prchal <jiri.prchal@aksignal.cz>,
	Jiri Slaby <jslaby@suse.cz>,
	Marcel Partap <mpartap@gmx.net>,
	Michael Scott <michael.scott@linaro.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Russ Gorby <russ.gorby@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 263/310] tty: n_gsm: Allow ADM response in addition to UA for control dlci
Date: Wed, 11 Apr 2018 20:36:42 +0200
Message-Id: <20180411183633.976088548@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476303221952902?=
X-GMAIL-MSGID: =?utf-8?q?1597477725508678002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit ea3d8465ab9b3e01be329ac5195970a84bef76c5 ]

Some devices have the control dlci stay in ADM mode instead of the UA
mode. This can seen at least on droid 4 when trying to open the ts
27.010 mux port. Enabling n_gsm debug mode shows the control dlci
always respond with DM to SABM instead of UA:

# modprobe n_gsm debug=0xff
# ldattach -d GSM0710 /dev/ttyS0 &
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_receive: 00000000: f9 03 1f 01 36 f9
<-- 0) C: DM(P)
...
$ minicom -D /dev/gsmtty1
minicom: cannot open /dev/gsmtty1: No error information
$ strace minicom -D /dev/gsmtty1
...
open("/dev/gsmtty1", O_RDWR|O_NOCTTY|O_NONBLOCK|O_LARGEFILE) = -1 EL2HLT

Note that this is different issue from other n_gsm -EL2HLT issues such
as timeouts when the control dlci does not respond at all.

The ADM mode seems to be a quite common according to "RF Wireless World"
article "GSM Issue-UE sends SABM and gets a DM response instead of
UA response":

  This issue is most commonly observed in GSM networks where in UE sends
  SABM and expects network to send UA response but it ends up receiving
  DM response from the network. SABM stands for Set asynchronous balanced
  mode, UA stands for Unnumbered Acknowledge and DA stands for
  Disconnected Mode.

  An RLP entity can be in one of two modes:
  - Asynchronous Balanced Mode (ABM)
  - Asynchronous Disconnected Mode (ADM)

Currently Linux kernel closes the control dlci after several retries
in gsm_dlci_t1() on DM. This causes n_gsm /dev/gsmtty ports to produce
error code -EL2HLT when trying to open them as the closing of control
dlci has already set gsm->dead.

Let's fix the issue by allowing control dlci stay in ADM mode after the
retries so the /dev/gsmtty ports can be opened and used. It seems that
it might take several attempts to get any response from the control
dlci, so it's best to allow ADM mode only after the SABM retries are
done.

Note that for droid 4 additional patches are needed to mux the ttyS0
pins and to toggle RTS gpio_149 to wake up the mdm6600 modem are also
needed to use n_gsm. And the mdm6600 modem needs to be powered on.

Cc: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1467,6 +1467,10 @@ static void gsm_dlci_open(struct gsm_dlc
  *	in which case an opening port goes back to closed and a closing port
  *	is simply put into closed state (any further frames from the other
  *	end will get a DM response)
+ *
+ *	Some control dlci can stay in ADM mode with other dlci working just
+ *	fine. In that case we can just keep the control dlci open after the
+ *	DLCI_OPENING retries time out.
  */
 
 static void gsm_dlci_t1(unsigned long data)
@@ -1480,8 +1484,15 @@ static void gsm_dlci_t1(unsigned long da
 		if (dlci->retries) {
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
-		} else
+		} else if (!dlci->addr && gsm->control == (DM | PF)) {
+			if (debug & 8)
+				pr_info("DLCI %d opening in ADM mode.\n",
+					dlci->addr);
+			gsm_dlci_open(dlci);
+		} else {
 			gsm_dlci_close(dlci);
+		}
+
 		break;
 	case DLCI_CLOSING:
 		dlci->retries--;
@@ -1499,8 +1510,8 @@ static void gsm_dlci_t1(unsigned long da
  *	@dlci: DLCI to open
  *
  *	Commence opening a DLCI from the Linux side. We issue SABM messages
- *	to the modem which should then reply with a UA, at which point we
- *	will move into open state. Opening is done asynchronously with retry
+ *	to the modem which should then reply with a UA or ADM, at which point
+ *	we will move into open state. Opening is done asynchronously with retry
  *	running off timers and the responses.
  */
 
