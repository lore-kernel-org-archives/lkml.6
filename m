Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+TGlrJg4vzX7JKeT+IIT578Qha0r5+MMFV7WQloFA1K0nflM+nxL86pUYRrWt5fpkkh4qR
ARC-Seal: i=1; a=rsa-sha256; t=1522168612; cv=none;
        d=google.com; s=arc-20160816;
        b=QqJHQIiAd1rCA+GIFFbZW36EU7mSOISHx6awrlnHkQzelUpOh8gD8/pt5S7CLgZiqv
         ZIGR9cbwcevJAvI6wOnz6j+oIx8+GOeOVIZbJGv7LW8eiT2WU0TJyPSySLJeQE6fSNZb
         OIugU5+NW38K7ynfQu0fCyWkuv+ZpFiusgZMUSKQi0EZMhI0RkRYgGTn5/SBznvab9gl
         ireFraznv449HyJypcOadKVJBDoI7rh7SRFtAtXbn9rUI3kX6hEeVwIghPJv0EM3Z3Bg
         nr8vCLO6NWx8BHz5vdTPu1CKR4ZCWg0UPzylMYhCn8GVVxurHnPtgcwSYT1r4CnQhPqt
         pxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+aav3LMyCOgJpeYizY3gAsWlklz7QbIf1xs+DIbb9Wg=;
        b=b0mHJCtDiGCue8zBeNo2/Irk+4A1DU2Orme0Sy0OYw2LxQu1lO562I2Fj8RtOKEglt
         5CCUKIqIDxn6b1as7oL7kaIWKjpDRpGjlkg08xhlX5uBfu6yHxmGgJvsUT8FQBRDkpN7
         XN9GSTNIRqQlZMWd0htAlfMgS4HxyAc7uHzXV0ko6DOWEwyTeebCZJ3dsJ6tSGlg0p5O
         +DjFX0vy3BfqRoxrFYIlhV4dfnM33J6G4qKf3f8MxVKIFOxsSRdPwSn7bvWShQobWo9V
         4e/dvefsbhG+a8zx4l464ENWqdqf9hr1hsx7+prNHX/gLZv28z4wz4/702FYP+pzuvvP
         GNNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephane Grosjean <s.grosjean@peak-system.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 071/101] can: peak/pcie_fd: remove useless code when interface starts
Date: Tue, 27 Mar 2018 18:27:43 +0200
Message-Id: <20180327162754.459017834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109474825307310?=
X-GMAIL-MSGID: =?utf-8?q?1596109474825307310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Grosjean <s.grosjean@peak-system.com>

commit ffd137f7043cb30067e1bff6fe62a073ae190b23 upstream.

When an interface starts, the echo_skb array is empty and the network
queue should be started only. This patch replaces useless code and locks
when the internal RX_BARRIER message is received from the IP core, telling
the driver that tx may start.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/peak_canfd/peak_canfd.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -333,7 +333,6 @@ static int pucan_handle_status(struct pe
 
 	/* this STATUS is the CNF of the RX_BARRIER: Tx path can be setup */
 	if (pucan_status_is_rx_barrier(msg)) {
-		unsigned long flags;
 
 		if (priv->enable_tx_path) {
 			int err = priv->enable_tx_path(priv);
@@ -342,16 +341,8 @@ static int pucan_handle_status(struct pe
 				return err;
 		}
 
-		/* restart network queue only if echo skb array is free */
-		spin_lock_irqsave(&priv->echo_lock, flags);
-
-		if (!priv->can.echo_skb[priv->echo_idx]) {
-			spin_unlock_irqrestore(&priv->echo_lock, flags);
-
-			netif_wake_queue(ndev);
-		} else {
-			spin_unlock_irqrestore(&priv->echo_lock, flags);
-		}
+		/* start network queue (echo_skb array is empty) */
+		netif_start_queue(ndev);
 
 		return 0;
 	}
