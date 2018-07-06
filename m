Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA10BC6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E913240BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E913240BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeGFAuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:50:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35754 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeGFAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:49:56 -0400
Received: by mail-qk0-f196.google.com with SMTP id u21-v6so5503834qku.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 17:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF9vhHMbhCIoy849wuH0XzT7nyqYG2N3OmiLDtOcUco=;
        b=fql0Cw/knAhO6Eu6rULqXQ1H8pZvWrYNS5B6u5MD6BWl8+v1IzKhriJZYH036V25LS
         ncWYcCP3gD2HXkUC98cd7sYXiCHFqKz0yxavnpqxuOhRdBJ4EFxP7wEEBLH3dzBDIEOJ
         bIEwM4A27SIQhmKnIjKn1hFQas8xle20d/zSujABSxKKQ5Lo/+miv/6UglcYqwJldMI+
         6Z4ERgscb6CyIUcp0jPhIaWBhvEeAhFF6Zl2Q70lXyxXCAZS+cPlx9ddIHfOBIKhpYdP
         NwslJRrw75h9QULJFEleqytUuJvuySkNWxyIA6NeOwPqrMZaC6MOlLOsAWeAUZO4vR7M
         vCvg==
X-Gm-Message-State: APt69E0hJK6f+KHut+dsTVCd28CftEM8m81jtcP+RDHPYmWh7uzPOAVv
        dKUT8I4OTGZJ3oVAbKZ8EXTYPw==
X-Google-Smtp-Source: AAOMgpfznhwUV1q/oCR6qzOvFshlkWZIRKc6U5LBpxA4eui7YlkNPMW5sxw/WlZIh8EITS2KQoNlJg==
X-Received: by 2002:a37:d61b:: with SMTP id t27-v6mr6770286qki.244.1530838196243;
        Thu, 05 Jul 2018 17:49:56 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id q67-v6sm4675205qkb.16.2018.07.05.17.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 17:49:55 -0700 (PDT)
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
Subject: [PATCHv6 3/4] powerpc: Add build salt to the vDSO
Date:   Thu,  5 Jul 2018 17:49:39 -0700
Message-Id: <20180706004940.32587-4-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Remove semi-colon
---
 arch/powerpc/kernel/vdso32/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/note.S b/arch/powerpc/kernel/vdso32/note.S
index d4b5be4f3d5f..227a7327399e 100644
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
+BUILD_SALT
-- 
2.17.1

