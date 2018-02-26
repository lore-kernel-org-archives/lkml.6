Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242xGNsncXWQAMyxtqmobMSpCcjXeFj1aAGg83lQ2P0/TN7p/2A+38xfeDCOcFsvyG8gBLI
ARC-Seal: i=1; a=rsa-sha256; t=1519676175; cv=none;
        d=google.com; s=arc-20160816;
        b=A2g/+Y0ollkCKrVoM3lmDF8y1Y+5JMT2ykQuy1pntT0/oPpm6WaZACwwfZlMVtkJS4
         rhdTTM+2BBqH8HIHi8C1Qor3M9k8gYcpdUQVpSBKo0L1twR/h2BMzu1DCCbquyL9iz+S
         jy/9u1tEZ9w7xTab9zQTNnzZ07KKm8EsKbAqOkjTmv93VhlJhQxs4r/Iv88reLZ5ds0R
         VbMPlAt/gvjaBVtoVsZ2vwXrlIkE5w0wxQ8EodTsYihNAlFx9QvQ7N4aSUM4L4MWmZdd
         QO6MoPuao4tImIs2LQsy+f1C7GQqVILAg7nLU8CkPYrIg3IyTEAFv9p3DTFRz7A3x3wB
         yqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HdccgPruOTz22p5FU+KhF7rhJGRvchwMmq+A8s/pa7A=;
        b=qE5mK0wSjI8Q/MJxosMFO1+TZnTgY8Z7YGBYRn0xmrOpm/xKjreEzyp9G2vd2N/yPX
         IOWBQqEFIoKeaJj1JnrqqzKPe/hkye1SMmDA52tDgaSpbmOqXtYJbFmZ5cb0kXiwM0U9
         Q3bRziHg9yjRPbvDidJSTJGFEp79Im5I6lezK7oGb31Zo2Zq0z8ZNXF2JlxYRjEyVBbn
         TLUPgdGRx5rZ5z0MjDX648/Z/IeBQklbIrS94ktar9kstsfATso00SwpBsxa3Drsnvwk
         8yQT59ROM3eRc3SheAvRrxnjB9VVm5bPM/8q6akjyk9jjdsUpGXAEJrXA/Pq7+k8zkGZ
         62zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3.18 03/13] xtensa: fix high memory/reserved memory collision
Date: Mon, 26 Feb 2018 21:15:31 +0100
Message-Id: <20180226201527.397042375@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495966162056282?=
X-GMAIL-MSGID: =?utf-8?q?1593495966162056282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 6ac5a11dc674bc5016ea716e8082fff61f524dc1 upstream.

Xtensa memory initialization code frees high memory pages without
checking whether they are in the reserved memory regions or not. That
results in invalid value of totalram_pages and duplicate page usage by
CMA and highmem. It produces a bunch of BUGs at startup looking like
this:

BUG: Bad page state in process swapper  pfn:70800
page:be60c000 count:0 mapcount:-127 mapping:  (null) index:0x1
flags: 0x80000000()
raw: 80000000 00000000 00000001 ffffff80 00000000 be60c014 be60c014 0000000a
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G    B            4.16.0-rc1-00015-g7928b2cbe55b-dirty #23
Stack:
 bd839d33 00000000 00000018 ba97b64c a106578c bd839d70 be60c000 00000000
 a1378054 bd86a000 00000003 ba97b64c a1066166 bd839da0 be60c000 ffe00000
 a1066b58 bd839dc0 be504000 00000000 000002f4 bd838000 00000000 0000001e
Call Trace:
 [<a1065734>] bad_page+0xac/0xd0
 [<a106578c>] free_pages_check_bad+0x34/0x4c
 [<a1066166>] __free_pages_ok+0xae/0x14c
 [<a1066b58>] __free_pages+0x30/0x64
 [<a1365de5>] init_cma_reserved_pageblock+0x35/0x44
 [<a13682dc>] cma_init_reserved_areas+0xf4/0x148
 [<a10034b8>] do_one_initcall+0x80/0xf8
 [<a1361c16>] kernel_init_freeable+0xda/0x13c
 [<a125b59d>] kernel_init+0x9/0xd0
 [<a1004304>] ret_from_kernel_thread+0xc/0x18

Only free high memory pages that are not reserved.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/mm/init.c |   70 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -307,19 +307,75 @@ void __init zones_init(void)
 	free_area_init_node(0, zones_size, ARCH_PFN_OFFSET, NULL);
 }
 
+#ifdef CONFIG_HIGHMEM
+static void __init free_area_high(unsigned long pfn, unsigned long end)
+{
+	for (; pfn < end; pfn++)
+		free_highmem_page(pfn_to_page(pfn));
+}
+
+static void __init free_highpages(void)
+{
+	unsigned long max_low = max_low_pfn;
+	struct memblock_region *mem, *res;
+
+	reset_all_zones_managed_pages();
+	/* set highmem page free */
+	for_each_memblock(memory, mem) {
+		unsigned long start = memblock_region_memory_base_pfn(mem);
+		unsigned long end = memblock_region_memory_end_pfn(mem);
+
+		/* Ignore complete lowmem entries */
+		if (end <= max_low)
+			continue;
+
+		if (memblock_is_nomap(mem))
+			continue;
+
+		/* Truncate partial highmem entries */
+		if (start < max_low)
+			start = max_low;
+
+		/* Find and exclude any reserved regions */
+		for_each_memblock(reserved, res) {
+			unsigned long res_start, res_end;
+
+			res_start = memblock_region_reserved_base_pfn(res);
+			res_end = memblock_region_reserved_end_pfn(res);
+
+			if (res_end < start)
+				continue;
+			if (res_start < start)
+				res_start = start;
+			if (res_start > end)
+				res_start = end;
+			if (res_end > end)
+				res_end = end;
+			if (res_start != start)
+				free_area_high(start, res_start);
+			start = res_end;
+			if (start == end)
+				break;
+		}
+
+		/* And now free anything which remains */
+		if (start < end)
+			free_area_high(start, end);
+	}
+}
+#else
+static void __init free_highpages(void)
+{
+}
+#endif
+
 /*
  * Initialize memory pages.
  */
 
 void __init mem_init(void)
 {
-#ifdef CONFIG_HIGHMEM
-	unsigned long tmp;
-
-	reset_all_zones_managed_pages();
-	for (tmp = max_low_pfn; tmp < max_pfn; tmp++)
-		free_highmem_page(pfn_to_page(tmp));
-#endif
+	free_highpages();
 
 	max_mapnr = max_pfn - ARCH_PFN_OFFSET;
 	high_memory = (void *)__va(max_low_pfn << PAGE_SHIFT);
