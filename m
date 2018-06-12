Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E44CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8F208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MksncrhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeFLE1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:27:13 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34274 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeFLE1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:27:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so11404278pfl.1;
        Mon, 11 Jun 2018 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SStYGhlcztqQ2MrXH1jzRquNyv/Gz5mhdhNphCnT8tg=;
        b=MksncrhAv+28cnPrTeqSYPjg0teTHebXSTHHFRMMHB9Oa7iemr97MRBUi71KNfp6kF
         abgC+HFzraaqgsPVQBHPJ+/l8w13HtcKecyoDCBpyzQYE9707epJQ/rxjIY4nHUJ+VYq
         L+qKCTel8jpgLgP2Bz6ct+vakZTxEhGBdu4f9/vgnBI2GZFRbX7EUE0LAE7q3f49tm3P
         8cJL1LnZY8AQ6gdl5sEUxnNgp+/Uk77gCWm5v3blHbbbkHYvGvQiJrYVfrTKtkWCL4+w
         kwSS5PxihyX41rmx/rzpyWEZq+6obHk3rcez14CJSfjvsVsfQl1UGt66bS8Y9qnZs5BB
         jkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SStYGhlcztqQ2MrXH1jzRquNyv/Gz5mhdhNphCnT8tg=;
        b=J7XIS1GqUVyecm/LmR7CovgYpTk4hu0BXXPcwx0lZ5c5LikYj5xTVdIp38nr6mARYH
         k455Cyc9PdsOuTPD9hd+MroKO9AdXCuPRQFXOk/s/243GIz7zaV8uL0xVU+MF38oKEtD
         mzY8UnmALtcza+LQ/cX2M0Ebud+jiitr6akZt4GekK/t+/RayTH2xPSHPtLchh9U+mps
         ymOS4Di7gLl3wV87tc9PhP0AV80aS1YxdcYkZmBjSENyGnyHYHnGokdYrEeyvvxCdbih
         Q8WGm/WYXt9DVy9xRkW8KWqCq4f4R2Ckf/HCXm3SAzKgA5awA9M8FJ6/25IMPPRhHP3B
         Puag==
X-Gm-Message-State: APt69E0jIIzNiFEV8WGSA/YjWdweG/3jCkKMgb5U5H5Vd61f1yF2qTwh
        Thh+7clR2kA+VN0lSSV6N7E=
X-Google-Smtp-Source: ADUXVKIXBgY4TeQGWFZM7aYt7WRtOsIXgsiRlfWxGzPBklqFWT4qf++bzaWoStIbI/a4m62CRGr3vQ==
X-Received: by 2002:a63:6f42:: with SMTP id k63-v6mr1756600pgc.135.1528777631602;
        Mon, 11 Jun 2018 21:27:11 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id c19-v6sm4347607pfn.182.2018.06.11.21.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:27:11 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        Jeff Layton <jlayton@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: add error handling for kmem_cache_create
Date:   Tue, 12 Jun 2018 12:27:03 +0800
Message-Id: <1528777625-40502-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_create fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_create.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 security/integrity/iint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 149faa8..c074fd8 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -172,6 +172,9 @@ static int __init integrity_iintcache_init(void)
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
+	if (!iint_cache)
+		return -ENOMEM;
+
 	return 0;
 }
 security_initcall(integrity_iintcache_init);
-- 
2.7.4

