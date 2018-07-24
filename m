Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE27C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4733520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjfYdeC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4733520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbeGYARP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:17:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37428 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeGYARP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:17:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so3913394pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HnzN7gTjy8OgXtKH2z5DPrF2p31jsWED8E0Yv2kBkkk=;
        b=jjfYdeC7zpKQpSvx/KTnQqvVhuBFk816S8bC8LsywxdaHRKEZITMCfEpdVOXY/t6NU
         0CsWk2Kzws9+LOsQCgiWABdVTjcZo3rph60/XqssHc4o8jSz1U1pN9DxpXncLuQB6YGP
         3VS0qLjbwIs572oYOKCszPOJyzT47Kis4+cnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HnzN7gTjy8OgXtKH2z5DPrF2p31jsWED8E0Yv2kBkkk=;
        b=nJWlfOB4n9jLj5iobpMB8jaaUEKWTDsJLqCoyf/GrrP/xEsTzxDaFJmHbh623+VN6o
         waWoiyuJ6J0D8ZPQxH4ec7fCjqbrSexi8GuBgFmlIEa54kaJeh5s0ldlbjt9jIVRtGWG
         SfBNFVIh0PbxibR3BJTVRS5wLdbedrMUgrgBVmtCWfFzSKf1Ssr4BmXzPoTcdtOqOTkW
         OYw6g6G4Y7negJ0wUSGFq/Dt9tHggFtOfAqmzEY39BzX/hdNa3nIK2rAUQjkSwbHQwlm
         +sxAa+IeIWzyA2nKvkqIOKNGn74t6Qr/8oRvZqhHLDI5ADOFoK78I3IpFUsNYGwdmw4D
         l59Q==
X-Gm-Message-State: AOUpUlF2gZBdHDYV/KVs/M/DIW6kEX/oyHhyW38sc4QIJOWDp30zn4BD
        bI2hzosq9OPmK4p7eNLS/QQoLA==
X-Google-Smtp-Source: AAOMgpcaqEtT7FfIbnU3YqR3QljfG3/B6yzKwQYM3DnavUyg7bArpVlf9XgTpzXb9ELjN9fbOPhZ8g==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr18117377pgu.259.1532473709567;
        Tue, 24 Jul 2018 16:08:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h10-v6sm23716422pfj.78.2018.07.24.16.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 16:08:28 -0700 (PDT)
Date:   Tue, 24 Jul 2018 16:08:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/boot: Fix if_changed build flip/flop
Message-ID: <20180724230827.GA37823@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Gouders reported that two consecutive "make" invocations on an
already compiled tree will show alternating behaviors:

$ make
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  DATAREL arch/x86/boot/compressed/vmlinux
Kernel: arch/x86/boot/bzImage is ready  (#48)
  Building modules, stage 2.
  MODPOST 165 modules

$ make
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  OBJCOPY arch/x86/boot/vmlinux.bin
  BUILD   arch/x86/boot/bzImage
Setup is 15644 bytes (padded to 15872 bytes).
System is 6663 kB
CRC 3eb90f40
Kernel: arch/x86/boot/bzImage is ready  (#48)
  Building modules, stage 2.
  MODPOST 165 modules

He bisected it back to:

    commit 98f78525371b ("x86/boot: Refuse to build with data relocations")

The root cause was the use of the "if_changed" kbuild function multiple
times for the same target. It was designed to only be used once per
target, otherwise it will effectively always trigger, flipping back and
forth between the two commands getting recorded by "if_changed". Instead,
this patch merges the two commands into a single function to get stable
build artifacts (i.e. .vmlinux.cmd), and a single build behavior.

Reported-by: Dirk Gouders <dirk@gouders.net>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
v2: improved changelog, added Reviewed-by
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
