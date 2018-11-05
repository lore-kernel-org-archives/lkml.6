Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80B3C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09A620685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09A620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeKELfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:35:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKELfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:35:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 220B680E7B;
        Mon,  5 Nov 2018 02:18:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05E8B10018FF;
        Mon,  5 Nov 2018 02:18:12 +0000 (UTC)
Date:   Mon, 5 Nov 2018 10:18:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Long Li <longli@linuxonhyperv.com>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
Message-ID: <20181105021807.GC13699@ming.t460p>
References: <20181102145951.31979-1-ming.lei@redhat.com>
 <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
 <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 05 Nov 2018 02:18:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 01:02:18PM +0100, Thomas Gleixner wrote:
> Jens,
> 
> On Sat, 3 Nov 2018, Jens Axboe wrote:
> 
> > On 11/2/18 8:59 AM, Ming Lei wrote:
> > > Hi Jens,
> > > 
> > > As I mentioned, there are at least two issues in the patch of '
> > > irq: add support for allocating (and affinitizing) sets of IRQs':
> > > 
> > > 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
> > > 
> > > 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
> > > 
> > > The fix isn't trivial, and I introduce two extra patches as preparation,
> > > then the implementation can be more clean.
> > > 
> > > The patchset is against mq-maps branch of block tree, feel free to
> > > integrate into the whole patchset of multiple queue maps.
> > 
> > Thanks Ming, I ran this through my testing, and I end up with the
> > same maps and affinities for all the cases I cared about. I'm going
> > to drop my initial version, and add the three.
> 
> So I assume, that I can pick up Mings series instead.
> 
> There is another patch pending affecting the irq affinity spreading. Can
> you folks please have a look at it?
> 
> https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com

This patch looks fine.

It ensures that all CPUs are covered in irq's affinity when required
vector number is <= nr_numa_nodes.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
