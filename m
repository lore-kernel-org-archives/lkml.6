Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeEQGNR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:13:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750825AbeEQGNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:13:16 -0400
Date: Thu, 17 May 2018 14:13:11 +0800
From: Baoquan He <bhe@redhat.com>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-ID: <20180517061311.GO24627@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
 <20180517032702.GA6521@localhost.localdomain>
 <20180517040343.GL24627@MiWiFi-R3L-srv>
 <20180517055301.GB6521@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517055301.GB6521@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/18 at 01:53pm, Chao Fan wrote:
> On Thu, May 17, 2018 at 12:03:43PM +0800, Baoquan He wrote:
> >Hi Chao,
> >
> >On 05/17/18 at 11:27am, Chao Fan wrote:
> >> >+/* Store the number of 1GB huge pages which user specified.*/
> >> >+static unsigned long max_gb_huge_pages;
> >> >+
> >> >+static int parse_gb_huge_pages(char *param, char* val)
> >> >+{
> >> >+	char *p;
> >> >+	u64 mem_size;
> >> >+	static bool gbpage_sz = false;
> >> >+
> >> >+	if (!strcmp(param, "hugepagesz")) {
> >> >+		p = val;
> >> >+		mem_size = memparse(p, &p);
> >> >+		if (mem_size == PUD_SIZE) {
> >> >+			if (gbpage_sz)
> >> >+				warn("Repeadly set hugeTLB page size of 1G!\n");
> >> >+			gbpage_sz = true;
> >> >+		} else
> >> >+			gbpage_sz = false;
> >> >+	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
> >> >+		p = val;
> >> >+		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> >> >+		debug_putaddr(max_gb_huge_pages);
> >> >+	}
> >> >+}
> >> >+
> >> >+
> >> > static int handle_mem_memmap(void)
> >> > {
> >> > 	char *args = (char *)get_cmd_line_ptr();
> >> >@@ -466,6 +492,51 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
> >> > 	}
> >> > }
> >> > 
> >> >+/* Skip as many 1GB huge pages as possible in the passed region. */
> >> >+static void process_gb_huge_page(struct mem_vector *region, unsigned long image_size)
> >> >+{
> >> >+	int i = 0;
> >> >+	unsigned long addr, size;
> >> >+	struct mem_vector tmp;
> >> >+
> >> >+	if (!max_gb_huge_pages) {
> >> >+		store_slot_info(region, image_size);
> >> >+		return;
> >> >+	}
> >> >+
> >> >+	addr = ALIGN(region->start, PUD_SIZE);
> >> >+	/* If Did we raise the address above the passed in memory entry? */
> >> >+	if (addr < region->start + region->size)
> >> >+		size = region->size - (addr - region->start);
> >> >+
> >> >+	/* Check how many 1GB huge pages can be filtered out*/
> >> >+	while (size > PUD_SIZE && max_gb_huge_pages) {
> >> >+		size -= PUD_SIZE;
> >> >+		max_gb_huge_pages--;
> >> 
> >> The global variable 'max_gb_huge_pages' means how many huge pages
> >> user specified when you get it from command line.
> >> But here, everytime we find a position which is good for huge page
> >> allocation, the 'max_gdb_huge_page' decreased. So in my understanding,
> >> it is used to store how many huge pages that we still need to search memory
> >> for good slots to filter out, right?
> >> If it's right, maybe the name 'max_gb_huge_pages' is not very suitable.
> >> If my understanding is wrong, please tell me.
> >
> >No, you have understood it very right. I finished the draft patch last
> >week, but changed this variable name and the function names several
> >time, still I feel they are not good. However I can't get a better name.
> >
> >Yes, 'max_gb_huge_pages' stores how many 1GB huge pages are expected
> >from kernel command-line. And in this function it will be decreased. But
> >we can't define another global variable only for decreasing in this
> >place.
> >
> >And you can see that in this patchset I only take cares of 1GB huge
> >pages. While on x86 we have two kinds of huge pages, 2MB and 1GB, why
> >1GB only? Because 2MB is not impacted by KASLR, please check the code in 
> >hugetlb_nrpages_setup() of mm/hugetlb.c . Only 1GB huge pages need be
> >pre-allocated in hugetlb_nrpages_setup(), and if you look into
> >hugetlb_nrpages_setup(), you will find that it will call
> >alloc_bootmem_huge_page() to allocate huge pages one by one, but not at
> >one time. That is why I always add 'gb' in the middle of the global
> >variable and the newly added functions.
> >
> >And it will answer your below questions. When walk over all memory
> >regions, 'max_gb_huge_pages' is still not 0, what should we do? It's
> >normal and done as expected. Here hugetlb only try its best to allocate
> >as many as possible according to 'max_gb_huge_pages'. If can't fully
> >satisfied, it's fine. E.g on bare-metal machine with 16GB RAM, you add
> >below to command-line:
> >
> >default_hugepagesz=1G hugepagesz=1G hugepages=20
> >
> >Then it will get 14 good 1GB huge pages with kaslr disabled since [0,1G)
> >and [3G,4G) are touched by bios reservation and pci/firmware reservation.
> >Then this 14 huge pages are maximal value which is expected. It's not a
> >bug in huge page. But with kaslr enabled, it sometime only get 13 1GB
> >huge pages because KASLR put kernel into one of those good 1GB huge
> >pages. This is a bug.
> 
> Thanks for your explaination, I got it.
> 
> >
> >I am not very familiar with huge page handling, just read code recently
> >because of this kaslr bug. Hope Luiz and people from his team can help
> >correct and clarify if anything is not right. Especially the function
> >names, I feel it's not good, if anyone have a better idea, I will really
> >appreciate that.
> >> 
> >> >+		i++;
> >> >+	}
> >> >+
> >> >+	if (!i) {
> >> >+		store_slot_info(region, image_size);
> >> >+		return;
> >> >+	}
> >> >+
> >> >+	/* Process the remaining regions after filtering out. */
> >> >+
> >> This line may be unusable.
> >
> >Hmm, I made it on purpose. Because 1GB huge pages may be digged out from
> >the middle, then the remaing head and tail regions still need be
> >handled. I put it here to mean that it covers below two code blocks. 
> >
> 
> Yes, the two parts below are all in the condition when if(!i) is false.
> The first part is the memory before good slots for huge pages,
> the second part is after.
> 
> >I can remove it if people think it's not appropriate.
> >
> >> >+	if (addr >= region->start + image_size) {
> >> >+		tmp.start = region->start;
> >> >+		tmp.size = addr - region->start;
> >> >+		store_slot_info(&tmp, image_size);
> >> >+	}
> >> >+
> >> >+	size  = region->size - (addr - region->start) - i * PUD_SIZE;
> >> >+        if (size >= image_size) {
> >> >+		tmp.start = addr + i*PUD_SIZE;
> >> >+		tmp.size = size;
> >> >+		store_slot_info(&tmp, image_size);
> >> >+        }
> These 5 lines may have a wrong space, you can check it.

Yes, will replace it with tab. Thanks.

> 
> >> 
> >> I have another question not related to kaslr.
> >> Here you try to avoid the memory from addr to (addr + i * PUD_SIZE),
> >> but I wonder if after walking all memory regions, 'max_gb_huge_pages'
> >> is still more than 0, which means there isn't enough memory slots for
> >> huge page, what will happen?
> >
> >Please check the response at the beginning of response.
> >
> >Thanks
> >Baoquan
> >
> >> 
> >> 
> >> >+}
> >> >+
> >> > static unsigned long slots_fetch_random(void)
> >> > {
> >> > 	unsigned long slot;
> >> >-- 
> >> >2.13.6
> >> >
> >> >
> >> >
> >> 
> >> 
> >
> >
> 
> 
