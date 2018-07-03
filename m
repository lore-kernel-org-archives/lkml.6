Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0121EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9461218C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9461218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeGCXe7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:34:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43049 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeGCXeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:34:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so7204600oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AghIbnVb/XLoarKJLDeGiy1VGGbkXNPve5XpgZTOSXI=;
        b=NXvnua0XtxemDl42S/wKsZ2AHZ0MQXtEcyzjGm9BaRbIm6ZvvgPRzwvkr1DxxGXroz
         SfHE0FU9b2YelFlDYkB8z0dLQ6U8xY1M79Rw+Kn27iJtxFPfyyiVXMt3LfK5j8XA856P
         HHSMJbCN7ZoaEKZiLUR2fsXAgmfl6+QjU2/tTOl4L5tiJRztfdAbYJkK6E4s/XSkfXXx
         JyyYuvxPh05lqTKzNJ2u/aKh3z7ZYAX/T1OuX4Su11a/WymSpU501OiExkAMvVtWH3iT
         DBXa8e50hICRNHDD6GU8dEhqGnjOXxtKoZ/XDAF+u73p4+t55U25ZhiSK6NhjsfXJu4e
         fRng==
X-Gm-Message-State: APt69E2QSYHgb50kSdYOvBOjVHsVJ7K7tGjV9sNoS/FJVLxQhPQHFm44
        REVNguOqx5BM2ZK7Tys8iz5DoQ==
X-Google-Smtp-Source: AAOMgpe/DVRsI4G0MBpoWKf+FTkH31VwBb+o+JtL8jemOYJrOR2KF8/abLqoWXh3f+R3Q0//YsYi3A==
X-Received: by 2002:aca:4d56:: with SMTP id a83-v6mr21592669oib.205.1530660886024;
        Tue, 03 Jul 2018 16:34:46 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1828702otc.25.2018.07.03.16.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:34:44 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 4/4] arm64: Add build salt to the vDSO
Date:   Tue,  3 Jul 2018 16:34:30 -0700
Message-Id: <20180703233430.14416-5-labbott@redhat.com>
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
v5: I was previously focused on x86 only but since powerpc gave a patch,
I figured I would do arm64 since the changes were also fairly simple.
---
 arch/arm64/kernel/vdso/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
index b82c85e5d972..2c429dfd3f45 100644
--- a/arch/arm64/kernel/vdso/note.S
+++ b/arch/arm64/kernel/vdso/note.S
@@ -22,7 +22,10 @@
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
+#include <linux/build-salt.h>
 
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT;
-- 
2.17.1

