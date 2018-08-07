Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BB21707
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0v0T8KO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5BB21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbeHGOfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:35:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42031 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbeHGOfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:35:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so15562531wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ax9UHW3ewkE4/uBesYwUO7e7O7TyW+sjcfNTMdNL530=;
        b=W0v0T8KOHI7gB1OWRZTepzBIYC7YFbyVjgsktKUDshZvu9AH3wmpYZ+XRfI44PlkLy
         XtDa7LHS4R668W5lCBQvaBS5EUlUEKIDor+sZWSWFgtWELKvTVlCmyWQC1hYK8hlMrJ2
         7pSGh5CNL4l49XD4uY+P0c+m+JF2zwI2x9jcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ax9UHW3ewkE4/uBesYwUO7e7O7TyW+sjcfNTMdNL530=;
        b=QNC3KTLurt/xyhx8jmgo/H3Q9E7a7WyNbt/1ucLN8/+VA0MJBn+BieBnebWUmG32it
         pnFFKrMmU9qfQp9RdQP5Jsm0W5YkEdcBrE7wICzecEhC50DJyPh6hNMZU+N/BiaS1IRx
         27uXWMmwoZjmbQNXEiubrYyGIyD+8cdQcA1aiuKyPdfd7/cqeuLVKO2uDzfTnGP93qez
         pE1QnQF90SZApdZuHCMi1AUUyXKvyOc/bheUx6xKiYRfq//R5dW419yZaIs/2PxAhOtc
         U6kFX8801jCS2CkLoVU1MHJt1okk9sELw8Ct0yoGF7dwf4iXlSDaxFy1vKG+pub1r1hD
         gnTw==
X-Gm-Message-State: AOUpUlFMBuAJyiymomxN8XZNRZI2vEXzBwFw7RNKztBUbWi3mFzDmebR
        s8ARIMBvPN3zAj5ceDs9t6t+rQ==
X-Google-Smtp-Source: AAOMgpcrjv56bIDExAtre+fHeW5WD6WLVDbfHUKnlyUZlnVY59kQtAB8/SBA+dlGtLqTUrpQ8d69cg==
X-Received: by 2002:adf:9086:: with SMTP id i6-v6mr12146167wri.271.1533644502796;
        Tue, 07 Aug 2018 05:21:42 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id e10-v6sm1106535wmh.19.2018.08.07.05.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 05:21:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        niklas.cassel@linaro.org
Subject: [PATCH] nvmem: core: return error code instead of NULL from nvmem_device_get
Date:   Tue,  7 Aug 2018 13:19:35 +0100
Message-Id: <20180807121935.29653-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem_device_get() should return ERR_PTR() on error or valid pointer
on success, but one of the code path seems to return NULL, so fix it.

Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa1657831b70..6f064002f439 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -679,7 +679,7 @@ static struct nvmem_device *nvmem_find(const char *name)
 	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
 
 	if (!d)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	return to_nvmem_device(d);
 }
-- 
2.16.2

