Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCLNtO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:49:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54432 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeCLNtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:49:12 -0400
Date: Mon, 12 Mar 2018 14:48:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180312134853.GD9431@pd.tnic>
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
 <20180312095336.GB9431@pd.tnic>
 <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
 <20180312130653.GC9431@pd.tnic>
 <df1e721c-f030-68b4-f197-2592bce97bbf@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df1e721c-f030-68b4-f197-2592bce97bbf@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:32:30PM +0100, Maciej S. Szmigiero wrote:
> "microcode_amd.bin" in linux-firmware.

That is the microcode container for all families < 0x15. And it
*happens* to have 18 entries.

So purely arbitrary:

Equivalence table (magic: AMD, type: 0, length: 288 (0x120))
============================================================
|  inst_cpu  |   err_msk  |   err_cmp  | eq_cpu |   res  |
==========================================================
| 0x00100f80 | 0x00000000 | 0x00000000 | 0x1080 | 0x0000 |
| 0x00100f81 | 0x00000000 | 0x00000000 | 0x1081 | 0x0000 |
| 0x00100f62 | 0x00000000 | 0x00000000 | 0x1062 | 0x0000 |
| 0x00100f23 | 0x00000000 | 0x00000000 | 0x1022 | 0x0000 |
| 0x00100f43 | 0x00000000 | 0x00000000 | 0x1043 | 0x0000 |
| 0x00100f91 | 0x00000000 | 0x00000000 | 0x1081 | 0x0000 |
| 0x00100f2a | 0x00000000 | 0x00000000 | 0x1020 | 0x0000 |
| 0x00100f63 | 0x00000000 | 0x00000000 | 0x1043 | 0x0000 |
| 0x00100f42 | 0x00000000 | 0x00000000 | 0x1041 | 0x0000 |
| 0x00300f10 | 0x00000000 | 0x00000000 | 0x3010 | 0x0000 |
| 0x00200f31 | 0x00000000 | 0x00000000 | 0x2031 | 0x0000 |
| 0x00100f52 | 0x00000000 | 0x00000000 | 0x1041 | 0x0000 |
| 0x00100fa0 | 0x00000000 | 0x00000000 | 0x10a0 | 0x0000 |
| 0x00100f53 | 0x00000000 | 0x00000000 | 0x1043 | 0x0000 |
| 0x00100f22 | 0x00000000 | 0x00000000 | 0x1022 | 0x0000 |
| 0x00500f10 | 0x00000000 | 0x00000000 | 0x5010 | 0x0000 |
| 0x00500f20 | 0x00000000 | 0x00000000 | 0x5020 | 0x0000 |
| 0x00000000 | 0x00000000 | 0x00000000 | 0x0000 | 0x0000 |

> There is no problem raising this value in that (future) case.
> As I wrote previously, currently the maximum used count is 18.

There is a problem because not everyone can upgrade their kernels
like you. Distros and big deployments can't just up and update their
kernels at a whim just because you imposed an arbitrary limit which you
determined would be ok.

> Not really, since even in the existing code CONTAINER_HDR_SZ (12) gets
> added to this size, then the sum is cast to a (signed) int.
> If this value is negative then the file get rejected.

That is a bug in install_equiv_cpu_table() - it should return unsigned int.

> It can be changed to the current maximum across sizes for particular

What is the "current maximum across sizes"?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
