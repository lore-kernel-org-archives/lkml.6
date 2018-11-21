Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C99C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63197206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8DTMIIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63197206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbeKVFrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389139AbeKVFre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:47:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F47D206BB;
        Wed, 21 Nov 2018 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827520;
        bh=KbCNDhqeRC6lM8xuozkTYKQJsafE1Fm296pZ4vSZTr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8DTMIIXMzHPygA9J6IcDXMfk0ohrBkzRMrT/fcfGZnMS+OCfW2B8cZ7i5gylWwdv
         5X/WeGi+ksWGW5YyIPqVkCQJVbIKBGe/m/Ixn6FkNYckYHMtfmBrz7YZcsdYlc048S
         DKeCuRDX7zD5RTYdgRroa+/mbbYOmGuuopv9Ar8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 35/59] arm64: uaccess: suppress spurious clang warning
Date:   Wed, 21 Nov 2018 20:06:50 +0100
Message-Id: <20181121183509.626442199@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit d135b8b5060ea91dd751ff172d179eb4eab1e966 upstream.

Clang tries to warn when there's a mismatch between an operand's size,
and the size of the register it is held in, as this may indicate a bug.
Specifically, clang warns when the operand's type is less than 64 bits
wide, and the register is used unqualified (i.e. %N rather than %xN or
%wN).

Unfortunately clang can generate these warnings for unreachable code.
For example, for code like:

do {                                            \
        typeof(*(ptr)) __v = (v);               \
        switch(sizeof(*(ptr))) {                \
        case 1:                                 \
                // assume __v is 1 byte wide    \
                asm ("{op}b %w0" : : "r" (v));  \
                break;                          \
        case 8:                                 \
                // assume __v is 8 bytes wide   \
                asm ("{op} %0" : : "r" (v));    \
                break;                          \
        }
while (0)

... if op() were passed a char value and pointer to char, clang may
produce a warning for the unreachable case where sizeof(*(ptr)) is 8.

For the same reasons, clang produces warnings when __put_user_err() is
used for types that are less than 64 bits wide.

We could avoid this with a cast to a fixed-width type in each of the
cases. However, GCC will then warn that pointer types are being cast to
mismatched integer sizes (in unreachable paths).

Another option would be to use the same union trickery as we do for
__smp_store_release() and __smp_load_acquire(), but this is fairly
invasive.

Instead, this patch suppresses the clang warning by using an x modifier
in the assembly for the 8 byte case of __put_user_err(). No additional
work is necessary as the value has been cast to typeof(*(ptr)), so the
compiler will have performed any necessary extension for the reachable
case.

For consistency, __get_user_err() is also updated to use the x modifier
for its 8 byte case.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -198,7 +198,7 @@ do {									\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__get_user_asm("ldr", "ldtr", "%",  __gu_val, (ptr),	\
+		__get_user_asm("ldr", "ldtr", "%x",  __gu_val, (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
@@ -272,7 +272,7 @@ do {									\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__put_user_asm("str", "sttr", "%", __pu_val, (ptr),	\
+		__put_user_asm("str", "sttr", "%x", __pu_val, (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\


