Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E0C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0B920882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0B920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeG2V0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:26:48 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48282 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2V0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:26:47 -0400
Received: from [2001:470:1f07:12aa:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjrmL-0002Lb-CK; Sun, 29 Jul 2018 15:54:57 -0400
Date:   Sun, 29 Jul 2018 15:54:51 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 10/11] x86,tlb: really leave mm on shootdown
Message-ID: <20180729155451.7a1eb1a5@imladris.surriel.com>
In-Reply-To: <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
        <20180728215357.3249-11-riel@surriel.com>
        <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jul 2018 21:21:17 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com> wrote:
> > Conditionally skip lazy TLB mm refcounting. When an architecture has
> > CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> > lazy TLB mode anywhere will get shot down from exit_mmap, and there
> > in no need to incur the cache line bouncing overhead of refcounting
> > a lazy TLB mm.  
> 
> Unless I've misunderstood something, this patch results in idle tasks
> whose active_mm has been freed still having active_mm pointing at
> freed memory. 

Below (plus the next email) should fix the bug you pointed
out, in a somewhat non-invasive way. Patches have survived
a few simple tests on my test system, I have not thrown a
full load at them yet.

I would like to save the full rewrite to remove ->active_mm
for a later series, because this is already as much churn
as I am comfortable with for this code :)

---8<---

Author: Rik van Riel <riel@surriel.com>
Subject: [PATCH 10/11] x86,tlb: really leave mm on shootdown

When getting an mm shot down from under us in lazy TLB mode, don't
just switch the TLB over to the init_mm page tables, but really drop
our references to the lazy TLB mm.

This allows for faster (instant) freeing of a lazy TLB mm, which is
a precondition to getting rid of the refcounting of mms in lazy TLB mode.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7b1add904396..425cb9fa2640 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -140,6 +140,8 @@ void leave_mm(void *dummy)
 	WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
 
 	switch_mm(NULL, &init_mm, NULL);
+	current->active_mm = &init_mm;
+	mmdrop(loaded_mm);
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
@@ -483,6 +485,8 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
+		current->active_mm = &init_mm;
+		mmdrop(loaded_mm);
 		return;
 	}
 
-- 
2.14.4

