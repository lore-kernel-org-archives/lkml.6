Return-Path: <luc.vanoostenryck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524575926; cv=none;
        d=google.com; s=arc-20160816;
        b=YmLbevobl/d5EBn+DgSwbaHD+8a0hsJBQbNU8JAywHtDKOOCqxHVgH/32B7ZsQ0Dwz
         tZhZhFzQ4dj6KBoNYlkLTYj4wMmej7GYenlhlYLFY8HWComAV5hE/pZokcaqUnwKyCDW
         QDwqwvxw4Z3tyJWOuJyiFQ6qAy+9MJdBUaOD4+JYi3R7gS3/opM83ry5U08iQlSJkfnu
         uR5zSu0HLB03qeCXl+k+RSrdynryVTG5prkPyKUKW2ggStvk++rWGFN4OYRIYY/7qlRD
         Fvjbo/CxCAOLf41J5kfImKpovYeOfwECdr7yR574KjBj7LRcao2Rn0Bc5f6Og/lH9ruT
         +0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=MRCohO7Lx2AskNmREzQd8frKDgTkt3+hF0VekPVvuqs=;
        b=wrEKoVOt3T12a8oRdCoSH49pewthCeAyGy4h5EIcVW51oGfLdpR+nPMrF9NjhPKTKv
         Cc0OtTzLa2ZU3U+/n/SW8+ebtaP/CyvrbWYIAvRTblUHTonaQD+8fZA4w/u1GsSEB1BN
         eC7rU/CeQwTdoGxLkJLG6G/MMNcEJLw8MBHp9FpPfBcVMW35Xg+ivF87bwCagG4OtRi1
         HWbM78LVk+Bfl1H7teFDPgbA9APsb8H/1Q9nznvRN2lawEodkoUCjX+UsR90suskFnXt
         aaOoTyv0q92RAP7Gx+jVrEcqtoATdP6FB5s3SphZ1rQhdsyvAJfa/V62tJeKLxoYytUD
         yg6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EW6dSFKM;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EW6dSFKM;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+uSGbAkSz223rbM/P4jnaplnQlVZ3w15FoXnrZRq8YvPdzWdz9ltvlZIEpnYd03swziWr/eQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Bhumika Goyal <bhumirks@gmail.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: f_phonet: fix pn_net_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:41 +0200
Message-Id: <20180424131844.5417-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598633726843366074?=
X-GMAIL-MSGID: =?utf-8?q?1598633726843366074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/usb/gadget/function/f_phonet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index 7889bcc05..8b72b192c 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -221,7 +221,7 @@ static void pn_tx_complete(struct usb_ep *ep, struct usb_request *req)
 	netif_wake_queue(dev);
 }
 
-static int pn_net_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t pn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct phonet_port *port = netdev_priv(dev);
 	struct f_phonet *fp;
-- 
2.17.0
