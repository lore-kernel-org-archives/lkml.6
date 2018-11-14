Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7995FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442472175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442472175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbeKNL3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 06:29:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeKNL3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 06:29:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B18FA89AF4;
        Wed, 14 Nov 2018 01:28:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F41A5D6A6;
        Wed, 14 Nov 2018 01:28:11 +0000 (UTC)
Date:   Tue, 13 Nov 2018 20:28:10 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: nvme: utilize two queue maps, one for reads and one for writes
Message-ID: <20181114012810.GA14592@redhat.com>
References: <20181114004148.GA29545@roeck-us.net>
 <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 14 Nov 2018 01:28:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13 2018 at  7:51pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 11/13/18 5:41 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > On Wed, Oct 31, 2018 at 08:36:31AM -0600, Jens Axboe wrote:
> >> NVMe does round-robin between queues by default, which means that
> >> sharing a queue map for both reads and writes can be problematic
> >> in terms of read servicing. It's much easier to flood the queue
> >> with writes and reduce the read servicing.
> >>
> >> Implement two queue maps, one for reads and one for writes. The
> >> write queue count is configurable through the 'write_queues'
> >> parameter.
> >>
> >> By default, we retain the previous behavior of having a single
> >> queue set, shared between reads and writes. Setting 'write_queues'
> >> to a non-zero value will create two queue sets, one for reads and
> >> one for writes, the latter using the configurable number of
> >> queues (hardware queue counts permitting).
> >>
> >> Reviewed-by: Hannes Reinecke <hare@suse.com>
> >> Reviewed-by: Keith Busch <keith.busch@intel.com>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > This patch causes hangs when running recent versions of
> > -next with several architectures; see the -next column at
> > kerneltests.org/builders for details.  Bisect log below; this
> > was run with qemu on alpha. Reverting this patch as well as
> > "nvme: add separate poll queue map" fixes the problem.
> 
> I don't see anything related to what hung, the trace, and so on.
> Can you clue me in? Where are the test results with dmesg?
> 
> How to reproduce?

Think Guenter should've provided a full kerneltests.org url, but I had a
look and found this for powerpc with -next:
https://kerneltests.org/builders/next-powerpc-next/builds/998/steps/buildcommand/logs/stdio

Has useful logs of the build failure due to block.

(not seeing any -next failure for alpha but Guenter said he was using
qemu so the build failure could've been any arch qemu supports)

Mike
