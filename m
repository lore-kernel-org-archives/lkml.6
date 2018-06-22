Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50731C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204A23C7F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0204A23C7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934276AbeFVCwo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:52:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933914AbeFVCwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68D9E4015199;
        Fri, 22 Jun 2018 02:52:43 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEEAD1117652;
        Fri, 22 Jun 2018 02:52:40 +0000 (UTC)
Date:   Fri, 22 Jun 2018 10:52:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     lijiang <lijiang@redhat.com>, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, dyoung@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
 manner for kdump
Message-ID: <20180622025235.GN29979@MiWiFi-R3L-srv>
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-4-lijiang@redhat.com>
 <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
 <c591dec2-2135-2e96-8ace-87cbf4b055bf@redhat.com>
 <20180621083915.GE3815@MiWiFi-R3L-srv>
 <4c71ac2a-5c53-f1b1-8de6-4b7b944d5d06@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c71ac2a-5c53-f1b1-8de6-4b7b944d5d06@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 02:52:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 02:52:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/18 at 08:12am, Tom Lendacky wrote:
> On 6/21/2018 3:39 AM, Baoquan He wrote:
> > On 06/21/18 at 01:42pm, lijiang wrote:
> >> 在 2018年06月21日 00:42, Tom Lendacky 写道:
> >>> On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
> >>>> In kdump mode, it will copy the device table of IOMMU from the old
> >>>> device table, which is encrypted when SME is enabled in the first
> >>>> kernel. So we must remap it in encrypted manner in order to be
> >>>> automatically decrypted when we read.
> >>>>
> >>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> >>>> ---
> >>>> Some changes:
> >>>> 1. add some comments
> >>>> 2. clean compile warning.
> >>>>
> >>>>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
> >>>>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> >>>> index 904c575..a20af4c 100644
> >>>> --- a/drivers/iommu/amd_iommu_init.c
> >>>> +++ b/drivers/iommu/amd_iommu_init.c
> >>>> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
> >>>>  	}
> >>>>  
> >>>>  	old_devtb_phys = entry & PAGE_MASK;
> >>>> +
> >>>> +	/*
> >>>> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
> >>>> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
> >>>> +	 *  encryption mask to obtain the true physical address in kdump mode.
> >>>> +	 */
> >>>> +	if (mem_encrypt_active() && is_kdump_kernel())
> >>>> +		old_devtb_phys = __sme_clr(old_devtb_phys);
> >>>> +
> >>>
> >>> You can probably just use "if (is_kdump_kernel())" here, since memory
> >>> encryption is either on in both the first and second kernel or off in
> >>> both the first and second kernel.  At which point __sme_clr() will do
> >>> the proper thing.
> >>>
> >>> Actually, this needs to be done no matter what.  When doing either the
> >>> ioremap_encrypted() or the memremap(), the physical address should not
> >>> include the encryption bit/mask.
> >>>
> >>> Thanks,
> >>> Tom
> >>>
> >> Thanks for your comments. If we don't remove the memory encryption mask, it will
> >> return false because the 'old_devtb_phys >= 0x100000000ULL' may become true.
> > 
> > Lianbo, you may not get what Tom suggested. Tom means no matter what it
> > is, encrypted or not in 1st kernel, we need get pure physicall address,
> > and using below code is always right for both cases.
> > 
> > 	if (is_kdump_kernel())
> > 		old_devtb_phys = __sme_clr(old_devtb_phys);
> > 
> > And this is simpler. You even can add one line of code comment to say
> > like "Physical address w/o encryption mask is needed here."
> 
> Even simpler, there's no need to even check for is_kdump_kernel().  The
> __sme_clr() should always be done if the physical address is going to be
> used for some form of io or memory remapping.
> 
> So you could just change the existing:
> 
> 	old_devtb_phys = entry & PAGE_MASK;
> 
> to:
> 
> 	old_devtb_phys = __sme_clr(entry) & PAGE_MASK;

Agree, this is even better.

> 
> >>
> >> Lianbo
> >>>>  	if (old_devtb_phys >= 0x100000000ULL) {
> >>>>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
> >>>>  		return false;
> >>>>  	}
> >>>> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> >>>> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
> >>>> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
> >>>> +							dev_table_size)
> >>>> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);> +
> >>>>  	if (!old_devtb)
> >>>>  		return false;
> >>>>  
> >>>>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
