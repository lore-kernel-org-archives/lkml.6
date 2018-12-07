Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E7D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E7D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGBVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:21:43 -0500
Received: from verein.lst.de ([213.95.11.211]:60695 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbeLGBVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:21:43 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1B6EB68AA6; Fri,  7 Dec 2018 02:21:42 +0100 (CET)
Date:   Fri, 7 Dec 2018 02:21:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, brouer@redhat.com,
        tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Message-ID: <20181207012141.GA4256@lst.de>
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com> <20181206184330.GB30039@lst.de> <173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com> <20181206200006.GA31548@lst.de> <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:24:38PM +0000, Robin Murphy wrote:
> On 06/12/2018 20:00, Christoph Hellwig wrote:
>> On Thu, Dec 06, 2018 at 06:54:17PM +0000, Robin Murphy wrote:
>>> I'm pretty sure we used to assign dummy_dma_ops explicitly to devices at
>>> the point we detected the ACPI properties are wrong - that shouldn't be too
>>> much of a headache to go back to.
>>
>> Ok.  I've cooked up a patch to use NULL as the go direct marker.
>> This cleans up a few things nicely, but also means we now need to
>> do the bypass scheme for all ops, not just the fast path.  But we
>> probably should just move the slow path ops out of line anyway,
>> so I'm not worried about it.  This has survived some very basic
>> testing on x86, and really needs to be cleaned up and split into
>> multiple patches..
>
> I've also just finished hacking something up to keep the arm64 status quo - 
> I'll need to actually test it tomorrow, but the overall diff looks like the 
> below.

Nice.  I created a branch that picked up your bits and also the ideas
from Linus, and the result looks reall nice.  I'll still need a signoff
for your bits, though.

Jesper, can you give this a spin if it changes the number even further?

  git://git.infradead.org/users/hch/misc.git dma-direct-calls.2

  http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2
