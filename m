Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeFEOK0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:10:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:13816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752251AbeFEOKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:10:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="46591612"
Date: Tue, 5 Jun 2018 17:10:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mark native_set_p4d() as __always_inline
Message-ID: <20180605141017.bxqtid7ankvxqrdj@black.fi.intel.com>
References: <20180605113715.1133726-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605113715.1133726-1-arnd@arndb.de>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:35:15AM +0000, Arnd Bergmann wrote:
> When CONFIG_OPTIMIZE_INLINING is enabled, the function native_set_p4d()
> may not be fully inlined into the caller, resulting in a false-positive
> warning about an access to the __pgtable_l5_enabled variable from a
> non-__init function, despite the original caller being an __init function:
> 
> WARNING: vmlinux.o(.text.unlikely+0x1429): Section mismatch in reference from the function native_set_p4d() to the variable .init.data:__pgtable_l5_enabled
> WARNING: vmlinux.o(.text.unlikely+0x1429): Section mismatch in reference from the function native_p4d_clear() to the variable .init.data:__pgtable_l5_enabled
> The function native_set_p4d() references
> the variable __initdata __pgtable_l5_enabled.
> This is often because native_set_p4d lacks a __initdata
> annotation or the annotation of __pgtable_l5_enabled is wrong.
> 
> Marking the native_set_p4d function and its caller native_p4d_clear()
> avoids this problem.
> 
> I did not bisect the original cause, but I assume this is related to
> the recent rework that turned pgtable_l5_enabled() into an inline
> function, which in turn caused the compiler to make different inlining
> decisions.
> 
> Fixes: ad3fe525b950 ("x86/mm: Unify pgtable_l5_enabled usage in early boot code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing this.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Do you have a clue which native_set_p4d() call causes the issue?

-- 
 Kirill A. Shutemov
