Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12341C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EBC218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfBKWOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:14:16 -0500
Received: from gateway36.websitewelcome.com ([50.116.126.2]:42002 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbfBKWOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:14:15 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 7CAE640127343
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:28:20 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tJqBgIrkMdnCetJqBgIBOn; Mon, 11 Feb 2019 16:14:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=59992 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtJqA-0046sS-D5; Mon, 11 Feb 2019 16:14:14 -0600
Date:   Mon, 11 Feb 2019 16:14:13 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] i3c: master: dw-i3c-master: mark expected switch fall-through
Message-ID: <20190211221413.GA21822@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtJqA-0046sS-D5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:59992
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/i3c/master/dw-i3c-master.c: In function ‘dw_i3c_master_bus_init’:
drivers/i3c/master/dw-i3c-master.c:603:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ret)
      ^
drivers/i3c/master/dw-i3c-master.c:605:2: note: here
  case I3C_BUS_MODE_PURE:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i3c/master/dw-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index bb03079fbade..59279224e07f 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -602,6 +602,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 		ret = dw_i2c_clk_cfg(master);
 		if (ret)
 			return ret;
+		/* fall through */
 	case I3C_BUS_MODE_PURE:
 		ret = dw_i3c_clk_cfg(master);
 		if (ret)
-- 
2.20.1

