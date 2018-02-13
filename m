Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934580AbeBMLVt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:21:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57276 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934354AbeBMLVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:21:47 -0500
Date: Tue, 13 Feb 2018 12:21:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andi Kleen <andi@firstfloor.org>
Cc: tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, jpoimboe@redhat.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] x86/retpoline: Fix return buffer filling
Message-ID: <20180213112118.GB11572@pd.tnic>
References: <20180213000422.16916-1-andi@firstfloor.org>
 <20180213000422.16916-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213000422.16916-2-andi@firstfloor.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:04:22PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> An earlier patch moved the RSB filling out of line, ending
> it with a return. This results in the return buffer filling
> only giving 15 instead of 16 usable returns because
> the return from fill_rsb already uses one up.

Or, we can get rid of the RET:

---
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 480edc3a5e03..359130ceaa64 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -91,7 +91,8 @@ GENERATE_THUNK(r15)
 
 ENTRY(__fill_rsb)
 	STUFF_RSB RSB_FILL_LOOPS, %_ASM_SP
-	ret
+	pop %_ASM_BX
+	jmp *%_ASM_BX
 END(__fill_rsb)
 EXPORT_SYMBOL_GPL(__fill_rsb)
 
@@ -99,6 +100,7 @@ EXPORT_SYMBOL_GPL(__fill_rsb)
 
 ENTRY(__clear_rsb)
 	STUFF_RSB RSB_CLEAR_LOOPS, %_ASM_SP
-	ret
+	pop %_ASM_BX
+	jmp *%_ASM_BX
 END(__clear_rsb)
 EXPORT_SYMBOL_GPL(__clear_rsb)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
