Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC4020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbeGSOxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:34340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbeGSOxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:53:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C17CAF63;
        Thu, 19 Jul 2018 14:10:26 +0000 (UTC)
Date:   Thu, 19 Jul 2018 16:10:25 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Rework NVMe abort handling
Message-ID: <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180719134203.GA15212@lst.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:42:03PM +0200, Christoph Hellwig wrote:
> Without even looking at the code yet:  why?  The nvme abort isn't
> very useful, and due to the lack of ordering between different
> queues almost harmful on fabrics.  What problem do you try to
> solve?

The problem I'm trying to solve here is really just single commands
timing out because of i.e. a bad switch in between which causes frame
loss somewhere.

I know RDMA and FC are defined to be lossless but reality sometimes
has a different view on this (can't talk too much for RDMA but I've
had some nice bugs in SCSI due to faulty switches dropping odd
frames).

Of cause we can still do the big hammer if one command times out due
to a misbehaving switch but we can also at least try to abort it. I
know aborts are defined as best effort, but as we're in the error path
anyways it doesn't hurt to at least try.

This would give us a chance to recover from such situations, of cause
given the target actually does something when receiving an abort.

In the FC case we can even send an ABTS and try to abort the command
on the FC side first, before doing it on NVMe. I'm not sure if we can
do it on RDMA or PCIe as well.

So the issue I'm trying to solve is easy, if one command times out for
whatever reason, there's no need to go the big transport reset route
before not even trying to recover from it. Possibly we should also try
doing a queue reset if aborting failed before doing the transport
reset.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
