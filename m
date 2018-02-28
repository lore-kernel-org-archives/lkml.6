Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeB1N7l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:59:41 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56985 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752488AbeB1N7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:59:39 -0500
X-ME-Sender: <xms:ybWWWvteCTL_AeMThxy_fhe4vzkCHrB6QqaZHleVU0zQB2SDGAFIeg>
Date: Wed, 28 Feb 2018 10:59:31 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] x86/microcode: Synchronize late microcode loading
Message-ID: <20180228135931.uwveegfdv5afozxe@khazad-dum.debian.net>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-8-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228102846.13447-8-bp@alien8.de>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Borislav Petkov wrote:
> + * Late loading dance. Why the heavy-handed stomp_machine effort?
> + *
> + * - HT siblings must be idle and not execute other code while the other sibling
> + *   is loading microcode in order to avoid any negative interactions caused by
> + *   the loading.
> + *
> + * - In addition, microcode update on the cores must be serialized until this
> + *   requirement can be relaxed in the future. Right now, this is conservative
> + *   and good.

Eek! If I read that right, this effectively halts the entire box until
every core is updated, with one core entering deep-coma at a time (the
rest are left either spinning or cpu_relax()ing depending on whether
they have already updated or not)?

If this is correct, I shudder at what it would do on a server with
dozens, or hundreds of cores...  According to Ben Hawkes' paper, Intel's
on-die microcode update loader takes linear time relative to the update
size to do the crypto dance.

On my single-xeon X5550 workstation, which should be relatively fast
since its microcode update is small, the whole thing would take about
3,2 million cycles (circa 800k cycles per core, 4 cores, skipping
hyperthreads) to do a sync late update.  I don't believe this has
changed much, but I *did not* test, e.g., a Skylake Xeon, or anything
newer than that Xeon X5550.

Anyway, maybe there is a safe way to do it in a more parallel fashion
based on cpu topology?

AFAIK, it is not like there is any way to make OS microcode updates
(early or late) safe against SMIs and NMIs hitting the sibling
hyperthread while updating the other, so we don't have to care about
*that* nasty corner case simply because we can't avoid it in the first
place.

Hopefully AMD has none of those pitfalls, and could just trigger an
update on half the cores at a time, easily bounding it to approximately
twice the time it takes to update a single core :-(

-- 
  Henrique Holschuh
