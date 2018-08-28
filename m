Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499DEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C95B20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C95B20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeH1Vcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:32:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Vcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1BDD15BF;
        Tue, 28 Aug 2018 10:40:00 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 735613F5BD;
        Tue, 28 Aug 2018 10:40:00 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0B65D1AE3413; Tue, 28 Aug 2018 18:40:12 +0100 (BST)
Date:   Tue, 28 Aug 2018 18:40:12 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com,
        ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add NUMA emulation support
Message-ID: <20180828174011.GE20375@arm.com>
References: <20180824230559.32336-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824230559.32336-1-shuah@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 05:05:59PM -0600, Shuah Khan (Samsung OSG) wrote:
> Add NUMA emulation support to emulate NUMA on non-NUMA platforms. A new
> CONFIG_NUMA_EMU option enables NUMA emulation and a new kernel command
> line option "numa=fake=N" allows users to specify the configuration for
> emulation.
> 
> When NUMA emulation is enabled, a flat (non-NUMA) machine will be split
> into virtual NUMA nodes when booted with "numa=fake=N", where N is the
> number of nodes, the system RAM will be split into N equal chunks and
> assigned to each node.
> 
> Emulated nodes are bounded by MAX_NUMNODES and the number of memory block
> count to avoid splitting memory blocks across NUMA nodes.
> 
> If NUMA emulation init fails, it will fall back to dummy NUMA init.
> 
> This is tested on Raspberry Pi3b+ with ltp NUMA test suite, numactl, and
> numastat tools. In addition, tested in conjunction with cpuset cgroup to
> verify cpuset.cpus and cpuset.mems assignments.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  arch/arm64/Kconfig            |   9 +++
>  arch/arm64/include/asm/numa.h |   8 +++
>  arch/arm64/mm/Makefile        |   1 +
>  arch/arm64/mm/numa.c          |   4 ++
>  arch/arm64/mm/numa_emu.c      | 109 ++++++++++++++++++++++++++++++++++
>  5 files changed, 131 insertions(+)
>  create mode 100644 arch/arm64/mm/numa_emu.c

Hmm, is this just for debugging and kernel development? If so, it's quite a
lot of code just for that. Can't you achieve the same thing by faking up the
firmware tables?

Will
