Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeBLHsP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 02:48:15 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35395 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeBLHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 02:48:13 -0500
X-Google-Smtp-Source: AH8x224Art9Y6Rmj8paGFWCfxrvWZTws2Y/adVJxhF4FLVATRWnbk29enLpooSPOvGnoT6JLhnT7Dg==
Date: Mon, 12 Feb 2018 10:48:10 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/5] x86: Enumerate TME and PCONFIG, add MKTME_KEY_PROG
 helper
Message-ID: <20180212074809.7hk6m7y2yzf5r252@node.shutemov.name>
References: <20180209140754.17062-1-kirill.shutemov@linux.intel.com>
 <20180211190241.nzulvhhzkb74t72o@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211190241.nzulvhhzkb74t72o@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 08:02:41PM +0100, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> 
> > Multikey Total Memory Encryption (MKTME)[1] is a technology that allows
> > transparent memory encryption in upcoming Intel platforms.
> >
> > MKTME is built on top of TME. TME allows encryption of the entirety of
> > system memory using a single key. MKTME allows to have multiple encryption
> > domains, each having own key -- different memory pages can be encrypted
> > with different keys.
> > 
> > The patchset does some ground work for MKTME enabling:
> >   - Adds two new cpufeatures: TME and PCONFIG;
> >   - Detects if BIOS enabled TME and MKTME;
> >   - Enumerates what PCONFIG targets are supported;
> >   - Provides helper to program encryption keys into CPU;
> > 
> > As part of TME enumeration we check out how many bits from physical address
> > are claimed for encryption key ID. This may be critical as we or guest VM
> > must not use these bits for physical address.
> 
> So how will the 'full' patchset look like, roughly - is there a tree or diffstat 
> we could take a look at perhaps?

I don't have anything to show beyond this yet. I'll post as soon I have it
ready.

This patchset includes only things that are close to hardware and unlikely
to change substantially by the next steps.

> I'm also wondering how 'TME' compares to AMD's SME (Secure Memory Encryption) and 
> SEV features. SME required a number of low level boot code changes - I'm wondering 
> how much commonality there can be achieved with Intel's TME so that we don't end 
> up with two sets of interfaces.

Unlike AMD SME, Intel TME doesn't really requires enabling on kernel side.

It's job of BIOS to get it enabled and by time kernel has control all
memory it has access too is encrypted with the single TME key. BIOS
exclude some of its memory for encryption to work properly.

What requires enabling is MKTME. As with TME, it gets enabled by BIOS: it
reserves a number of upper bits from physical address to indicate KeyID.

This means we don't need to change anything during early boot. MKTME is
targeted to userspace memory: typically to protect one VM from another.

Of course we can choose to use MKTME for kernel hardening and it may
require changes during early boot, that's not part of my initial enabling
plan.

Key design points of Intel MKTME:

 - Initial HW implementation would support upto 63 keys (plus one default
   TME key). But the number of keys may be as low as 3, depending to SKU
   and BIOS settings

 - To access encrypted memory you need to use mapping with proper KeyID
   int the page table entry. KeyID is encoded in upper bits of PFN in page
   table entry.

   This means we cannot use direct map to access encrypted memory from
   kernel side. My idea is to re-use kmap() interface to get proper
   temporary mapping on kernel side.

 - CPU does not enforce coherency between mappings of the same physical
   page with different KeyIDs or encryption keys. We wound need to take
   care about flushing cache on allocation of encrypted page and on
   returning it back to free pool.

 - For managing keys, there's MKTME_KEY_PROGRAM leaf of the new PCONFIG
   (platform configuration) instruction. It allows load and clear keys
   associated with a KeyID. You can also ask CPU to generate a key for
   you or disable memory encryption when a KeyID is used.

If you have any questions I would be glad to answer.

-- 
 Kirill A. Shutemov
