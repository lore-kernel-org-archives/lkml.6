Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A479C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6C020859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAOFPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:15:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOFPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:15:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5D5280E7B;
        Tue, 15 Jan 2019 05:15:16 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD3716091C;
        Tue, 15 Jan 2019 05:15:11 +0000 (UTC)
Date:   Tue, 15 Jan 2019 13:15:07 +0800
From:   Dave Young <dyoung@redhat.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH V2] x86/kexec: fix a kexec_file_load failure
Message-ID: <20190115051507.GA9893@dhcp-128-65.nay.redhat.com>
References: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 15 Jan 2019 05:15:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 at 09:12am, Dave Young wrote:
> The code cleanup mentioned in Fixes tag changed the behavior of
> kexec_locate_mem_hole.  The kexec_locate_mem_hole will try to
> allocate free memory only when kbuf.mem is initialized as zero.
> 
> But in x86 kexec_file_load implementation there are a few places
> the kbuf.mem is reused like below:
>   /* kbuf initialized, kbuf.mem = 0 */
>   ...
>   kexec_add_buffer()
>   ...
>   kexec_add_buffer()
> 
>   The second kexec_add_buffer will reuse previous kbuf but not
>   reinitialize the kbuf.mem.
> 
> Thus kexec_file_load failed because the sanity check failed.
> 
> So explictily reset kbuf.mem to fix the issue.
> 
> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> Signed-off-by: Dave Young <dyoung@redhat.com>
> Cc: <stable@vger.kernel.org>
> ---
> V1 -> V2: use KEXEC_BUF_MEM_UNKNOWN in code.
>  arch/x86/kernel/crash.c           | 1 +
>  arch/x86/kernel/kexec-bzimage64.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index f631a3f15587..6b7890c7889b 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -469,6 +469,7 @@ int crash_load_segments(struct kimage *image)
>  
>  	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		vfree((void *)image->arch.elf_headers);
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 278cd07228dd..0d5efa34f359 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -434,6 +434,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	kbuf.memsz = PAGE_ALIGN(header->init_size);
>  	kbuf.buf_align = header->kernel_alignment;
>  	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret)
>  		goto out_free_params;
> @@ -448,6 +449,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		kbuf.bufsz = kbuf.memsz = initrd_len;
>  		kbuf.buf_align = PAGE_SIZE;
>  		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  		ret = kexec_add_buffer(&kbuf);
>  		if (ret)
>  			goto out_free_params;
> -- 
> 2.17.0
> 

Andrew, Boris,  can any of you take this patch? Without this fix we have a regression.

Thanks
Dave
