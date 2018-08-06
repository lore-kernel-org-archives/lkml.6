Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C8C219F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hu5j4Jdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C8C219F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeHFMXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:23:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50652 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHFMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:23:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so13261314wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9JA7LCMtLtUIHYZ4eob5oWeSin5WJbToJukCzkjtFbo=;
        b=hu5j4JdqU9oREAYySHXkjKnQN69h/Cz+guXlaHFCehSOESLk3MrJcASPUVfeb2gUYd
         g1B7Aep6yc2KV5wa8BLrK7wLad+mE/Om+PvZMBNkIB/E5rto4B43MgiwY9jgfe7XU/zw
         +0Z/KiZp6Wo7iqZVFMKtsVmQhaevgIdwHi+jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9JA7LCMtLtUIHYZ4eob5oWeSin5WJbToJukCzkjtFbo=;
        b=Yd8xXSjsjXpwYRqSMNb2Qtd4v8Hn8xcdavXH6Q9LTKvCoQebZ7GpJ3Q9jVyVyrBr79
         596ST/LKHhX72/b0FupFwnyWVLFGU0z1lGtz2Qr78ggVOaH6hb1XYMZk+61mqlDVQvAm
         HECqY1GlPVWkLs5wGtvcHJ72ntbCIhz7BIbR89CdhXSeE/bSrz0LmeidASyi/pS2tVFe
         kYJh2hP0nCYjikHwxlTXjDouvF8DM96fkJimFK0YJUTPDvoEPhts6d9nN84p3jRrSabI
         CWDuZSF6kGsplD6iQuyORg6fUeATH1KhsaC68QJ9jYr2wWlG1MVMMlB4cVBawIbUbhpG
         aHXQ==
X-Gm-Message-State: AOUpUlHqYqjEiRmSt+jaFnGN+ewdSvOcPkzbHGCXo1FuK3f+QidNguoj
        FEPgngsXhZeWKGd7tLnPJD/P/g==
X-Google-Smtp-Source: AAOMgpcRFnb268xMip1tIK5Pgp/v2OD6pX827sYaXhxrz5cK3vfvT7R1u83+wIJJKTbO+hR21aC5Lw==
X-Received: by 2002:a1c:207:: with SMTP id 7-v6mr11630442wmc.146.1533550485247;
        Mon, 06 Aug 2018 03:14:45 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id s2-v6sm8095644wrw.52.2018.08.06.03.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 03:14:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] ASoC: sdm845: remove unused header files
Date:   Mon,  6 Aug 2018 11:12:07 +0100
Message-Id: <20180806101209.15167-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused header files from the driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index be0cb1122036..c9884e380549 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -5,11 +5,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/atomic.h>
 #include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <linux/soc/qcom/apr.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
-- 
2.16.2

