Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3473C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707EA20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpreQH00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707EA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937586AbeFSPNR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:13:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50717 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:12:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so1020230wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnQSKW5o2YhxDqE/nKAX2tk0JqwF4Q5eataCmZqSwi4=;
        b=bpreQH00Y8Ey+sv1dlbzJrp/uNViVpOvCxQfvYoAv19cRY+qCFgBDL3PNDpcWtFYA7
         HlrBk7NGEZc7hLw9wYPX+lThXv+VB9Kmqk1AWaow9+GqKNY8war+9lTAIU0jQeCAOhe9
         3cl3SiXOq5l4W4Lw3jgQAotHfHNu8l9GTRESA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnQSKW5o2YhxDqE/nKAX2tk0JqwF4Q5eataCmZqSwi4=;
        b=MAXhM7S26UfGSffaS38/EgqlStKgSELZm6FiiilW5ic5aMuFvm403tS3ODaskwmzY9
         7dtfnB3K/wq7qniZm0iWbwABE9YUb0s/nuRxHdUOewVRtJx++r94QTi6YFQ8/CMhScu5
         CRkZELKHuaAJz5D3O9rpPVRtTnjuvKAI88uSNV3w2vh4XUb2O8BlF/X2ftLcNcPTeiTT
         ZEVSDXqSUbhY1FX9+zoGVnJ2qTQ5Ymj4txKuujS926gwUPohoOe/F/FHqSxZQKMlEn7D
         PLhM+53zqdFcsUf9u1WAvlEKUAVpA3+VVI5s+/WcmqlqGbkm2q808bZHjGzzHABEXYgT
         1TPQ==
X-Gm-Message-State: APt69E2ymH4cmqfmQHVo3lTQkQ+OR9EA+EgdJgFd5NQ8jTf9JJIVBs4n
        fwe6xJo9A2vYPjqiiXlS0wGdIHb9bz4=
X-Google-Smtp-Source: ADUXVKLBu3kfm2jOtFvk7LAQnkJCSLVWyYzvNX74otmym/UR4kGTdEY0hJVH1w//B9Gk4NXl1El1MA==
X-Received: by 2002:a1c:988d:: with SMTP id a135-v6mr13131937wme.79.1529421136310;
        Tue, 19 Jun 2018 08:12:16 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f81-v6sm473599wmh.32.2018.06.19.08.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 08:12:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] slimbus: messaging: pass correct wbuf
Date:   Tue, 19 Jun 2018 16:12:02 +0100
Message-Id: <20180619151205.11300-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
References: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a typo while filling msg for slim_write, wbuf is
set to NULL instead of rbuf.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 457ea1f8db30..5a2ff01b394c 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -307,7 +307,7 @@ int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
 {
 	struct slim_val_inf msg;
 
-	slim_fill_msg(&msg, addr, count,  val, NULL);
+	slim_fill_msg(&msg, addr, count,  NULL, val);
 
 	return slim_xfer_msg(sdev, &msg, SLIM_MSG_MC_CHANGE_VALUE);
 }
-- 
2.16.2

