Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E759BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A322148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548670546;
	bh=oyXEftwZ1GLNPaw5L6KuZGnCT+5kOhemtMNZw8aQCsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hv+cCOEtqq00RLAEq2z4q2QJRWFsK82hQX7Xr4yya6/Y0yOZfzNCY5+k/JUbZl7lN
	 1gob5eRCTPsFBmbCdp9zJ008MwMd9V0+fDpiQyieV99uYrPYsjcdXKbnvzcPQinf4m
	 OxpzFSxl5ViGwoBTU6+ME5jqr7AJ/OcfYOq0UOX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1KPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1KPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:15:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CC5B20856;
        Mon, 28 Jan 2019 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548670543;
        bh=oyXEftwZ1GLNPaw5L6KuZGnCT+5kOhemtMNZw8aQCsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aw28n8iEjdhFroHnl8iwtrRxXw4xStt7peCRIEX2JdcHCnXBeKA09uIxgj23GpK20
         4qlXJAI5VRLrRgo27LTcdd1cOe1Xl2JNKpLOoeNIRZJWtmQTb876fRj8SbVfFLHFaN
         p4o5B43UJyJeEvY/v/4QWZomf5W8WK8yTEhNoA3g=
Date:   Mon, 28 Jan 2019 11:15:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Message-ID: <20190128101541.GA32222@kroah.com>
References: <20190128094301.151252-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128094301.151252-1-drinkcat@chromium.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:43:01PM +0800, Nicolas Boichat wrote:
> L1 tables are allocated with __get_dma_pages, and therefore already
> ignored by kmemleak.
> 
> Without this, the kernel would print this error message on boot,
> when the first L1 table is allocated:
> 
> [    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
> [    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
> [    2.831227] Workqueue: events deferred_probe_work_func
> [    2.836353] Call trace:
> ...
> [    2.852532]  paint_ptr+0xa0/0xa8
> [    2.855750]  kmemleak_ignore+0x38/0x6c
> [    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
> [    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
> [    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
> ...
> 
> Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> I only tested this on top of my other series
> (https://patchwork.kernel.org/patch/10720495/), but I think the same fix
> applies. I'm still a bit confused as to why this only shows up now, as IIUC,
> the kmemleak_ignore call was always wrong with L1 tables.
> 
>  drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
