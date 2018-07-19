Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6DDECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDE820684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDE820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeGSPTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:19:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731471AbeGSPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:19:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E958AD61;
        Thu, 19 Jul 2018 14:35:35 +0000 (UTC)
Date:   Thu, 19 Jul 2018 16:35:34 +0200
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
Message-ID: <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180719142355.GA18800@lst.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 04:23:55PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 19, 2018 at 04:10:25PM +0200, Johannes Thumshirn wrote:
> > The problem I'm trying to solve here is really just single commands
> > timing out because of i.e. a bad switch in between which causes frame
> > loss somewhere.
> 
> And that is exactly the case where NVMe abort does not actually work
> in any sensible way.
> 
> Remember that while NVMe guarantes ordered delivery inside a given
> queue it does not guarantee anything between multiple queues.
> 
> So now you have your buggy FC setup where an I/O command times out
> because your switch delayed it for two hours due to a firmware bug.
> 
> After 30 seconds we send an abort over the admin queue, which happens
> to pass through just fine.  The controller will tell you: no command
> found as it has never seen it.
> 
> No with the the code following what we have in PCIe that just means
> we'll eventually controller reset after the I/O command times out
> the second time as we still won't have seen a completion for it.

Exactly that was my intention.

> If you incorrectly just continue and resend the command we'll actually
> get the command sent twice and thus a potential bug once the original
> command just gets sent along.

OK, let me see where I'm stuck here. We're issuing a command, it gets
lost due to $REASON and I'm aborting it. The upper layers then
eventually retry the command and it arrives at the target side. But so
does the old command as well and we have a duplicate. Correct?

So if we keep our old behavior and tear down the queues and
re-establish them, then the upper layers retry the command and it
arrives on the target. But shortly afterwards the switch happens to
find the old command in it's ingress buffers and decides to forward it
to the target as well, how does that differ? The CMDID and SQID are
probably different but all the payload will be the same, wouldn't it?

So we still have our duplicate on the other side, don't we?

I feel I'm missing out something here.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
