Return-Path: <luc.vanoostenryck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524575921; cv=none;
        d=google.com; s=arc-20160816;
        b=eW99AeSW1SrTYeI1miVCakgrJSuc4j3xPmZFej0yrgeHvAsRvlgOqK8uEzlIEOqdRg
         gqW5CKXYQ4XpGOYNirC7Dzdkc3nTG0RXtdE187p5Bp/0qJRzZhah3bNs4vmptuVatUIW
         YwMeH2Q/qW/4EHD9aVIRyW9Hb1FiHDvXwPuQiKjIYBBMAHN/UohBEkqt/9G6l0u2BKDH
         ieJ+TpYAasfijfir+1V/QCdBrU9KJKb4hAzlWWmul4I/LA4wNLvYOefwRfg5UJPiMSAk
         MtNrvJgVF/rxH4+Ql2grkLg9g9WdubtYfSdzhEnD7cQNLREBs0XiHdHRQqvwqtH/Izxt
         Hbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xLvR/HRcHL3Y9WSadO8cFo0tJpj5rVNndfqUcfQG4vo=;
        b=Y3/ub0v+B+9Q2dq9S/FhzHTCyBnxG1X03NTBMhZ+lvifkU6iDcgbQYyUNduPRtNuNa
         Gm1lAtOMQj1HLzDOP2sDZpbpk6aVEoajctq4zr5va10rRHNlOWsX/VxXWZWnFZ2r4Hb6
         mMhi2NxXcIJTrZXEUImRTojSZicTivvJerC+YRSwsnkXzE5J97AEyWA/1YO4ZeBPri5z
         bA8ZoMae2wbEGIjHCR6qpLzDu53G8u/Di0GaXa5fVLlgDLiHBVvTIUUi3W9HVlgYES5T
         hQ5JlB6EPPqsdxPkmLYlxgA7+pMA0puxDIMLdfd87nXU2iP7JBBRMCHL7ZVCUDmERJxc
         cy4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bZVQ10o9;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bZVQ10o9;
       spf=pass (google.com: domain of luc.vanoostenryck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=luc.vanoostenryck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/oCmmLO4bAB1+J57dTIgYAbE4AO/6FT79bHZRZcbQw304MOQ0yBUQsfPlondbspzALc/9kiQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] tty: n_gsm: fix gsm_mux_net_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:39 +0200
Message-Id: <20180424131840.5368-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598633721377223511?=
X-GMAIL-MSGID: =?utf-8?q?1598633721377223511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3b3e1f663..349c2e967 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2665,7 +2665,7 @@ static inline void muxnet_put(struct gsm_mux_net *mux_net)
 	kref_put(&mux_net->ref, net_free);
 }
 
-static int gsm_mux_net_start_xmit(struct sk_buff *skb,
+static netdev_tx_t gsm_mux_net_start_xmit(struct sk_buff *skb,
 				      struct net_device *net)
 {
 	struct gsm_mux_net *mux_net = netdev_priv(net);
-- 
2.17.0
