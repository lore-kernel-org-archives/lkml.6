Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23551C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE30208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE30208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJPKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:39:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbeJPKjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:39:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F4015D66B;
        Tue, 16 Oct 2018 02:51:27 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E36477F25;
        Tue, 16 Oct 2018 02:51:20 +0000 (UTC)
Date:   Tue, 16 Oct 2018 10:51:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bp@suse.de, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com,
        tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com,
        dan.j.williams@intel.com, tglx@linutronix.de,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20181016025116.GA14358@dhcp-128-65.nay.redhat.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
 <20180930092741.GC6950@dhcp-128-65.nay.redhat.com>
 <20181015045138.GA9719@dhcp-128-65.nay.redhat.com>
 <20181015134404.GA5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015134404.GA5906@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 16 Oct 2018 02:51:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 at 08:44am, Bjorn Helgaas wrote:
> On Mon, Oct 15, 2018 at 12:51:38PM +0800, Dave Young wrote:
> > On 09/30/18 at 05:27pm, Dave Young wrote:
> > > On 09/30/18 at 05:21pm, Dave Young wrote:
> > > > On 09/27/18 at 09:21am, Bjorn Helgaas wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > 
> > > > > The only use of KEXEC_BACKUP_SRC_END is as an argument to
> > > > > walk_system_ram_res():
> > > > > 
> > > > >   int crash_load_segments(struct kimage *image)
> > > > >   {
> > > > >     ...
> > > > >     walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
> > > > >                         image, determine_backup_region);
> > > > > 
> > > > > walk_system_ram_res() expects "start, end" arguments that are inclusive,
> > > > > i.e., the range to be walked includes both the start and end addresses.
> > > > 
> > > > Looking at the function comment of find_next_iomem_res,  the res->end
> > > > should be exclusive, am I missing something?
> > > 
> > > Oops,  you fix it in 2nd patch, I apparently miss that.
> > > 
> > > Since the fix of checking the end is in another patch, probably merge
> > > these two patches so that they are in one patch to avoid break bisect. 
> > 
> > Not sure if above comment was missed, Boris, would you mind to fold the
> > patch 1 and 2?
> 
> Sorry, I did miss this comment.
> 
> Patch 2 was for the very specific case of a single-byte resource at
> the end address, which we probably never see in practice.
> 
> For patch 1, the find_next_iomem_res() function comment had
> "[res->start.res->end)", but I think the code actually treated it as
> "[res->start.res->end]", so the comment was inaccurate.
> 
> Before my patches we had:
> 
>   #define KEXEC_BACKUP_SRC_START  (0UL)
>   #define KEXEC_BACKUP_SRC_END    (640 * 1024UL)    # 0xa0000
> 
> The intention is to search for system RAM resources that intersect
> this region:
> 
>   [mem 0x0-0x9ffff]
> 
> The call is:
> 
>   walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
>                       ..., determine_backup_region);
>   walk_system_ram_res(0, 0xa0000, ..., determine_backup_region);
> 
> Assume iomem_resource contains this system RAM resource:
> 
>   [mem 0x90000-0xaffff]
> 
> In find_next_iomem_res(), the "res" input parameter is the region to
> search:
> 
>   res->start = 0;                          # KEXEC_BACKUP_SRC_START
>   res->end   = 0xa0000;                    # KEXEC_BACKUP_SRC_END
> 
> In one of the loop iterations we find the [mem 0x90000-0xaffff]
> resource (p):
> 
>   p->start = 0x90000;
>   p->end   = 0xaffff;
> 
>   if (p->start > end)                      # 0x90000 > 0xa0000? false
>   if (p->end >= start && p->start < end)   # 0xaffff >= 0 ? true
>                                            # 0x90000 < 0xa0000 ? true
>     break;                                 # so we'll return part of "p"
> 
>   if (res->start < p->start)               # 0x0 < 0x90000 ? true
>     res->start = 0x90000;                  # trim beginning to p->start
>   if (res->end > p->end)                   # 0xa0000 > 0xaffff ? false
> 
> So find_next_iomem_res() returns with this:
> 
>   res->start = 0x90000;                    # trimmed to p->start
>   res->end   = 0xa0000;                    # unchanged from input
> 
>   [mem 0x90000-0xa0000]                    # returned resource (res)
> 
> and we call determine_backup_region(res), which sets:
> 
>   image->arch.backup_src_start = 0x90000;
>   image->arch.backup_src_sz = resource_size(res)  # 0xa0000 - 0x90000 + 1
>                                                   # (0x10001)
> 
> This is incorrect.  What we wanted was the part of [mem 0x90000-0xaffff]
> that intersects the first 640K, i.e., [mem 0x90000-0x9ffff], but what
> we got was [mem 0x90000-0xa0000], which is one byte too long.
> 
> The resource returned find_next_iomem_res() always ends at the
> "res->end" supplied as an input parameter *unless* the input res->end
> is strictly greater than the p->end, when it is truncated to p->end.
> 
> Bottom line, I don't think patches 1 and 2 need to be folded together
> because they fix different problems.
> 
> Bjorn

Bjorn,  thanks for the detail explanations,  it is very clear now to me.
Indeed 2nd patch is for different issue, please ignore my comment :)

For the series:
Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
