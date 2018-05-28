Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165256AbeE1NQf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163598AbeE1KuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 200/496] net: ethtool: dont ignore return from driver get_fecparam method
Date: Mon, 28 May 2018 11:59:45 +0200
Message-Id: <20180528100328.363581006@linuxfoundation.org>
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

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit a6d50512b4d86ecd9f5952525e454583be1c3b14 ]

If ethtool_ops->get_fecparam returns an error, pass that error on to the
 user, rather than ignoring it.

Fixes: 1a5f3da20bd9 ("net: ethtool: add support for forward error correction modes")
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2505,11 +2505,14 @@ static int set_phy_tunable(struct net_de
 static int ethtool_get_fecparam(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_fecparam fecparam = { ETHTOOL_GFECPARAM };
+	int rc;
 
 	if (!dev->ethtool_ops->get_fecparam)
 		return -EOPNOTSUPP;
 
-	dev->ethtool_ops->get_fecparam(dev, &fecparam);
+	rc = dev->ethtool_ops->get_fecparam(dev, &fecparam);
+	if (rc)
+		return rc;
 
 	if (copy_to_user(useraddr, &fecparam, sizeof(fecparam)))
 		return -EFAULT;
