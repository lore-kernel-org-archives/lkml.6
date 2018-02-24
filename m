Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeBXVsm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 16:48:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:47366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeBXVsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 16:48:39 -0500
Date: Sat, 24 Feb 2018 22:48:18 +0100
From: Borislav Petkov <bp@suse.de>
To: tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hpa@zytor.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        bp@suse.de
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180224214818.GD29374@pd.tnic>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 04:19:38AM -0800, tip-bot for Kirill A. Shutemov wrote:
> Commit-ID:  b91993a87aff6dafd60a9c8ce80ebc425161a815
> Gitweb:     https://git.kernel.org/tip/b91993a87aff6dafd60a9c8ce80ebc425161a815
> Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> AuthorDate: Fri, 9 Feb 2018 17:22:27 +0300
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sun, 11 Feb 2018 12:36:19 +0100
> 
> x86/boot/compressed/64: Prepare trampoline memory

This patch breaks X in my test guest image here. The failing Xorg.0.log file
has:

[     8.504] (II) Loading /usr/lib/xorg/modules/libint10.so
[     8.506] (II) Module int10: vendor="X.Org Foundation"
[     8.506]    compiled for 1.19.2, module version = 1.0.0
[     8.506]    ABI class: X.Org Video Driver, version 23.0
[     8.506] (II) VESA(0): initializing int10
[     8.506] (EE) VESA(0): V_BIOS address 0x0 out of range
[     8.506] (II) UnloadModule: "vesa"
[     8.506] (II) UnloadSubModule: "int10"
[     8.506] (II) Unloading int10
[     8.506] (II) UnloadSubModule: "vbe"
[     8.506] (II) Unloading vbe
[     8.506] (EE) Screen(s) found, but none have a usable configuration.
[     8.506] (EE)
Fatal server error:
[     8.506] (EE) no screens found(EE)
[     8.506] (EE)
Please consult the The X.Org Foundation support
         at http://wiki.x.org
 for help.
[     8.506] (EE) Please also check the log file at "/var/log/Xorg.0.log" for additional information.
[     8.506] (EE)
[     8.516] (EE) Server terminated with error (1). Closing log file.

note the

[     8.506] (EE) VESA(0): V_BIOS address 0x0 out of range

line.

I tried reverting this patch but it doesn't revert cleanly so I checked
out the one before it in tip/master:

4440977be134 ("x86/boot/compressed/64: Introduce paging_prepare()")

With it, guest X starts just fine and Xorg.0.log has:

[     7.594] (II) Loading /usr/lib/xorg/modules/libint10.so
[     7.595] (II) Module int10: vendor="X.Org Foundation"
[     7.595]    compiled for 1.19.2, module version = 1.0.0
[     7.595]    ABI class: X.Org Video Driver, version 23.0
[     7.595] (II) VESA(0): initializing int10
[     7.596] (II) VESA(0): Primary V_BIOS segment is: 0xc000
[     7.596] (II) VESA(0): VESA BIOS detected
[     7.596] (II) VESA(0): VESA VBE Version 3.0
[     7.596] (II) VESA(0): VESA VBE Total Mem: 16384 kB
[     7.596] (II) VESA(0): VESA VBE OEM: SeaBIOS VBE(C) 2011
[     7.596] (II) VESA(0): VESA VBE OEM Software Rev: 0.0
[     7.596] (II) VESA(0): VESA VBE OEM Vendor: SeaBIOS Developers
[     7.596] (II) VESA(0): VESA VBE OEM Product: SeaBIOS VBE Adapter
[     7.596] (II) VESA(0): VESA VBE OEM Product Rev: Rev. 1
[     7.623] (II) VESA(0): Creating default Display subsection in Screen section
        "Default Screen Section" for depth/fbbpp 24/32
[     7.623] (==) VESA(0): Depth 24, (--) framebuffer bpp 32
[     7.623] (==) VESA(0): RGB weight 888
[     7.623] (==) VESA(0): Default visual is TrueColor
[     7.623] (==) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
