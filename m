Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425069AbeE1MpG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937743AbeE1K5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:57:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 360/496] drivers: macintosh: rack-meter: really fix bogus memsets
Date: Mon, 28 May 2018 12:02:25 +0200
Message-Id: <20180528100334.948100641@linuxfoundation.org>
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

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit e283655b5abe26462d53d5196f186c5e8863af3b ]

We should zero an array using sizeof instead of number of elements.

Fixes the following compiler (GCC 7.3.0) warnings:

drivers/macintosh/rack-meter.c: In function 'rackmeter_do_pause':
drivers/macintosh/rack-meter.c:157:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
drivers/macintosh/rack-meter.c:158:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]

Fixes: 4f7bef7a9f69 ("drivers: macintosh: rack-meter: fix bogus memsets")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/macintosh/rack-meter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -154,8 +154,8 @@ static void rackmeter_do_pause(struct ra
 		DBDMA_DO_STOP(rm->dma_regs);
 		return;
 	}
-	memset(rdma->buf1, 0, ARRAY_SIZE(rdma->buf1));
-	memset(rdma->buf2, 0, ARRAY_SIZE(rdma->buf2));
+	memset(rdma->buf1, 0, sizeof(rdma->buf1));
+	memset(rdma->buf2, 0, sizeof(rdma->buf2));
 
 	rm->dma_buf_v->mark = 0;
 
