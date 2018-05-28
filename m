Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161507AbeE1KcU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161359AbeE1KcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:32:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 133/329] smsc75xx: fix smsc75xx_set_features()
Date: Mon, 28 May 2018 12:01:02 +0200
Message-Id: <20180528100253.742943168@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 88e80c62671ceecdbb77c902731ec95a4bfa62f9 ]

If an attempt is made to disable RX checksums, USB adapter is changed
but netdev->features is not, because smsc75xx_set_features() returns a
non zero value.

This throws errors from netdev_rx_csum_fault() :
<devname>: hw csum failure

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/smsc75xx.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -957,10 +957,11 @@ static int smsc75xx_set_features(struct
 	/* it's racing here! */
 
 	ret = smsc75xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
-	if (ret < 0)
+	if (ret < 0) {
 		netdev_warn(dev->net, "Error writing RFE_CTL\n");
-
-	return ret;
+		return ret;
+	}
+	return 0;
 }
 
 static int smsc75xx_wait_ready(struct usbnet *dev, int in_pm)
