Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49057ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B8E208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuRgkB0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B8E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbeGODRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 23:17:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42894 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbeGODRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 23:17:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id f4-v6so9605485plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=w+cBuSBjAko7b7SGWXDrrFvc8ZdhXkhhHhtMq9PdBnk=;
        b=cuRgkB0vYjA62cUyy94ChkasNaSUNGeD/qUtKWgdEqeymhiL8OgNB13OidGa+MLY2s
         os+DtOPwyHJZfch6RbxYR2CD4SvvZ5oX54kp3XJdtclxkeo4o9X0HCXyee4ZpI6wQwe/
         I3lWfjOvJZIC+R0QOEFviX9sR1XvU3dHSlpzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=w+cBuSBjAko7b7SGWXDrrFvc8ZdhXkhhHhtMq9PdBnk=;
        b=dsdR6qgdVWUhf8KdnBHP8aS09GkYwOZQveSP1RlX2eleeXucXDXaNOWK6bkbr/8hvv
         oYPeG4vL/42hsylrthXj16XLkU910UE8SvUlyW04s1WGfpOeA9qT2FeXlvpHJGHZkLgf
         in+CCYh9sga5Arjc9eXuGXKnB1wW6WOUvItm6e6ML1dQvmb8bKd0E5+sN1MgexzKCzBh
         6ew4MYvC3U/Uofs7ZxOV1VCmZh2bHRyXh2jjsiGkB1KaRt++vs5jlVlGT9Xc71ZTMbGQ
         46j4A/kYFRw8FmmTJPXxDRV/GqJ5pKKU3flCr3dpRZA3n2CugRJUFQ8wG4SMQvTtSCkU
         9teA==
X-Gm-Message-State: AOUpUlFAwPkkK/GogKifQ8DMt/uP+ICnxwqSDjo/2LDe3kZ0f6T47XyD
        Xhz4KXI+jXejJ8vpjrsjStV3sg==
X-Google-Smtp-Source: AAOMgpdxn5ttvFKTYdZorrUUeERM+lZQT5gdCFrCf3MrowU4Oke7s0zZqqRGx3oKMJIYLmCV+fuWAQ==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr11776904pld.72.1531623389207;
        Sat, 14 Jul 2018 19:56:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r22-v6sm60569233pfl.112.2018.07.14.19.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 19:56:27 -0700 (PDT)
Date:   Sat, 14 Jul 2018 19:56:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot: Fix if_changed build flip/flop
Message-ID: <20180715025626.GA48623@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if_changed kbuild function can only be used once per target. If not
it will effectively always trigger, flipping back and forth between the
two commands getting recorded. Instead, merge the two commands into a
single function to get stable build artifacts (i.e. .vmlinux.cmd).

Reported-by: Dirk Gouders <dirk@gouders.net>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Fixes: 98f78525371b ("x86/boot: Refuse to build with data relocations")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..169c2feda14a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -106,9 +106,13 @@ define cmd_check_data_rel
 	done
 endef
 
+# We need to run two commands under "if_changed", so merge them into a
+# single invocation.
+quiet_cmd_check-and-link-vmlinux = LD      $@
+      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
+
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
-	$(call if_changed,check_data_rel)
-	$(call if_changed,ld)
+	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
-- 
2.17.1


-- 
Kees Cook
Pixel Security
