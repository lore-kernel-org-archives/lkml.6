Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2BAECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7520850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeGTIqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:46:53 -0400
Received: from mout.perfora.net ([74.208.4.196]:45655 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeGTIqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:46:52 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LvSth-1g73xt3YpP-010gY9; Fri, 20 Jul 2018 09:54:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH] clk: tegra: probe deferral error reporting
Date:   Fri, 20 Jul 2018 09:54:22 +0200
Message-Id: <20180720075422.26563-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:jSx3S0+Uw0BKBltfDbK5KOWw2TH5eiiBRFwjtcOQwEofY98Acqh
 0m0Um3CdtedhxpxECOG1fScHNIJyIIjeI+E9j9KlNmBYu+HEQMzeFx11wb0716LZprsW6gd
 E0ZG94cwX+2ooKqo3cWkpjEcJaaywTfOUb8FuB1KGshooqWu6GVx0IXEjMTag0BLzcZO1bf
 y7aSxqb1LivFeiJz/NHZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QtTHvtuSO/8=:dDxUUM7AGw2JZztqPCG1r1
 iSTI/x+dDvNWzqI3sz3k1RBjFmy+VBL41MYXdGFbRfO7Z2QHczt29PZ30872vVUCAihKY3hQV
 +tpJFIO2ygh5KDBZlr18aS0t4vjTRkl8dpat4kyYH++CqonPmhZYSPzJKoqynmt8P8Fr6sLh/
 CiBuSkBAdHxK/cntmEngf8ijt4flD8kblVPizUgar/JJhCHpyznCU58X+KBjm5y9z+HTcBY96
 AYYRv/hbGlf98Rcpbr7REZm0zHJiu+rdxYXsGE+LtWHq7hNJm2gCA/gXefKcCCxfpl+yIww5A
 HxZtS7fsczwwGcX7N2hwRzmwamZBdjZD0lniTfJbYHYHBaXh8CmjiZdHu/LTjEapQIWU3o3bm
 l3ds6tSmxT69nkiBLxllm/fSrhk24MOMFpPWfTVpwkWTRuYzpe1uIJMRaFg1+xjOOuNY8Nnd1
 e4ef8xP1WIBfmsdIkWvCPN9lsPDTDYQt7ytRFtPmiabno5Pq2xWw8A95Ve/lGSc/8aKpUgLTY
 FFjSugRQtfugp+AuWKUG2Q/3qcyLPnksPURDXtelKLyv1l7p3ykI8tf8bER5ZQIZKNzdYhG4r
 DGSmU5k/HkO+k6e+j/ZrYl0YPc4E8geCr6gXvBpfj0q9ds2fuA0scgJeM7NZnITV3yH4Ta7ek
 OCWxCFJJc3aO8Fy7+l5HhCfRUZBvM91dWgrbaixC0gVtGSIGSvWC2KwMYenP/ZjfiAFo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error code from devm_regulator_get() which may as
well just be a probe deferral.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/clk/tegra/clk-dfll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 48ee43734e05..b2123084e175 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1609,8 +1609,9 @@ int tegra_dfll_register(struct platform_device *pdev,
 
 	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
 	if (IS_ERR(td->vdd_reg)) {
-		dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
-		return PTR_ERR(td->vdd_reg);
+		ret = PTR_ERR(td->vdd_reg);
+		dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n", ret);
+		return ret;
 	}
 
 	td->dvco_rst = devm_reset_control_get(td->dev, "dvco");
-- 
2.14.4

