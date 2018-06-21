Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06CBC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D06E21A81
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqehOgsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06E21A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932994AbeFUTKf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:10:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40268 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeFUTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so5896722lfc.7;
        Thu, 21 Jun 2018 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Mr0xxBNlgr4IsLn3JB5gZ2Lb1iO3344i89/obcwTs4=;
        b=SqehOgsQxHrgAeMG+JF4zCsSnuoFdJq7h2uWdhaTK/0dbyE/qS/kBIkWpEM5bAbDxf
         Gij8U3S7BtkCn2jp+5lqQbNI0NH6NdqqKR6II0lV4p3wClGtuJZGcEYVzgDXQCl4wRK2
         le6CchCZYhtkkDD+VkNcHDeZwyv6283hGRFG/WFlXb1SKPqw58S+VcIg3/slem5WM/sK
         YCbBvjN2NHljARHJQcvXRTU/AcGzJn4C6rGsD0wU6ZPsP8Fdj3+u9lHN4wFUsN9fcR6b
         uGPMhAWVUzbEIPsTRr9OnLDZT5lNJ/fBzVC/l0sjCM1DkODlCyHbj6507K1g6HQH2dB6
         6saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Mr0xxBNlgr4IsLn3JB5gZ2Lb1iO3344i89/obcwTs4=;
        b=FqZO0uMTuHdgzMTnsnXLLVWVI0gajSDT6yfr23RsYlguHguy8uzlC/30aIyqsSXC5d
         c4iRTs27k+kH/2uEhajoTN/ZjEoq9n4NuoiEd8NRx2/iPgDbOUKAvK9YLMTNrDXlZ96j
         a5sD5bjk/087+bN+K/11/UfdNhm5IxGudiEooWpnY0d/kF8PSMpkIiiUs8rpxPMyvFAE
         yjqxxNfJIYtIr1zHEdATIsoPH8t+jeqHYvISI4ma3rdD6XQNSwYglJSTUiDxhPojSgPV
         9ZaQdxeX7FbHQ9EmiL5YKb5e9dkM3m95KmLMSWQGmz+ZKREpbt0YNsiT0pBU+kMrVmp4
         p+mg==
X-Gm-Message-State: APt69E27zWQu0cD8D243Fjv1VDP2/5wCc4lEEpMZ+HV9KvUKpvR70vU6
        4czH/gmeSd0Www3YN3X60zo=
X-Google-Smtp-Source: ADUXVKKq5zq99JYrhvl76YhSnwYbMpSjVfQ8PSR8HZcFxuGapuwgxOlCtJlcvWVc8TLy0PIBTFr3rg==
X-Received: by 2002:a2e:95d5:: with SMTP id y21-v6mr17359048ljh.90.1529608228674;
        Thu, 21 Jun 2018 12:10:28 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:28 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 5/7] dt-bindings: samsung: Document bindings for Samsung aries boards
Date:   Thu, 21 Jun 2018 21:09:57 +0200
Message-Id: <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..edce6602de50 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -2,6 +2,8 @@
 
 Required root node properties:
     - compatible = should be one or more of the following.
+	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
 	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
-- 
2.7.4

