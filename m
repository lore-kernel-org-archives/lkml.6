Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C83C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D2B20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D2B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeIKOP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:15:28 -0400
Received: from verein.lst.de ([213.95.11.211]:41809 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeIKOP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:15:27 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8504C68C8A; Tue, 11 Sep 2018 11:21:26 +0200 (CEST)
Date:   Tue, 11 Sep 2018 11:21:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     Ming Lei <ming.lei@redhat.com>, tglx@linutronix.de, hch@lst.de,
        linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: Affinity managed interrupts vs non-managed interrupts
Message-ID: <20180911092126.GA10330@lst.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:16:23PM +0530, Sumit Saxena wrote:
> > Could you explain a bit what the specific use case the extra 16 vectors
> is?
> We are trying to avoid the penalty due to one interrupt per IO completion
> and decided to coalesce interrupts on these extra 16 reply queues.
> For regular 72 reply queues, we will not coalesce interrupts as for low IO
> workload, interrupt coalescing may take more time due to less IO
> completions.
> In IO submission path, driver will decide which set of reply queues
> (either extra 16 reply queues or regular 72 reply queues) to be picked
> based on IO workload.

The point I don't get here is why you need separate reply queues for
the interrupt coalesce setting.  Shouldn't this just be a flag at
submission time that indicates the amount of coalescing that should
happen?

What is the benefit of having different completion queues?
