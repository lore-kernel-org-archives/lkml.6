Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B198C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74192086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY+kCt7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74192086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeH2LTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:19:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeH2LTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:19:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1881623pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=seB2EasrbLLttRjaVUxm8LWrqGhdTSP6c9RcfLeVRng=;
        b=LY+kCt7wU54DVcNE2SWOwcbLQH6afqKB04dK6VaxrmfS7I3MNU7hUkQFLZ60+GnafL
         c+sQK91PQkdQN7J5B0JBPNzf22GraPTxb+F0v5Q90ykY1M2V7KumoT01ytUdra1e0N5q
         qdgXRn5Aq1SjrirloHxCNf7TLKGL8O5jke33XiAEdydz7q8116O0iUc5KxRP+wSlsJK0
         6hBR042EoSZoG0S65TsS2PPX8PkqgXnvoUoLwvLtSm0Xjcbc30QIUTUX01/SpQLdc53O
         7eu9V/CbRBG6Mk4dx8kgWGY01phjh5xz7V+whKicTV2gqKObkZ6a4jqKcPsZLsll+wIU
         od4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=seB2EasrbLLttRjaVUxm8LWrqGhdTSP6c9RcfLeVRng=;
        b=YUVOVF6Fdr4Uy8WlI/LAYYm7RbTNB1nHqhhwZHpzD6rPk/iy2xCSJy4as5uT+68qqI
         XbxWSB8A3JtEScw3T5Wjn6oZ3ysOIA8KyPI2AHTcyNb1+CTfZgIH3xF6gsM3/PT0k7/M
         HCZgER00MZ+4yVxXLxbyrKAo76ex9098jMhdvh/yeFuHpev16ZLaRRKIKXfZ/zrVKr+x
         mhVSk5wnNvMFejuejyaScbvYo/Nf10ec8OcHsdpMIKcy5tZSV/P8SNDVf2wwNkHqcWxr
         XF5GDoD4RBp2KCdfQ1r9tDdqjqJPlh8XkXQKAHC8OqfTB9PItFZUm8ce7XuCZPL5bo0v
         dW7g==
X-Gm-Message-State: APzg51C7bN8iKLyAZ2AOcgdMrB5NJf/3N1tKV22bj1iaU4pVHef/gRY+
        LRuoShJ0N9gHT7MdH9Ss1UZ1bnouDGw=
X-Google-Smtp-Source: ANB0VdYJBmtLxhaKmMtt575QTc/D94dVyHLRjoBkRQrZLeI9+SXdyYRCkfEiDoNHSTr+uA25xTfbEg==
X-Received: by 2002:a62:565c:: with SMTP id k89-v6mr4691564pfb.212.1535527418484;
        Wed, 29 Aug 2018 00:23:38 -0700 (PDT)
Received: from myhostname.localdomain (M014013131161.v4.enabler.ne.jp. [14.13.131.161])
        by smtp.gmail.com with ESMTPSA id e186-v6sm3269688pfg.187.2018.08.29.00.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 00:23:38 -0700 (PDT)
From:   Takuya Yamamoto <tkyymmt01@gmail.com>
To:     tglx@linuxtronix.de
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Fix typo in arch/x86/mm/extable.c
Date:   Wed, 29 Aug 2018 16:22:57 +0900
Message-Id: <20180829072257.936-1-tkyymmt01@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Takuya Yamamoto <tkyymmt01@gmail.com>
---
 arch/x86/mm/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 45f5d6cf65ae..9ceb940334cd 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -230,7 +230,7 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
 	 * result in a hard-to-debug panic.
 	 *
 	 * Keep in mind that not all vectors actually get here.  Early
-	 * fage faults, for example, are special.
+	 * page faults, for example, are special.
 	 */
 	if (fixup_exception(regs, trapnr))
 		return;
-- 
2.18.0

