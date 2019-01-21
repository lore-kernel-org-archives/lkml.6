Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8866C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777E32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUk0nlUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfAUIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:05:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34911 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbfAUIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:05:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so9772687pfi.2;
        Mon, 21 Jan 2019 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WgEsgGcp3+eolPgDUpIcJ3Mj29Uglkush+HiUCCyvXI=;
        b=nUk0nlUQlznj3wf/1qw0J3Y8jT9RU0fgXOKEnzailUeIBhn87vhvPad70vbB7shJH0
         Kcf4pj7BXyNRMMMhwD8/lKt5AxWScIGW3K6+iWHg9E/aRJ6zkdTmvkVUibTaGTN4D/7v
         XTFt2RT4EYhjwsBWbQcLKJLngDH1MhcBw3oKvTAtp1U8QOA7U/endrpxqtZrPj6jbhSf
         F9MU4i8im9PxqMRTpFfjad82guWoD0dUNeGoOkneENgstO3kPJax7QvUg41G2IX4NHHC
         BJMOgTlJGmocBz/T/mAR64VSswCPQt1eyhPEEnbKBdTGXHmmt9hAR9w3s2+IYlwFwtcX
         j1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WgEsgGcp3+eolPgDUpIcJ3Mj29Uglkush+HiUCCyvXI=;
        b=FjVmeVr8Rf9rnk+03hT6gJUia0MBsbNYCk/gkBqPT/bOG3kYAEDlGrAmxVvbew83Pg
         T46fteD74TbrWuoSf8q0SAn9QtyMiSOKA0bdU5opj10RWxLC+HCnlJquUwSxFkYwENMa
         Kovjcjpoqg3zOCtm52cGFOoIxZeg7gWGQqzO/ahsyJffquYNd40Xtf1aL7pZFlpOgJqR
         XmepecL30HNxCPWMfhjpnyxG6dRWyA1XEjBvGDxipfGk+0akQWLAhiqGpQZWK+byENbu
         0rHwzej3PHUSTPx4LOjURIUgfQMxs0Bahl0iq+FxfBU4+XkqaiSO91sBt7G85PFT+EVN
         zy/g==
X-Gm-Message-State: AJcUukdjmHmS2xUqYyU4w77xymVG7Jd4vMNaODRjN9lA24WZzMarI/cw
        NjK8U/yVaY+ZAObmNlkf6A1u7549BiE=
X-Google-Smtp-Source: ALg8bN7+LIGl7TaApfRvZDiaBbQFEnmcRWcNXyTIxwHZshKypc+uCjVP8oyCK7WkbLx3ODe8glICOw==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr26156376pgf.388.1548035389972;
        Sun, 20 Jan 2019 17:49:49 -0800 (PST)
Received: from localhost.localdomain ([103.232.108.130])
        by smtp.gmail.com with ESMTPSA id o4sm26438963pgs.12.2019.01.20.17.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 17:49:49 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
Subject: [PATCH] input: Fix the CONFIG_SPARC64 mixup
Date:   Sun, 20 Jan 2019 17:49:14 -0800
Message-Id: <20190121014914.2328-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann pointed out that CONFIG_* cannot be used
in a uapi header. Override with an equivalent conditional.

Fixes: 2e746942ebac ("Input: input_event - provide override for sparc64")
Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/input.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index ffab958bc512..f056b2a00d5c 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -32,7 +32,7 @@ struct input_event {
 #define input_event_usec time.tv_usec
 #else
 	__kernel_ulong_t __sec;
-#ifdef CONFIG_SPARC64
+#if defined(__sparc__) && defined(__arch64__)
 	unsigned int __usec;
 #else
 	__kernel_ulong_t __usec;
-- 
2.17.1

