Return-Path: <psodagud@codeaurora.org>
X-Google-Smtp-Source: AH8x224fT8wihluTmdAA74GfeL24jmE+a7w8agd9h9mV+bJvtrpL7ZzUVYMEsH2shwPJr6b3JTi2
ARC-Seal: i=1; a=rsa-sha256; t=1517960819; cv=none;
        d=google.com; s=arc-20160816;
        b=Z7mGYnNfziVUW1NYWxUoQc80UrL0j5Sa1+DBVHZZMoWSlT5icjZXLexvF3JLs+vinX
         48ERqlNHjeuNc+Kne9403s2i2A9rE6FjlEvkCADIB8Qv5kw5H6tfx/or/1K2qDQsWVTl
         ZohICi0jV13s9WBJXtFOD/bLwSUESzcjhGQCbz26TQvCGxjoNU6bWDFWmdl5CpyqKrKp
         S07nhnUWj92X4ULfEvZqZinkmBAFh0pSGFxBL6LoMSH5OM5LB4VW7qlIE4cTy0gEZ07T
         xU5BlLjY38xGLoEpuwIG/GQKeR/BvXQiFS7FODXr1OOAs8/GCfneeDU/3RZ59cRDQo0X
         QH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=XMNunb7/1Ijgi+WvxGFi/Uxol24HCHtQ6uH4s+Vxmeo=;
        b=l2t78TmNKEMV6xpP4kKBvMusUDEBAq0ur4JjlDOrRJQazSwd3ENqHlsLM9uPkkUhcP
         zQVqtkQXEVX0Z3tMsgZ8v90bgm8vknDWHjJZN3EW6rN6S+loyuXnG8Din2aQ0CoJTMF1
         7K0v08ui44T/+Tu0u5e5EnVRX0nHq9083kL9pcD2mUgdBaMphr7uyEYE5Akwhphuk8ua
         cENcve0lKtxmkM0xZmjwKmBcKCwsrHBWRuf8do8bqn4dA+Kt1NHxNrvjpPbBR/P2w5tG
         kufvj0KdieROXXId6Qn/TBpOCcT5H5tr//YCJQqM0JxEgeLmpc84f2+dr7/dfjDufw1u
         LVZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TnN+coOH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TnN+coOH;
       spf=pass (google.com: domain of psodagud@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=psodagud@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TnN+coOH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TnN+coOH;
       spf=pass (google.com: domain of psodagud@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=psodagud@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC1ED60209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From: Prasad Sodagudi <psodagud@codeaurora.org>
To: yamada.masahiro@socionext.com
Cc: gregkh@linuxfoundation.org,
	segher@kernel.crashing.org,
	ghackmann@google.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH] kbuild: clang: disable unused variable warnings only when constant
Date: Tue,  6 Feb 2018 15:46:51 -0800
Message-Id: <1517960811-21674-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAK7LNAQ1d5t5-UHsF1ZJ9tNLpGgbMGnDoHdht9=wNy5kLDVyxw@mail.gmail.com>
References: <CAK7LNAQ1d5t5-UHsF1ZJ9tNLpGgbMGnDoHdht9=wNy5kLDVyxw@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697284772714302?=
X-GMAIL-MSGID: =?utf-8?q?1591697284772714302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, GCC disables -Wunused-const-variable, but not
-Wunused-variable, so warns unused variables if they are
non-constant.

While, Clang does not warn unused variables at all regardless of
the const qualifier because -Wno-unused-const-variable is implied
by the stronger option -Wno-unused-variable.

Disable -Wunused-const-variable instead of -Wunused-variable so that
GCC and Clang work in the same way.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 11aff0f..ca0a571 100644
--- a/Makefile
+++ b/Makefile
@@ -700,7 +700,6 @@ KBUILD_CFLAGS += $(stackp-flag)
 
 ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
@@ -718,9 +717,9 @@ else
 # These warnings generated too much noise in a regular build.
 # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 endif
 
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
