Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518595774; cv=none;
        d=google.com; s=arc-20160816;
        b=DSxSeFr/K/CQ/M6E7kCEqe4m7GThKuZkBlVJnMsESfWqHD3FfHllzCGpoKRX9B/WMd
         Ik7pLCAswEDcNTuhnwHdwONgGleoomWFNnjK77TI2oZWlgaX6sPkAuvtz9vA58JMEQlt
         LnUpj6kEIBTIYjXHu432m+I9s6qYAf4Z2Fsg5DP3hdo0cQqTDz2Jb6dOPjHk1+WXn99k
         h9A3b3YqmGkR/KVXwikytbMD+7YbWpUF13Cx6eKJlWjLpBDAjHPGkZYK8WjGwLDb8+NZ
         P76OTERNJtO6vZBbmPvNvV5fHDO8Tiucub5dJXrEa5XVZw0poQmLYR5B69zj16ZaqWfE
         LY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=RITreYDzbqAAFUSiMM+3UdDHoM6iH4a+Gd8n0YsrXkc=;
        b=YAE913eWh+hr6lLgZqiwofLL/F9nUz4CVffahKo+3MFjJp6kKb+fKdE01K2ONU6/NN
         LPmZYPiC8MHLEQzRFwNAypTgl63wccVU8AAfR/6sMz7TtDaLnufWaq2aYGnzPnLVqYqe
         jy5xl/HJ2gLg0cZtwWbDsE8t+GgMWd9m5QQGYkHlJDEb64GJUMCi7xv1wDNLLqoMmnWl
         Zx1ZCHUyezUCs79wRnyl2sw5g1SjXg1dCBX2efNGoOQ7B5u5daLunX5M7LAyMpqDhgAb
         yusQkvIiRJbnoIdRT21bX2CRwZWDcy+C0XygGx/egVsKXzj5OrZK3OLOyVMVOO1f+c+G
         nyxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hKoLZSpZ;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hKoLZSpZ;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x227oBl/BeHepUu2sCv8XhZahJ/ejgX1cG6i3GbubwJ8VDQ9UylKGVDdTLs4/8C8/jKwFan/VEQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 14 Feb 2018 09:09:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com,
	daniel.m.jordan@oracle.com, mgorman@techsingularity.net,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v3 0/4] optimize memory hotplug
Message-ID: <20180214080930.n44x3arzqanja5zq@gmail.com>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213135359.705680d373a482b650f38b50@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213135359.705680d373a482b650f38b50@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446760578462?=
X-GMAIL-MSGID: =?utf-8?q?1592363083052223969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 13 Feb 2018 14:31:55 -0500 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> 
> > This patchset:
> > - Improves hotplug performance by eliminating a number of
> > struct page traverses during memory hotplug.
> > 
> > - Fixes some issues with hotplugging, where boundaries
> > were not properly checked. And on x86 block size was not properly aligned
> > with end of memory
> > 
> > - Also, potentially improves boot performance by eliminating condition from
> >   __init_single_page().
> > 
> > - Adds robustness by verifying that that struct pages are correctly
> >   poisoned when flags are accessed.
> 
> I'm now attempting to get a 100% review rate on MM patches, which is
> why I started adding my Reviewed-by: when I do that thing.
> 
> I'm not familiar enough with this code to add my own Reviewed-by:, and
> we'll need to figure out what to do in such cases.  I shall be sending
> out periodic review-status summaries.
> 
> If you're able to identify a suitable reviewer for this work and to
> offer them beer, that would help.  Let's see what happens as the weeks
> unfold.

The largest patch, fix patch #2, looks good to me and fixes a real bug.
Patch #1 and #3 also look good to me (assuming the runtime overhead
added by patch #3 is OK to you):

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

(I suspect patch #1 and patch #2 should also get a Cc: stable.)

Patch #4 is too large to review IMO: it should be split up into as many patches as 
practically possible. That will also help bisectability, should anything break.

Before applying these patches please fix changelog and code comment spelling.

But it's all good stuff AFAICS!

Thanks,

	Ingo
