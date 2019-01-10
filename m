Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A66214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZuZIIiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfAJLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:15:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43405 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfAJLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:15:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so9314318lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leTkA6VDWwRI0ED9PAVTtmUEZJGPYfC9CIv59vOBny0=;
        b=YZuZIIiYe/b4lEoUc0NoDPsa93vLneqxp1nKl2w6FSJXDHthMAcOhzy9y03FAtYYZ8
         3Artv8/bA3mHmz4mlqixshaVryKkbj6I6DcLi/BOQVM0kdT0BGmVpgFKRHAAfsNBUbIY
         OKlPSBTp+j+XIKhZmdlcOEGjVt0hGgIS6AUG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leTkA6VDWwRI0ED9PAVTtmUEZJGPYfC9CIv59vOBny0=;
        b=Qj8L9i9JtxBATlYS5o4JwocD21RYRd8Jn/4TORlvBScC9UEJvdq+F0l0h714RVZJcK
         ppPe5R8dLw2qNBJMHZI7S977Zu9BHkZrTA3XfFjHfHcPmeXBei9uWX6bfkBg0ZucOy4r
         feq92k+MglxBlYnyxx3P2limSB40MnHCVQny5RXDZRXvvMZ41VKvIt/2MQJNTDA+tXTZ
         tNVH6+jXUCJzN8q5b0me8bmsJQ76NQNo7eBCxr37KFTqBAotvHp37E3CUXcTUkf/388e
         kYmDonuFZr3tAvjnGpxESHo9vdO5QEDQ5eOSklkz507tbVQl7hrvU+ktkyIzKWKN3adq
         itXw==
X-Gm-Message-State: AJcUukffaDwwusrJoNHqcZlWl6HIAOvOpsUIGL51I92yXjbiQo3o0V3Z
        fpXgdaBBEd2byFSxIcRRbpdjQA==
X-Google-Smtp-Source: ALg8bN7YMbtohThRzfY+Y189/Lm6uTC3wtQD5z7F3zRDEOQZrfUsBs+mNOAW6UNUp15YsSFdtsXCVg==
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr5551057ljr.53.1547118941044;
        Thu, 10 Jan 2019 03:15:41 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id i75sm14334658lfb.58.2019.01.10.03.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 03:15:40 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] dma: ixm-dma: fix warning comparison of distinct pointer types
Date:   Thu, 10 Jan 2019 12:15:35 +0100
Message-Id: <20190110111535.11235-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning got introduced by commit 930507c18304 ("arm64: add basic
Kconfig symbols for i.MX8"). Since it got enabled for arm64. The warning
haven't been seen before since size_t was 'unsigned int' when built on
arm32.

../drivers/dma/imx-dma.c: In function ‘imxdma_sg_next’:
../include/linux/kernel.h:846:29: warning: comparison of distinct pointer types lacks a cast
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                             ^~
../include/linux/kernel.h:860:4: note: in expansion of macro ‘__typecheck’
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
../include/linux/kernel.h:870:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
../include/linux/kernel.h:879:19: note: in expansion of macro ‘__careful_cmp’
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
../drivers/dma/imx-dma.c:288:8: note: in expansion of macro ‘min’
  now = min(d->len, sg_dma_len(sg));
        ^~~

Rework so that we use min_t and pass in the size_t that returns the
minimum of two values, using the specified type.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/dma/imx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index c2fff3f6c9ca..fa3ef43fe314 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -285,7 +285,7 @@ static inline int imxdma_sg_next(struct imxdma_desc *d)
 	struct scatterlist *sg = d->sg;
 	unsigned long now;
 
-	now = min(d->len, sg_dma_len(sg));
+	now = min_t(size_t, d->len, sg_dma_len(sg));
 	if (d->len != IMX_DMA_LENGTH_LOOP)
 		d->len -= now;
 
-- 
2.19.2

