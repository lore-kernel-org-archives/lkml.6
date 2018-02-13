Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934966AbeBML5X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:57:23 -0500
Received: from foss.arm.com ([217.140.101.70]:55876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934733AbeBML5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:57:22 -0500
Date: Tue, 13 Feb 2018 11:57:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, timur@codeaurora.org,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>, rrichter@cavium.com,
        tchalamarla@cavium.com, opendmb@gmail.com
Subject: Re: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
Message-ID: <20180213115717.4ubsnjraacorwbgk@armageddon.cambridge.arm.com>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 03:45:23PM -0800, Florian Fainelli wrote:
> On many platforms, including, but not limited to Brahma-B53 platforms,
> the L1 cache line size is 64bytes. Increasing the value to 128bytes
> appears to be creating performance problems for workloads involving
> network drivers and lots of data movement. In order to keep what was
> introduced with 97303480753e ("arm64: Increase the max granular size"),
> a kernel built for ARCH_THUNDER or ARCH_THUNDER2 will get a 128bytes
> cache line size definition.

This approach has been raised before ([1] as an example but you can
probably find other threads) and NAK'ed. I really don't want this macro
to be configurable as we aim for a single kernel Image.

My proposal was to move L1_CACHE_SHIFT back to 6 and ARCH_DMA_MIN_ALIGN
to 128 as this is the largest known CWG. The networking code is wrong in
assuming SKB_DATA_ALIGN only needs SMP_CACHE_BYTES for DMA alignment but
we can add some safety checks (i.e. WARN_ON) in the arch dma ops code if
the device is non-coherent.

I'll send a patch to the list (hopefully later today).

Catalin

[1] https://patchwork.kernel.org/patch/8634481/
