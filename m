Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEF9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5274920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5274920664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJaCUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:20:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeJaCUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:20:16 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHXm1-0003bD-0P; Tue, 30 Oct 2018 18:25:49 +0100
Date:   Tue, 30 Oct 2018 18:25:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
In-Reply-To: <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
Message-ID: <alpine.DEB.2.21.1810301824570.5984@nanos.tec.linutronix.de>
References: <20181029163738.10172-1-axboe@kernel.dk> <20181029163738.10172-12-axboe@kernel.dk> <20181030142601.GA18906@localhost.localdomain> <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk> <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk> <20181030150840.GC18906@localhost.localdomain> <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk> <20181030160242.GD18906@localhost.localdomain> <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

On Tue, 30 Oct 2018, Jens Axboe wrote:
> On 10/30/18 10:02 AM, Keith Busch wrote:
> > pci_alloc_irq_vectors_affinity() starts at the provided max_vecs. If
> > that doesn't work, it will iterate down to min_vecs without returning to
> > the caller. The caller doesn't have a chance to adjust its sets between
> > iterations when you provide a range.
> > 
> > The 'masks' overrun problem happens if the caller provides min_vecs
> > as a smaller value than the sum of the set (plus any reserved).
> > 
> > If it's up to the caller to ensure that doesn't happen, then min and
> > max must both be the same value, and that value must also be the same as
> > the set sum + reserved vectors. The range just becomes redundant since
> > it is already bounded by the set.
> > 
> > Using the nvme example, it would need something like this to prevent the
> > 'masks' overrun:
> 
> OK, now I hear what you are saying. And you are right, the callers needs
> to provide minvec == maxvec for sets, and then have a loop around that
> to adjust as needed.

But then we should enforce it in the core code, right?

Thanks,

	tglx
