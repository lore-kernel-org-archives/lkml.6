Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Kk3ttMsohFxchGY4s96MGGc4yCYkupUHMPHFASr0A0/TwCxx6IW0yNDwPdKdJEHb3opj+
ARC-Seal: i=1; a=rsa-sha256; t=1523399887; cv=none;
        d=google.com; s=arc-20160816;
        b=omQu44wKIhhcvCs/HnIcg0cOQP8vEdzgXztzUaMPpwNzqZE7WKdh3maQFklkzgqTtH
         IcAWt4f6vNv5/F1qk6Ofd5UOLwHvP7R8BmfYHd3VrWPvS8gdO/xVJmwDu1DIaYHY9awv
         PiX+xI5UzCJGUO2j8oKCs2D6lXAOM6O7GYWOWR1AJqHrVgbfK9RWrOtl3/MWlOWSvccJ
         4dAWkOacxZ8ek8Hs6Ir3YhBmT4ruPv2v1R1aGhsDagvK73K46Nql5XkmHlYezDKqmQ5w
         ZowaHOoiaEI5Bq7c1/4xOXPmHbvXFDP5w+edBQtlkjvD/z7Jmo+flc97R8VFtncoYPqT
         U+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ivF8aLS22O7Ui79aYvljUA6stsMVdE4vjaI7qMEXVwQ=;
        b=I8BWLofNMAnvHhaTFAB1TnA2FE2DdBcmoxV9Q3wXT+tIBjmeRhaD3O0S1XYk7COmq5
         xC0jo9DQMqKcszx7UHeACLOGhGkk0VbF/+tANzXKuWnlYDlCErVx120fuGvhnVlZbQ2Q
         dSEbQxKl1PTpeSyZ8SNsAOmOZXT9nEHn55/8bJJoXseuxzdWUz8jQIicZ+me08iMKU3u
         9PqexUNaNEbSjFuw/G2Jp3gairddOU2e3hADO1OTHCjPmeRQyp5ReXh/cgEdXoflT6qF
         AGhJ2CnZ5mRbwryz5lfCPuZQT45O64GsGCv4FcKlw7RG3GWERdsYUUw8iXGSDuAnNUls
         EXpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Raghuram Chary J <raghuramchary.jallipalli@microchip.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 099/138] lan78xx: Crash in lan78xx_writ_reg (Workqueue: events lan78xx_deferred_multicast_write)
Date: Wed, 11 Apr 2018 00:24:49 +0200
Message-Id: <20180410212913.661481818@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400133742270469?=
X-GMAIL-MSGID: =?utf-8?q?1597400559924150823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>


[ Upstream commit 2d2d99ec13f62d5d2cecb6169dfdb6bbe05356d0 ]

Description:
Crash was reported with syzkaller pointing to lan78xx_write_reg routine.

Root-cause:
Proper cleanup of workqueues and init/setup routines was not happening
in failure conditions.

Fix:
Handled the error conditions by cleaning up the queues and init/setup
routines.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2863,8 +2863,7 @@ static int lan78xx_bind(struct lan78xx_n
 	if (ret < 0) {
 		netdev_warn(dev->net,
 			    "lan78xx_setup_irq_domain() failed : %d", ret);
-		kfree(pdata);
-		return ret;
+		goto out1;
 	}
 
 	dev->net->hard_header_len += TX_OVERHEAD;
@@ -2872,14 +2871,32 @@ static int lan78xx_bind(struct lan78xx_n
 
 	/* Init all registers */
 	ret = lan78xx_reset(dev);
+	if (ret) {
+		netdev_warn(dev->net, "Registers INIT FAILED....");
+		goto out2;
+	}
 
 	ret = lan78xx_mdio_init(dev);
+	if (ret) {
+		netdev_warn(dev->net, "MDIO INIT FAILED.....");
+		goto out2;
+	}
 
 	dev->net->flags |= IFF_MULTICAST;
 
 	pdata->wol = WAKE_MAGIC;
 
 	return ret;
+
+out2:
+	lan78xx_remove_irq_domain(dev);
+
+out1:
+	netdev_warn(dev->net, "Bind routine FAILED");
+	cancel_work_sync(&pdata->set_multicast);
+	cancel_work_sync(&pdata->set_vlan);
+	kfree(pdata);
+	return ret;
 }
 
 static void lan78xx_unbind(struct lan78xx_net *dev, struct usb_interface *intf)
@@ -2891,6 +2908,8 @@ static void lan78xx_unbind(struct lan78x
 	lan78xx_remove_mdio(dev);
 
 	if (pdata) {
+		cancel_work_sync(&pdata->set_multicast);
+		cancel_work_sync(&pdata->set_vlan);
 		netif_dbg(dev, ifdown, dev->net, "free pdata");
 		kfree(pdata);
 		pdata = NULL;
