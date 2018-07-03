Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF815C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83225218C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83225218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeGCXeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:34:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40211 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeGCXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:34:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so7222964oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PPKzxzbXZeTzzpbPbKd1oISc49HTYwkroXCel3beca4=;
        b=ODOIqz4e/raHhKGDPm3sYhfF/086i7s/JOO98yEC0xJGKJwseM6y6/kM3oYfRvRZtG
         RAYmeZI+ZqewO/2+T2KHwlNYyouKK6MUYscJJmlsekBCaB44lUCDFXSBrMQJkgM5geaE
         JfDcRJwLoC20+YzqUN3/z6+0wqgrwdQLSi/OVXkdkQbQvbDRDJJSwA8cAeP6XLwHSLrc
         IDvxEPZ+5h/693/zkP6Ypy6pksRfWxdPBkeA5GwVB/OdPX7lVWJlWsikfTeAATdvokGG
         e55yGO5DpBAPNm0ewsBlTe0FwNPX0lvDNtxcyU1vklB3mx1rZCiXcOXfpPK//vdcQS1a
         ISJg==
X-Gm-Message-State: APt69E3DWmRF5DE1Dg4t08/l7F6s2Mkj68GFhyT/865cQBcTm6KYmYka
        fwKyj4YkflEl0IMRQqpoLZoROQ==
X-Google-Smtp-Source: AAOMgpc5FQLNfk5ZFnnS06tJ9olyRLUbbg58CUH/7CStcvAgCkdie+U/IH3DSiTe7PFOXycJs7JQFw==
X-Received: by 2002:aca:4286:: with SMTP id p128-v6mr21394232oia.242.1530660880792;
        Tue, 03 Jul 2018 16:34:40 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1828702otc.25.2018.07.03.16.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:34:39 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 2/4] x86: Add build salt to the vDSO
Date:   Tue,  3 Jul 2018 16:34:28 -0700
Message-Id: <20180703233430.14416-3-labbott@redhat.com>
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
v5: Switched to using the single line BUILD_SALT macro
---
 arch/x86/entry/vdso/vdso-note.S   | 3 +++
 arch/x86/entry/vdso/vdso32/note.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
index 79a071e4357e..79423170118f 100644
--- a/arch/x86/entry/vdso/vdso-note.S
+++ b/arch/x86/entry/vdso/vdso-note.S
@@ -3,6 +3,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -10,3 +11,5 @@
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
index 9fd51f206314..e78047d119f6 100644
--- a/arch/x86/entry/vdso/vdso32/note.S
+++ b/arch/x86/entry/vdso/vdso32/note.S
@@ -4,6 +4,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
 
@@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
 
+BUILD_SALT
+
 #ifdef CONFIG_XEN
 /*
  * Add a special note telling glibc's dynamic linker a fake hardware
-- 
2.17.1

