Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsrnUOYe6MjOirRkaoZjtg8R3xWW8OMF4H7RgN647uF9Qby+IF6XZ80KpfD6dr5bakntYXL
ARC-Seal: i=1; a=rsa-sha256; t=1521214525; cv=none;
        d=google.com; s=arc-20160816;
        b=A7wKlq9OKZn1vrU9jAK1pgRgwb6/UCJlJ2MABwv305g2KcCmZGdrQZm+GjPDV6xSFB
         QwViqDNPmZJ9n+B037ukrH1TEeZob0t0c9q3O4augMYZSmmiyKM57+RjtyTFww1+IqYm
         gQuYPow7QIbwGvoynF4k8eTjacR3E27GCWRtLcLtDK8kp5rV72QM/+ymb8VDYnwcjUbW
         c8uCEaUxhAlnheEeDzSvPdU/sIv2rq1DMy3NTJhJbmBM3y2+PvA69AZtfHDtI8ucktXq
         gMnhYc6jgf9qrgFEuDd3wj4X88NUSuwngVxrpWdThjHt9TDoVos+ekgWyL52YlMWxENa
         KORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nT5RF8ORj46xEAAb6+hmlmVAygFnKLKhHMh7sX05YPw=;
        b=aX4wgRDPLV07q7O5XyEMWgcJrn25MEqilrq+Qbg3pN9Naa94xDmMbhHS0hRKq1uHYN
         T//EsE8+oXc97gGaupeDSALIllTqlzGX/XMBpz8cBSizkJhq3idhCutzvvhBjdluM/4i
         DXzXlBrr9zvx7O8nqyc+SrrfxbJnJ/SHQP7skxke2N7iUfev5nISNMsDMzto7kcyz7iC
         llsPsEhIq5W6vOCNz1tKOniMVkkpimG8G3zYXIsTxLvdnm2h5bdkvh+gzUtMlfZiYmi+
         RbWXtSJ5a3VrGadFd8TEwBRTbmU7Xh0aoZmYbwEWeYAWLUn7LrVWNVyfZNefSfZEymUH
         Ab9A==
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
Subject: [PATCH 4.14 038/109] typec: tcpm: fusb302: Resolve out of order messaging events
Date: Fri, 16 Mar 2018 16:23:07 +0100
Message-Id: <20180316152332.015163661@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109042483154217?=
X-GMAIL-MSGID: =?utf-8?q?1595109042483154217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/staging/typec/fusb302/fusb302.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -1552,6 +1552,21 @@ static int fusb302_pd_read_message(struc
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
 
@@ -1659,13 +1674,12 @@ static irqreturn_t fusb302_irq_intn(int
 
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
@@ -1686,7 +1700,6 @@ static irqreturn_t fusb302_irq_intn(int
 				    "cannot read in PD message, ret=%d", ret);
 			goto done;
 		}
-		tcpm_pd_receive(chip->tcpm_port, &pd_msg);
 	}
 done:
 	mutex_unlock(&chip->lock);
