Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADA7C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3B1240BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3B1240BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeGFAuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:50:03 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40038 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbeGFAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:50:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id b129-v6so5500820qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 17:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PFn9mkwdccGrhASv75koBIRMBltlMYl7BIJMUgrwj/0=;
        b=E1b+YhkBItZjYSjcy5dSrht65mANOaHSmfzuBrKGaHA/Qf7SsMpb2eIbAxG/O26U9u
         QYb9fnWeXmRDzpdghOABu2HG8rEI6eNG8gcms46yePuuHXbcoEsCmW5d+aaZFbNY6cMx
         IGP/TgzosAv7vOLYZTgj86Nv90nf9v2DAitc9EmJ5AkAd/8zMj1Dwc+1/HTwcb5gpesO
         A4Uy4pgWI3iUF0x3lj5C1C8jjds0OMfYodCnFTx05BIBi5i4mhUFsSHQycWtpk4zqloO
         rQApnds3INQ/wHGM67sOWMrpnCCPbufh0j5APmn+qbD/UphvxTy1JI+jahGvrhssAdaA
         i86w==
X-Gm-Message-State: APt69E2Z2szqnI7CmGi5EePx72vyp7+dmHUtywujN9jPaJWNrf7LRMv0
        CA1762JE1I6YzFIt+jThrkFpUA==
X-Google-Smtp-Source: AAOMgpf0gZNH5HO9WbONhZv8whNft0fjWjfHb38QRUH9TItapPCX8LphEPMjmKoGWv3l4ODNPVIDQw==
X-Received: by 2002:ae9:dc05:: with SMTP id q5-v6mr1842490qkf.332.1530838199726;
        Thu, 05 Jul 2018 17:49:59 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id q67-v6sm4675205qkb.16.2018.07.05.17.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 17:49:58 -0700 (PDT)
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
Subject: [PATCHv6 4/4] arm64: Add build salt to the vDSO
Date:   Thu,  5 Jul 2018 17:49:40 -0700
Message-Id: <20180706004940.32587-5-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Remove the semi-colon, Ack from Will
---
 arch/arm64/kernel/vdso/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
index b82c85e5d972..e20483b104d9 100644
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
+BUILD_SALT
-- 
2.17.1

