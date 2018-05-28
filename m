Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164445AbeE1Kzx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164426AbeE1Kzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 286/496] macsec: missing dev_put() on error in macsec_newlink()
Date: Mon, 28 May 2018 12:01:11 +0200
Message-Id: <20180528100331.887783491@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5dcd8400884cc4a043a6d4617e042489e5d566a9 ]

We moved the dev_hold(real_dev); call earlier in the function but forgot
to update the error paths.

Fixes: 0759e552bce7 ("macsec: fix negative refcnt on parent link")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3248,7 +3248,7 @@ static int macsec_newlink(struct net *ne
 
 	err = netdev_upper_dev_link(real_dev, dev);
 	if (err < 0)
-		goto unregister;
+		goto put_dev;
 
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
@@ -3284,7 +3284,8 @@ del_dev:
 	macsec_del_dev(macsec);
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
-unregister:
+put_dev:
+	dev_put(real_dev);
 	unregister_netdevice(dev);
 	return err;
 }
