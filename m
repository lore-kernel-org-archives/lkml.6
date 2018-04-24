Return-Path: <luc.vanoostenryck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524575757; cv=none;
        d=google.com; s=arc-20160816;
        b=OUbdBbk1/qaAVC4d5pNxIVw7uxpbD6QNLIet2tsCOVqgqal4dQwgUjHJ5jAyJamAY2
         FP9Di1fag0Oh2Yfbz/RBsunQhYwYq1Ree21sYoZVhn84p9URAX1HEPaYLvBaeWJB2p53
         PMYQIKXnM3ovKuitxw/JjcZ+SFKmi0FWMxf+X92jjnkJwMyIm3Zt6qo8JtrHY9GerMWP
         lsnhzdG99W4VuVJCST/w9zt6aFkIiO0b1wxT7E5H/XNxZzPQLv0oWvUcwL8tMKj2phOi
         q0ghk0PYUN0hYsYD764tctg7mK48v0W58ou1SdhnQTGW8ySE0hQG9NIxnBjRUZY1r3as
         DgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=C4BCamhOlXCsQ3HjdFwuzi1ooE6LyAdN3mUWX16LnLs=;
        b=N4C5++jSwbFxCcg9a/SPZ3+QF0QQTPkjvQcvoCHX4S1Jrx8GaSpsfWqwqTQVoGpPPj
         uEbtNp/miEwOqucd+wHeE6hskTR6rdaZ+tkP5XisBn0SHs2d5sFJAefl4qv17l6lGJ4d
         +lC9yNrroIfJnOyDvXpIzIE3GLF8kL0MsrssG8cdUJlS7ftJI9tZM3ZwOrUmm+RkNoNX
         pHaI4QAQCZnmPbJjKZiKboLfIYKUrya9BgVx344k1iheywe3YVjpOMLiublZP8/YKA72
         NITZWd50p23p8rX0anBz+z5m3Rnwb8zKLC/3DdpM9KHxyBafOpQdBrZuV3rJgFROuOqK
         eEaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P+6GtWeu;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P+6GtWeu;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/2gp6xFXg2bo67+ALWffSanS1lObfUuiwzM09M0XxNpLShvEjX7zBRJ73VL9zXdCB/nzZuFw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Cliff Whickman <cpw@sgi.com>,
	Robin Holt <robinmholt@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] sgi-xp: fix xpnet_dev_hard_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:15:56 +0200
Message-Id: <20180424131556.2961-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598633549415004585?=
X-GMAIL-MSGID: =?utf-8?q?1598633549415004585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Robin Holt <robinmholt@gmail.com>
---
 drivers/misc/sgi-xp/xpnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 0c26eaf5f..216d5c756 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -407,7 +407,7 @@ xpnet_send(struct sk_buff *skb, struct xpnet_pending_msg *queued_msg,
  * destination partid.  If the destination partid octets are 0xffff,
  * this packet is to be broadcast to all connected partitions.
  */
-static int
+static netdev_tx_t
 xpnet_dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xpnet_pending_msg *queued_msg;
-- 
2.17.0
