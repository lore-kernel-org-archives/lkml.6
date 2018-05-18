Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqWZaawVMr2rf6hVh6ZoTCBnnIyV1ylL0iZpoI8DTMruNZpjV9CrTse9rGeUdQ0wcXfCxfU
ARC-Seal: i=1; a=rsa-sha256; t=1526631594; cv=none;
        d=google.com; s=arc-20160816;
        b=mATv217fq6TUbkZ0vjdfr6qmJJEGcRGBnQNkgBBgJnUT6EFYsjEBIaO5+GdDCaXpv4
         UDGEEN9wtA/5QbsNSeoag5uftbihYtFB3CBnqFxBgZ3lw/mqmi1jfY+21RQyruZaWTlA
         Q7ii3XdAJ6e1upSES5eggGF6nik93kDzI5tuWvqNh8+e64QNyt/go0+vrn+TJZs2uX8/
         4Lo62Vtqh7QoWPOy2cvezDegT+caNB1+U4nTLctNGmDA2as8Fme7jKPrO7uygKpWO13s
         VhQyH8skVEhpuR5h0Sc3+47Y9W+H10tcR6+0Cmi4cvZAqlkFJ5XxfcWjBDwbmKl+yqUl
         EOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rJTTOwTbL3ubhQHw/50XbswAD512hZapVoL6z1cjWbk=;
        b=lwYVY9ZXOO2msEInTNudtIu/g7SciRCeFRpQe9Gk18gZxQBH11t9pshGZd0G7EEymr
         zLR3WP9TU3eoIABIew9QgeIrs/2dPizVEOEDMjtXPwy6O60U+PeW8faQr7vkO3wV98VF
         qE/9A0KNjXYkwRGF8cGjc9piXmS4KJdfLJU1vULoRCEQU6Q+nlP3mR0wuAKCb49dZ78J
         FCJjeBEk9ORbopBvlr5P38xfX3Q4up4kJdlek5a/jXDfFXPzwGi3bYyFSD6XUKh5sTPw
         9p0lGYXbimVKlHFKHBWsBIFeC0Yf9V1HutXGE4q6WZxqyHWcOp/C8YAYG8cvTG8BX+MC
         IBwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yAbzOXzM;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yAbzOXzM;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Taglang <rob@taglang.io>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/45] net: ethernet: sun: niu set correct packet size in skb
Date: Fri, 18 May 2018 10:15:24 +0200
Message-Id: <20180518081530.697794522@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789080586007484?=
X-GMAIL-MSGID: =?utf-8?q?1600789250900392641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Taglang <rob@taglang.io>

[ Upstream commit 14224923c3600bae2ac4dcae3bf0c3d4dc2812be ]

Currently, skb->len and skb->data_len are set to the page size, not
the packet size. This causes the frame check sequence to not be
located at the "end" of the packet resulting in ethernet frame check
errors. The driver does work currently, but stricter kernel facing
networking solutions like OpenVSwitch will drop these packets as
invalid.

These changes set the packet size correctly so that these errors no
longer occur. The length does not include the frame check sequence, so
that subtraction was removed.

Tested on Oracle/SUN Multithreaded 10-Gigabit Ethernet Network
Controller [108e:abcd] and validated in wireshark.

Signed-off-by: Rob Taglang <rob@taglang.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/niu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3442,7 +3442,7 @@ static int niu_process_rx_pkt(struct nap
 
 		len = (val & RCR_ENTRY_L2_LEN) >>
 			RCR_ENTRY_L2_LEN_SHIFT;
-		len -= ETH_FCS_LEN;
+		append_size = len + ETH_HLEN + ETH_FCS_LEN;
 
 		addr = (val & RCR_ENTRY_PKT_BUF_ADDR) <<
 			RCR_ENTRY_PKT_BUF_ADDR_SHIFT;
@@ -3452,7 +3452,6 @@ static int niu_process_rx_pkt(struct nap
 					 RCR_ENTRY_PKTBUFSZ_SHIFT];
 
 		off = addr & ~PAGE_MASK;
-		append_size = rcr_size;
 		if (num_rcr == 1) {
 			int ptype;
 
@@ -3465,7 +3464,7 @@ static int niu_process_rx_pkt(struct nap
 			else
 				skb_checksum_none_assert(skb);
 		} else if (!(val & RCR_ENTRY_MULTI))
-			append_size = len - skb->len;
+			append_size = append_size - skb->len;
 
 		niu_rx_skb_append(skb, page, off, append_size, rcr_size);
 		if ((page->index + rp->rbr_block_size) - rcr_size == addr) {
