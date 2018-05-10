Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeEJUrG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeEJUrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:47:04 -0400
Date: Thu, 10 May 2018 17:47:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for x86_64
 KPTI entry trampolines
Message-ID: <20180510204700.GF4311@kernel.org>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
 <20180509170717.GI13491@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C13DE9E@IRSMSX106.ger.corp.intel.com>
 <20180510201542.GD4311@kernel.org>
 <20180510201922.GE4311@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510201922.GE4311@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 10, 2018 at 05:19:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 10, 2018 at 05:15:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 10, 2018 at 07:08:37PM +0000, Hunter, Adrian escreveu:
> > > Let me know if you want me to post the workaround patches separately,
> > > otherwise I will wait a bit before sending the patches again.

> > I'll see if I went thru all of the patches already...
 
> So I looked at the patches posted and one comment is about the terse
> commit logs for some of the kcore_copy patches, for instance:
 
> --------------------
>  In preparation to add more program headers, get rid of kernel_map and
> modules_map.
> --------------------
 
> Can't this be made a bit more verbose? Lemme re-read the patch...

So you had just one pointers to the kernel map and a module_maps, and
then this is replaced by kcore_copy__map() that instead of populating
those fields that are being removed:

-       struct phdr_data kernel_map;
-       struct phdr_data modules_map;

Will allocate and add "struct phdr_data" instances to the
kcore_copy_info->phdrs list, so I propose, to follow convention used
elsewhere in tools/perf/ that you rename kcore_copy__map() to

  kcore_copy_info__addnew(kci, fields)

I would do it as:

struct phdr_data *phdr_data__new(fields)
{
	return  zalloc() + init fields;
}

struct phdr_data *kcore_copy_info__addnew(kci, fields)
{
	struct phdr_data *pd = phdr_data__new(fields);

	if (pd)
		list_add(&pd->list, &kci->phdrs)
}

Also please rename pd->list to pd->node, to clarify that it is a node in
some list, not a list.

The commit log list then could reflect that somehow, with something
around:

----------------------

Move ->kernel_map and ->modules_map to newly allocated entries in the
->phdrs list.

----------------------

wdyt?

- Arnaldo
