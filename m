Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755566AbeDFOuX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:50:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:65189 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeDFOuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:50:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="44012063"
Subject: Re: [PATCH v3 4/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, pagupta@redhat.com
References: <20180228032657.32385-1-bhe@redhat.com>
 <20180228032657.32385-5-bhe@redhat.com>
Cc: linux-mm@kvack.org, kirill.shutemov@linux.intel.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5dd3942a-cf66-f749-b1c6-217b0c3c94dc@intel.com>
Date: Fri, 6 Apr 2018 07:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180228032657.32385-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a really hard time tying all the pieces back together.  Let
me give it a shot and you can tell me where I go wrong.

On 02/27/2018 07:26 PM, Baoquan He wrote:
> In sparse_init(), two temporary pointer arrays, usemap_map and map_map
> are allocated with the size of NR_MEM_SECTIONS.

In sparse_init(), two temporary pointer arrays, usemap_map and map_map
are allocated to hold the maps for every possible memory section
(NR_MEM_SECTIONS).  However, we obviously only need the array sized for
nr_present_sections (introduced in patch 1).

The reason this is a problem is that, with 5-level paging,
NR_MEM_SECTIONS (8M->512M) went up dramatically and these temporary
arrays can eat all of memory, like on kdump kernels.

This patch does two things: it makes sure to give usemap_map/mem_map a
less gluttonous size on small systems, and it changes the map allocation
and handling to handle the now more compact, less sparse arrays.

---

The code looks fine to me.  It's a bit of a shame that there's no
verification to ensure that idx_present never goes beyond the shiny new
nr_present_sections.


> @@ -583,6 +592,7 @@ void __init sparse_init(void)
>  	unsigned long *usemap;
>  	unsigned long **usemap_map;
>  	int size;
> +	int idx_present = 0;

I wonder whether idx_present is a good name.  Isn't it the number of
consumed mem_map[]s or usemaps?

> 
>  		if (!map) {
>  			ms->section_mem_map = 0;
> +			idx_present++;
>  			continue;
>  		}
>  


This hunk seems logically odd to me.  I would expect a non-used section
to *not* consume an entry from the temporary array.  Why does it?  The
error and success paths seem to do the same thing.
