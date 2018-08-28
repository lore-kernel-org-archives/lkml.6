Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F88FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7D420834
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W12t1uPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7D420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeH1RcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:32:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45452 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeH1RcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:32:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so1391546eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dOIHmNDNib+rD5vz/dIrQhyM0hJLtwPoCOQ75FCLGyI=;
        b=W12t1uPKBxj5FBiei2C4V+G8XUfnGLGJEoSRf4Mr9+2oj4Gbj9D5P8y9L0btCKzAkP
         GeSzvhO9vckBntwnlqKMdTU6p1IVXApFXpf0PdKqQwNqcwFhXmi0zcOL7HexrIKUi/qv
         BcOyoCCB6uTdWNCY+5WgbMne9bX3FUWSvXnDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dOIHmNDNib+rD5vz/dIrQhyM0hJLtwPoCOQ75FCLGyI=;
        b=S2v7HQrL8DML2pTCNrDoJS9M4DLjP6R+EtOfiFmHU8XcQ8KbuWr8qlt4C4h+qe55Nf
         LxBTVa15olIJZ8gn0KAjP413ry7+kEJNSIvKz4b4jBmIQbamuWOhD1pbJWxcU6vrFREx
         vFrF5fiRgrZuaTLi8WvTEgkgRTJtQBrLSgLiOT7HJaLe4zgHWCz26bU5cbdddbRz6AJq
         ToTBHT67VHPGYJWrvujcd+ADPHhB3sf/iVwjGmrIY7Zbiyqs5M60UrKK3Z6z79JNcQrg
         TJO0vIPE8/PjzRmPM3KCQ66MdPL9EJC1hBK18HezM9qb2Etm0yJfYLWK2DDsgauSe5pf
         Q6Uw==
X-Gm-Message-State: APzg51AnI6lc4cgQXFepOjz21Eqlmp1NYn/ui2jtOvKZClp4mLLe/CC8
        wnmAv9c8RCezmbnTKGKp/YYnhXxo7Po=
X-Google-Smtp-Source: ANB0Vda7xMbNCW9iAo/0xeONk2+CSIseLNQpN4MDrWJ06r0d21+3bftDqYlFUlLtab5qsQPAP85H1g==
X-Received: by 2002:a50:bdc5:: with SMTP id z5-v6mr2464195edh.46.1535463618168;
        Tue, 28 Aug 2018 06:40:18 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id p10-v6sm525756edh.9.2018.08.28.06.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:40:17 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 11/11] MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
Date:   Tue, 28 Aug 2018 19:08:40 +0530
Message-Id: <72c63bc617acdaddd0a420ceac1914acdf4c720f.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an entry for the TSENS drivers and mark them as maintained

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..b8c96e0699c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12076,6 +12076,13 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/qcom_iommu.c
 
+QUALCOMM TSENS THERMAL DRIVER
+M:	Amit Kucheria <amit.kucheria@linaro.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/qcom/
+
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

