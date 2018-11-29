Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC291C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE98A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TkEsBa2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE98A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeK3KQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeK3KQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so1772624pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5qRnAHvPLwTYWJ6XrP8J0eXuupaITeoM9M8kSneem64=;
        b=TkEsBa2Pb7Kvnin+G7PwzdAL2bxJZn1x/oP46o81zr/pjHYD220igpS6QiukYHZpOP
         NkLTObc8KThwKXo/sTwREZwcDn8qoUtLDjqWsDMcS6txwxl86JfacRoztRc2h4HQ25sS
         NMGllAHMSHLmuAla/jPhuZGfPy4TPtRyJ2tTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5qRnAHvPLwTYWJ6XrP8J0eXuupaITeoM9M8kSneem64=;
        b=p5mNr51avyctUChu101Qpgbj5GYhVwkDqwAMYyj5r8QFvU2o2zPOzheLvA906sS22X
         sUFvtHBCx1eT+rHPC0iLPo1UPGSER9kFZXW7nllX5VprWjfHfB85KFGgWBEWy+s8bfX5
         nb023JniE/bK+0POzzHK0D9U1JFeVr44cOoujbhg3IWarYSSf5xdPc4hh+M6f6cYG9tz
         bKrj/CI5QAL51J3CsMSZJhMORlqHK+71bObXiJzN/QqoFTR5vCOaisT21BupcecW5mmq
         V5Q/vrWOxtnjYc4W8J6nCBTkWRKc9xVlKUC3eWxm64kZZzYSrlNniC3h10kLS54JbJRf
         u7Xw==
X-Gm-Message-State: AA+aEWZaKY6rCXc4dJ1JD5RlKb1BeiB/c7QGWN6HFn1bpgkI+whz/H0H
        /0rmUOMDNXQDm1n2mKOhBTJpww==
X-Google-Smtp-Source: AFSGD/X6OeFf9vrYB4Mxp9NSD6fW4zg9yJ4AS0lurkqRqqsuQfrVMkycRv3ZSkofgEKOvRxgLIVNVg==
X-Received: by 2002:a62:db41:: with SMTP id f62mr3357599pfg.123.1543532939820;
        Thu, 29 Nov 2018 15:08:59 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m65sm6477030pfg.180.2018.11.29.15.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 09/12] pstore: Replace open-coded << with BIT()
Date:   Thu, 29 Nov 2018 15:08:38 -0800
Message-Id: <20181129230841.29955-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor clean-up to use BIT() (as already done in pstore_ram.h).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pstore.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 81669aa80027..f46e5df76b58 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -192,10 +192,10 @@ struct pstore_info {
 };
 
 /* Supported frontends */
-#define PSTORE_FLAGS_DMESG	(1 << 0)
-#define PSTORE_FLAGS_CONSOLE	(1 << 1)
-#define PSTORE_FLAGS_FTRACE	(1 << 2)
-#define PSTORE_FLAGS_PMSG	(1 << 3)
+#define PSTORE_FLAGS_DMESG	BIT(0)
+#define PSTORE_FLAGS_CONSOLE	BIT(1)
+#define PSTORE_FLAGS_FTRACE	BIT(2)
+#define PSTORE_FLAGS_PMSG	BIT(3)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
-- 
2.17.1

