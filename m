Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA13C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC7C2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC7C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeI3Pxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 11:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbeI3Pxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 11:53:32 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACC3230820C4;
        Sun, 30 Sep 2018 09:21:20 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FAF73091886;
        Sun, 30 Sep 2018 09:21:14 +0000 (UTC)
Date:   Sun, 30 Sep 2018 17:21:10 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>,
        bhe@redhat.com, thomas.lendacky@amd.com, tiwai@suse.de,
        x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com,
        baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de,
        bp@suse.de, akpm@linux-foundation.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 30 Sep 2018 09:21:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 09/27/18 at 09:21am, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The only use of KEXEC_BACKUP_SRC_END is as an argument to
> walk_system_ram_res():
> 
>   int crash_load_segments(struct kimage *image)
>   {
>     ...
>     walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
>                         image, determine_backup_region);
> 
> walk_system_ram_res() expects "start, end" arguments that are inclusive,
> i.e., the range to be walked includes both the start and end addresses.

Looking at the function comment of find_next_iomem_res,  the res->end
should be exclusive, am I missing something?


/*
 * Finds the lowest iomem resource existing within [res->start.res->end).
 * The caller must specify res->start, res->end, res->flags, and optionally
 * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
 * This function walks the whole tree and not just first level children until
 * and unless first_level_children_only is true.
 */
static int find_next_iomem_res(struct resource *res, unsigned long desc,
                               bool first_level_children_only)


> 
> KEXEC_BACKUP_SRC_END was previously defined as (640 * 1024UL), which is the
> first address *past* the desired 0-640KB range.
> 
> Define KEXEC_BACKUP_SRC_END as (640 * 1024UL - 1) so the KEXEC_BACKUP_SRC
> region is [0-0x9ffff], not [0-0xa0000].
> 
> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/include/asm/kexec.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index f327236f0fa7..5125fca472bb 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -67,7 +67,7 @@ struct kimage;
>  
>  /* Memory to backup during crash kdump */
>  #define KEXEC_BACKUP_SRC_START	(0UL)
> -#define KEXEC_BACKUP_SRC_END	(640 * 1024UL)	/* 640K */
> +#define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
>  
>  /*
>   * CPU does not save ss and sp on stack if execution is already
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
