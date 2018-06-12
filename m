Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 01EE3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2209208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2209208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbeFLAc7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:32:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35192 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934815AbeFLAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:32:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so10575200pge.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WE8UorqEcWR0qayLlC9jh0/UiPlrZYUo/DYEnp/7/Hs=;
        b=dRf7JTnxiWC/+FXaLlYQlBCPUjTKH4moDO5TUsmqBBGzJ8fHRq3S+VXUuKCh/YJONf
         Z2DA21/+eMEWr7NZURG4mOQzIdi1NjPRcRiHHcMjWmIZlj9NirFsyD7S56h00w/vWVOY
         z/bn0tNXZ86VZIAJdSRl+xKzPHAX1ejqvYG4NEFIO3HbGtFxl0LD1wDKqnyFKb5daKOH
         EhRP18EMdTdR/ObklW9LeTsX42Zdu50s07qrjcXAbznfoepPK9MUWNn4XaR0Mwt13ZNF
         Jzn59WxiF8qOAXGsDuahuUm97wyjUVdTqSf/DWkA9qzFMYgi3R2wlP3ClsL5MX9N/Ogp
         uD+A==
X-Gm-Message-State: APt69E2lXl1MKfeRrzIynbt4SYy4EZv0hRDwR+J3vudUnp7PDFaa0PQB
        FmjEh6wSKiXW/mtfFU2/r8Ldww==
X-Google-Smtp-Source: ADUXVKLxcuCuWAEKmgw6zsfo7NYAcvvMbh1/xeZSE/Sz5Dmi7GQ39uMmRkgnuWhxAFmLO+KdtDF89g==
X-Received: by 2002:a62:6406:: with SMTP id y6-v6mr1384980pfb.204.1528763574248;
        Mon, 11 Jun 2018 17:32:54 -0700 (PDT)
Received: from localhost.net ([2601:602:9802:a8dc::27e5])
        by smtp.gmail.com with ESMTPSA id c12-v6sm40866112pfi.177.2018.06.11.17.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 17:32:53 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: [PATCHv4 3/3] x86: Add build salt to the vDSO and kernel linker scripts
Date:   Mon, 11 Jun 2018 17:32:24 -0700
Message-Id: <20180612003224.3658-4-labbott@redhat.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180612003224.3658-1-labbott@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Both the kernel and the vDSO need to have unique build ids.
Insert the build salt section to make the build ids unique.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 3 ++-
 arch/x86/kernel/vmlinux.lds.S         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index acfd5ba7d943..a331c1d41360 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
-
+#include <asm-generic/vmlinux.lds.h>
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
  * its virtual address, and with only one read-only segment.
@@ -74,6 +74,7 @@ SECTIONS
 	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
 
 
+	BUILD_SALT
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5e1458f609a1..b61c33fa2617 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -172,6 +172,7 @@ SECTIONS
 		_edata = .;
 	} :data
 
+	BUILD_SALT
 	BUG_TABLE
 
 	ORC_UNWIND_TABLE
-- 
2.18.0.rc1

