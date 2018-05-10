Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeEJV7q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:59:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:60677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeEJV7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:59:43 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] powerpc: flipper-pic: Don't match all IRQ domains
Date: Thu, 10 May 2018 23:59:18 +0200
Message-Id: <20180510215919.27808-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510215919.27808-1-j.neuschaefer@gmx.net>
References: <20180510215919.27808-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aN2P0tH3380sKJIlbw8zzrqmPPT359+KkQag4F8avqLCuhMMsuz
 1ZXeK910Cat/nAvUToTMUft7AxWUMn7PtJEc6DbiIRuW/NEDNmA/9L1DaRyI0i1HpB9dngq
 qcsnqOLEsR0T8TXJfJ1VMu+TVyBqD2dvCN347fQ9BYNFdsP2szZ385HIfH97cQOUQWhucJS
 0Pu/kAdB0fIPuiibhdmng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RqGi+EugLnM=:AGlundxWyGR5CpMCg4qxjd
 pOUpEJydT6BpCdIQwJCuFetE+9uo5Vd7Tql0TWCysLjtV6alKLvn28bYn6wqLV2Tiyx1RJodY
 RDfAW9F5BlJ+a37kYTUQCV0hgD+w/I5I3TfbFSH4d8QS7cdJcBuPh4i7pLVW7NfMQKsbNFPmO
 MHHAS1LKUw8EUFCtR1eWs2ZWheVX+/+/KRmFmk5CaOsDP+edhAS9vaUeGFT7BTEZwQIiki4qP
 4aAQtIDO1lijmfJfix+38rahYj+b1WsCvrNV+N6cMHKEp/O6XyjlVBxyWznmyyDFy+UDN5vnl
 gl3+uujLsNqvr5R30E71DudIUkW53oW8zCduzxZGU6tNiZtLw3PFQdnVLgYwxcUrkB6JgzMUu
 sHxBY/VVCP1aNEKLYnBz/Z9HlrPE6mdRSuBgDSmQEBgNngjeDhDGCcfpYiPuHsADj59oSTYyZ
 9gDQqYWu45ThYWt3GKieGHHDoLgbXA0YIuh+3hLfFxLJCWtbQqQ8fjO/XHnivTAPWvDr9Aiyw
 h8FY2IM/kLFtLx1ulgeYU8qdKwTsKAboA5yUoFOxTe2N4/0kam5auLA322XgJ4SiBG6iIXPZj
 DZHRnXbd3wrL/7/1DrerXDA9/i8BQ54UxGaCovgq/+2lvmDd/Yzo0biuwQNDoZtJbjCx/FpgG
 0K+vWd69MF0UpQWnq21zpMSXQHueQmn7edMe8Orzar6/qE3fyKgaIkQufB1Lv+jPc0iNq0iuW
 x4iE4v7WSAWJs4oF4xvvu9o5QhbZVr88RpigqYOK+S/sGaszLRgjcN0i6eaMvmU4lvvsK+8aA
 g9cX73+
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Wii, there is a secondary IRQ controller (hlwd-pic), so
flipper-pic's match operation should not be hardcoded to return 1.
In fact, the default matching logic is sufficient, and we can completely
omit flipper_pic_match.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

Note: This shouldn't break Linux on the GameCube, but I've only tested
on the Wii. Some confirmation that I didn't break interrupt handling on
the GC would be nice. (If someone still runs mainline on the GC.)
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 7206f3f573d4..db0be007fd06 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -108,16 +108,8 @@ static int flipper_pic_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static int flipper_pic_match(struct irq_domain *h, struct device_node *np,
-			     enum irq_domain_bus_token bus_token)
-{
-	return 1;
-}
-
-
 static const struct irq_domain_ops flipper_irq_domain_ops = {
 	.map = flipper_pic_map,
-	.match = flipper_pic_match,
 };
 
 /*
-- 
2.17.0
