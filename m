Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68857C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389472084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBYIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:23:36 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54923 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbfBYIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:23:36 -0500
X-IronPort-AV: E=Sophos;i="5.58,410,1544457600"; 
   d="scan'208";a="55180386"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Feb 2019 16:23:33 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 533084724007;
        Mon, 25 Feb 2019 16:23:21 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 25 Feb 2019 16:23:37 +0800
Date:   Mon, 25 Feb 2019 16:23:18 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190225082318.GB9326@localhost.localdomain>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 533084724007.A61F0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 03:59:56PM +0800, Pingfan Liu wrote:
>crashkernel=x@y option may fail to reserve the required memory region if
>KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
>skip the required region.
>
>Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Will Deacon <will.deacon@arm.com>
>Cc: Nicolas Pitre <nico@linaro.org>
>Cc: Pingfan Liu <kernelfans@gmail.com>
>Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
>Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: linux-kernel@vger.kernel.org
>---
> arch/x86/boot/compressed/kaslr.c | 26 +++++++++++++++++++++++++-
> 1 file changed, 25 insertions(+), 1 deletion(-)
>

Hi Pingfan,

Some not important comments:

>diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>index 9ed9709..728bc4b 100644
>--- a/arch/x86/boot/compressed/kaslr.c
>+++ b/arch/x86/boot/compressed/kaslr.c
>@@ -109,6 +109,7 @@ enum mem_avoid_index {
> 	MEM_AVOID_BOOTPARAMS,
> 	MEM_AVOID_MEMMAP_BEGIN,
> 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
>+	MEM_AVOID_CRASHKERNEL,
> 	MEM_AVOID_MAX,
> };
> 
>@@ -240,6 +241,27 @@ static void parse_gb_huge_pages(char *param, char *val)
> 	}
> }
> 
>+/* parse crashkernel=x@y option */
>+static int mem_avoid_crashkernel_simple(char *option)
>+{
>+	char *cur = option;
>+	unsigned long long crash_size, crash_base;

Change the position of two lines above.

>+
>+	crash_size = memparse(option, &cur);
>+	if (option == cur)
>+		return -EINVAL;
>+
>+	if (*cur == '@') {
>+		option = cur + 1;
>+		crash_base = memparse(option, &cur);
>+		if (option == cur)
>+			return -EINVAL;
>+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
>+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
>+	}
>+
>+	return 0;

You just call this function and don't use its return value.
So why not change it as void type.

>+}
> 
> static void handle_mem_options(void)

If you want to change this function, I think you could change the
function name and the comment:

        /* Mark the memmap regions we need to avoid */
        handle_mem_options();

> {
>@@ -250,7 +272,7 @@ static void handle_mem_options(void)
> 	u64 mem_size;
> 
> 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
>-		!strstr(args, "hugepages"))
>+		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> 		return;
> 
> 	tmp_cmdline = malloc(len + 1);
>@@ -286,6 +308,8 @@ static void handle_mem_options(void)
> 				goto out;
> 
> 			mem_limit = mem_size;
>+		} else if (strstr(param, "crashkernel")) {
>+			mem_avoid_crashkernel_simple(val);

I am wondering why you call this function mem_avoid_crashkernel_*simple*().

Thanks,
Chao Fan

> 		}
> 	}
> 
>-- 
>2.7.4
>
>
>


