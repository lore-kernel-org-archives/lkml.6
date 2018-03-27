Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nApeGz6C6QSdOQOLxAIrf3V3+mlg8xBlAm/yhkunXG6zyqjc0B0PswW6XBndlkI9I1iYN
ARC-Seal: i=1; a=rsa-sha256; t=1522168401; cv=none;
        d=google.com; s=arc-20160816;
        b=zbbpUDL5citzDxf4Eru/q6EQhJYdqkzKs1IbUzX19nwUdfTC1EFcZ7i1Q87bPUwXml
         u3HgNgpcE9z0aFgNT6pjklcgwSNr1BQaDX8C4aCeKmHXmuVpai/zdEq7vcNShSISC1Rl
         6sWPfan6WorF4WN4dpnGQolfhIrFanJMrmpjVg1j9EH41D+nB3A3FBtItiR04YXbdslE
         Ug6HYxz6yuGgLGhJHoeF9GNXe8crVDv5giWY+o2bOa/aUW9FMEIpftjQV1rd1A/qmPJD
         78ltz/CUI3Vy3KufDFXzyVdFhZtyD5nq79wH3wE33liZ4NSeIleLRBGLRxuQcBfm13yS
         B/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5YMyF2LjFEPS81Py27NOhva9hNRv5Yvzp05gKTQFBW8=;
        b=Tewxvf3/1Uq+d621mkHjermzPuA0ZzAy86ocn9n2SVHY2UDGZFmoBJ6CowNAQ0kGGU
         H9Qc7/WqTQ/ffskebn6XuGwLWEjVPR/i8+y9FbWknBOMebQmnT/lZn/pY5ASPfUR2kNs
         Wkzt7MV3HghhlECyQHdluQBxbXHcPzUkpMQiVWk/4U6uTTN0kAUilFaZQ3f3DrDTZKU8
         Ds29dAyUAnalPgdOqd2e2TIefb8QzydhDpq+rAnEIAY8mCkdYodSrrmW2fjf2k0Sjue+
         wrwk2JrPlMbxkq9fidwCEGews9zOKowWVQ0LWV7yHpgPExI7rhLnVCQKt6s4gnw8liKG
         +mzQ==
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
Subject: [PATCH 4.9 45/67] can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
Date: Tue, 27 Mar 2018 18:27:37 +0200
Message-Id: <20180327162729.629242896@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109023717652626?=
X-GMAIL-MSGID: =?utf-8?q?1596109254084465192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
