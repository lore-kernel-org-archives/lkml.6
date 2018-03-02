Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AG47ELut3GQHD7jyyt8KZLMZ8G+3PAUrJPUV6RaABX0Y3Z2Pmsa/XMn94tScTBbSuAivDvy4iTxt
ARC-Seal: i=1; a=rsa-sha256; t=1519995943; cv=none;
        d=google.com; s=arc-20160816;
        b=ATdr2ZnXacS1aBX2UsGwStZgEGpFWxJ5u0eV6tpevMvkBbea1RLXAXO+XNq5LJd93P
         av85CcnYriZ4a2qn06aeJ0QqeLzjmIuKWcZlSbq2D7XgaWn9w/3vkQu5edxE+ZnxKcVd
         6KPR8LDavPUJA3aKfSGupFRYj/CTra1YvNGpTn95z3nXfh3dBbmzHtuY2M8yllBxpEFp
         c+jxQsCG3WMp2TnbwtIERr71FEgdmKb0fLubKwpER2+73Cp1HmIwLcfn62f2/xVeTLJV
         1PAmPLeCHRHgTirPbeUabFY8qhhF8/M2N4KjMZJm5NEleqAXezzCUI76HenRTJx894JV
         /1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+5Vr4hu7ZFdPjN0NVCuqmn0hWKwysqCC1uyB35i6ajc=;
        b=W/w5bOTXMHwvxBzbT4EapvyiM/3QlwuNTc7WZDKFje7FXtXnreRpaTDv0BbDXoakvI
         nXE5Qavh4Qu3xJiwyQPwy4UJzXfpJ3H1qw8GNsVIMd9CftcXCV07eFRhdvYHQmUBfAlm
         TK3+ONA7xQgIrLoaubhIEDpuAxFYkRfGpxwGgMqKgZGCYpvOdSAUVMbUPI6pLeRVRZFm
         R4Y4zDXgLSQoTpNuaSpEHGu0HRjGVlgyfNbm2lvFeteKsD2dig19zzRA+XKL8dy1oph+
         XYnDXWdSA4/vYEYsdm/rMAchEEHRkeMojnOosR0Lng1O2/SQLFGekfLHWb6OgLF+GAgB
         ecWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Fri, 2 Mar 2018 14:05:41 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v5 0/6] optimize memory hotplug
Message-ID: <20180302130541.GO15057@dhcp22.suse.cz>
References: <20180228030308.1116-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228030308.1116-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612185598129869?=
X-GMAIL-MSGID: =?utf-8?q?1593831266822395440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
I will not get to review this version before Mar 12 because I am moving
and will be without access to my email and I am pretty sure the time
will not work well for me either.

Sorry about that.

On Tue 27-02-18 22:03:02, Pavel Tatashin wrote:
> Changelog:
> 	v5 - v4
> 	- Addressed more comments from Ingo Molnar and Michal Hocko.
> 	- In the patch "optimize memory hotplug" we are now using
> 	  struct memory_block to hold node id as suggested by Michal.
> 	- In the patch "don't read nid from struct page during hotplug"
> 	  renamed register_new_memory() to hotplug_memory_register() as
> 	  suggested by Ingo. Also, in this patch replaced the
> 	  description with the one provided by Michal.
> 	- Fixed other spelling issues found by Ingo.
> 
> 	v3 - v4
> 	Addressed comments from Ingo Molnar and from Michal Hocko
> 	Split 4th patch into three patches
> 	Instead of using section table to save node ids, saving node id in
> 	the first page of every section.
> 
> 	v2 - v3
> 	Fixed two issues found during testing
> 	Addressed Kbuild warning reports
> 
> 	v1 - v2
> 	Added struct page poisoning checking in order to verify that
> 	struct pages are never accessed until initialized during memory
> 	hotplug
> 
> This patchset:
> - Improves hotplug performance by eliminating a number of
> struct page traverses during memory hotplug.
> 
> - Fixes some issues with hotplugging, where boundaries
> were not properly checked. And on x86 block size was not properly aligned
> with end of memory
> 
> - Also, potentially improves boot performance by eliminating condition from
>   __init_single_page().
> 
> - Adds robustness by verifying that that struct pages are correctly
>   poisoned when flags are accessed.
> 
> The following experiments were performed on Xeon(R)
> CPU E7-8895 v3 @ 2.60GHz with 1T RAM:
> 
> booting in qemu with 960G of memory, time to initialize struct pages:
> 
> no-kvm:
> 	TRY1		TRY2
> BEFORE:	39.433668	39.39705
> AFTER:	36.903781	36.989329
> 
> with-kvm:
> BEFORE:	10.977447	11.103164
> AFTER:	10.929072	10.751885
> 
> Hotplug 896G memory:
> no-kvm:
> 	TRY1		TRY2
> BEFORE: 848.740000	846.910000
> AFTER:  783.070000	786.560000
> 
> with-kvm:
> 	TRY1		TRY2
> BEFORE: 34.410000	33.57
> AFTER:	29.810000	29.580000
> 
> Pavel Tatashin (6):
>   mm/memory_hotplug: enforce block size aligned range check
>   x86/mm/memory_hotplug: determine block size based on the end of boot
>     memory
>   mm: add uninitialized struct page poisoning sanity checking
>   mm/memory_hotplug: optimize probe routine
>   mm/memory_hotplug: don't read nid from struct page during hotplug
>   mm/memory_hotplug: optimize memory hotplug
> 
>  arch/x86/mm/init_64.c      | 33 +++++++++++++++++++++++++++++----
>  drivers/base/memory.c      | 40 ++++++++++++++++++++++------------------
>  drivers/base/node.c        | 24 +++++++++++++++++-------
>  include/linux/memory.h     |  3 ++-
>  include/linux/mm.h         |  4 +++-
>  include/linux/node.h       |  4 ++--
>  include/linux/page-flags.h | 22 +++++++++++++++++-----
>  mm/memblock.c              |  2 +-
>  mm/memory_hotplug.c        | 44 +++++++++++++++++---------------------------
>  mm/page_alloc.c            | 28 ++++++++++------------------
>  mm/sparse.c                |  8 +++++++-
>  11 files changed, 127 insertions(+), 85 deletions(-)
> 
> -- 
> 2.16.2
> 

-- 
Michal Hocko
SUSE Labs
