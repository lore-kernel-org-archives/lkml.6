Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFDE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIdFF9ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFDE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeIYHkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:40:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIYHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:40:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so1328183pfi.8;
        Mon, 24 Sep 2018 18:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Nt3UGAe2ghv2I3b32rDyWQzeC0rBjAmbAzPPihUJ1I=;
        b=FIdFF9ovKydNpN1ismDcpC8KZedLbezkaplTjaztdWyoLv33rhDl7Sk5A6a38Evv/r
         GkTCIUdL0ZXFei4+IG8jVhIComTEozDfoQOqwa7wbxH/635eydRt19heKg/Yuc3l02nu
         iYcB6YVAHCFFVIcMjf1Y31fIl9qjG4C6IEqMTr8OA6HxGGdJau05AisD7eyhIDAS5ybF
         svDq5jG7mQPxAajTk8YEpuEj2N2QV/2koy4karpKitKk29aVIeKKvviOra2p45Ju4CUS
         +SWH7zdLPo4OzkL2nDvI3Cz9eGmsPSRHg6WSOvfaaKjY6YhI2nNzBzmqGkn7G8Dlv6fA
         loDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Nt3UGAe2ghv2I3b32rDyWQzeC0rBjAmbAzPPihUJ1I=;
        b=jt4YyZ3cteSplCjgDxLLhzzj9/7P1xSnq68xvDNJ33ZKSsBfoIFbis9CnBrdkP4wK5
         Qr1LDsX9963mSYa6lW5cUYRD1IQhNYsR6+DIv5qXKNu6/tRdBxcrv7XIeUURES2/EXgn
         2rTiLoPn8K6eztOKr3t+ac1Rfc7imq2yJ5JYwM930hH+sxcdhgiLTLt/+RVMOnkrDbAS
         fsOIRvo+6uK/s48xyLicR+ucQbBd8T5NvGJrttJPCsSb6apqqjbirBMBlX6xcZ7EqIXZ
         TqMRpK3Y4649yWMmqVUniJS+4sMii0LrzixArFSApHpShx01P1653/DEcZNveYAaRdy/
         fT9A==
X-Gm-Message-State: ABuFfoiO6lsv+p31MhZsVDxNPLSVO42SwpfoDrJQZc8Rjko//nOqWVju
        oS3875yjHn3ZFuWUnUCNciA=
X-Google-Smtp-Source: ACcGV60AUxSkpNf88uB0cfWG5HrRPvOdihANP7JquyyOpuwdR+ODgWJCQ6dmtfJMbAWCO4Rca7Ni9g==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr1098541pgh.348.1537839351034;
        Mon, 24 Sep 2018 18:35:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g66-v6sm716784pfk.39.2018.09.24.18.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 18:35:50 -0700 (PDT)
Date:   Mon, 24 Sep 2018 18:35:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        SZ Lin <sz.lin@moxa.com>
Subject: Re: [PATCH 4.9 111/111] MIPS: VDSO: Drop gic_get_usm_range() usage
Message-ID: <20180925013548.GA28493@roeck-us.net>
References: <20180924113103.337261320@linuxfoundation.org>
 <20180924113116.349047480@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924113116.349047480@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:53:18PM +0200, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 

This patch breaks v4.4.y and v4.9.y builds.
It includes asm/mips-cps.h which doesn't exist in those releases.

Building mips:malta_defconfig:smp:initrd ... failed
------------
Error log:
arch/mips/kernel/vdso.c:23:26: fatal error: asm/mips-cps.h: No such file or directory

Guenter

> ------------------
> 
> From: Paul Burton <paul.burton@imgtec.com>
> 
> commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.
> 
> We don't really need gic_get_usm_range() to abstract discovery of the
> address of the GIC user-visible section now that we have access to its
> base address globally.
> 
> Switch to calculating it ourselves, which will allow us to stop
> requiring the irqchip driver to care about a counter exposed to userland
> for use via the VDSO.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/17040/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/mips/kernel/vdso.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -13,7 +13,6 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> -#include <linux/irqchip/mips-gic.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> @@ -21,6 +20,7 @@
>  #include <linux/timekeeper_internal.h>
>  
>  #include <asm/abi.h>
> +#include <asm/mips-cps.h>
>  #include <asm/page.h>
>  #include <asm/vdso.h>
>  
> @@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
>  {
>  	struct mips_vdso_image *image = current->thread.abi->vdso;
>  	struct mm_struct *mm = current->mm;
> -	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
> +	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
>  	struct vm_area_struct *vma;
> -	struct resource gic_res;
>  	int ret;
>  
>  	if (down_write_killable(&mm->mmap_sem))
> @@ -127,7 +126,7 @@ int arch_setup_additional_pages(struct l
>  	 * only map a page even though the total area is 64K, as we only need
>  	 * the counter registers at the start.
>  	 */
> -	gic_size = gic_present ? PAGE_SIZE : 0;
> +	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
>  	vvar_size = gic_size + PAGE_SIZE;
>  	size = vvar_size + image->size;
>  
> @@ -168,13 +167,9 @@ int arch_setup_additional_pages(struct l
>  
>  	/* Map GIC user page. */
>  	if (gic_size) {
> -		ret = gic_get_usm_range(&gic_res);
> -		if (ret)
> -			goto out;
> +		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
>  
> -		ret = io_remap_pfn_range(vma, base,
> -					 gic_res.start >> PAGE_SHIFT,
> -					 gic_size,
> +		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
>  					 pgprot_noncached(PAGE_READONLY));
>  		if (ret)
>  			goto out;
> 
> 
