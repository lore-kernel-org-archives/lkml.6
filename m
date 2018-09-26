Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42491C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9502821746
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9502821746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeI0Bxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:53:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0Bxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:53:34 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFshF-1fyvRK0r9z-00HNTr; Wed, 26 Sep 2018 21:38:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: mediatek: mark dummy helpers as 'static inline'
Date:   Wed, 26 Sep 2018 21:38:09 +0200
Message-Id: <20180926193818.2481220-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:U4TWxtICXljj/5j09tCKrv67Z85xP2cxpkeXlSTGbXjqP+u0d6H
 fcKJlK8i2GgNBaNfDoKQBEfypHR6YfYAdicoobLlFxO7rJDvex+E8KNqgykzskywRnt71HJ
 l01N/s/DiJPbXj0xTUhSZLtRDVAKTmC3UAmB7jB6O0zhPHH8Q9jtqDGBpVv1Xwy+4vqfHDT
 ZsRhx5sEZLuzGY6YSJLcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cwENl99UqBw=:yFNVMb058SugpmC5fH4kv9
 tZaTD8m93KP9FfaaAJ98TFP7f8ExZXdWxxr+CYmOtDyJGin9U+E8RYShA0DZljB8qKB+7w2ID
 NsKqStQYNFXbF9RP/ez5/uDIPzIyfhpQwTGOzk7rcZNAHMyS+lqsqwpeGtwkdQkM0k3vbVua+
 MBZarDGcT30qB0KqDASIlSohHWI5hpIy0TIUw3G3gXsO49nsVAFcfMWaBtCRu+jb50w7PlUPf
 OIolECIWbsaENcQ2mioJ7pKpH8XY17ck0BcipXFPNaBCfiTH6VBh8uHtHOI4extawgo4RuxfL
 ixHs7ISoIawJdgEvAf4macFjli3pd42e9DeaOBGHkPUFClXoEY1njetHL07Q26xuJaad3UTS3
 8UYChwH30yYj72Lx/F0KnW/kGuOx7yrmR4Tse+IekFNjsQkkZ9m7V1+K+8Pr8yNI4bmWSc8gV
 WaqOdsNdgCt5Yi+9F41JsBvhcxysjs9j4rxIGamFb7vSC0HJNx8FL7/I0SygZsK8VS/RYmgOs
 O301Gr6RkiHEptS9iolmpmO8n38xBNRJBIUlPKMo4WJ2C0SKIyfQNMTcyCqyRXV2ipkMNdh40
 i9UI+nC4/3XsqR3LtdPuNDteBrST0RVoG+H+odW16xflu1jvzyaf/qSOIMzIp8Z+zr/jhfKlp
 fzf2dLAxuIOOM9J1kYuycHyDTFgVecMaohDPEdZACjy31oUIvbNYygHEIOFUQ4HfSoS4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_eint_set_debounce and mtk_eint_find_irq are defined as stub functions
in a header file, but without marking them as 'static inline', we get
a copy for each file that includes the header:

drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_set_debounce':
pinctrl-mtk-common-v2.c:(.text+0x134): multiple definition of `mtk_eint_set_debounce'
drivers/pinctrl/mediatek/pinctrl-moore.o:pinctrl-moore.c:(.text+0x7d0): first defined here
drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_find_irq':
pinctrl-mtk-common-v2.c:(.text+0x13c): multiple definition of `mtk_eint_find_irq'

Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/mediatek/mtk-eint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
index c286a9b940f2..48468d0fae68 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.h
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -92,13 +92,13 @@ static inline int mtk_eint_do_resume(struct mtk_eint *eint)
 	return -EOPNOTSUPP;
 }
 
-int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
+static inline int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
 			  unsigned int debounce)
 {
 	return -EOPNOTSUPP;
 }
 
-int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
+static inline int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.18.0

