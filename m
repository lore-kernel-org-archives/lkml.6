Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrI5H916ZqvTZbwN2OIR5nRRz1OZeXqaQJEPRnuE8xn0bKqgY1yFzJ6BRO5LbFicxGtpIFH
ARC-Seal: i=1; a=rsa-sha256; t=1526631504; cv=none;
        d=google.com; s=arc-20160816;
        b=hC22SfLKDfumHFx/iSoQ9bEvSCi+ZsjU6VLN4FEkQUwhXiM+7AR2DZ+RRqKBMv7Wc1
         Fwv/Tyfh0KgLtrTlhZv79fnzIXnAtJMnIgHsRlSWdadV4RkeIUIns6/rMxzJ0Nvdr25F
         GS+z0nBx081mGkMMLEmzqxjtAkt9XvzGezi9RZelgYlIPZqMaJhjrGYEQ2/yRy8t/v8Y
         TaL0h01thWpc95b83y0HMyhw8m/fHjmy33YoPi9pcFoC7o9ar7GFpjoehzaPCjLgJk/4
         EDKAXdqSEKd8tMeEPVM60yw/8GLKlQa3hiCkWVeDx82SEhN+WxkTVulNf7RwEA72Xjea
         +xfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RX+Th33rBkTq+w7K2294SFcxPrXNMfEKJPrvOocx5y4=;
        b=KEVn4SEEskWcdwzNWTkUkxZlcQl/Ib8oidg3MmwmkKnPyE4Em1bukR2BEXlzgrVa51
         33yjA1G8NZ32mBs3xkcf5o8Vt4ff64MfATKTrrK3tNU8gwAeAG1zqFCZoHXa69liLcnP
         Y+Q2Ycx+Z66wqf0x4iI9eRG9OVxsvgWQXjmOtnE3NqyqasRCZXomFcPCMXuh8JwOHKjG
         vl7jnT962OwHD5igV4vwYQLzBUTXtFiQnpmLlCDF62u/akPFNtTGHA+HGH4UQRr0yxaj
         jaWJYRtDOs7aaIaJGJPItdy4zICB4bI1EV1PFyRgG4qV+QwbBrGscqMgoKaTxLtL9g4+
         3lrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rYfM4vme;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rYfM4vme;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 43/55] net: systemport: Correclty disambiguate driver instances
Date: Fri, 18 May 2018 10:15:39 +0200
Message-Id: <20180518081459.462766164@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789155954752152?=
X-GMAIL-MSGID: =?utf-8?q?1600789155954752152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 1f3ccc3c3fc26468be00392ef0b2c215f9c9d054 ]

While adding the DSA notifier, we will be sending DSA notifications with
info->master that is going to point to a particular net_device instance.

Our logic in bcm_sysport_map_queues() correctly disambiguates net_device
instances that are not covered by our own driver, but it will not make
sure that info->master points to a particular driver instance that we
are interested in. In a system where e.g: two or more SYSTEMPORT
instances are registered, this would lead in programming two or more
times the queue mapping, completely messing with the logic which does
the queue/port allocation and tracking.

Fix this by looking at the notifier_block pointer which is unique per
instance and allows us to go back to our driver private structure, and
in turn to the backing net_device instance.

Fixes: d156576362c0 ("net: systemport: Establish lower/upper queue mapping")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2052,14 +2052,21 @@ static const struct net_device_ops bcm_s
 	.ndo_select_queue	= bcm_sysport_select_queue,
 };
 
-static int bcm_sysport_map_queues(struct net_device *dev,
+static int bcm_sysport_map_queues(struct notifier_block *nb,
 				  struct dsa_notifier_register_info *info)
 {
-	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	struct bcm_sysport_tx_ring *ring;
+	struct bcm_sysport_priv *priv;
 	struct net_device *slave_dev;
 	unsigned int num_tx_queues;
 	unsigned int q, start, port;
+	struct net_device *dev;
+
+	priv = container_of(nb, struct bcm_sysport_priv, dsa_notifier);
+	if (priv->netdev != info->master)
+		return 0;
+
+	dev = info->master;
 
 	/* We can't be setting up queue inspection for non directly attached
 	 * switches
@@ -2082,6 +2089,7 @@ static int bcm_sysport_map_queues(struct
 	if (priv->is_lite)
 		netif_set_real_num_tx_queues(slave_dev,
 					     slave_dev->num_tx_queues / 2);
+
 	num_tx_queues = slave_dev->real_num_tx_queues;
 
 	if (priv->per_port_num_tx_queues &&
@@ -2109,7 +2117,7 @@ static int bcm_sysport_map_queues(struct
 	return 0;
 }
 
-static int bcm_sysport_dsa_notifier(struct notifier_block *unused,
+static int bcm_sysport_dsa_notifier(struct notifier_block *nb,
 				    unsigned long event, void *ptr)
 {
 	struct dsa_notifier_register_info *info;
@@ -2119,7 +2127,7 @@ static int bcm_sysport_dsa_notifier(stru
 
 	info = ptr;
 
-	return notifier_from_errno(bcm_sysport_map_queues(info->master, info));
+	return notifier_from_errno(bcm_sysport_map_queues(nb, info));
 }
 
 #define REV_FMT	"v%2x.%02x"
