Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFADECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FBA2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FBA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbeITMg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:36:26 -0400
Received: from verein.lst.de ([213.95.11.211]:57950 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeITMgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:36:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DF52168D7F; Thu, 20 Sep 2018 08:54:30 +0200 (CEST)
Date:   Thu, 20 Sep 2018 08:54:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     zhe.he@windriver.com, hch@lst.de, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing cma to command
 line
Message-ID: <20180920065430.GA13761@lst.de>
References: <CGME20180917032603epcas4p4da3674e558c4704622f58b133e7fe5ce@epcas4p4.samsung.com> <1537154660-296740-1-git-send-email-zhe.he@windriver.com> <20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784~VdHnT_5yZ0331203312eucas1p1U@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784~VdHnT_5yZ0331203312eucas1p1U@eucas1p1.samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:28:33AM +0200, Marek Szyprowski wrote:
> Hi
> 
> On 2018-09-17 05:24, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> >
> > early_cma does not check input argument before passing it to
> > simple_strtoull. The argument would be a NULL pointer if "cma", without
> > its value, is set in command line and thus causes the following panic.
> >
> > PANIC: early exception 0xe3 IP 10:ffffffffa3e9db8d error 0 cr2 0x0
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #7
> > [    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
> > ...
> > [    0.000000] Call Trace:
> > [    0.000000]  simple_strtoull+0x29/0x70
> > [    0.000000]  memparse+0x26/0x90
> > [    0.000000]  early_cma+0x17/0x6a
> > [    0.000000]  do_early_param+0x57/0x8e
> > [    0.000000]  parse_args+0x208/0x320
> > [    0.000000]  ? rdinit_setup+0x30/0x30
> > [    0.000000]  parse_early_options+0x29/0x2d
> > [    0.000000]  ? rdinit_setup+0x30/0x30
> > [    0.000000]  parse_early_param+0x36/0x4d
> > [    0.000000]  setup_arch+0x336/0x99e
> > [    0.000000]  start_kernel+0x6f/0x4e6
> > [    0.000000]  x86_64_start_reservations+0x24/0x26
> > [    0.000000]  x86_64_start_kernel+0x6f/0x72
> > [    0.000000]  secondary_startup_64+0xa4/0xb0
> >
> > This patch adds a check to prevent the panic.
> >
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > Cc: stable@vger.kernel.org
> > Cc: hch@lst.de
> > Cc: m.szyprowski@samsung.com
> > Cc: robin.murphy@arm.com
> 
> Thanks for the fix.
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, added to the dma-mapping tree.
