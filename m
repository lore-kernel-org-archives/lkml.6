Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F803C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE272244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyobdCAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE272244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeGCHUz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:20:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33925 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeGCHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:20:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so747272lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVh3B2a7Tr9gfn7ZY9RqNUrCIYyj/w2OKBi1aCPSlpI=;
        b=OyobdCAaL4sjwDOJzCu8/scocB5P2ZOmKXnt9rUNYyKJpqQnzssUh2I+k7C+/5QAYi
         /2Ml0xh+77VSlutyQfgRf5ANJgwnFQ6Szpp99aY2HgbWJ8Cq6m2rG1gZl/njldyxoa7T
         eHHHXCbsVxnk0QeuuclRaztQF2zndlK7Qa3EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVh3B2a7Tr9gfn7ZY9RqNUrCIYyj/w2OKBi1aCPSlpI=;
        b=YiB7vvWkWm+sE3a5j9bT6NWF4j7+Pzp7HIPmIXsT+Eu5jriRrTlM1lJ52XBDP0rUR5
         rpT/bswOnIimAk6/bIRYsxUhwSwLy6p7wPQbwaMH4LsAOOAeb5GaLnNfj3qHxF8p3jcH
         yito9MwJYIJVwmdHj62qPJN7h80oHVrjxVlL6ngsMB/b/w1h/bfzzsIeR4GW7pgjYaid
         XhtQJrEcesTXuk566FAuDBS1mv0TD++7f1s+1/MQSHkoDXR0LbpPPYmmUBQLgZfSjU6X
         QI/yL49hINa7KuDWP66RNJ+y1UwGGgoRmruqkOwcQ4FfJ+1VbwlJ2qll/PTPXdy0Zz3g
         ZgZQ==
X-Gm-Message-State: APt69E2nGLyO4hBhjhoqlfffWKC1UjGgf2L2oaTetPCb6yW+u7Qm32JJ
        nDOxFILZi3kLMPEJ35uSLT/0qw==
X-Google-Smtp-Source: AAOMgpeiucslW4y5TwLaEFCTP604n91Z8ugpirHAloPz11Lxw2JVkcx/Mep2plx0Xk70J4PQ6L23Vg==
X-Received: by 2002:a19:1d8c:: with SMTP id d134-v6mr19854826lfd.56.1530602450221;
        Tue, 03 Jul 2018 00:20:50 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 10-v6sm65125ljh.91.2018.07.03.00.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:20:49 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] soc: qcom: smem: Add missing include of sizes.h
Date:   Tue,  3 Jul 2018 09:20:28 +0200
Message-Id: <20180703072034.20213-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/soc/qcom/smem.c: In function ‘qcom_smem_get_ptable’:
drivers/soc/qcom/smem.c:666:64: error: ‘SZ_4K’ undeclared
  ptable = smem->regions[0].virt_base + smem->regions[0].size - SZ_4K;
                                                                ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/smem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index bf4bd71ab53f..b77573eed596 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
-- 
2.17.1

