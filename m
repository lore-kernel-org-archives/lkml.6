Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BDBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DD92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DD92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeJaXWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:22:30 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:60582 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbeJaXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:22:30 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991025AbeJaOYNSQVxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:24:13 +0100
Date:   Wed, 31 Oct 2018 14:24:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
In-Reply-To: <20180914095808.22202-5-hch@lst.de>
Message-ID: <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, 14 Sep 2018, Christoph Hellwig wrote:

> All the cache maintainance is already stubbed out when not enabled,
> but merging the two allows us to nicely handle the case where
> cache maintainance is required for some devices, but not others.

 FYI, you commit bc3ec75de545 ("dma-mapping: merge direct and noncoherent 
ops") has caused:

fddi0: DMA command request failed!
fddi0: Adapter open failed!

with the `defxx' driver on my R4400SC TURBOchannel DECstation (but not the 
R3400 one) and consequently the interface does not work anymore.  Both are 
non-coherent cache systems, however the R3400 implements the write-through 
policy while the policy of the R4400SC is write-back (it also has 1MiB of 
secondary cache), which I suspect is the reason of the difference.

 I'll be experimenting with this commit to figure out what the real cause 
is, but it'll take a while as my resources are limited, so I'm sending 
this early heads-up in case you or someone else has an idea what might be 
going wrong here.

  Maciej
