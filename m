Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbeAaNTo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:19:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:52150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeAaNTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:19:42 -0500
Date: Wed, 31 Jan 2018 14:19:37 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, broonie@kernel.org
Subject: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE
Message-ID: <20180131131937.GA6740@dhcp22.suse.cz>
References: <2a05eaf2-20fd-57a8-d4bd-5a1fbf57686c@linux.vnet.ibm.com>
 <20180124090539.GH1526@dhcp22.suse.cz>
 <5acba3c2-754d-e449-24ff-a72a0ad0d895@linux.vnet.ibm.com>
 <20180126140415.GD5027@dhcp22.suse.cz>
 <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
 <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au>
 <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-01-18 10:35:38, Anshuman Khandual wrote:
> On 01/30/2018 03:12 PM, Michal Hocko wrote:
[...]
> > Anshuman, could you try to run
> > sed 's@^@@' /proc/self/smaps
> > on a system with MAP_FIXED_NOREPLACE reverted?
> > 
> 
> After reverting the following commits from mmotm-2018-01-25-16-20 tag.
> 
> 67caea694ba5965a52a61fdad495d847f03c4025 ("mm-introduce-map_fixed_safe-fix")
> 64da2e0c134ecf3936a4c36b949bcf2cdc98977e ("fs-elf-drop-map_fixed-usage-from-elf_map-fix-fix")
> 645983ab6ca7fd644f52b4c55462b91940012595 ("mm: don't use the same value for MAP_FIXED_NOREPLACE and MAP_SYNC")
> d77bab291ac435aab91fa214b85efa74a26c9c22 ("fs-elf-drop-map_fixed-usage-from-elf_map-checkpatch-fixes")
> a75c5f92d9ecb21d3299cc7db48e401cbf335c34 ("fs, elf: drop MAP_FIXED usage from elf_map")
> 00906d029ffe515221e3939b222c237026af2903 ("mm: introduce MAP_FIXED_NOREPLACE")
> 
> $sed 's@^@@' /proc/self/smaps

Interesting

> -------------------------------------------
> 10000000-10020000 r-xp 00000000 fd:00 10558                              /usr/bin/sed
> 10020000-10030000 r--p 00010000 fd:00 10558                              /usr/bin/sed
> 10030000-10040000 rw-p 00020000 fd:00 10558                              /usr/bin/sed
> 2cbb0000-2cbe0000 rw-p 00000000 00:00 0                                  [heap]

We still have a brk and at a different offset. Could you confirm that we
still try to map previous brk at the clashing address 0x10030000?

> 7fff7f9c0000-7fff7f9e0000 rw-p 00000000 00:00 0 
> 7fff7f9e0000-7fff86280000 r--p 00000000 fd:00 33660156                   /usr/lib/locale/locale-archive
> 7fff86280000-7fff86290000 r-xp 00000000 fd:00 33660115                   /usr/lib64/libdl-2.17.so
> 7fff86290000-7fff862a0000 r--p 00000000 fd:00 33660115                   /usr/lib64/libdl-2.17.so
> 7fff862a0000-7fff862b0000 rw-p 00010000 fd:00 33660115                   /usr/lib64/libdl-2.17.so
> 7fff862b0000-7fff86300000 r-xp 00000000 fd:00 33594504                   /usr/lib64/libpcre.so.1.2.0
> 7fff86300000-7fff86310000 r--p 00040000 fd:00 33594504                   /usr/lib64/libpcre.so.1.2.0
> 7fff86310000-7fff86320000 rw-p 00050000 fd:00 33594504                   /usr/lib64/libpcre.so.1.2.0
> 7fff86320000-7fff864f0000 r-xp 00000000 fd:00 33660109                   /usr/lib64/libc-2.17.so
> 7fff864f0000-7fff86500000 r--p 001c0000 fd:00 33660109                   /usr/lib64/libc-2.17.so
> 7fff86500000-7fff86510000 rw-p 001d0000 fd:00 33660109                   /usr/lib64/libc-2.17.so
> 7fff86510000-7fff86540000 r-xp 00000000 fd:00 33594516                   /usr/lib64/libselinux.so.1
> 7fff86540000-7fff86550000 r--p 00020000 fd:00 33594516                   /usr/lib64/libselinux.so.1
> 7fff86550000-7fff86560000 rw-p 00030000 fd:00 33594516                   /usr/lib64/libselinux.so.1
> 7fff86560000-7fff86570000 r--s 00000000 fd:00 67194934                   /usr/lib64/gconv/gconv-modules.cache
> 7fff86570000-7fff86590000 r-xp 00000000 00:00 0                          [vdso]
> 7fff86590000-7fff865c0000 r-xp 00000000 fd:00 33660102                   /usr/lib64/ld-2.17.so
> 7fff865c0000-7fff865d0000 r--p 00020000 fd:00 33660102                   /usr/lib64/ld-2.17.so
> 7fff865d0000-7fff865e0000 rw-p 00030000 fd:00 33660102                   /usr/lib64/ld-2.17.so
> 7fffd27a0000-7fffd27d0000 rw-p 00000000 00:00 0                          [stack]

-- 
Michal Hocko
SUSE Labs
