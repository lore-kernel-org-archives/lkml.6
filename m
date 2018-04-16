Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeDPKSZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:18:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDPKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:18:23 -0400
Date: Mon, 16 Apr 2018 13:17:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Laura Abbott <labbott@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: [PATCH net] Revert "macsec: missing dev_put() on error in
 macsec_newlink()"
Message-ID: <20180416101750.GA19613@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414223121.GA7475@bistromath.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is just wrong, sorry.  I was trying to fix a static checker
warning and misread the code.  The reference taken in macsec_newlink()
is released in macsec_free_netdev() when the netdevice is destroyed.

This reverts commit 5dcd8400884cc4a043a6d4617e042489e5d566a9.

Reported-by: Laura Abbott <labbott@redhat.com>
Fixes: 5dcd8400884c ("macsec: missing dev_put() on error in macsec_newlink()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
---
I sent this earlier but I messed up the CC list.  I've updated the
commit message as well.

 drivers/net/macsec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9cbb0c8a896a..7de88b33d5b9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3277,7 +3277,7 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 
 	err = netdev_upper_dev_link(real_dev, dev, extack);
 	if (err < 0)
-		goto put_dev;
+		goto unregister;
 
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
@@ -3316,8 +3316,7 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 	macsec_del_dev(macsec);
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
-put_dev:
-	dev_put(real_dev);
+unregister:
 	unregister_netdevice(dev);
 	return err;
 }
-- 
2.16.2
