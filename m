Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484AxPtpB/LL9nZHiM6IhacfizQRM+u6A26zDRzT8df2LaYr9aIH1SVE/y1Dikp0JrLf8eq
ARC-Seal: i=1; a=rsa-sha256; t=1524652877; cv=none;
        d=google.com; s=arc-20160816;
        b=aiyKxv+yacgw4gsPyfYde7jAwrV5xu7337hQqKwh7MJli2m1EOtfYwqWD6DREXCONB
         n32KOTVLhnNHkqh5Ycq0OVyZ7O9ivZrN6eogQKzhYKh8dW1MxCS4bmnHRM9F6OXFJDvH
         /2fMABA7PcmWj/ZOzdp3GQuwPkqpWuFh67KH6QP+vWvJ9cDNZDfGA3LARttFD/ShOUs/
         W4KEJ7lxIIrZmm5v9Kh7Q6C5RA9vZtxar/MTRnJowd2kfTyjjzRBqTHIglGQy90sA8Yq
         u5R9dCJYa8b/Qr2rSl2EBQg2JeBrMy/I+lwcxDqzcp8aSrtoE3FFm5NJ+rEAJxwH1X3d
         6ADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c1wFJWKNUceUTGtHpVPZJnCG+gT/bQUm4muaeVVMnYI=;
        b=rCZxx13QGFZKq0z3npAwcTmkBMrqRlHrzn0S1xTzhZEp4mY5TCU6nZv8BaHA29o1NX
         OaBBEksXJjNdLoU3HkYVbLJA8c59kFHomSpG1m5XfRmRfewM/azpXhvpwoWGGhWQsCPz
         Ur/KyuLhPJI/iPHzK5b6uxtFzPlReQ1PjdK/5G//Kba6qo+a2h783UckMYvVeqL3zkE7
         qZB12sxyz318wGETzyMXbYhoML8PL/KlKBWnD3zQ/nO0wKOhxDVYJVBoUtupc4zMlZAQ
         yLHv2058b6AvvBzxcLkTciyTz85bXtdkHuaRQLJS/UjHhO23ePGlsIpd5JtXwYBnNHX4
         sbpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Spencer <aspencer@spacex.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 101/183] gianfar: prevent integer wrapping in the rx handler
Date: Wed, 25 Apr 2018 12:35:21 +0200
Message-Id: <20180425103246.520603552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714416112930195?=
X-GMAIL-MSGID: =?utf-8?q?1598714416112930195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Spencer <aspencer@spacex.com>


[ Upstream commit 202a0a70e445caee1d0ec7aae814e64b1189fa4d ]

When the frame check sequence (FCS) is split across the last two frames
of a fragmented packet, part of the FCS gets counted twice, once when
subtracting the FCS, and again when subtracting the previously received
data.

For example, if 1602 bytes are received, and the first fragment contains
the first 1600 bytes (including the first two bytes of the FCS), and the
second fragment contains the last two bytes of the FCS:

  'skb->len == 1600' from the first fragment

  size  = lstatus & BD_LENGTH_MASK; # 1602
  size -= ETH_FCS_LEN;              # 1598
  size -= skb->len;                 # -2

Since the size is unsigned, it wraps around and causes a BUG later in
the packet handling, as shown below:

  kernel BUG at ./include/linux/skbuff.h:2068!
  Oops: Exception in kernel mode, sig: 5 [#1]
  ...
  NIP [c021ec60] skb_pull+0x24/0x44
  LR [c01e2fbc] gfar_clean_rx_ring+0x498/0x690
  Call Trace:
  [df7edeb0] [c01e2c1c] gfar_clean_rx_ring+0xf8/0x690 (unreliable)
  [df7edf20] [c01e33a8] gfar_poll_rx_sq+0x3c/0x9c
  [df7edf40] [c023352c] net_rx_action+0x21c/0x274
  [df7edf90] [c0329000] __do_softirq+0xd8/0x240
  [df7edff0] [c000c108] call_do_irq+0x24/0x3c
  [c0597e90] [c00041dc] do_IRQ+0x64/0xc4
  [c0597eb0] [c000d920] ret_from_except+0x0/0x18
  --- interrupt: 501 at arch_cpu_idle+0x24/0x5c

Change the size to a signed integer and then trim off any part of the
FCS that was received prior to the last fragment.

Fixes: 6c389fc931bc ("gianfar: fix size of scatter-gathered frames")
Signed-off-by: Andy Spencer <aspencer@spacex.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2932,7 +2932,7 @@ static irqreturn_t gfar_transmit(int irq
 static bool gfar_add_rx_frag(struct gfar_rx_buff *rxb, u32 lstatus,
 			     struct sk_buff *skb, bool first)
 {
-	unsigned int size = lstatus & BD_LENGTH_MASK;
+	int size = lstatus & BD_LENGTH_MASK;
 	struct page *page = rxb->page;
 	bool last = !!(lstatus & BD_LFLAG(RXBD_LAST));
 
@@ -2947,11 +2947,16 @@ static bool gfar_add_rx_frag(struct gfar
 		if (last)
 			size -= skb->len;
 
-		/* in case the last fragment consisted only of the FCS */
+		/* Add the last fragment if it contains something other than
+		 * the FCS, otherwise drop it and trim off any part of the FCS
+		 * that was already received.
+		 */
 		if (size > 0)
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 					rxb->page_offset + RXBUF_ALIGNMENT,
 					size, GFAR_RXB_TRUESIZE);
+		else if (size < 0)
+			pskb_trim(skb, skb->len + size);
 	}
 
 	/* try reuse page */
