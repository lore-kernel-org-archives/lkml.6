Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F8121852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS/yiuRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLRPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38216 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeLRPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so7933558pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+PXOceOUR7U/rQANrR+vw2A964XlQSf8XMtPCKMYHI=;
        b=VS/yiuREOc8OeuaqUfIW05DBA0mGj+sRt5yGJNaUKLAnV+1tASE31acji8rxx5iu/g
         WPPL1nyUBjv6bhpKgvJ8q6ObDIf3fuH5zgTvFFmdWODYtwfYKHnv8xPyLgD/6nB82jcB
         uvzC8SlEW+sEJZiNiLqOiR64K2+bHTLkag894=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+PXOceOUR7U/rQANrR+vw2A964XlQSf8XMtPCKMYHI=;
        b=dQfrLF6HoBJ4VcCKlty5K6ETWXQ2BvfFi6Tct9JZ/f2E2qvSuTjU7HhJj+s7MUBoBt
         OO+pWSCmRnWXuJGY7DqrhdttkheB2caqgVwhdpwi2n+JafAmgvk70uz+jYwxlvjeGCU5
         xo96+ODQTqNLgx68d+3aDtyo/Fe9O+uVpgjPTKIFSUbAd2E3GoesrDhDsoocQx6W9qzf
         tXq+zuwCkjOR8TV1M8a1fa2F5TL8GPBmc10NctYhiISMu2XBWEgmRb2ncZQPfyjwX/yH
         nIQG8t0LLPn2toiOOiFgLt2XAgFCS9fspcmsPK+wdXkR7BcB/lmSN0iviDv/78PCg+ah
         sW5w==
X-Gm-Message-State: AA+aEWbJ+qI48HdRovSZOLa1bkO0aak9ETTFFdfPGdxf4il8GKZe9InJ
        /NojZxEM+unwq/RIHqbbzcNR
X-Google-Smtp-Source: AFSGD/UlRNA2nubwSWRzd8OyLINe5DM0EYTgNrrYuRaVzUV1RGPfDkzhU+T2dvJYCXYhuMbjxJm5Mg==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr17101796pfb.55.1545145380020;
        Tue, 18 Dec 2018 07:03:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:02:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 01/11] dt-bindings: Add RDA Micro vendor prefix
Date:   Tue, 18 Dec 2018 20:32:28 +0530
Message-Id: <20181218150238.23010-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add vendor prefix for RDA Micro which now merged into Unisoc
Communications Inc.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..37826fac7684 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -320,6 +320,7 @@ ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 raspberrypi	Raspberry Pi Foundation
 raydium	Raydium Semiconductor Corp.
+rda	Unisoc Communications, Inc.
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
 richtek	Richtek Technology Corporation
-- 
2.17.1

