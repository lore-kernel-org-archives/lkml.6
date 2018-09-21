Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EC12086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlMNkJr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EC12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbeIUT36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51113 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:58 -0400
Received: by mail-it1-f193.google.com with SMTP id j81-v6so2002187ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3uDbLTzNxTj5EpbFkmxIXP5huf1tEDTFmj6fZv8t3Vk=;
        b=VlMNkJr0iVKdRxtmjRLashHgxEVWMK9U/Zw91zA5n0jDxzncwy3Yj3sAmQFP4OjCK7
         wk9j3Hz7LENB4phV2xLeMMCIKHfwMRsb6LDrUMThpJ2eFAGUPF3wF3Bvxphwz/U2otXV
         MWhtDjNIi8wK78lQK3Uj3NQm+YLA98T7e3X2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3uDbLTzNxTj5EpbFkmxIXP5huf1tEDTFmj6fZv8t3Vk=;
        b=VxTDelhN0gGUWbQXmbIrR2t8tQtoNlUqfZl3nWXXRIqjNX1DI/VvqFiHWgnidU6vfH
         sW2E928z2xnA2IJyUy+Wo5o8fIr0BsxrQa327+zzG5whrAqwxNURtPOtYWDbaht2nAWc
         3HGHkwe0x+I477f9IMZPNYtQB3+3r6dno229LaVvn+JXuSNETq9qJmE0sy4PNoTibPLN
         Qq51tnMDEv6Xt1DQbFKK/PMhnX0GAyJZw7akiIBX8PsTOjtk7T85RmfWPWHmfwXee1Zk
         U1Wjm+aVZ1ZmLcg4x+ro3Qjie6hskAwsFrXo8nJM8aHbzoxREX8efSs1YM9cFg3VYl41
         T+Wg==
X-Gm-Message-State: APzg51BYtlvQHZjvJwiwc//0JZDmzjv6fcCTHahkRQlvto0YFumNfm8n
        ell5zk9p3hPba3f0hpDpDyYCdg==
X-Google-Smtp-Source: ANB0VdanemkMCmsfSNhZXsbW1WzzRoxeF9SdiQbWxwHZ0qVO2PyC9JCEMNhEp2Mq7EUn95+oV3sOeg==
X-Received: by 2002:a24:96c6:: with SMTP id z189-v6mr5614142itd.41.1537537263024;
        Fri, 21 Sep 2018 06:41:03 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:41:02 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 25/26] nvmem: sunxi_sid: remove unused variable in probe
Date:   Fri, 21 Sep 2018 06:40:25 -0700
Message-Id: <20180921134026.4596-26-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch fixes below warning:
sunxi_sid.c:157:6: warning: unused variable 'ret' [-Wunused-variable]

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 1310f8af37f8..570a2e354f30 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -154,7 +154,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
-	int ret, i, size;
+	int i, size;
 	char *randomness;
 	const struct sunxi_sid_cfg *cfg;
 
-- 
2.19.0

