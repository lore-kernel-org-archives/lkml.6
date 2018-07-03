Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0920DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA885218C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA885218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeGCXes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:34:48 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39681 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeGCXeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:34:44 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so7225461oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=etAvmKHM8E9YR7JAbwmTeTq4fxcpjVM907hKynRt4kQ=;
        b=cl+LL2vEj97M/0DuZSaFYXj4/E4rHv2zFy4dIUhxiRx25lsV9FRvlyf0uYIv0C45m8
         Ci8eahHl9B8yGSiZmLeiGIMQ9bnyfdWebEo2lPEBRmerM/u+DYLlxrNkYzUAAtOF/ygu
         IYXL9xdG+H1N00BLtcJ+XUwCbEkon1mTdUad3O4YyLA3DPSm30ywCkFHUJ820GRjQHfm
         UCESUVVKzlGYG29u9p+cd0r+sTyLtqJggcfYqgsYeXmTu2NG1Urvw2bO4mfMcKWl9lC4
         C5Nl2lXdoOhRAOXXP/cG8EkmqAsBXFuNY7pdabRholLS0yOqH8aWJmtFwy1eHJ/tRFye
         vdeg==
X-Gm-Message-State: APt69E3ZH94b3pyZF733HUYz8UgGMxssjytnnVQd/4JY+Oox39cmHQnE
        vc/83TBBAx3W1PY7N/ZQMgu+fw==
X-Google-Smtp-Source: AAOMgpeGovF1gSGWBVcl6onc/Ny175vdvdIRsvAPta8FLoIT8EfqPBYg0NfOKXe7Yd62OrDtsxBCvw==
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr1740252oig.98.1530660883424;
        Tue, 03 Jul 2018 16:34:43 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1828702otc.25.2018.07.03.16.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:34:42 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 3/4] powerpc: Add build salt to the vDSO
Date:   Tue,  3 Jul 2018 16:34:29 -0700
Message-Id: <20180703233430.14416-4-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703233430.14416-1-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: New approach with the BUILD_SALT macro
---
 arch/powerpc/kernel/vdso32/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/note.S b/arch/powerpc/kernel/vdso32/note.S
index d4b5be4f3d5f..ec1d05265c75 100644
--- a/arch/powerpc/kernel/vdso32/note.S
+++ b/arch/powerpc/kernel/vdso32/note.S
@@ -5,6 +5,7 @@
 
 #include <linux/uts.h>
 #include <linux/version.h>
+#include <linux/build-salt.h>
 
 #define ASM_ELF_NOTE_BEGIN(name, flags, vendor, type)			      \
 	.section name, flags;						      \
@@ -23,3 +24,5 @@
 	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
 	.long LINUX_VERSION_CODE
 	ASM_ELF_NOTE_END
+
+BUILD_SALT;
-- 
2.17.1

