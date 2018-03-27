Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeC0JYN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:24:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47518 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeC0JYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:24:11 -0400
Date: Tue, 27 Mar 2018 11:23:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86/mm: Do not lose cpuinfo_x86:x86_phys_bits
 adjustment
In-Reply-To: <20180315134907.9311-3-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803271115040.1964@nanos.tec.linutronix.de>
References: <20180315134907.9311-1-kirill.shutemov@linux.intel.com> <20180315134907.9311-3-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Kirill A. Shutemov wrote:

> Some features (Intel MKTME, AMD SME) may reduce number of effectively

May? They fricking reduce the number of bits.

> available physical address bits. We adjust x86_phys_bits accordingly.
> 
> But if get_cpu_cap() got called more than one time we may lose this
> information.

We may? Dammit, I asked you more than once to stop writing fairy
tales. Changelogs are about facts and not about may/could or whatever. And
not WE lose the information, the information gets overwritten by the
subsequent invocation of get_cpu_cap().

> That's exactly what happens in setup_pku(): it gets called after
> detect_tme() and x86_phys_bits gets overwritten.
> 
> Add x86_phys_bits_adj which stores by how many bits we should reduce
> x86_phys_bits comparing to what CPUID returns.

That's just sloppy, really.

The real question is: Why on earth is get_cpu_cap() updating the 0x80000008
leaf information again after the first initialization?

If there is no reason to do so, then this needs to be taken out of
get_cpu_caps().

If there is a reason, then this wants to be explained proper.

This 'add some duct tape' mode has to stop. The cpu feature detection is
messy enough already, there is no need to add more to it unless there is a
real compelling reason.

Thanks,

	tglx
