Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F20C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DFA20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKKSuDjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DFA20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeHQDtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 23:49:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34051 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeHQDtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 23:49:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so2897228plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p0oCNQsdQUbRDMsJjqL1ysfaYPclrK2oDX4CTK64hvQ=;
        b=ZKKSuDjFWWmykcRRi7TrJRUD9PanYVvVF+B+XJS7a31kl3uxHujJ8Xgo9hd9Lmf06L
         ILt9x+BmWqYOzjtFAby7YxP131OuuHFWTmVvNDtrmMP2tq4xFV79SQnH238tHMuNXlvI
         gwysV9Z0gl3qidJ55dMd7fxH6cbgR7n3G3FGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0oCNQsdQUbRDMsJjqL1ysfaYPclrK2oDX4CTK64hvQ=;
        b=gdrIdQMpxxJyu629T0pDILHXlS9xEz+6VHTUrQo2TtqenHWsPw3LlCiY6gnJCdt/Fs
         c9MJjRIohVcwC3W6gk+6TNKtdzVnWLNsMz9A7mjbWxootduubN5Rfq4CLoOb8JtBUJra
         CvFa6pvYxLRFMQPVANXHPZC7q3PKY6AkXiwxmxT3bJXPwZQkbAfJ7p1Ea6uPjThWf9ke
         iJ2ANuXS247HtQH4iwnzXTNoYVthYOFjDWGOGTDMh5Qs8FrERltvPY0iNaaNC+rHDYEd
         o4hWZlBLqVxTb00gwAIisYJTvg+Rz998B7SYdzPMoFBwBJBFaPmEClscRfb3Ao7k7kfv
         ok4w==
X-Gm-Message-State: AOUpUlEz5YsMLbCn+l5cKgZZSCydBYWBIQKZRUT9QH9JBjzCep1u8/0V
        lHCvq4Ar9yTO/8BicGsNWofqHA==
X-Google-Smtp-Source: AA+uWPzFfByjAS59ZLfTibgnxTumeSRqs/idBgdVTqmkQLp4dBfTGhfZpm04VwOXVtwL53tTkj2Q0A==
X-Received: by 2002:a17:902:6b:: with SMTP id 98-v6mr30773992pla.68.1534466883360;
        Thu, 16 Aug 2018 17:48:03 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r23-v6sm647641pfd.144.2018.08.16.17.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 17:48:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH] remoteproc/davinci: Use %zx for formating size_t
Date:   Thu, 16 Aug 2018 17:49:19 -0700
Message-Id: <20180817004919.10805-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

da8xx_rproc_mem size is of type size_t, so use %zx to format the debug
print of it to avoid a compile warning.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/da8xx_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index e230bef71be1..d200334577f6 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -226,7 +226,7 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
 				res->start & DA8XX_RPROC_LOCAL_ADDRESS_MASK;
 		drproc->mem[i].size = resource_size(res);
 
-		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
+		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %p da 0x%x\n",
 			mem_names[i], &drproc->mem[i].bus_addr,
 			drproc->mem[i].size, drproc->mem[i].cpu_addr,
 			drproc->mem[i].dev_addr);
-- 
2.18.0

