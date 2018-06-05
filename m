Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeFERDF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbeFERDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 13/37] irda: fix overly long udelay()
Date: Tue,  5 Jun 2018 19:01:18 +0200
Message-Id: <20180605170109.686137201@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit c9bd28233b6d0d82ac3ba0215723be0a8262c39c upstream.

irda_get_mtt() returns a hardcoded '10000' in some cases,
and with gcc-7, we get a build error because this triggers a
compile-time check in udelay():

drivers/net/irda/w83977af_ir.o: In function `w83977af_hard_xmit':
w83977af_ir.c:(.text.w83977af_hard_xmit+0x14c): undefined reference to `__bad_udelay'

Older compilers did not run into this because they either did not
completely inline the irda_get_mtt() or did not consider the
10000 value a constant expression.

The code has been wrong since the start of git history.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/irda/w83977af_ir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/irda/w83977af_ir.c
+++ b/drivers/net/irda/w83977af_ir.c
@@ -518,7 +518,9 @@ static netdev_tx_t w83977af_hard_xmit(st
 		
 		mtt = irda_get_mtt(skb);
 		pr_debug("%s(%ld), mtt=%d\n", __func__ , jiffies, mtt);
-			if (mtt)
+			if (mtt > 1000)
+				mdelay(mtt/1000);
+			else if (mtt)
 				udelay(mtt);
 
 			/* Enable DMA interrupt */
