Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC22C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCDC208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4QMe9eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCDC208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754275AbeFTP0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:26:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52236 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbeFTPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so207714wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m9bM2usci+57xc3zRMgpKMd80JVfANdAQuqRMxrSXbE=;
        b=P4QMe9eUNQNmUEDFBBlBegREw9qogy95KBK5zhWridJ7KAYuu4P4qoJ4RSKpU9A9uj
         5fca0DIDVpiHr/mfdFgE3ofA/Enl3ijcfpPqVwDoidv/ZBmJd3UfR+UiNCeMZof4XCST
         4C/1T1Yp+k36uWBvPwnzfbw0QykFayqOyUY5ncoD2eTJsW/QASmCkGs/GutEvLYzNuJj
         869lLy8dgvSAUBlgEVAbePvzExXpPUkKx6xwcWa6d2c6HPYOArGLmbtV9voMXMuXOIDR
         Yv0PUDda2BBkNvrXOwhUkwNT0fQrGVD3726M/2PMhCspWsSHXdrSHi0Ge+6EaYp8cb5d
         tjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m9bM2usci+57xc3zRMgpKMd80JVfANdAQuqRMxrSXbE=;
        b=R7jyMC+dI+9EZbMnk8WZm5lHHKsws60+sYJd7XPPwunXbEUySyM3h/El1zagDQUg1X
         jg5J4lQo9kPAe7XP3ALuy+OEg+zohX3dh7D5OiQ2jS5Gih3JtDKFwqZY6cuxBNXaEQjZ
         EPbQWPTBfi1wfbFphSvR2fBDD56Qz5YX2V3grhBaicCxluvgyCtAQQbJnu+WljorpqXx
         SebYuXE76sNpqyJWKCCDSr3LaV6tUGBDaCIHqyhG9mfWXseVREXHSwkG5W0QVIu/KT+5
         6CqdrpA4XHqLfcYv3dC2Kz7vjMRM4JR3LgeLwWMAdIsRnMQ6Y0FyrfsWwbWR21nWVdDO
         CYjA==
X-Gm-Message-State: APt69E1MUiT1hrnPjm+4iTei7Xe9nTMUVhzPoYqiJmaYrfdhrheJq+lB
        2rVqV8WDHXEv94PqU4SkD2F2og==
X-Google-Smtp-Source: ADUXVKLQqaSurFJRIyHjy++pghmW5yD8Wq8MdxfPzk2iZvkneLGTJmoAUuaWj2bOKS5adHS07hEvOA==
X-Received: by 2002:a1c:9015:: with SMTP id s21-v6mr2104314wmd.20.1529508274166;
        Wed, 20 Jun 2018 08:24:34 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:33 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 3/7] arm64: untag user addresses in access_ok and __uaccess_mask_ptr
Date:   Wed, 20 Jun 2018 17:24:22 +0200
Message-Id: <69573b1f821c5068be21fdff556cef11f03a09b4.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 2d6451cbaa86..fa7318d3d7d5 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -105,7 +105,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	\
+	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -237,7 +238,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -245,10 +247,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.18.0.rc1.244.gcf134e6275-goog

