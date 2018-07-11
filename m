Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C35C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8831C20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fuPvhDmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8831C20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbeGKUmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41137 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390286AbeGKUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1748325pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zbkP//JFKhVRhh8B5f8winKslJMgyIBJ8s7W/9N89AE=;
        b=fuPvhDmyzhG8j+GJ5IeIi7yZeY/GqMYyert8l2k//jXMBO3sU0SDBGII8thD440TLL
         H7E1gaHn3R6Iyp783UtiV3WLnEncJCEBAtL9to9l+o9L6/TJ41cezeme41IseUe+4oT+
         clkBXCvHTpVBRlYWPBpF4E5J8jAi4DjUZNhBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zbkP//JFKhVRhh8B5f8winKslJMgyIBJ8s7W/9N89AE=;
        b=Zd5UUpZ8MsXS6o9ToNfP2puVUN22l1YfhtNYDYI3bnv4AhxT4Je6pkgFHadTZFaVFv
         ot0JNuu5Zg0OZJQ6pgZe2cj3XmYWX9PPEYJDQJ51ku1FCctOKM38lywMSxz8HLUfyxyz
         17q7M89/kjWRw4oopsw/upmM1mOV5+TNDZ8VJGxjjzZUI2qFB25B3NceUMj7Fswi2wVC
         oHKe7nAApwPTX2XIpJ20RXKJNEYjQzTozEQU+nXMt+Q8lwYRyMVAYHDMjU/0o+Pw1Udt
         hSs+NNTNQyk+f03H0ACp14j8qMaBNlEm5d1fT/9Rh3FtwkNJ/cMkUg/5i5N+8GadrVM8
         NETA==
X-Gm-Message-State: AOUpUlF5KXFRHivuLS7SdxBniY4CSLGHSx1YM/mVI3N7lcZGm24cIhaw
        Ii18Fnd48OEeUosJyOSXix8P7Q==
X-Google-Smtp-Source: AAOMgpepV5D3hXGjQPONIQWKHnKjYnMEWl4+AlUQZK99ilxTACsZh9+0+dEBeo0kkAvkBrSh5sgV+A==
X-Received: by 2002:a62:c699:: with SMTP id x25-v6mr180974pfk.16.1531341393327;
        Wed, 11 Jul 2018 13:36:33 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y85-v6sm17725654pfa.170.2018.07.11.13.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/14] kbuild: Introduce FRAME_WARN_BUMP_FLAG
Date:   Wed, 11 Jul 2018 13:36:15 -0700
Message-Id: <20180711203619.1020-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_FRAME_WARN, it is sometimes useful to
give certain compilation units small additional headroom. This is
normally useful when VLA removal exposes a large stack allocation,
especially with FRAME_WARN at 1024 or smaller. This adds 20%.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index c9132594860b..06fe93edd052 100644
--- a/Makefile
+++ b/Makefile
@@ -684,7 +684,13 @@ endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
+# Small code (mostly exposed by VLA removal) needs some additional
+# headroom, especially for a FRAME_WARN of 1024. This adds 20% which
+# can be used by the CFLAG_FRAME_WARN_BUMP option.
+FRAME_WARN_BUMP_SIZE := $(shell expr $(CONFIG_FRAME_WARN) / 5 + $(CONFIG_FRAME_WARN))
+FRAME_WARN_BUMP_FLAG := $(call cc-option,-Wframe-larger-than=$(FRAME_WARN_BUMP_SIZE))
 endif
+export FRAME_WARN_BUMP_FLAG
 
 stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
 stackp-flags-$(CONFIG_STACKPROTECTOR)             := -fstack-protector
-- 
2.17.1

