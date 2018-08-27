Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD810C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4220858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrBnXDAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB4220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeH0PXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:23:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37529 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeH0PXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:23:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so11669362lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5y8f1A2LGSv4rWnyluaZwk3cmZztXT6bBDJJy++sGPI=;
        b=VrBnXDAWgLJ5x+JAZKARR1QWt/kO7N9zrOQs36lDWm3/6C+PozN+cMMY4QnAbj5rQQ
         hr8HGeU57oK3rhYQB/mrLZKY8a34P/5PSgDTmEigH5nyZuKOG0UgN9LUKotbGN2iN1mq
         9TlPwUc1HEB5DJ35+DgznO1vML0nlUdWScGUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5y8f1A2LGSv4rWnyluaZwk3cmZztXT6bBDJJy++sGPI=;
        b=NBF7+rXj3RRGhFau2ezuOQoLGLx5Vkt46Z365v7KKbZrz2F8R1Shcnp29OTCze2M95
         XlbSEkvfKOPM9XVfe6i0g0kxkDV4SVM5JRIIen3iTdxkvi2MC0UwwYWNfPk8vf/yv0hQ
         B6sS6esvpJJSHxMHqbdv3Z0d7TKUQLsLaE1UdtXTb/p6g84EPpSPNMHdXaQj0HucpYJR
         WE47e81hO4346GsK0Xy30+aETbgTmxirnCr7QCaUizAmaXAdvQtPy/i/ZpcIgsrwdwNs
         iMXKz2U99EkQ4kbcltgN8o+wDqRQLTKdr8wlblqjg+5j3cjDvy2lyw6+92GqyJGncujH
         ZSSg==
X-Gm-Message-State: APzg51BZeBTiWdeZ8ERy5fy6gwUBkU0eqQnCV32t1qiK3VUqM622hYsL
        sPkKlzQj2lX2BjDg+YlxUR46jA==
X-Google-Smtp-Source: ANB0VdYjng1xa3PJSYzbAJFifxftASjs6fkz2kWQUjyLggbGC+vaVm7uXOU2KuZDDM6MJn5jcxcpbQ==
X-Received: by 2002:a19:d98f:: with SMTP id s15-v6mr8563849lfi.103.1535369808470;
        Mon, 27 Aug 2018 04:36:48 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2724498ljb.33.2018.08.27.04.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:36:48 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
Date:   Mon, 27 Aug 2018 13:36:03 +0200
Message-Id: <20180827113605.9594-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827113605.9594-1-niklas.cassel@linaro.org>
References: <20180827113605.9594-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_SMD_RPM builds perfectly fine without CONFIG_OF set.
Remove the bogus depends of OF.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7da6e67c7ea1..ac657164a136 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -114,7 +114,7 @@ config QCOM_SMEM
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM
-	depends on RPMSG && OF
+	depends on RPMSG
 	help
 	  If you say yes to this option, support will be included for the
 	  Resource Power Manager system found in the Qualcomm 8974 based
-- 
2.17.1

