Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEQD1N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 23:27:13 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40684 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751457AbeEQD1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 23:27:12 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40023199"
Date: Thu, 17 May 2018 11:27:02 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
        <lcapitulino@redhat.com>, <keescook@chromium.org>,
        <tglx@linutronix.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-ID: <20180517032702.GA6521@localhost.localdomain>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180516100532.14083-2-bhe@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 611814B3EF17.A954E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

I have reviewed the patch, I think the caculation of address has no
problem. But maybe I miss something, so I have several questions.

On Wed, May 16, 2018 at 06:05:31PM +0800, Baoquan He wrote:
>Functions parse_gb_huge_pages() and process_gb_huge_page() are introduced to
>handle conflict between KASLR and huge pages, will be used in the next patch.
>
>Function parse_gb_huge_pages() is used to parse kernel command-line to get
>how many 1GB huge pages have been specified. A static global variable
>'max_gb_huge_pages' is added to store the number.
>
>And process_gb_huge_page() is used to skip as many 1GB huge pages as possible
>from the passed in memory region according to the specified number.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
> arch/x86/boot/compressed/kaslr.c | 71 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 71 insertions(+)
>
>diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>index a0a50b91ecef..13bd879cdc5d 100644
>--- a/arch/x86/boot/compressed/kaslr.c
>+++ b/arch/x86/boot/compressed/kaslr.c
>@@ -215,6 +215,32 @@ static void mem_avoid_memmap(char *str)
> 		memmap_too_large = true;
> }
> 
>+/* Store the number of 1GB huge pages which user specified.*/
>+static unsigned long max_gb_huge_pages;
>+
>+static int parse_gb_huge_pages(char *param, char* val)
>+{
>+	char *p;
>+	u64 mem_size;
>+	static bool gbpage_sz = false;
>+
>+	if (!strcmp(param, "hugepagesz")) {
>+		p = val;
>+		mem_size = memparse(p, &p);
>+		if (mem_size == PUD_SIZE) {
>+			if (gbpage_sz)
>+				warn("Repeadly set hugeTLB page size of 1G!\n");
>+			gbpage_sz = true;
>+		} else
>+			gbpage_sz = false;
>+	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
>+		p = val;
>+		max_gb_huge_pages = simple_strtoull(p, &p, 0);
>+		debug_putaddr(max_gb_huge_pages);
>+	}
>+}
>+
>+
> static int handle_mem_memmap(void)
> {
> 	char *args = (char *)get_cmd_line_ptr();
>@@ -466,6 +492,51 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
> 	}
> }
> 
>+/* Skip as many 1GB huge pages as possible in the passed region. */
>+static void process_gb_huge_page(struct mem_vector *region, unsigned long image_size)
>+{
>+	int i = 0;
>+	unsigned long addr, size;
>+	struct mem_vector tmp;
>+
>+	if (!max_gb_huge_pages) {
>+		store_slot_info(region, image_size);
>+		return;
>+	}
>+
>+	addr = ALIGN(region->start, PUD_SIZE);
>+	/* If Did we raise the address above the passed in memory entry? */
>+	if (addr < region->start + region->size)
>+		size = region->size - (addr - region->start);
>+
>+	/* Check how many 1GB huge pages can be filtered out*/
>+	while (size > PUD_SIZE && max_gb_huge_pages) {
>+		size -= PUD_SIZE;
>+		max_gb_huge_pages--;

The global variable 'max_gb_huge_pages' means how many huge pages
user specified when you get it from command line.
But here, everytime we find a position which is good for huge page
allocation, the 'max_gdb_huge_page' decreased. So in my understanding,
it is used to store how many huge pages that we still need to search memory
for good slots to filter out, right?
If it's right, maybe the name 'max_gb_huge_pages' is not very suitable.
If my understanding is wrong, please tell me.

>+		i++;
>+	}
>+
>+	if (!i) {
>+		store_slot_info(region, image_size);
>+		return;
>+	}
>+
>+	/* Process the remaining regions after filtering out. */
>+
This line may be unusable.
>+	if (addr >= region->start + image_size) {
>+		tmp.start = region->start;
>+		tmp.size = addr - region->start;
>+		store_slot_info(&tmp, image_size);
>+	}
>+
>+	size  = region->size - (addr - region->start) - i * PUD_SIZE;
>+        if (size >= image_size) {
>+		tmp.start = addr + i*PUD_SIZE;
>+		tmp.size = size;
>+		store_slot_info(&tmp, image_size);
>+        }

I have another question not related to kaslr.
Here you try to avoid the memory from addr to (addr + i * PUD_SIZE),
but I wonder if after walking all memory regions, 'max_gb_huge_pages'
is still more than 0, which means there isn't enough memory slots for
huge page, what will happen?

Thanks,
Chao Fan

>+}
>+
> static unsigned long slots_fetch_random(void)
> {
> 	unsigned long slot;
>-- 
>2.13.6
>
>
>
