Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC5C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D98E2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8db4TPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfBKWyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:54:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfBKWyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:54:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so265788pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DAhMB66WOye4Rsj6bDeOQbNbLoWJEGTVizWiNqAylXQ=;
        b=P8db4TPa00jf2gdKKbsQ4JR//27/enkXpoooyBg+8q37oeI9r+KJsbfjzUGRvsueLU
         fyzK+7yqAR5bjN2O0ltSJyKkztHw80ITBsWeJRQys1gcvytiD7vO+GmXI1yM9eykfcRS
         o+F/+mVfa7oclkW1vswNiWfBhQL8vx+jsixUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DAhMB66WOye4Rsj6bDeOQbNbLoWJEGTVizWiNqAylXQ=;
        b=CJ+DLCSuKmLLUrfTIX4qnBJZoEL3f3tBAemveMIHWfj7CGpP7xQz+Ybmxg4eVdjhRj
         LsaSbPCoFWAtDywlIQdFVIjg5Ucfa3/e7g9hwhZjbkFDbX2GoTGDIoU5WSIU8Ql7xZCD
         D9badvkSXRMSMyF8M0eleweiQnhSdNPzBsMvpmJhKU1MyHdhWVyGDWHQlpogXkc0m4CD
         LwcMkt8Mjdf+om04zU4L7IEpiWsl3DTit0Ma6hkGAjkTTBvYcb53HjeDgVqvxXBOxYKe
         WbpNs/f9foY01i6JnvxPva6etxTwIqry//uzSLQX9mmQF4d5IrE9eRqDmylRYUpXMjZ4
         v6Vg==
X-Gm-Message-State: AHQUAuZFUnoJMhwiDQcCEcYuEvgefmJVjSCQBAN0Xp+tnq/iPR26XTva
        P+cUEaBJNhl7IXzZ0sRAMfaMULci4Co=
X-Google-Smtp-Source: AHgI3IbouTZp0J23mCdzPG9Xy5+T20eSKOMw4lKUIEr/HO1rruye272esKEhb3FqkeQMscDJL+8HkQ==
X-Received: by 2002:a63:c56:: with SMTP id 22mr626220pgm.44.1549925645759;
        Mon, 11 Feb 2019 14:54:05 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m68sm6141079pfj.89.2019.02.11.14.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:54:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:54:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
Message-ID: <20190211225403.GA7769@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
used on the command line, and report that it is happening.

Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 3147785e20d7..e6153ed54361 100644
--- a/security/security.c
+++ b/security/security.c
@@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	if (chosen_lsm_order)
+	if (chosen_lsm_order) {
+		if (chosen_major_lsm) {
+			pr_info("security= is ignored because of lsm=\n");
+			chosen_major_lsm = NULL;
+		}
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-	else
+	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-- 
2.17.1


-- 
Kees Cook
