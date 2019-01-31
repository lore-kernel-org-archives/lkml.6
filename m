Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA10C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2BF20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvJ8b78v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfAaTbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:31:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39317 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfAaT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so1777977pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QqM92PuroQMRE5kfXgAFoy35KvoRU+1smYlTm3vmiw=;
        b=mvJ8b78vHV25r93JNQW5CF+SxfDiDnz/t5sOvODw/zPSqpI5rsWDibc4bweSjX4usY
         Zuj7fShtiLzRkVs6tfF7SibkS+yAfqRzJkZYWjWErRqGnfNWInjw8/wTtGRqC0elnwIm
         TjONK91xHi6iO0G613VXaLvcVDSdLI1ZqdXMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QqM92PuroQMRE5kfXgAFoy35KvoRU+1smYlTm3vmiw=;
        b=LzDkt08XH3uKWhe9QL5VrE5Niifb7X08N0Fbemrv900WJKWiB/z56X7Gn/NvwdfF9L
         Z8AzrezhFnheTtpiwdq4fh3ibTX7+1fZ8Q/dX/DlihLc+t6Z0wQimt3gZXqPHP0/kfWS
         PUlD8iXsxRCWmriPvgnsVUAJ4WbSsYCDSfLJDcjdw4Reqrt3RZBND1s4uyAbAyZrLEyf
         1seJ8t01dWlpRMQa7+q1Jypluv6TtQxQR8njt9xevdEQAySs25ta2GVuq5rUsPjgj/Ve
         sHI8U5FVYKZVzYxSY0Nd0Dk3VIZ6sbBznH3DeWZ8D9fKIyYarmy5pi8PnZdXy9pCXNVv
         aJWQ==
X-Gm-Message-State: AJcUukdYeUoC1yUy96wYKbPEKpW0lOhqLYF+d1rxy5RSb4gdVPbkWX3K
        87CGCcLm9HJuI5GXVfiPQwW2yA==
X-Google-Smtp-Source: ALg8bN4UCCGzROZSVTh4Z8EZ+pWB4VhtlRjlb03JvWGx05veb0DLZU9/IKrkehXCe6miSdM0Z17fZA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr32175673pgh.394.1548962896699;
        Thu, 31 Jan 2019 11:28:16 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:16 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Garnier <thgarnie@google.com>,
        Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/27] x86: Use symbol name in jump table for PIE support
Date:   Thu, 31 Jan 2019 11:24:09 -0800
Message-Id: <20190131192533.34130-3-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the %c constraint with %P. The %c is incompatible with PIE
because it implies an immediate value whereas %P reference a symbol.
Change the _ASM_PTR reference to .long for expected relocation size and
add a long padding to ensure entry alignment.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 65191ce8e1cf..e47fad8ee632 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -25,9 +25,9 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
+		_ASM_PTR "%P0 - .\n\t"
 		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+		: :  "X" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
 l_yes:
@@ -42,9 +42,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
+		_ASM_PTR "%P0 - .\n\t"
 		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+		: : "X" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
 l_yes:
-- 
2.20.1.495.gaa96b0ce6b-goog

