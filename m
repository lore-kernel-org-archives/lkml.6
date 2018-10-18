Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539ACECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12592208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvg+eZUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12592208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeJSC6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:58:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34301 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJSC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:58:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so9537928pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KcPXcVZPJJ486uAlRAS1H7LwXud5oU3bNigNjeiK1CA=;
        b=jvg+eZUogXDOK2WV69h92FhDTPeOPjDDZg5lwu81GR/45ueFBW68lUILtEZ8vLni1J
         SMdlT+uIKFaCmhQwbpQgkdINxqfgG+WFx31vlbqf6iGWV6Pzro9JnWJ1LgZMOwBgOXHj
         Jm+tH2svPgeLa2KJoxo3YJEKENysJ31BoOcjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KcPXcVZPJJ486uAlRAS1H7LwXud5oU3bNigNjeiK1CA=;
        b=SCsDrWXaY46obl+V4Jdm8lG80v/8Hp27mgnyUn07tOHJ+onnrhtAuTn83/0aE8EkFH
         uOsOQXV8XghEJQ6qLQu0+jEMc0r2wyHQHvgcm10vQgdy+nPoSsiPlhUueGlM/fh41nnW
         kdwf2NY6Dui1AvEa4LHVgiOM7mjPL+enYHEI+FjH0pp+hi4KYIqKjekVjS6BgVtXUqCc
         Ou4fBMccCTL834Cd9jLUk6SiN5dbRFVKWgFUO81n+Oqdgt9jlNcoWdzwOykl5Hzl+dPE
         i2cBCUAZ+zpHmnGLM+Qyf7OjUXayjIa+SD+kD3FoloexmH5v6Q8EXXbwyTSAshcqZdMZ
         H88w==
X-Gm-Message-State: ABuFfogVU8KHfjwuafJcmsQbf1NjYbPWdCTRuC9vsk2weLJ5/p0+UXUJ
        3UVDi6conLLfW5LtizExE0PRfA==
X-Google-Smtp-Source: ACcGV615fCFhRnUxvu+tCgFbp6k9LMzZfF+cZkXbT4bp470iUSCB1lwaYF8bkQwHeEjjKv+LjL0fng==
X-Received: by 2002:a63:a119:: with SMTP id b25-v6mr29470326pgf.186.1539888981540;
        Thu, 18 Oct 2018 11:56:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r1-v6sm27269932pfb.41.2018.10.18.11.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:56:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH pstore-next v2 2/4] pstore: Allocate compression during late_initcall()
Date:   Thu, 18 Oct 2018 11:56:14 -0700
Message-Id: <20181018185616.14768-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018185616.14768-1-keescook@chromium.org>
References: <20181018185616.14768-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

ramoops's call of pstore_register() was recently moved to run during
late_initcall() because the crypto backend may not have been ready during
postcore_initcall(). This meant early-boot crash dumps were not getting
caught by pstore any more.

Instead, lets allow calls to pstore_register() earlier, and once crypto
is ready we can initialize the compression.

Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Fixes: cb3bee0369bc ("pstore: Use crypto compress API")
[kees: trivial rebase]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 10 +++++++++-
 fs/pstore/ram.c      |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d61e26812af6..578f178a695f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -786,13 +786,21 @@ static int __init pstore_init(void)
 
 	pstore_choose_compression();
 
+	/*
+	 * Check if any pstore backends registered earlier but did not
+	 * initialize compression because crypto was not ready. If so,
+	 * initialize compression now.
+	 */
+	if (psinfo && !tfm)
+		allocate_buf_for_compression();
+
 	ret = pstore_init_fs();
 	if (ret)
 		return ret;
 
 	return 0;
 }
-module_init(pstore_init)
+late_initcall(pstore_init);
 
 static void __exit pstore_exit(void)
 {
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f4fd2e72add4..6ea9cd801044 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -962,7 +962,7 @@ static int __init ramoops_init(void)
 
 	return ret;
 }
-late_initcall(ramoops_init);
+postcore_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
-- 
2.17.1

