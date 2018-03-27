Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+VzFUavSyt9l5hbXATkaO1dVBjgokR9ylaVj2n4NC0TAUZQz4Q3e8VIlgHNtl3dvnUWysD
ARC-Seal: i=1; a=rsa-sha256; t=1522168620; cv=none;
        d=google.com; s=arc-20160816;
        b=Q2D3X63xVhCa5aTeGv5JyhAHUPCRrvuBAiABvM8tojAK4it3G3Xdh/bBsr6N9Bb3gR
         ByuYpaZUyL0eF9HId3Vx5Vzx/5eJ0DS0tOSoaLpA38SEE2ry2p7XZodyAjWdEeI3T27b
         l9QLDjIWwCu14r2llfh/aXxYHq214AKCpW0gE54cBJZkRoOou4sbiWKQR0FaVB49y9dS
         BwZJYfA25v4PNbRPGfTbt6qvbquTcGacEckJexeKgo2L0nrkp0S+huOH4foryPFtrtgj
         aHJ72/E2gBn22Jq64yrKYealrENMy16mu9AAi7I7OQu3E36dVjBBM+bJ6zyK7JJ9lbaw
         l+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EDp9sC1dHZu+EXISum7C2of9PaUtY/Q0ceT3tIEadXE=;
        b=tzEZ5znnUDtUxwa1+u2EhgPlB1Iuy+MKmpHjfu9rkQ2E+XLyncA32ei/7Y/NHa1sK8
         ijO/IsnD36SAecbtLZgDw8hK/O+vs2JzYPUGPwEr6rj1tG4TY2jJHuRrYx3Fl3co0eSJ
         tjWMtRsPM6tPnTVdBCUHuq2f4004ZVvvAyHPxeWt5G/VggJl0hM2laUUfl9WH064YsdZ
         05Pxve+MUUKR6UEUDzu3+fkQgjfVqe6d7N5Rm23MUZm5ONx2dL/e3fyjaEg0H/tdSxjr
         2rws7S4GaXTHhFAmjLFmVu1xFzkeNjfiNgs419MHvfmaqIT3cIhD65y7z5nJTOY5GEq+
         DWpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Andri Yngvason <andri.yngvason@marel.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 074/101] can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
Date: Tue, 27 Mar 2018 18:27:46 +0200
Message-Id: <20180327162754.639057000@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109023717652626?=
X-GMAIL-MSGID: =?utf-8?q?1596109483196717750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit f4353daf4905c0099fd25fa742e2ffd4a4bab26a upstream.

This has been reported to cause stalls on rt-linux.

Suggested-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(stru
 
 	stats->tx_bytes += dlc;
 
-
-	/*
-	 * HM: We had some cases of repeated IRQs so make sure the
-	 * INT is acknowledged I know it's already further up, but
-	 * doing again fixed the issue
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
-
 	return NETDEV_TX_OK;
 }
 
@@ -684,12 +675,6 @@ static void cc770_tx_interrupt(struct ne
 	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
-	/*
-	 * We had some cases of repeated IRQ so make sure the
-	 * INT is acknowledged
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
 
 	stats->tx_packets++;
 	can_get_echo_skb(dev, 0);
