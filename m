Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6BCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F302174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LObL09Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F302174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeHCLLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:11:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37325 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeHCLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:11:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id d5-v6so2317606pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=etHi7NjPWv5rtE0pcyzpcsTXynU6H94ykdb2CjhM8yE=;
        b=LObL09TjUECsmenp2PvDNnqqaC3rbhaJzTueeqwlvyWGq1bRXhx1G5y9A32+aBBn6B
         hwygeRq8LnRpzphuMjPpfJt0Uvv/K+Y/bSrRQFE0NP0C40N4m6RZzu4zAlKBSwSLQuQD
         txYFfDudfqNDJnIm1mPR9EkSfkvma1EKKREVv4OimlgTNtJ09ycCQK+qCc5o/jvoP2rB
         A21qiVC0POupo+hNnbCmNvUwzJadgv7oqbP3DmshCknLmiHjm2CYbY7fXEwuEJ6sJzs7
         FB41NuZoWXhwaHR/iU1F/4sYp/4BfZDmG6txg2Pgs7DawwaDSszRrSkPKeFjaKjpTPjw
         sqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=etHi7NjPWv5rtE0pcyzpcsTXynU6H94ykdb2CjhM8yE=;
        b=XPuHCmqRE2PT5OiVnj0wAe9cwBKYSjmszoUVfSywqvylroPh6WlJcZUJ8kynPEEvlC
         skSuR5IZ8GR7OS8cJhsguPvFJG8RX+iTpGqBNqPfJnrmLjBY+EZlURQdofgFou0GlgyB
         tqBio7E00zLBmZtePLrD3+0+k7kA/6ps9XEXmZ4OWy6jL1jTu8kpWrGmjfZGoJrQkr3Y
         0BIccIFYKBA0NXcxy5IEHgOKcHR8KVznxLzGA6sqmrI0TB127md/dwfKhE803kWkM0sW
         t3pRSDNf+JgOTX7I7MpZh9RfXRvKMDDQzed5Ui07ZUK+g1N2kkSUoNMVwTs4voRMq2N4
         sCZA==
X-Gm-Message-State: AOUpUlFMYh1Rg6eUrMdQWIcSTk12Ad8vsqDwMtaWhEeszbMYB3g7Fvuk
        4phYG75hYWxLs7S6L6l7hcU=
X-Google-Smtp-Source: AAOMgpcUuJf86SRxjMTtFPQHyc2DGSnSHDxaCHO7spbAV4/Ibj9sTZxjEqUFp8ONbnmqiP1LzY+/cQ==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2-v6mr2760969plx.205.1533287789344;
        Fri, 03 Aug 2018 02:16:29 -0700 (PDT)
Received: from localhost (outboundhk.mxmail.xiaomi.com. [207.226.244.123])
        by smtp.gmail.com with ESMTPSA id k79-v6sm11759706pfa.22.2018.08.03.02.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 02:16:28 -0700 (PDT)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: [PATCH] pstore: set PSTORE_ZSTD_COMPRESS to bool
Date:   Fri,  3 Aug 2018 17:16:19 +0800
Message-Id: <834feb7bd03c803eddaf00568c7a8e5b2a4712f0.1533287504.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGXu5jKr_M1zxirDJjbE5fzzhQyXeNWaAkGUK13RDKTBANTbPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error:

   fs/pstore/platform.o: In function `zbufsize_zstd':
>> platform.c:(.text+0x172): undefined reference to `ZSTD_compressBound'

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/pstore/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 63cf4813559a..503086f7f7c1 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -51,7 +51,7 @@ config PSTORE_842_COMPRESS
 	  This option enables 842 compression algorithm support.
 
 config PSTORE_ZSTD_COMPRESS
-	tristate "zstd compression"
+	bool "zstd compression"
 	depends on PSTORE
 	select CRYPTO_ZSTD
 	help
-- 
2.17.1

