Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030312AbeBNNco (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:32:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:55549 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030198AbeBNNcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:32:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="18053995"
Date: Wed, 14 Feb 2018 16:32:38 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        g@black.fi.intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] x86/mm: Make LDT_BASE_ADDR dynamic
Message-ID: <20180214133238.cliqsqp5rdggjzqy@black.fi.intel.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
 <20180214111656.88514-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214111656.88514-6-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:16:52AM +0000, Kirill A. Shutemov wrote:
> LDT_BASE_ADDR has different value in 4- and 5-level paging
> configurations.
> 
> We need to make it dynamic in preparation for boot-time switching
> between paging modes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I've just realized that the patch that I'm splitting has hunk that belong
here.

Could you fold it in?

Sorry for this.

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 9efee6f464ab..a32f0621d664 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -579,6 +579,9 @@ static int __init pt_dump_init(void)
 	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
 	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
 #endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+        address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
+#endif
 #endif
 #ifdef CONFIG_X86_32
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
-- 
 Kirill A. Shutemov
