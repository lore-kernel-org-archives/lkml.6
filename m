Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BBEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93AC20657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93AC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeIRTBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:01:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbeIRTBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:01:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65B89ED1;
        Tue, 18 Sep 2018 06:28:45 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1059F3F557;
        Tue, 18 Sep 2018 06:28:43 -0700 (PDT)
Subject: Re: move swiotlb noncoherent dma support from arm64 to generic code
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20180917153826.28052-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d6a4f58e-975f-e7dc-d622-d56760710a92@arm.com>
Date:   Tue, 18 Sep 2018 14:28:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 17/09/18 16:38, Christoph Hellwig wrote:
> Hi all,
> 
> this series starts with various swiotlb cleanups, then adds support for
> non-cache coherent devices to the generic swiotlb support, and finally
> switches arm64 to use the generic code.

I think there's going to be an issue with the embedded folks' grubby 
hack in arm64's mem_init() which skips initialising SWIOTLB at all with 
sufficiently little DRAM. I've been waiting for 
dma-direct-noncoherent-merge so that I could fix that case to swizzle in 
dma_direct_ops and avoid swiotlb_dma_ops entirely.

> Given that this series depends on patches in the dma-mapping tree, or
> pending for it I've also published a git tree here:
> 
>      git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent

However, upon sitting down to eagerly write that patch I've just 
boot-tested the above branch as-is for a baseline and discovered a 
rather more significant problem: arch_dma_alloc() is recursing back into 
__swiotlb_alloc() and blowing the stack. Not good :(

Robin.

----->8-----
[    4.032760] Insufficient stack space to handle exception!
[    4.032765] ESR: 0x96000047 -- DABT (current EL)
[    4.042666] FAR: 0xffff00000a937fb0
[    4.046113] Task stack:     [0xffff00000a938000..0xffff00000a93c000]
[    4.052399] IRQ stack:      [0xffff000008008000..0xffff00000800c000]
[    4.058684] Overflow stack: [0xffff80097ff4b290..0xffff80097ff4c290]
[    4.064972] CPU: 1 PID: 130 Comm: kworker/1:1 Not tainted 4.19.0-rc2+ 
#681
[    4.071775] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Jul 10 2018
[    4.082456] Workqueue: events deferred_probe_work_func
[    4.087542] pstate: 00000005 (nzcv daif -PAN -UAO)
[    4.092283] pc : arch_dma_alloc+0x0/0x198
[    4.096250] lr : dma_direct_alloc+0x20/0x28
[    4.100385] sp : ffff00000a938010
[    4.103660] x29: ffff00000a938010 x28: ffff800974e15238
[    4.108918] x27: ffff000008bf30d8 x26: ffff80097543d400
[    4.114176] x25: 0000000000000300 x24: ffff80097543d400
[    4.119434] x23: ffff800974e15238 x22: 0000000000001000
[    4.124691] x21: ffff80097543d400 x20: 0000000000001000
[    4.129948] x19: 0000000000000300 x18: ffffffffffffffff
[    4.135206] x17: 0000000000000000 x16: ffff000008bf1b58
[    4.140463] x15: ffff0000091eb688 x14: ffff00008a93ba1d
[    4.145720] x13: ffffff0000000000 x12: 0000000000000000
[    4.150977] x11: 0000000000000001 x10: ffffff7f7fff7fff
[    4.156235] x9 : 0000000000000000 x8 : 0000000000000000
[    4.161492] x7 : ffff800974df9810 x6 : 0000000000000000
[    4.166749] x5 : 0000000000000000 x4 : 0000000000000300
[    4.172006] x3 : 00000000006002c0 x2 : ffff800974e15238
[    4.177263] x1 : 0000000000001000 x0 : ffff80097543d400
[    4.182521] Kernel panic - not syncing: kernel stack overflow
[    4.188207] CPU: 1 PID: 130 Comm: kworker/1:1 Not tainted 4.19.0-rc2+ 
#681
[    4.195008] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Jul 10 2018
[    4.205681] Workqueue: events deferred_probe_work_func
[    4.210765] Call trace:
[    4.213183]  dump_backtrace+0x0/0x1f0
[    4.216805]  show_stack+0x14/0x20
[    4.220084]  dump_stack+0x9c/0xbc
[    4.223362]  panic+0x138/0x294
[    4.226381]  __stack_chk_fail+0x0/0x18
[    4.230088]  handle_bad_stack+0x11c/0x130
[    4.234052]  __bad_stack+0x88/0x8c
[    4.237415]  arch_dma_alloc+0x0/0x198
[    4.241036]  __swiotlb_alloc+0x3c/0x178
[    4.244828]  arch_dma_alloc+0xd0/0x198
[    4.248534]  dma_direct_alloc+0x20/0x28
[    4.252327]  __swiotlb_alloc+0x3c/0x178
[    4.256119]  arch_dma_alloc+0xd0/0x198
[    4.259825]  dma_direct_alloc+0x20/0x28
[    4.263617]  __swiotlb_alloc+0x3c/0x178
[    4.267409]  arch_dma_alloc+0xd0/0x198
[    4.271115]  dma_direct_alloc+0x20/0x28
[    4.274907]  __swiotlb_alloc+0x3c/0x178
[    4.278700]  arch_dma_alloc+0xd0/0x198
[    4.282405]  dma_direct_alloc+0x20/0x28
[    4.286198]  __swiotlb_alloc+0x3c/0x178
[    4.289990]  arch_dma_alloc+0xd0/0x198
[    4.293696]  dma_direct_alloc+0x20/0x28
[    4.297489]  __swiotlb_alloc+0x3c/0x178
[    4.301281]  arch_dma_alloc+0xd0/0x198
[    4.304987]  dma_direct_alloc+0x20/0x28
[    4.308779]  __swiotlb_alloc+0x3c/0x178
[    4.312571]  arch_dma_alloc+0xd0/0x198
[    4.316277]  dma_direct_alloc+0x20/0x28
[    4.320069]  __swiotlb_alloc+0x3c/0x178
[    4.323861]  arch_dma_alloc+0xd0/0x198
[    4.327567]  dma_direct_alloc+0x20/0x28
[    4.331359]  __swiotlb_alloc+0x3c/0x178
[    4.335151]  arch_dma_alloc+0xd0/0x198
[    4.338857]  dma_direct_alloc+0x20/0x28
[    4.342650]  __swiotlb_alloc+0x3c/0x178
[    4.346442]  arch_dma_alloc+0xd0/0x198
[    4.350148]  dma_direct_alloc+0x20/0x28
[    4.353940]  __swiotlb_alloc+0x3c/0x178
[    4.357732]  arch_dma_alloc+0xd0/0x198
[    4.361438]  dma_direct_alloc+0x20/0x28
[    4.365230]  __swiotlb_alloc+0x3c/0x178
[    4.369022]  arch_dma_alloc+0xd0/0x198
[    4.372728]  dma_direct_alloc+0x20/0x28
[    4.376520]  __swiotlb_alloc+0x3c/0x178
[    4.380313]  arch_dma_alloc+0xd0/0x198
[    4.384018]  dma_direct_alloc+0x20/0x28
[    4.387811]  __swiotlb_alloc+0x3c/0x178
[    4.391603]  arch_dma_alloc+0xd0/0x198
[    4.395309]  dma_direct_alloc+0x20/0x28
[    4.399101]  __swiotlb_alloc+0x3c/0x178
[    4.402893]  arch_dma_alloc+0xd0/0x198
[    4.406599]  dma_direct_alloc+0x20/0x28
[    4.410391]  __swiotlb_alloc+0x3c/0x178
[    4.414183]  arch_dma_alloc+0xd0/0x198
[    4.417889]  dma_direct_alloc+0x20/0x28
[    4.421682]  __swiotlb_alloc+0x3c/0x178
[    4.425474]  arch_dma_alloc+0xd0/0x198
[    4.429180]  dma_direct_alloc+0x20/0x28
[    4.432972]  __swiotlb_alloc+0x3c/0x178
[    4.436764]  arch_dma_alloc+0xd0/0x198
[    4.440470]  dma_direct_alloc+0x20/0x28
[    4.444262]  __swiotlb_alloc+0x3c/0x178
[    4.448055]  arch_dma_alloc+0xd0/0x198
[    4.451760]  dma_direct_alloc+0x20/0x28
[    4.455553]  __swiotlb_alloc+0x3c/0x178
[    4.459345]  arch_dma_alloc+0xd0/0x198
[    4.463051]  dma_direct_alloc+0x20/0x28
[    4.466843]  __swiotlb_alloc+0x3c/0x178
[    4.470635]  arch_dma_alloc+0xd0/0x198
[    4.474341]  dma_direct_alloc+0x20/0x28
[    4.478134]  __swiotlb_alloc+0x3c/0x178
[    4.481926]  arch_dma_alloc+0xd0/0x198
[    4.485632]  dma_direct_alloc+0x20/0x28
[    4.489424]  __swiotlb_alloc+0x3c/0x178
[    4.493216]  arch_dma_alloc+0xd0/0x198
[    4.496922]  dma_direct_alloc+0x20/0x28
[    4.500714]  __swiotlb_alloc+0x3c/0x178
[    4.504506]  arch_dma_alloc+0xd0/0x198
[    4.508212]  dma_direct_alloc+0x20/0x28
[    4.512004]  __swiotlb_alloc+0x3c/0x178
[    4.515797]  arch_dma_alloc+0xd0/0x198
[    4.519502]  dma_direct_alloc+0x20/0x28
[    4.523295]  __swiotlb_alloc+0x3c/0x178
[    4.527087]  arch_dma_alloc+0xd0/0x198
[    4.530793]  dma_direct_alloc+0x20/0x28
[    4.534585]  __swiotlb_alloc+0x3c/0x178
[    4.538378]  arch_dma_alloc+0xd0/0x198
[    4.542083]  dma_direct_alloc+0x20/0x28
[    4.545876]  __swiotlb_alloc+0x3c/0x178
[    4.549668]  arch_dma_alloc+0xd0/0x198
[    4.553374]  dma_direct_alloc+0x20/0x28
[    4.557166]  __swiotlb_alloc+0x3c/0x178
[    4.560958]  arch_dma_alloc+0xd0/0x198
[    4.564664]  dma_direct_alloc+0x20/0x28
[    4.568456]  __swiotlb_alloc+0x3c/0x178
[    4.572248]  arch_dma_alloc+0xd0/0x198
[    4.575954]  dma_direct_alloc+0x20/0x28
[    4.579747]  __swiotlb_alloc+0x3c/0x178
[    4.583539]  arch_dma_alloc+0xd0/0x198
[    4.587245]  dma_direct_alloc+0x20/0x28
[    4.591037]  __swiotlb_alloc+0x3c/0x178
[    4.594829]  arch_dma_alloc+0xd0/0x198
[    4.598535]  dma_direct_alloc+0x20/0x28
[    4.602327]  __swiotlb_alloc+0x3c/0x178
[    4.606120]  arch_dma_alloc+0xd0/0x198
[    4.609826]  dma_direct_alloc+0x20/0x28
[    4.613618]  __swiotlb_alloc+0x3c/0x178
[    4.617410]  arch_dma_alloc+0xd0/0x198
[    4.621116]  dma_direct_alloc+0x20/0x28
[    4.624908]  __swiotlb_alloc+0x3c/0x178
[    4.628701]  arch_dma_alloc+0xd0/0x198
[    4.632407]  dma_direct_alloc+0x20/0x28
[    4.636199]  __swiotlb_alloc+0x3c/0x178
[    4.639991]  arch_dma_alloc+0xd0/0x198
[    4.643697]  dma_direct_alloc+0x20/0x28
[    4.647490]  __swiotlb_alloc+0x3c/0x178
[    4.651282]  arch_dma_alloc+0xd0/0x198
[    4.654988]  dma_direct_alloc+0x20/0x28
[    4.658780]  __swiotlb_alloc+0x3c/0x178
[    4.662572]  arch_dma_alloc+0xd0/0x198
[    4.666278]  dma_direct_alloc+0x20/0x28
[    4.670070]  __swiotlb_alloc+0x3c/0x178
[    4.673862]  arch_dma_alloc+0xd0/0x198
[    4.677568]  dma_direct_alloc+0x20/0x28
[    4.681361]  __swiotlb_alloc+0x3c/0x178
[    4.685153]  arch_dma_alloc+0xd0/0x198
[    4.688859]  dma_direct_alloc+0x20/0x28
[    4.692651]  __swiotlb_alloc+0x3c/0x178
[    4.696443]  arch_dma_alloc+0xd0/0x198
[    4.700148]  dma_direct_alloc+0x20/0x28
[    4.703941]  __swiotlb_alloc+0x3c/0x178
[    4.707733]  arch_dma_alloc+0xd0/0x198
[    4.711439]  dma_direct_alloc+0x20/0x28
[    4.715231]  __swiotlb_alloc+0x3c/0x178
[    4.719023]  arch_dma_alloc+0xd0/0x198
[    4.722729]  dma_direct_alloc+0x20/0x28
[    4.726522]  __swiotlb_alloc+0x3c/0x178
[    4.730313]  arch_dma_alloc+0xd0/0x198
[    4.734019]  dma_direct_alloc+0x20/0x28
[    4.737811]  __swiotlb_alloc+0x3c/0x178
[    4.741604]  arch_dma_alloc+0xd0/0x198
[    4.745310]  dma_direct_alloc+0x20/0x28
[    4.749102]  __swiotlb_alloc+0x3c/0x178
[    4.752894]  arch_dma_alloc+0xd0/0x198
[    4.756600]  dma_direct_alloc+0x20/0x28
[    4.760393]  __swiotlb_alloc+0x3c/0x178
[    4.764185]  arch_dma_alloc+0xd0/0x198
[    4.767891]  dma_direct_alloc+0x20/0x28
[    4.771683]  __swiotlb_alloc+0x3c/0x178
[    4.775475]  arch_dma_alloc+0xd0/0x198
[    4.779181]  dma_direct_alloc+0x20/0x28
[    4.782973]  __swiotlb_alloc+0x3c/0x178
[    4.786765]  arch_dma_alloc+0xd0/0x198
[    4.790471]  dma_direct_alloc+0x20/0x28
[    4.794263]  __swiotlb_alloc+0x3c/0x178
[    4.798055]  arch_dma_alloc+0xd0/0x198
[    4.801761]  dma_direct_alloc+0x20/0x28
[    4.805553]  __swiotlb_alloc+0x3c/0x178
[    4.809345]  arch_dma_alloc+0xd0/0x198
[    4.813051]  dma_direct_alloc+0x20/0x28
[    4.816844]  __swiotlb_alloc+0x3c/0x178
[    4.820636]  arch_dma_alloc+0xd0/0x198
[    4.824342]  dma_direct_alloc+0x20/0x28
[    4.828134]  __swiotlb_alloc+0x3c/0x178
[    4.831926]  arch_dma_alloc+0xd0/0x198
[    4.835632]  dma_direct_alloc+0x20/0x28
[    4.839425]  __swiotlb_alloc+0x3c/0x178
[    4.843217]  arch_dma_alloc+0xd0/0x198
[    4.846923]  dma_direct_alloc+0x20/0x28
[    4.850715]  __swiotlb_alloc+0x3c/0x178
[    4.854507]  arch_dma_alloc+0xd0/0x198
[    4.858212]  dma_direct_alloc+0x20/0x28
[    4.862005]  __swiotlb_alloc+0x3c/0x178
[    4.865797]  arch_dma_alloc+0xd0/0x198
[    4.869503]  dma_direct_alloc+0x20/0x28
[    4.873295]  __swiotlb_alloc+0x3c/0x178
[    4.877087]  arch_dma_alloc+0xd0/0x198
[    4.880793]  dma_direct_alloc+0x20/0x28
[    4.884586]  __swiotlb_alloc+0x3c/0x178
[    4.888377]  arch_dma_alloc+0xd0/0x198
[    4.892083]  dma_direct_alloc+0x20/0x28
[    4.895875]  __swiotlb_alloc+0x3c/0x178
[    4.899667]  arch_dma_alloc+0xd0/0x198
[    4.903373]  dma_direct_alloc+0x20/0x28
[    4.907165]  __swiotlb_alloc+0x3c/0x178
[    4.910957]  arch_dma_alloc+0xd0/0x198
[    4.914663]  dma_direct_alloc+0x20/0x28
[    4.918455]  __swiotlb_alloc+0x3c/0x178
[    4.922247]  arch_dma_alloc+0xd0/0x198
[    4.925953]  dma_direct_alloc+0x20/0x28
[    4.929746]  __swiotlb_alloc+0x3c/0x178
[    4.933538]  arch_dma_alloc+0xd0/0x198
[    4.937244]  dma_direct_alloc+0x20/0x28
[    4.941036]  __swiotlb_alloc+0x3c/0x178
[    4.944828]  arch_dma_alloc+0xd0/0x198
[    4.948534]  dma_direct_alloc+0x20/0x28
[    4.952327]  __swiotlb_alloc+0x3c/0x178
[    4.956119]  arch_dma_alloc+0xd0/0x198
[    4.959825]  dma_direct_alloc+0x20/0x28
[    4.963617]  __swiotlb_alloc+0x3c/0x178
[    4.967409]  arch_dma_alloc+0xd0/0x198
[    4.971115]  dma_direct_alloc+0x20/0x28
[    4.974907]  __swiotlb_alloc+0x3c/0x178
[    4.978699]  arch_dma_alloc+0xd0/0x198
[    4.982405]  dma_direct_alloc+0x20/0x28
[    4.986197]  __swiotlb_alloc+0x3c/0x178
[    4.989990]  arch_dma_alloc+0xd0/0x198
[    4.993695]  dma_direct_alloc+0x20/0x28
[    4.997488]  __swiotlb_alloc+0x3c/0x178
[    5.001280]  arch_dma_alloc+0xd0/0x198
[    5.004986]  dma_direct_alloc+0x20/0x28
[    5.008778]  __swiotlb_alloc+0x3c/0x178
[    5.012570]  arch_dma_alloc+0xd0/0x198
[    5.016276]  dma_direct_alloc+0x20/0x28
[    5.020069]  __swiotlb_alloc+0x3c/0x178
[    5.023861]  arch_dma_alloc+0xd0/0x198
[    5.027567]  dma_direct_alloc+0x20/0x28
[    5.031359]  __swiotlb_alloc+0x3c/0x178
[    5.035151]  arch_dma_alloc+0xd0/0x198
[    5.038857]  dma_direct_alloc+0x20/0x28
[    5.042650]  __swiotlb_alloc+0x3c/0x178
[    5.046442]  arch_dma_alloc+0xd0/0x198
[    5.050148]  dma_direct_alloc+0x20/0x28
[    5.053940]  __swiotlb_alloc+0x3c/0x178
[    5.057732]  arch_dma_alloc+0xd0/0x198
[    5.061438]  dma_direct_alloc+0x20/0x28
[    5.065230]  __swiotlb_alloc+0x3c/0x178
[    5.069023]  arch_dma_alloc+0xd0/0x198
[    5.072728]  dma_direct_alloc+0x20/0x28
[    5.076521]  __swiotlb_alloc+0x3c/0x178
[    5.080313]  arch_dma_alloc+0xd0/0x198
[    5.084019]  dma_direct_alloc+0x20/0x28
[    5.087811]  __swiotlb_alloc+0x3c/0x178
[    5.091604]  arch_dma_alloc+0xd0/0x198
[    5.095309]  dma_direct_alloc+0x20/0x28
[    5.099102]  __swiotlb_alloc+0x3c/0x178
[    5.102894]  arch_dma_alloc+0xd0/0x198
[    5.106600]  dma_direct_alloc+0x20/0x28
[    5.110392]  __swiotlb_alloc+0x3c/0x178
[    5.114184]  arch_dma_alloc+0xd0/0x198
[    5.117890]  dma_direct_alloc+0x20/0x28
[    5.121682]  __swiotlb_alloc+0x3c/0x178
[    5.125474]  arch_dma_alloc+0xd0/0x198
[    5.129180]  dma_direct_alloc+0x20/0x28
[    5.132973]  __swiotlb_alloc+0x3c/0x178
[    5.136765]  arch_dma_alloc+0xd0/0x198
[    5.140470]  dma_direct_alloc+0x20/0x28
[    5.144262]  __swiotlb_alloc+0x3c/0x178
[    5.148054]  arch_dma_alloc+0xd0/0x198
[    5.151760]  dma_direct_alloc+0x20/0x28
[    5.155552]  __swiotlb_alloc+0x3c/0x178
[    5.159345]  arch_dma_alloc+0xd0/0x198
[    5.163050]  dma_direct_alloc+0x20/0x28
[    5.166843]  __swiotlb_alloc+0x3c/0x178
[    5.170635]  arch_dma_alloc+0xd0/0x198
[    5.174341]  dma_direct_alloc+0x20/0x28
[    5.178133]  __swiotlb_alloc+0x3c/0x178
[    5.181925]  arch_dma_alloc+0xd0/0x198
[    5.185631]  dma_direct_alloc+0x20/0x28
[    5.189423]  __swiotlb_alloc+0x3c/0x178
[    5.193215]  arch_dma_alloc+0xd0/0x198
[    5.196921]  dma_direct_alloc+0x20/0x28
[    5.200714]  __swiotlb_alloc+0x3c/0x178
[    5.204506]  arch_dma_alloc+0xd0/0x198
[    5.208212]  swiotlb_alloc+0x20/0x28
[    5.211748]  pl330_probe+0x344/0xaf0
[    5.215283]  amba_probe+0xe8/0x1b8
[    5.218646]  really_probe+0xdc/0x3d0
[    5.222181]  driver_probe_device+0x5c/0x148
[    5.226318]  __device_attach_driver+0xa8/0x160
[    5.230712]  bus_for_each_drv+0x64/0xc8
[    5.234505]  __device_attach+0xd8/0x158
[    5.238298]  device_initial_probe+0x10/0x18
[    5.242434]  bus_probe_device+0x90/0x98
[    5.246227]  deferred_probe_work_func+0x88/0xe0
[    5.250708]  process_one_work+0x1e0/0x330
[    5.254673]  worker_thread+0x238/0x460
[    5.258380]  kthread+0x128/0x130
[    5.261571]  ret_from_fork+0x10/0x1c
[    5.265109] SMP: stopping secondary CPUs
[    5.268990] Kernel Offset: disabled
[    5.272438] CPU features: 0x0,25806004
[    5.276143] Memory Limit: none
[    5.279168] ---[ end Kernel panic - not syncing: kernel stack 
overflow ]---
