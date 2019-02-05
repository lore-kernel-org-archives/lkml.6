Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F03C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140B5217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTFmUd1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfBEXZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:25:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfBEXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:25:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so2234055pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WNp4gohR0kMr5GUi8PqSACf2MyhhTlb9SKT3Z79/9T4=;
        b=CTFmUd1NWnzQEmzeNv77ejYV6bDV+03HNubH5pp8Bf7ecdZAgok7sKxHz2RnIkroO2
         2zA6DcOTpsLNnZaIHkTy+LiaxO8Gl2n4bc8/s27NGj7Ac9rF+xQ14bfBukZZvczWQ82B
         lhUn+IHLnUD+u8DD3GjQNYCyQX+2VTarLjIAP7/vDCqo6N4blKsoIdqsU4qLG9iQdWr8
         d6yw5RwC92mX4gXb4q0zMTueXbTucESrUzFnPLW9SE1EVmWJoezdwdefP/Ff6HJK3C5p
         de+95AJGnt5eus9nQ+sAKvTFUkNnuYsXaqjVzu5BlzixyRX2vd1ww/8QRSmniA/pOBKK
         zP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WNp4gohR0kMr5GUi8PqSACf2MyhhTlb9SKT3Z79/9T4=;
        b=twMxox1j5ZbL95gYXoekLQcXlchJnp35cnmygkMhBd7LYjrZ/SYOPP1c+H9zKEtvUv
         eemqP+Nj3LiHn0g5JH53CY0sbmIwW6LjOSgY2VMD4wmh511lVbTP7XgVX/ycktHH0ptv
         BalyySn5bg3SounmloOCOJ322DRyHZbgbgSpJxvDtk30IVHxIgmiyvi3fI9SZZN08iXR
         COZfYmmSjb2hJsGzlg4r/vUY4Kj9dGFluXenA6pEVLyo3x2nZZWWJ081x/syDhc7OLm5
         UljFtK2uzU7iONXornHkRfHWrdTxxXLtLxICfW157rDnVtvOfgS36nbMtQBJ9Xt4TQsE
         /oQQ==
X-Gm-Message-State: AHQUAuZcJrI352rf1JagERx32ez7G8t1wOM9VDJtgWx75A0SBo6Cj+55
        KXByGFxUL5qGjMxSsNvdG0V3PTk2jBfH1g==
X-Google-Smtp-Source: AHgI3IbjgKibiAxZFpQjJ7vzUVTR24eUAKYKE8dGLEXFleWiNZC6ihKqre2cwlTnbM25J7pUwxCXWw==
X-Received: by 2002:a63:3206:: with SMTP id y6mr6774105pgy.338.1549409103744;
        Tue, 05 Feb 2019 15:25:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:25:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] coresight: Use of_node_name_eq for node name comparisons
Date:   Tue,  5 Feb 2019 16:24:55 -0700
Message-Id: <20190205232458.7074-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 89092f83567e..7045930fc958 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -80,8 +80,8 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
 	 * Skip one-level up to the real device node, if we
 	 * are using the new bindings.
 	 */
-	if (!of_node_cmp(parent->name, "in-ports") ||
-	    !of_node_cmp(parent->name, "out-ports"))
+	if (of_node_name_eq(parent, "in-ports") ||
+	    of_node_name_eq(parent, "out-ports"))
 		parent = of_get_next_parent(parent);
 
 	return parent;
-- 
2.17.1

