Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DEECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AB1208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eB8ZoZ4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AB1208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIPFxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:53:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34480 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeIPFwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so5797925plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zg+yA6iBpUZzxZCfC7FbRgVPvRB/0N0Ik3Iu+95jWHE=;
        b=eB8ZoZ4tMyIPviAYdKjqes9M3w8pKOe5njrcU+iiJiycgH0TQa5knqhL7RzMCRSzsh
         SsTcm9DpzGnUbXAmqVLH3t2fUBOhQ/4znosFarR4rI1+BembNK+S9BVBT3yqyrTrugA7
         ebU8PdO/MYadi8BOY9h+SAxStt9PTOTauO2dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zg+yA6iBpUZzxZCfC7FbRgVPvRB/0N0Ik3Iu+95jWHE=;
        b=IJg55ICF69r66KcfamcmWytyK3WgzeYAbif1am4h3WSiv0FUlMknDXRCysEpgvigod
         a9iQh8qCveBiJ7xKxX0G0R6BsBZbQgKczf5wCN7dJWarvKCPX8REb5UVW9ByprCorqEc
         uEtLq4LJ4bYBFq59U3CMmR5YOWJ1uOeDYTVHdiSbeCVgo0ViTikI/dz0sjlBdYNZlM0d
         0NrHE+TQge3zDY/st9GXdgPr7iNlRfwP2K7joYXWaRB6/y0ugy4As5VFTWu1XoX+DRsv
         vL6Jkblan0h0tYlbk938xX7LDi+6L7uGM/VdweRUxnR1Kssam5teIa3+Nm68DzK78R3p
         IseA==
X-Gm-Message-State: APzg51DP7+bqRji7Zed8YjfmyOzwvC0t2TWysbeYMZMlab8XcTScDucP
        P26i3Rydh/oIJHpKPeB3U4Stgg==
X-Google-Smtp-Source: ANB0VdaiGIbcUCES3t3Rn7a0Q101MfJ+m63WoQTqFxMMykjqCPHnrrhjAFG9uHP4B1wFvWpdgeGe3Q==
X-Received: by 2002:a17:902:b212:: with SMTP id t18-v6mr18849902plr.107.1537057867383;
        Sat, 15 Sep 2018 17:31:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r81-v6sm15149679pfa.18.2018.09.15.17.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/18] vmlinux.lds.h: Avoid copy/paste of security_init section
Date:   Sat, 15 Sep 2018 17:30:42 -0700
Message-Id: <20180916003059.1046-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..934a45395547 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -473,13 +473,6 @@
 #define RODATA          RO_DATA_SECTION(4096)
 #define RO_DATA(align)  RO_DATA_SECTION(align)
 
-#define SECURITY_INIT							\
-	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-		__security_initcall_start = .;				\
-		KEEP(*(.security_initcall.init))			\
-		__security_initcall_end = .;				\
-	}
-
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -798,6 +791,12 @@
 		KEEP(*(.security_initcall.init))			\
 		__security_initcall_end = .;
 
+/* Older linker script style for security init. */
+#define SECURITY_INIT							\
+	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
+		SECURITY_INITCALL					\
+	}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-- 
2.17.1

