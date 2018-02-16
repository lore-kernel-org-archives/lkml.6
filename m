Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518772762; cv=none;
        d=google.com; s=arc-20160816;
        b=XvvaenoRK9tgQHQQ7JDeHxXgoVi7RidntloYYplkxAw90DBySpL7oGcUfnbz82gbU1
         uI8pzZmOqRwNlJng3448zXFaC6DSSMWvOdfD1cEW5w+hOOj2veAEYILuD/dcQH9eyEgy
         Wg8kpcf6ykLE6falJW0JD1jzYHbgudDdQ3HvOgW7MkxFul8LX2GBnTepNNseMMI8D9LC
         4jOzZObmuSnnaIexTrTSGe3qPurqgACP3gFrIR9CU48jRFU6gP590k2ELlD3TD0Q8+FG
         nrxdHEv/JKLBKKWEmBumiYcaItzJG+EXJl/ag90kC1XmzOC2Um27bgDWHtDpT6c6QV4F
         ZZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=fyZi/Le+65izgN68fNC98H/yWECnzzgwfJDYAddcA8Y=;
        b=QB0kthgr7kFwtV8YS7IVxURnVl2DVlQTb9iTVzZ7mn1mdhyr0iL88ZnaP5OGMDNUBx
         ePB2hvht/35iEG8hXKVJ9F/EEuy4+H3MlQ3xuDoRYfqr+vKe4f8SGUfCYUi+AXOm5Rwb
         mkCaDFzmPgcaYwu2GEQgJuYbzBG3F8hHd2z5cJw8LTJPu9RH/X1UYeFvxutX2FPlV3XA
         l7utAtVwh615GJhMns41ieri15DeewLbdoWKCdU3mrVDfPCKGfqU2AIylh7ri/pTbwat
         Zw1AC8GN4NRZfZ+1PkIu58sUrvm2QCZgj4+Ii4Xl1AN7KosWLHDLSw446TTBM6TBSrge
         FA2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UjwZIdFn;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UjwZIdFn;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x225UAJvaDyclBC0dgdHF8r+LKBgD2hQ0+2hApfBRacEXrzQ61j0QVH4u1rf9HvzwU7vZjuq59A==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 16 Feb 2018 10:19:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [v4 5/6] mm/memory_hotplug: don't read nid from struct page
 during hotplug
Message-ID: <20180216091918.axu57tfsezzybeoa@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-6-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165920.8570-6-pasha.tatashin@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487103505854531?=
X-GMAIL-MSGID: =?utf-8?q?1592548668765565864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> During memory hotplugging the probe routine will leave struct pages
> uninitialized, the same as it is currently done during boot. Therefore, we
> do not want to access the inside of struct pages before
> __init_single_page() is called during onlining.
> 
> Because during hotplug we know that pages in one memory block belong to
> the same numa node, we can skip the checking. We should keep checking for
> the boot case.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/base/memory.c |  2 +-
>  drivers/base/node.c   | 22 +++++++++++++++-------
>  include/linux/node.h  |  4 ++--
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index deb3f029b451..a14fb0cd424a 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -731,7 +731,7 @@ int register_new_memory(int nid, struct mem_section *section)
>  	}
>  
>  	if (mem->section_count == sections_per_block)
> -		ret = register_mem_sect_under_node(mem, nid);
> +		ret = register_mem_sect_under_node(mem, nid, false);
>  out:

The namespace of all these memory range handling functions is horribly random,
and I think now it got worse: we add an assumption that register_new_memory() is 
implicitly called as part of hotplugged memory (where things are pre-cleared) - 
but nothing in its naming suggests so.

How about renaming it to hotplug_memory_register() or so?

With that change you can add:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
