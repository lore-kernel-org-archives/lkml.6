Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206EF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfA2RVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:21:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:19859 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfA2RVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:21:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 09:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="129872084"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 29 Jan 2019 09:21:47 -0800
Date:   Tue, 29 Jan 2019 10:20:59 -0700
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
Message-ID: <20190129172059.GC17132@localhost.localdomain>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
 <20190129154433.GF15302@localhost.localdomain>
 <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:12:40PM +0000, John Garry wrote:
> On 29/01/2019 15:44, Keith Busch wrote:
> > 
> > Hm, we used to freeze the queues with CPUHP_BLK_MQ_PREPARE callback,
> > which would reap all outstanding commands before the CPU and IRQ are
> > taken offline. That was removed with commit 4b855ad37194f ("blk-mq:
> > Create hctx for each present CPU"). It sounds like we should bring
> > something like that back, but make more fine grain to the per-cpu context.
> > 
> 
> Seems reasonable. But we would need it to deal with drivers where they only
> expose a single queue to BLK MQ, but use many queues internally. I think
> megaraid sas does this, for example.
> 
> I would also be slightly concerned with commands being issued from the
> driver unknown to blk mq, like SCSI TMF.

I don't think either of those descriptions sound like good candidates
for using managed IRQ affinities.
