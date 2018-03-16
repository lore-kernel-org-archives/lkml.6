Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvoRoA10ipED3f2hXO+l2UkHFubk8PzGuB78KxF73ZavBZ2N9aQTAcxODTXtQRk8eDFfrSN
ARC-Seal: i=1; a=rsa-sha256; t=1521214962; cv=none;
        d=google.com; s=arc-20160816;
        b=fki40vtkTZgsLVHhHeyhOLPZlDplyKIPWOeD4xnNoIUau9xajKRrTyT9D03e5vYxv2
         g/P9n/GMD0YA172Ja5AnLuaWUjhj+ihN22nVY1SyqVo6xy1NDyOkubKN3OGMnHldgyua
         RRpUn1pe0Nnzcr8UgOX7MnJOw/c5ZquYZkjmhXv83TSW0jCf3+WZvJQ3U+BMzcAHQmmW
         BIJnhGwMTIFKEHdKvZcYpTjKrqN6XJ5Ym0Kcm1mJYWztpD9oVBtpFfyGmRo1RnkEHCKZ
         TEpaDXdwzfGLynGsrSJKqswjQr0iCyQDaGn8sh1G613aeipE37Sa2YkqWFVS+rwoOC38
         Lmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AS1lXyZnX4kF2YP+L1LjvMfhcbvwlXpuLwBY41oenOo=;
        b=asWvIwUJmZeJJx/0Jm77enHP2dtmYjQpz8AjbTFv6nwTuzsYBXcYdOHWzBFP9eWWal
         44I7neH0wEe5L3c2dNkdZPo6jatpAgT413ZD49f/bZHpB02rzOKk5+v3qYmhUfgT0m7I
         ZGYfc0Hbdhg52brfSijCMbY9P/yS5knZ4QInKu8By4gmIq8/cvNWu7lBG7y0P1Z8p3x5
         tehLFWgzyzJs4zqNjKMTbxUw4//EwCArrQ+Rbje75lgToi97GBDWsvL2TNfziCoQJlSb
         Ixuxz2dWZrisZoRmV+pJbSJXeOHkFuU+Z4OG58IUO1TuJoK3P0FTVbJnpt7ZXY0viByh
         fcfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 043/128] typec: tcpm: fusb302: Resolve out of order messaging events
Date: Fri, 16 Mar 2018 16:23:04 +0100
Message-Id: <20180316152338.933623386@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109042483154217?=
X-GMAIL-MSGID: =?utf-8?q?1595109500894182532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>


[ Upstream commit ab69f61321140ff632d560775bc226259a78dfa2 ]

The expectation in the FUSB302 driver is that a TX_SUCCESS event
should occur after a message has been sent, but before a GCRCSENT
event is raised to indicate successful receipt of a message from
the partner. However in some circumstances it is possible to see
the hardware raise a GCRCSENT event before a TX_SUCCESS event
is raised. The upshot of this is that the GCRCSENT handling portion
of code ends up reporting the GoodCRC message to TCPM because the
TX_SUCCESS event hasn't yet arrived to trigger a consumption of it.
When TX_SUCCESS is then raised by the chip it ends up consuming the
actual message that was meant for TCPM, and this incorrect sequence
results in a hard reset from TCPM.

To avoid this problem, this commit updates the message reading
code to check whether a GoodCRC message was received or not. Based
on this check it will either report that the previous transmission
has completed or it will pass the msg data to TCPM for futher
processing. This way the incorrect ordering of the events no longer
matters.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/fusb302/fusb302.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1543,6 +1543,21 @@ static int fusb302_pd_read_message(struc
 	fusb302_log(chip, "PD message header: %x", msg->header);
 	fusb302_log(chip, "PD message len: %d", len);
 
+	/*
+	 * Check if we've read off a GoodCRC message. If so then indicate to
+	 * TCPM that the previous transmission has completed. Otherwise we pass
+	 * the received message over to TCPM for processing.
+	 *
+	 * We make this check here instead of basing the reporting decision on
+	 * the IRQ event type, as it's possible for the chip to report the
+	 * TX_SUCCESS and GCRCSENT events out of order on occasion, so we need
+	 * to check the message type to ensure correct reporting to TCPM.
+	 */
+	if ((!len) && (pd_header_type_le(msg->header) == PD_CTRL_GOOD_CRC))
+		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
+	else
+		tcpm_pd_receive(chip->tcpm_port, msg);
+
 	return ret;
 }
 
@@ -1650,13 +1665,12 @@ static irqreturn_t fusb302_irq_intn(int
 
 	if (interrupta & FUSB_REG_INTERRUPTA_TX_SUCCESS) {
 		fusb302_log(chip, "IRQ: PD tx success");
-		/* read out the received good CRC */
 		ret = fusb302_pd_read_message(chip, &pd_msg);
 		if (ret < 0) {
-			fusb302_log(chip, "cannot read in GCRC, ret=%d", ret);
+			fusb302_log(chip,
+				    "cannot read in PD message, ret=%d", ret);
 			goto done;
 		}
-		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
 	}
 
 	if (interrupta & FUSB_REG_INTERRUPTA_HARDRESET) {
@@ -1677,7 +1691,6 @@ static irqreturn_t fusb302_irq_intn(int
 				    "cannot read in PD message, ret=%d", ret);
 			goto done;
 		}
-		tcpm_pd_receive(chip->tcpm_port, &pd_msg);
 	}
 done:
 	mutex_unlock(&chip->lock);
