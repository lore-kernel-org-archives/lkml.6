Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeC3ICq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:02:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750744AbeC3ICk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:02:40 -0400
Date: Fri, 30 Mar 2018 16:02:32 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc: kexec_file: Fix error code when trying to load
 kdump kernel
Message-ID: <20180330080232.GB4323@dhcp-128-65.nay.redhat.com>
References: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/18 at 04:05pm, Thiago Jung Bauermann wrote:
> kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
> returns -ENOTSUPP in that case.
> 
> I've recently learned that this errno is internal to the kernel and isn't
> supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
> is defined in an uapi header.
> 
> This does indeed make kexec-tools happier. Before the patch, on ppc64le:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Unknown error 524
> 
> After the patch:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Operation not supported
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Reported-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This is a minor issue, but since it's a simple patch it might be worth
> applying it to stable branches.
> 
> This is the kexec-tools thread where this problem was brought up:
> 
> https://lists.infradead.org/pipermail/kexec/2018-March/020346.html
> 
> And this is an instance of a similar fix being applied elsewhere in the
> kernel, for the same reasons:
> 
> https://patchwork.kernel.org/patch/8490791/
> 
> The test shown in the commit log was made using Hari Bathini's patch
> adding kexec_file_load() support to kexec-tools in ppc64.
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index e4395f937d63..45e0b7d5f200 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> @@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  
>  	/* We don't support crash kernels yet. */
>  	if (image->type == KEXEC_TYPE_CRASH)
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
>  		fops = kexec_file_loaders[i];
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
