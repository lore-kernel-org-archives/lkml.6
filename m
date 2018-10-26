Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D7ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A42B20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VWYC4dAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A42B20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJ0Ci7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:38:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40043 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0Ci6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:38:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9-v6so850229pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqM+s1uaAengxOHgYO4et7nZ7c51ospkJSWuhz4cWTA=;
        b=VWYC4dAo/W9SAnb6iGTRhAWPGoxa29EHquegrpVnUmqhjCU9wpcdhRUJzs2WCusre8
         GYOfXA6FAA2eWw3JIKlMm50mLHoJ+SPUEzlnjZ0LS8sIrR27Gi9tKCqbLuw6WCg1q9yc
         AzwS/Ir7AXgeU0GJoIxb+ZPRiW/65Rkp6pt3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqM+s1uaAengxOHgYO4et7nZ7c51ospkJSWuhz4cWTA=;
        b=B6Fg6rukjhf7UV5t7q0bSleFs9LtosxnFBp9ksI3XwFaOu/teSS5of9VC7l9qKtCNT
         ZjAFK5EK8uEriaHsEk8sG/rjPNHz8N+zk9EIJwMyxtBWFlvoi6bAWORH3d84Tq15+uLq
         Pg9gBKva/VzVvWzkzYhJH5uyeIMN6+3rAE5PCinl+5ZMCgWqDtNwDVADWsqDtUDllTSj
         7Ldgx48oZGdiR5AuyV18HMMIRpIOECuLk78kmABjbtooDQVgPgC+B35QTYfFLM66Qh/F
         yo04Yi0188n2p4XiNKocLuSWx5r13YIMX8/91CAPEJKeTtGWowyU9q+ppNrkdf+tYPeL
         +rNQ==
X-Gm-Message-State: AGRZ1gJpXXzrXNyW5WpVa3lIsUgS5DCy9OleTjqqf5QjTvihzAoCrONb
        hiX7Y15dQTlFQp/b9ZZpBeb7dm7RQ1E=
X-Google-Smtp-Source: AJdET5eXy4pgqIIYZL3v2GCoIBL8jCBSyDQ5M8cbIl67WystZ/Zg4iV0d1TtINZ3capPfBIeKcl68g==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4-v6mr4413506plv.121.1540576858926;
        Fri, 26 Oct 2018 11:00:58 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v5-v6sm17521243pfd.64.2018.10.26.11.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:00:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC 6/6] Revert "pstore/ram_core: Do not reset restored zone's position and size"
Date:   Fri, 26 Oct 2018 11:00:42 -0700
Message-Id: <20181026180042.52199-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181026180042.52199-1-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 25b63da64708212985c06c7f8b089d356efdd9cf.

Due to the commit which is being reverted here, it is not possible to
know if pstore's messages were from a previous boot, or from very old
boots. This creates an awkard situation where its unclear if crash or
other logs are from the previous boot or from very old boots. Also
typically we dump the pstore buffers after one reboot and are interested
in only the previous boot's crash so let us reset the buffer after we
save them.

Lastly, if we don't zap them, then I think it is possible that part of
the buffer will be from this boot and the other parts will be from
previous boots. So this revert fixes all of this by calling
persistent_ram_zap always.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/ram_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 1299aa3ea734..67d74dd97da1 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -504,7 +504,6 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 			pr_debug("found existing buffer, size %zu, start %zu\n",
 				 buffer_size(prz), buffer_start(prz));
 			persistent_ram_save_old(prz);
-			return 0;
 		}
 	} else {
 		pr_debug("no valid data in buffer (sig = 0x%08x)\n",
-- 
2.19.1.568.g152ad8e336-goog

