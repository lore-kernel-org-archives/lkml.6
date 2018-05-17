Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeEQFjC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:39:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750727AbeEQFjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:39:01 -0400
Date: Thu, 17 May 2018 13:38:55 +0800
From: Baoquan He <bhe@redhat.com>
To: linux_dti@icloud.com
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-ID: <20180517053228.GM24627@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
 <20180517051225.GA2361@zrhn9910b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517051225.GA2361@zrhn9910b>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/18 at 07:12am, damian wrote:
> On Wed, 16. May 18:05, Baoquan He wrote:
> > Functions parse_gb_huge_pages() and process_gb_huge_page() are introduced to
> > handle conflict between KASLR and huge pages, will be used in the next patch.
> > 
> > Function parse_gb_huge_pages() is used to parse kernel command-line to get
> > how many 1GB huge pages have been specified. A static global variable
> > 'max_gb_huge_pages' is added to store the number.
> > 
> > And process_gb_huge_page() is used to skip as many 1GB huge pages as possible
> > from the passed in memory region according to the specified number.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 71 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index a0a50b91ecef..13bd879cdc5d 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -215,6 +215,32 @@ static void mem_avoid_memmap(char *str)
> >  		memmap_too_large = true;
> >  }
> >  
> > +/* Store the number of 1GB huge pages which user specified.*/
> > +static unsigned long max_gb_huge_pages;
> > +
> > +static int parse_gb_huge_pages(char *param, char* val)
> > +{
> > +	char *p;
> > +	u64 mem_size;
> > +	static bool gbpage_sz = false;
> > +
> > +	if (!strcmp(param, "hugepagesz")) {
> > +		p = val;
> > +		mem_size = memparse(p, &p);
> > +		if (mem_size == PUD_SIZE) {
> > +			if (gbpage_sz)
> > +				warn("Repeadly set hugeTLB page size of 1G!\n");
> > +			gbpage_sz = true;
> > +		} else
> > +			gbpage_sz = false;
> > +	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
> > +		p = val;
> > +		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> > +		debug_putaddr(max_gb_huge_pages);
> > +	}
> > +}
> Hello,
> 
> the return value is missing for the function or not ?

Thanks, very good catch. It should be 'static void ', no return value
since we didn't check it. Will update when repost.

> 
> > +
> > +
> >  static int handle_mem_memmap(void)
> >  {
> >  	char *args = (char *)get_cmd_line_ptr();
> > @@ -466,6 +492,51 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
> >  	}
> >  }
> >  
> > +/* Skip as many 1GB huge pages as possible in the passed region. */
> > +static void process_gb_huge_page(struct mem_vector *region, unsigned long image_size)
> > +{
> > +	int i = 0;
> > +	unsigned long addr, size;
> > +	struct mem_vector tmp;
> > +
> > +	if (!max_gb_huge_pages) {
> > +		store_slot_info(region, image_size);
> > +		return;
> > +	}
> > +
> > +	addr = ALIGN(region->start, PUD_SIZE);
> > +	/* If Did we raise the address above the passed in memory entry? */
> > +	if (addr < region->start + region->size)
> > +		size = region->size - (addr - region->start);
> > +
> > +	/* Check how many 1GB huge pages can be filtered out*/
> > +	while (size > PUD_SIZE && max_gb_huge_pages) {
> > +		size -= PUD_SIZE;
> > +		max_gb_huge_pages--;
> > +		i++;
> > +	}
> > +
> > +	if (!i) {
> > +		store_slot_info(region, image_size);
> > +		return;
> > +	}
> > +
> > +	/* Process the remaining regions after filtering out. */
> > +
> > +	if (addr >= region->start + image_size) {
> > +		tmp.start = region->start;
> > +		tmp.size = addr - region->start;
> > +		store_slot_info(&tmp, image_size);
> > +	}
> > +
> > +	size  = region->size - (addr - region->start) - i * PUD_SIZE;
> > +        if (size >= image_size) {
> > +		tmp.start = addr + i*PUD_SIZE;
> > +		tmp.size = size;
> > +		store_slot_info(&tmp, image_size);
> > +        }
> > +}
> > +
> >  static unsigned long slots_fetch_random(void)
> >  {
> >  	unsigned long slot;
> > -- 
> > 2.13.6
> > 
