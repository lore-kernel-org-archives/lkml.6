Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5B4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617342089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxqIgHHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617342089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeJIC2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:28:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46646 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbeJIC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:28:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so10473346plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0DFpLkI1lNkAOGQBFjmq2KvrwZ3ezAavaUuWVCM404M=;
        b=fxqIgHHLnh41AnjmBb2pMLDToDRT17Jxa32+2Cy+zp7fIx7L+N/JTOfoNEcgkrw5G5
         nLpTAIvb7j2PKfuMe2N3HDUZIQXF3/Ahs/ZOxVUy4V7hXfqd5CThL4dMsHjc/tcHCpWH
         QSfI14FmQ5nKO3vuYZJgQ9Zaf5iG3S9yiGyFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0DFpLkI1lNkAOGQBFjmq2KvrwZ3ezAavaUuWVCM404M=;
        b=PkViRPJjCGQfwAUR69ijvEBsd+lE6jNElx44Ig3TV5N+KxbOulfZ5wK7UDkesiZHdn
         YwVv1Q1hMz1MFch4iaxz3qcca+JIzEMAApm+oJRJa/IZiIwgnqwEM0mpb3SKbekbg7NS
         9DV4iAhQhR3cUqIkb50/Sx3r4JqaYJUjsP7Q9qbCHpDjjG63+ewuRgzkldfhM8sUULWm
         OnNYunbtqlcyARYEk8i2mCFNNf6uPqdrGjpUAZ/rdxBPbT+MQmPwfc0uZP5Zkilo/pAD
         g0HsexnMNAdZUGghWJpyLx293+QajktpBvHXgCYgqBPz5C5/JKcQK22mKxdi6jmgVHPF
         eZvw==
X-Gm-Message-State: ABuFfogrRr4M2kTGDXy1XKbvAJS0O7RSShZx8twqnZ+ADbPAJbAQfSP9
        mj66tN8P7umQFVZTR1alTNI3
X-Google-Smtp-Source: ACcGV60lNqTg5sTLhf3G+wxEdgZ8vpS2vhpwXx+N2Ol+ruVxnswHcKLIxxagVfd78KY2PyuWAOEwHA==
X-Received: by 2002:a17:902:509:: with SMTP id 9-v6mr25516482plf.155.1539026094911;
        Mon, 08 Oct 2018 12:14:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c6:20ea:9fd:1785:d893:1e98])
        by smtp.gmail.com with ESMTPSA id a15-v6sm15648035pff.8.2018.10.08.12.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:14:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] pinctrl: mediatek: pinctrl-mtk-common-v2: Make eint_m u16
Date:   Tue,  9 Oct 2018 00:44:10 +0530
Message-Id: <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SoC's which lacks EINT support, U16_MAX is assigned to both eint_m
and eint_n through macro NO_EINT_SUPPORT. This will generate integer
overflow warning because eint_m is declared as u8 type. Hence modify
the eint_m type to u16.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 991c1c56670c..6d24522739d9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -154,7 +154,7 @@ struct mtk_func_desc {
  * @eitn_n:		the eint number for this pin
  */
 struct mtk_eint_desc {
-	u8 eint_m;
+	u16 eint_m;
 	u16 eint_n;
 };
 
-- 
2.17.1

