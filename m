Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeA3NKc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:10:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeA3NKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:10:31 -0500
Date: Tue, 30 Jan 2018 14:10:20 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: William Grant <william.grant@canonical.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP
In-Reply-To: <7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com>
Message-ID: <alpine.DEB.2.20.1801301409430.1797@nanos>
References: <7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018, William Grant wrote:

> Since commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the
> fixmap"), i386's CPU_ENTRY_AREA has been mapped to the memory area just
> below FIXADDR_START. But already immediately before FIXADDR_START is the
> FIX_BTMAP area, which means that early_ioremap can collide with the
> entry area.
> 
> It's especially bad on PAE where FIX_BTMAP_BEGIN gets aligned to exactly
> match CPU_ENTRY_AREA_BASE, so the first early_ioremap slot clobbers the
> IDT and causes interrupts during early boot to reset the system.
> 
> The overlap wasn't a problem before the CPU entry area was introduced,
> as the fixmap has classically been preceded by the pkmap or vmalloc
> areas, neither of which is used until early_ioremap is out of the
> picture.
> 
> Relocate CPU_ENTRY_AREA to below FIX_BTMAP, not just below the permanent
> fixmap area.

Nice catch. I'm sure I stared at that more than once....

Thanks,

	tglx
