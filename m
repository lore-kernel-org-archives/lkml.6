Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B3820875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B3820875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933092AbeGIO4w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:56:52 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeGIO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:56:50 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MRDId-1fW7A61fmp-00UYtD; Mon, 09 Jul 2018 16:56:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: aspeed: fix compile testing warning
Date:   Mon,  9 Jul 2018 16:56:03 +0200
Message-Id: <20180709145612.4166409-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:pGGVIkWKmgTZ58vQUuEMi7fAMZyR4xNewyY/2y6+GsArhO5zYvR
 wtXKXFmf5Fl77JYQofh5LFvwdd2LtspuCLvzuL8ZbRDB680jczOGrhMQQuj+3i2m7tVwi6o
 cAtzki0ltHG3HKwZw0mgA/BksuzLDm9Ypo8+rAVq0G6W7c4UjgHzlTA6kOM+kEvTauB9U67
 A4tiB9QegXob24ruoiflg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2HSErx1C5PM=:83xsIO9CQ4pdykahu20FqB
 /5qsMZjB0YjdPiCjBPhJ4KK8WJmK29QxxiZVh+1PH6rTjrqhuTpBOV6APAukrPQ4wYmI2vstP
 /501gPCtaOQQcEMTNDiI95dbfrmlvFi4FYlh6xojGC5kRkZXp3Amzg+E26sY288Q+yEMd/Hjc
 0IK2YFSaFhYNtyHzVQmIWV0fS8FBtRSLsEUdmE3q6Zvmc1zdZXg1rKfudH+r1leeQGeNtxCEZ
 MiA2TaI4zJVlIrd1pU+BHDvzU786WjeBxsyZ7s5HqTXBwXdEfaDKnqmrG1nEvSWUqpElcQexb
 AURhCg3qyM3JK7SYTbruKV+VNfkyo+1oG9l1oIP4e8Ln4jr50W55bPoYjg8RT65oYepgMh7hN
 uEvyjHdKiE+tFmsF9LndfIzvr9YmhtZmAES2mc4xI81ls5lBTU2352W5iODkfWgThLOyp4ojI
 Hd3jcUWGeGP6E7dgMcwuQBfZRrOV3+WTdGz2367r3gYPqicdM3E29kQVdQ3fRm5PnHxL175qK
 B0TdeuZLi/LW3cnySQlgKvzB/xFSJKjhWhqNVGYk0fXRcuiUiVz1HB3GUyjO9KcwlP6apdbN8
 NrNpX+J6nnJXN5s8+B8HfkVrfJK4UJqBxz+ytwDROPB24OKaPCweUnEgmEdgPO3iRaEUHAhju
 8ylHcKJdIsZj56Svqd+Z2NBmgh03OShn5G3btcq15zc9RXKN1JGXdFESy1BMwcpZuSA0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc cannot always see that BUG_ON(1) is guaranteed to not
return, so we get a warning message in some configurations:

drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]

Using a plain BUG() is easier here and avoids the problem.

Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 1e00f4045f9d..2342e154029b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -240,7 +240,7 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
 	case reg_cmdsrc1:
 		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
 	}
-	BUG_ON(1);
+	BUG();
 }
 
 #define GPIO_BANK(x)	((x) >> 5)
-- 
2.9.0

