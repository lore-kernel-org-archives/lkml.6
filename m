Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5742FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254DD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfA2PpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:45:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:49362 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2PpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:45:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="139790854"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2019 07:45:20 -0800
Date:   Tue, 29 Jan 2019 08:44:33 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
Message-ID: <20190129154433.GF15302@localhost.localdomain>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:25:48AM -0800, John Garry wrote:
> Hi,
> 
> I have a question on $subject which I hope you can shed some light on.
> 
> According to commit c5cb83bb337c25 ("genirq/cpuhotplug: Handle managed 
> IRQs on CPU hotplug"), if we offline the last CPU in a managed IRQ 
> affinity mask, the IRQ is shutdown.
> 
> The reasoning is that this IRQ is thought to be associated with a 
> specific queue on a MQ device, and the CPUs in the IRQ affinity mask are 
> the same CPUs associated with the queue. So, if no CPU is using the 
> queue, then no need for the IRQ.
> 
> However how does this handle scenario of last CPU in IRQ affinity mask 
> being offlined while IO associated with queue is still in flight?
> 
> Or if we make the decision to use queue associated with the current CPU, 
> and then that CPU (being the last CPU online in the queue's IRQ 
> afffinity mask) goes offline and we finish the delivery with another CPU?
> 
> In these cases, when the IO completes, it would not be serviced and timeout.
> 
> I have actually tried this on my arm64 system and I see IO timeouts.

Hm, we used to freeze the queues with CPUHP_BLK_MQ_PREPARE callback,
which would reap all outstanding commands before the CPU and IRQ are
taken offline. That was removed with commit 4b855ad37194f ("blk-mq:
Create hctx for each present CPU"). It sounds like we should bring
something like that back, but make more fine grain to the per-cpu context.
