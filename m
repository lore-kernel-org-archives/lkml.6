Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FDF208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FDF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKPTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbeKPTXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:23:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82E70308212A;
        Fri, 16 Nov 2018 09:11:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DFC6600CD;
        Fri, 16 Nov 2018 09:11:41 +0000 (UTC)
Date:   Fri, 16 Nov 2018 10:11:38 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Cc:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] SelfTest: KVM: Drop Asserts for madvise failures
Message-ID: <20181116091138.zcqczgxdlzanceee@kamzik.brq.redhat.com>
References: <20181115180907.13974-1-ahmedsoliman0x666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115180907.13974-1-ahmedsoliman0x666@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 16 Nov 2018 09:11:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 08:09:07PM +0200, Ahmed Abd El Mawgood wrote:
> From: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
> 
> madvise() returns -1 without CONFIG_TRANSPARENT_HUGEPAGE=y. That would
> trigger asserts when checking for return value of madvice. Following
> similar decision to [1]. I thought it is ok to assume that madvise()
> failures implies that THP is not supported by host kernel.
> 
> Other options were to check for Transparent Huge Page support in
> /sys/kernel/mm/transparent_hugepage/enabled.
> 
> -- links --
> [1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04514.html
> 
> Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 1b41e71283d5..7725cfdf1b79 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -586,14 +586,12 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
>  
>  	/* As needed perform madvise */
> -	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> -		ret = madvise(region->host_mem, npages * vm->page_size,
> -			     src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
> -		TEST_ASSERT(ret == 0, "madvise failed,\n"
> -			    "  addr: %p\n"
> -			    "  length: 0x%lx\n"
> -			    "  src_type: %x",
> -			    region->host_mem, npages * vm->page_size, src_type);
> +	if (src_type == VM_MEM_SRC_ANONYMOUS) {
> +		madvise(region->host_mem, npages * vm->page_size,
> +				MADV_NOHUGEPAGE);

This is fine.

> +	} else if (src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> +		madvise(region->host_mem, npages * vm->page_size,
> +				MADV_HUGEPAGE);

I would still assert here, but with a more informative message like
"madvise(MADV_HUGEPAGE) failed. Does the kernel have
CONFIG_TRANSPARENT_HUGEPAGE=y?"

>  	}
>  
>  	region->unused_phy_pages = sparsebit_alloc();
> -- 
> 2.18.1
> 

Thanks,
drew
