Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEQFMh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:12:37 -0400
Received: from ms11p00im-qufv17100601.me.com ([17.58.37.33]:34786 "EHLO
        ms11p00im-qufv17100601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750727AbeEQFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:12:36 -0400
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-17_02:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805170049
Date: Thu, 17 May 2018 07:12:26 +0200
From: damian <linux_dti@icloud.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-id: <20180517051225.GA2361@zrhn9910b>
Mail-followup-to: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 mingo@kernel.org, lcapitulino@redhat.com, keescook@chromium.org,
 tglx@linutronix.de, x86@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
 yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20180516100532.14083-2-bhe@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16. May 18:05, Baoquan He wrote:
> Functions parse_gb_huge_pages() and process_gb_huge_page() are introduced to
> handle conflict between KASLR and huge pages, will be used in the next patch.
> 
> Function parse_gb_huge_pages() is used to parse kernel command-line to get
> how many 1GB huge pages have been specified. A static global variable
> 'max_gb_huge_pages' is added to store the number.
> 
> And process_gb_huge_page() is used to skip as many 1GB huge pages as possible
> from the passed in memory region according to the specified number.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index a0a50b91ecef..13bd879cdc5d 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -215,6 +215,32 @@ static void mem_avoid_memmap(char *str)
>  		memmap_too_large = true;
>  }
>  
> +/* Store the number of 1GB huge pages which user specified.*/
> +static unsigned long max_gb_huge_pages;
> +
> +static int parse_gb_huge_pages(char *param, char* val)
> +{
> +	char *p;
> +	u64 mem_size;
> +	static bool gbpage_sz = false;
> +
> +	if (!strcmp(param, "hugepagesz")) {
> +		p = val;
> +		mem_size = memparse(p, &p);
> +		if (mem_size == PUD_SIZE) {
> +			if (gbpage_sz)
> +				warn("Repeadly set hugeTLB page size of 1G!\n");
> +			gbpage_sz = true;
> +		} else
> +			gbpage_sz = false;
> +	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
> +		p = val;
> +		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> +		debug_putaddr(max_gb_huge_pages);
> +	}
> +}
Hello,

the return value is missing for the function or not ?

regards
Damian

> +
> +
>  static int handle_mem_memmap(void)
>  {
>  	char *args = (char *)get_cmd_line_ptr();
> @@ -466,6 +492,51 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
>  	}
>  }
>  
> +/* Skip as many 1GB huge pages as possible in the passed region. */
> +static void process_gb_huge_page(struct mem_vector *region, unsigned long image_size)
> +{
> +	int i = 0;
> +	unsigned long addr, size;
> +	struct mem_vector tmp;
> +
> +	if (!max_gb_huge_pages) {
> +		store_slot_info(region, image_size);
> +		return;
> +	}
> +
> +	addr = ALIGN(region->start, PUD_SIZE);
> +	/* If Did we raise the address above the passed in memory entry? */
> +	if (addr < region->start + region->size)
> +		size = region->size - (addr - region->start);
> +
> +	/* Check how many 1GB huge pages can be filtered out*/
> +	while (size > PUD_SIZE && max_gb_huge_pages) {
> +		size -= PUD_SIZE;
> +		max_gb_huge_pages--;
> +		i++;
> +	}
> +
> +	if (!i) {
> +		store_slot_info(region, image_size);
> +		return;
> +	}
> +
> +	/* Process the remaining regions after filtering out. */
> +
> +	if (addr >= region->start + image_size) {
> +		tmp.start = region->start;
> +		tmp.size = addr - region->start;
> +		store_slot_info(&tmp, image_size);
> +	}
> +
> +	size  = region->size - (addr - region->start) - i * PUD_SIZE;
> +        if (size >= image_size) {
> +		tmp.start = addr + i*PUD_SIZE;
> +		tmp.size = size;
> +		store_slot_info(&tmp, image_size);
> +        }
> +}
> +
>  static unsigned long slots_fetch_random(void)
>  {
>  	unsigned long slot;
> -- 
> 2.13.6
> 
