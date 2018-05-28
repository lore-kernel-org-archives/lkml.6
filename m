Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939904AbeE1QPz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932253AbeE1KNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:13:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 165/185] staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr
Date: Mon, 28 May 2018 12:03:26 +0200
Message-Id: <20180528100112.426691602@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit e1a7418529e33bc4efc346324557251a16a3e79b ]

Currently the allocation of priv->oldaddr is not null checked which will
lead to subsequent errors when accessing priv->oldaddr.  Fix this with
a null pointer check and a return of -ENOMEM on allocation failure.

Detected with Coccinelle:
drivers/staging/rtl8192u/r8192U_core.c:1708:2-15: alloc with no test,
possible model on line 1723

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192u/r8192U_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1682,6 +1682,8 @@ static short rtl8192_usb_initendpoints(s
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
+		if (!priv->oldaddr)
+			return -ENOMEM;
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
