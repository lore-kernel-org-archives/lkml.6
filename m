Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E257C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102642087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102642087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeKOQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:05:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKOQF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:05:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2622E308426A;
        Thu, 15 Nov 2018 05:59:00 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-146.pek2.redhat.com [10.72.12.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99D8C1019628;
        Thu, 15 Nov 2018 05:58:56 +0000 (UTC)
Date:   Thu, 15 Nov 2018 13:58:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181115055853.GA4445@dhcp-128-65.nay.redhat.com>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 15 Nov 2018 05:59:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 at 01:44pm, lijiang wrote:
> 在 2018年11月14日 19:26, Borislav Petkov 写道:
> > On Wed, Nov 14, 2018 at 03:29:25PM +0800, Lianbo Jiang wrote:
> >> When load the kernel image and initramfs by kexec_file_load syscall, it can
> >> not add exact e820 reserved type to kdump kernel e820 table.
> >>
> >> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
> >> desc to e820 table for kdump kernel. But, when convert the e820 type into
> >> the iores descriptors, several e820 types are converted to 'IORES_DES_NONE'
> >> in this function e820_type_to_iores_desc(). So the walk_iomem_res_desc()
> >> will get these unnecessary types(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE
> >> _KERN) when iterate io resources by the 'IORES_DES_NONE'.
> >>
> >> It needs filter out these redundant type(such as E820_TYPE_RAM/E820_TYPE_
> >> UNUSABLE/E820_TYPE_KERN) in order to add exact e820 reserved type to kdump
> >> kernel e820 table. Thus it also needs an extra checking in memmap_entry_
> >> callback() to match the e820 type and resource name.
> > 
> > Ok, it took me a while to parse what this is trying to say so let's
> > start from the top:
> > 
> > * What resource type do you do need in the second kernel?
> > 
> 
> Thanks for your comment.
> 
> The e820 reserved ranges need to be passed to the second kernel.
> 
> > * The most important question: why?
> > 
> 
> At present, the upstream kernel does not pass the e820 reserved ranges to the
> second kernel, which might cause two problems:
> 
> The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
> the reserved region otherwise it falls back to legacy mode, which might lead to
> the hot-plug device could not be recognized in kdump kernel.
> 
> Another one is that the e820 reserved ranges do not setup in kdump kernel, which
> could cause kdump can't work in some machines. To know more information, please
> refer to the [PATCH 2/2 v6] patch log.
> 
> 
> > * If it is the reserved resource, why aren't you adding
> > IORES_DESC_RESERVED or so which to look for instead of this hacky string
> > comparison?
> > 
> 
> Adding the new descriptor 'IORES_DESC_RESERVED' is also a good solution. I will

I was not sure if something else depends on IORES_DESC_NONE and if it is
easy to split it and add IORES_DESC_RESERVED

But if you can prove it is safe then it would be a better way.

Thanks
Dave
