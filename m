Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABDAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118A82147A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyVk7bhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118A82147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbeKIHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732999AbeKIHsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:48:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DC9208A3;
        Thu,  8 Nov 2018 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715029;
        bh=yLavgf0a/Z1xb1iHnfmRYDblmDxheKbcPlRB6+Nq3qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyVk7bhwdw+n4F9MHSBHVZ7yIqMfWgAS6tc82DypHu8dwxfFjb7DqJKh5rlDw1LRD
         gZMIB0WpKvs6PZeJ7kGldggJ1KyYkEmQJ2/rXIS+eaHAevee1tTTyaz9OkTz9QNHV1
         tnN2hpRWhHDfcLiuS33t9l5r8TLTAjw1axhLa5X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.18 32/34] x86/time: Correct the attribute on jiffies definition
Date:   Thu,  8 Nov 2018 13:53:01 -0800
Message-Id: <20181108215140.860636450@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit 53c13ba8ed39e89f21a0b98f4c8a241bb44e483d upstream.

Clang warns that the declaration of jiffies in include/linux/jiffies.h
doesn't match the definition in arch/x86/time/kernel.c:

arch/x86/kernel/time.c:29:42: warning: section does not match previous declaration [-Wsection]
__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
                                         ^
./include/linux/cache.h:49:4: note: expanded from macro '__cacheline_aligned'
                 __section__(".data..cacheline_aligned")))
                 ^
./include/linux/jiffies.h:81:31: note: previous attribute is here
extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
                              ^
./arch/x86/include/asm/cache.h:20:2: note: expanded from macro '__cacheline_aligned_in_smp'
        __page_aligned_data
        ^
./include/linux/linkage.h:39:29: note: expanded from macro '__page_aligned_data'
#define __page_aligned_data     __section(.data..page_aligned) __aligned(PAGE_SIZE)
                                ^
./include/linux/compiler_attributes.h:233:56: note: expanded from macro '__section'
#define __section(S)                    __attribute__((__section__(#S)))
                                                       ^
1 warning generated.

The declaration was changed in commit 7c30f352c852 ("jiffies.h: declare
jiffies and jiffies_64 with ____cacheline_aligned_in_smp") but wasn't
updated here. Make them match so Clang no longer warns.

Fixes: 7c30f352c852 ("jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181013005311.28617-1-natechancellor@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -25,7 +25,7 @@
 #include <asm/time.h>
 
 #ifdef CONFIG_X86_64
-__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
+__visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 #endif
 
 unsigned long profile_pc(struct pt_regs *regs)


