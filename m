Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3077CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84F2400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC84F2400A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGFNhT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:37:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbeGFNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:37:15 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lh6r1-1fvbIj1GAJ-00oaX4; Fri, 06 Jul 2018 15:36:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] stmmac: fix signed 64-bit division
Date:   Fri,  6 Jul 2018 15:36:07 +0200
Message-Id: <20180706133646.312427-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:7knJsMGAS7KwwSZw0xl8y9dA14NBAHQdD5kp0MOqjwfVBd1Di37
 0QPUQ5igf9o4nx1atH/0VcTqc2gsKYSsNiAdL/rphakAwdP7+hMXydOnLJ6TbFuDcFjERi1
 LnQ/4TwiG7N1fMpoqXCanmyQ0nlYrZflJ/k5BUyZdN+PES6nddcE7TpBSDl7hP2ZBel7B48
 XN+feB3zF3hN4xFb/5IQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p4UxxMstQB0=:pP6USaLOfPiZZSVAGkuF5g
 M8OBIc0bUqK5FqPGnAeBE3YsbFJ9/iOW2MvKdHinxbCA39aXyh8JYaeANcRKFq9LMxEWAOfLj
 Rut0zpcMzjYY9XY6BGQW14DMqoow7DmOpcUFG4j6KTMwK5Zb6B5zift6yUnPpd55gp6q9sr+N
 9KJ9EMT3WzQC/inFjxQua74sf/6lFimXy31ysKVijFJFfHCv0PIxEywcwN04f2g3iKaZebz+4
 1hdG9JKe19skgR/1+Vfw9DunJToaTHs8x1OIA7k42tHA4TnNjCfkv7kwot2ett/GtcQW44Kjr
 EID+sEAAj99PeHN1GzlKWjT680eHi03JijGvxvD+hZOlJ4XLPsPHOVTNSwr929WpCu9SFt75I
 IunEHzPlZn0WRjm6LElB6MnDfC9Q4MTzYc3Fb7tF1S+ZFBdYGqPkYbDjgGoRIMOe7IZV1kiKB
 3S3pjBhjxJyjKRJZgnNABwFFPS/elkzR5R5O25IPdx7QAl3NnY3PDUdVtYgCL8brHZ3RONu8T
 /WiWWUyPCyP1K9FO+dfNb8rGvKGdZtYhsuyrHskskYW2aCh1gb15TwD9aI6niSJiJu8jtpIye
 zAVfv1DjHjVC2+1p6dwopKTMjzMMFmO9JbKyQBhUJfwXUn/3xxYUOzIxiZDXaTtt9mpsOppqJ
 +EjYdJ9e/MOqOMoqMUtUhhE5qBMyRADvHOvr7xNiqebTry8pzQ03yWwlDNwk4LgHEvjg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I link error on 32-bit ARM points to yet another arithmetic bug:

drivers/net/ethernet/stmicro/stmmac/stmmac_tc.o: In function `tc_setup_cbs':
stmmac_tc.c:(.text+0x148): undefined reference to `__aeabi_uldivmod'
stmmac_tc.c:(.text+0x1fc): undefined reference to `__aeabi_uldivmod'
stmmac_tc.c:(.text+0x308): undefined reference to `__aeabi_uldivmod'
stmmac_tc.c:(.text+0x320): undefined reference to `__aeabi_uldivmod'
stmmac_tc.c:(.text+0x33c): undefined reference to `__aeabi_uldivmod'
drivers/net/ethernet/stmicro/stmmac/stmmac_tc.o:stmmac_tc.c:(.text+0x3a4): more undefined references to `__aeabi_uldivmod' follow

I observe that the last change to add the 'ul' prefix was incorrect,
as it did not turn the result of the multiplication into a 64-bit
expression on 32-bit architectures. Further, it seems that the
do_div() macro gets confused by the fact that we pass a signed
variable rather than unsigned into it.

This changes the code to instead use the div_s64() helper that is
meant for signed division, along with changing the constant suffix
to 'll' to actually make it a 64-bit argument everywhere, fixing
both of the issues I pointed out.

I'm not completely convinced that this makes the code correct, but
I'm fairly sure that we have two problems less than before.

Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
Fixes: c18a9c096683 ("net: stmmac_tc: use 64-bit arithmetic instead of 32-bit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 8fedc288d138..1a96dd9c1091 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -321,18 +321,16 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	speed_div = (priv->speed == SPEED_100) ? 100000 : 1000000;
 
 	/* Final adjustments for HW */
-	value = qopt->idleslope * 1024UL * ptr;
-	do_div(value, speed_div);
+	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
-	value = -qopt->sendslope * 1024UL * ptr;
-	do_div(value, speed_div);
+	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
 	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
 
-	value = qopt->hicredit * 1024UL * 8;
+	value = qopt->hicredit * 1024ll * 8;
 	priv->plat->tx_queues_cfg[queue].high_credit = value & GENMASK(31, 0);
 
-	value = qopt->locredit * 1024UL * 8;
+	value = qopt->locredit * 1024ll * 8;
 	priv->plat->tx_queues_cfg[queue].low_credit = value & GENMASK(31, 0);
 
 	ret = stmmac_config_cbs(priv, priv->hw,
-- 
2.9.0

