Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id W4yhMmwfHltcRwAAmS7hNA
	; Mon, 11 Jun 2018 07:07:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 40F8F60791; Mon, 11 Jun 2018 07:07:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CDF3D601D2;
	Mon, 11 Jun 2018 07:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDF3D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeFKHHH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:07:07 -0400
Received: from verein.lst.de ([213.95.11.211]:57467 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753998AbeFKHHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:07:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 23B2968CEE; Mon, 11 Jun 2018 09:15:01 +0200 (CEST)
Date: Mon, 11 Jun 2018 09:15:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gabriel C <nix.or.die@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>,
        alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics
        performance regression in 4.15 and later )
Message-ID: <20180611071501.GA1015@lst.de>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com> <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com> <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net> <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com> <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com> <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com> <20180608060223.GB24107@lst.de> <1c8b3938-6656-5d5a-f65d-dfd2e55d989e@amd.com> <CAEJqkggkZynDvV8XxkFfy89x-DX5xDTyubUJ3oXBO6eUjBWBKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkggkZynDvV8XxkFfy89x-DX5xDTyubUJ3oXBO6eUjBWBKw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the prime issue is that dma_direct_alloc respects the dma
mask.  Which we don't need if actually using the iommu.  This would
be mostly harmless exept for the the SEV bit high in the address that
makes the checks fail.

For now I'd say revert this commit for 4.17/4.18-rc and I'll look into
addressing these issues properly.
