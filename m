Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91857C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649DD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649DD2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJPKpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:45:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbeJPKpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE3E0C034DE3;
        Tue, 16 Oct 2018 02:57:06 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D13966246E;
        Tue, 16 Oct 2018 02:57:00 +0000 (UTC)
Date:   Tue, 16 Oct 2018 10:56:57 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, bhe@redhat.com
Subject: Re: [PATCH 0/3 v3] add reserved e820 ranges to the kdump kernel e820
 table
Message-ID: <20181016025657.GB13006@dhcp-128-65.nay.redhat.com>
References: <20180921073211.20097-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921073211.20097-1-lijiang@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Oct 2018 02:57:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/18 at 03:32pm, Lianbo Jiang wrote:
> E820 reserved ranges is useful in kdump kernel, we have added this in
> kexec-tools code.
> 
> One reason is PCI mmconf (extended mode) requires reserved region otherwise
> it falls back to legacy mode.
> 
> Furthermore, when AMD SME kdump support, it needs to map dmi table area as
> unencrypted. For normal boot, these ranges sit in e820 reserved ranges,
> thus the early ioremap code naturally map them as unencrypted. If we also
> have same e820 reserve setup in kdump kernel then it will just work like
> normal kernel.
> 
> Kdump uses walk_iomem_res_desc to iterate resources, then adds matched desc
> to e820 table for the kdump kernel.
> 
> But IORES_DESC_NONE resource type includes several different e820 types, we
> need add exact e820 type to the kdump kernel e820 table, thus it also needs
> an extra checking in memmap_entry_callback() to match the e820 type and
> resource name.
> 
> By the way, we also fix an error which walks through iomem resources, the
> values of the function parameter may be modified in the while loop of
> __walk_iomem_res_desc(), which will cause us to not get the desired result
> in some cases.
> 
> Changes since v2:
> 1. Modified the value of flags to "0", when walking through the whole
> tree for e820 reserved ranges.
> 2. Modified the invalid SOB chain issue.
> 
> Lianbo Jiang (3):
>   resource: fix an error which walks through iomem resources
>   x86/kexec_file: add e820 entry in case e820 type string matches to io
>     resource name
>   x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

Lianbo, since Bjorn has fixed the resource issue in another patchset,
can you rebase your patch 2 and 3 on top of his patches and resend?

> 
>  arch/x86/include/asm/e820/api.h |  2 ++
>  arch/x86/kernel/crash.c         | 11 ++++++++++-
>  arch/x86/kernel/e820.c          |  2 +-
>  kernel/resource.c               |  3 +++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 

Thanks
Dave
