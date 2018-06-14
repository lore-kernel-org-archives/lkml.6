Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 10FC4C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4A420864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATB2uIqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4A420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966338AbeFNOTG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966173AbeFNONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B441208E4;
        Thu, 14 Jun 2018 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985590;
        bh=xLxz/iUafIDXQrmVaFmjpQMPlJ1ucexw8e6tpSEf8W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATB2uIqmgBEGS30b0apJqBBcajqGej4tV0SPhQ+ae7/pAJSu7QBCzRIZSTebkifYD
         yaiFKFKOmxUhy16y5XvyLAL3q87pNhxSXlj8FOeWWZ2RwwDtsO7yI7DVJnrrg2k5RH
         1Pj4e8h61XdyIVs5ARvvAxADAxoi1/IQXgOzblRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 14/24] x86/crypto, x86/fpu: Remove X86_FEATURE_EAGER_FPU #ifdef from the crc32c code
Date:   Thu, 14 Jun 2018 16:05:09 +0200
Message-Id: <20180614132725.057373052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 02f39b2379fb81557ae864ec8f85421c0250c954 upstream.

The crypto code was checking both use_eager_fpu() and
defined(X86_FEATURE_EAGER_FPU).  The latter was nonsensical, so
remove it.  This will avoid breakage when we remove
X86_FEATURE_EAGER_FPU.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Rik van Riel <riel@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1475627678-20788-2-git-send-email-riel@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/crc32c-intel_glue.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -58,16 +58,11 @@
 asmlinkage unsigned int crc_pcl(const u8 *buffer, int len,
 				unsigned int crc_init);
 static int crc32c_pcl_breakeven = CRC32C_PCL_BREAKEVEN_EAGERFPU;
-#if defined(X86_FEATURE_EAGER_FPU)
 #define set_pcl_breakeven_point()					\
 do {									\
 	if (!use_eager_fpu())						\
 		crc32c_pcl_breakeven = CRC32C_PCL_BREAKEVEN_NOEAGERFPU;	\
 } while (0)
-#else
-#define set_pcl_breakeven_point()					\
-	(crc32c_pcl_breakeven = CRC32C_PCL_BREAKEVEN_NOEAGERFPU)
-#endif
 #endif /* CONFIG_X86_64 */
 
 static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t length)


