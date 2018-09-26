Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4CCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE92A20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE92A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIZTLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:11:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:11:39 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MIMOy-1g1uGN49kC-00EMbd; Wed, 26 Sep 2018 14:58:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sprd: don't mark remove function as __exit
Date:   Wed, 26 Sep 2018 14:58:21 +0200
Message-Id: <20180926125833.2225931-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:fNKgtJWj17TIxjEo3MAKRXHvevG7DRPgoBRViWCEWdGYz2znHdG
 7mzJDyXzjqchK03K6wyAd8tNk78aGTFOE6IyNMlZZYy1yw2HmLQH1hT/QAs6tm4To7n8+Fm
 nEmISL09Bf0pu+yue9G4uyn8OIsNqFky78358YwSoVyOY4gU3GiGNwd0fVUOKahludsiIXM
 4CbN0PF2PG6q41cBGRpPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dS/1xTYKdkY=:Kl2FRuZLFERXC4mfcSbENJ
 l99WhwLkcidBYR+ybcWL7b16HCw+vu5seI1LwN/F//+0W7qGslGqIvI/VDqidMjRT5cK00niq
 mfwcq5w06MN42+a8LI5BusjGb8rLx6Zxo2ejtiGuepqNoWZCtUS3o/PyI7wj+T2WIcRvZ9c95
 KjwL58V7KKHF78bKRph983NtcuiQ57zPF8BDuUJvcyT8BO+olDnFGMjoIV20QHOp94ZxTFlOH
 g0sKrebYKtU750TNeOKEtdiGNSFf1ablq73jZX+QJplFBwUHEHuJfXkrVpif0KltkxIcCF7gX
 /TxAyMQ+Zczr/AJ6KO7vBCr8nlt5/EPACZ9F8P24UQzTr0fV1pTCcNbiZU/VTai3SieVlvIPg
 2Csllu70KdJK+8ytmlmJsgzpKul5hFIviMXI7cKipgZSkuaH3eRLsO4jTfkC5bFq91BNs5B3j
 y0on/Bvd7z4Ehzjg0eInTyvrdwFvJm3uVRkf/a3+bFMLUjT3waQgsSTSCtyl2wqdEetrlqKEU
 pXMtZgw4yY0depIRs8/6P4OBZSiGCsYrdj4wsUxytOKemGJwRlRY3T1Vm3xSZ0cCAfWLB1V/s
 RefLPMM7F5pVljXpJLVms/nwQ/ib5kUt5FjQ3nLlJ6x1IntfMsSpXv52ewwTmPEeTM+eqYZG/
 4RQwTpVImwd+9JAD58aKFNgR+onI7olLZKEJO6Onr9Qm5W6Q6lk/odMGY8xtrkW7vjlA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __exit section is left out for built-in drivers, so a
'remove' callback must not be marked as such to avoid breaking when
we unbind a device at runtime. This was pointed out by kbuild:

`sprd_spi_remove' referenced in section `.data' of drivers/spi/spi-sprd.o: defined in discarded section `.exit.text' of drivers/spi/spi-sprd.o

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index a9a6c5ed443f..8daa24eec624 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -676,7 +676,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sprd_spi_remove(struct platform_device *pdev)
+static int sprd_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr = platform_get_drvdata(pdev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
-- 
2.18.0

