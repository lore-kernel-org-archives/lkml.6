Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqZICDihKNO/qC5ltNveDZ1DAcp/gd7C5rnbUtaEMgZN6PsUb+qMwTYdrUK2J8ZQ4OcSBzW
ARC-Seal: i=1; a=rsa-sha256; t=1526280628; cv=none;
        d=google.com; s=arc-20160816;
        b=sqO8WnsSh0kpXETR0ctM5bFsV4uMELWuVth570yyC+FaUmnvYSNWMEFZYJUBcFpiIb
         1xun98+72QW3WwexG1fDi8/ydm99QyHpj/UZX9Awe3QQsQesoKKVFvSSxIMCTnFopB+7
         4ITLSvulQliS7TFgtR3GSYiRAP0OpoN8VBChpDIck1ZlEhSUOT2AF6NcOZMF9dcK7fd7
         Ms6+YXJ8uRvUCe1NqKlsPmfQHh8Ecko6dZpeUqzsKosuH+hywRGVI4fzhCElJIVIiQcL
         QgES6ErfLWN3Nj8zpjGxu1wDS+/KiRQOsnLAU1B9447Spo9ufQsZzRg1jTAaH3mUOZJU
         RQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xu8yyolgZBNj14A1pStKm8OLdB2VM6TJ6wAYTunyN1M=;
        b=iFa3mDaW/j4zCoc31A3uqrspqVKK2FwxzrSHOcI5hoa/m+g1rfIZowbwhhY1GLDyZS
         ZCALqPEEAGdEqlxetUAPtPMP9s7vZXVq/9/0OAqu7dh7kwz6XoIfe8CwzrINgWJl+GEf
         jHYfLdsH/7FSygFvXRLuFtDZXdCrqzAfb0Y8YiL5A7sKrgcjSbE9JZYhLeIUXwcEybn9
         ey55OS4YfoNTboHOiX1LRd1ffuXFG15AgbAVWtHg8gYLKk0uBnbVknfy8hwbNf58VFla
         fbPofHP/k1T9w9xRqMQKqmi7Hj78IxPkgtEZcHaA2jDsEZcgMPcWWe/0EZtN/vY378KI
         B2rA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MBHVF7r0;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MBHVF7r0;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3.18 22/23] can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
Date: Mon, 14 May 2018 08:48:51 +0200
Message-Id: <20180514064704.975365846@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421236759746459?=
X-GMAIL-MSGID: =?utf-8?q?1600421236759746459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <extja@kvaser.com>

commit 6ee00865ffe4e8c8ba4a68d26db53c7ec09bbb89 upstream.

Increase rx_dropped, if alloc_can_skb() fails, not tx_dropped.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -850,7 +850,7 @@ static void kvaser_usb_rx_can_msg(const
 
 	skb = alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 
