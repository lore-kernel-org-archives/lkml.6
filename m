Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9915E218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfBKWXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:23:24 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.71]:25720 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727405AbfBKWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:23:21 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 4E7D62FEA8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:23:20 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tJyygAwewiQertJyygQa9k; Mon, 11 Feb 2019 16:23:20 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=33010 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtJyx-004BVE-EL; Mon, 11 Feb 2019 16:23:19 -0600
Date:   Mon, 11 Feb 2019 16:23:18 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] iio: mma8452: mark expected switch fall-through
Message-ID: <20190211222318.GA21656@embeddedor>
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
X-Exim-ID: 1gtJyx-004BVE-EL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:33010
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/iio/accel/mma8452.c: In function ‘mma8452_probe’:
drivers/iio/accel/mma8452.c:1581:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ret == data->chip_info->chip_id)
      ^
drivers/iio/accel/mma8452.c:1584:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 302781126bc6..00e100fc845a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1580,7 +1580,7 @@ static int mma8452_probe(struct i2c_client *client,
 	case FXLS8471_DEVICE_ID:
 		if (ret == data->chip_info->chip_id)
 			break;
-		/* else: fall through */
+		/* fall through */
 	default:
 		ret = -ENODEV;
 		goto disable_regulators;
-- 
2.20.1

