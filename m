Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5959DC28CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50E20840
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG3UHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:07:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37899 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbeG3UHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:07:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id y19-v6so13170643qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=AHdEeUWWGzjlYRRICwg9/Ip3Yv024o+iaN25w+YUuso=;
        b=JW2lxIR6uu/gLvVNAfKlysUCE5Wph1IdGxT752UxdasujwvjdP75ain7rXVQqGdmFm
         PoW4Etigbe7uoH/wxRmoMOm7O1Y9Arn4ftHlEpXAfTU3N8yeAmqeNrbdfkD49wPS+gW4
         bGe8AXC8jYIilgm6tzaVtz1uO/B0466Yfy57VSASNW5DRMJ4zOQ1q8b6aoTIWtJryfIg
         wzSx05J7lhVqkeJ+KWqJtpv7TIerN/6ny4mpspwcCqNmmh90uIeG8fqqOF57ALsV65o3
         KsKVrFBNDWXOAhbDHNOihvD6jdy4gxxv4mqy2sc0UcJ34Xce9eh7Cxd2r+ejN4HXKYuK
         wmuQ==
X-Gm-Message-State: AOUpUlHOK2eaXS0WsE5GbAAbFa2V00UP9OHB+keWRfP5eM3o6KSjBVEa
        K+RfiNiERaSPSZjpZcFMxpRH6A==
X-Google-Smtp-Source: AAOMgpdURye5+fidbm2scpzwtgtDgX5gOJXu/B/grz84leWsh9U9Wd1jGFBLsNjcerxjPwz3gfhyZg==
X-Received: by 2002:a0c:91b5:: with SMTP id n50-v6mr16213826qvn.90.1532975488398;
        Mon, 30 Jul 2018 11:31:28 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id q18-v6sm7826570qtg.82.2018.07.30.11.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:31:27 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] efi/libstub: Only disable stackleak plugin for arm64
Date:   Mon, 30 Jul 2018 11:31:18 -0700
Message-Id: <20180730183118.25869-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730163722.GD4276@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 uses the full KBUILD_CFLAGS for building libstub as opposed
to x86 which doesn't. This means that x86 doesn't pick up
the gcc-plugins. We need to disable the stackleak plugin but
doing this unconditionally breaks x86 build since it doesn't
have any plugins. Switch to disabling the stackleak plugin for
arm64 only.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/firmware/efi/libstub/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 25dd2a14560d..88c322d7c71e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,7 +11,10 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar
 
-cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
+# arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
+# disable the stackleak plugin
+cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
+				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic -mno-single-pic-base
 
@@ -21,7 +24,6 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
 				   $(call cc-option,-fno-stack-protector) \
-				   $(DISABLE_STACKLEAK_PLUGIN)
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
-- 
2.17.1

