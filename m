Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD28C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E62080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E62080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeKTAWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:22:36 -0500
Received: from verein.lst.de ([213.95.11.211]:38215 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbeKTAWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:22:36 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6584B68B02; Mon, 19 Nov 2018 14:58:52 +0100 (CET)
Date:   Mon, 19 Nov 2018 14:58:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arch: switch the default on ARCH_HAS_SG_CHAIN
Message-ID: <20181119135852.GA16428@lst.de>
References: <20181109090008.24150-3-hch@lst.de> <mhng-9c1955e1-d7cf-4ee4-8bf8-6bef720c9b98@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-9c1955e1-d7cf-4ee4-8bf8-6bef720c9b98@palmer-si-x1c4>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:52:14AM -0800, Palmer Dabbelt wrote:
> As far as I can tell, it looks like m68k, mips, and powerpc mention an 
> IOMMU in their ports, don't set ARCH_HAS_SG_CHAIN, and with this patch set 
> won't set ARCH_NO_SG_CHAIN.

m68k has no iommu, and not operations that operate on a scatterlist.

mips has a trivial iommu driver (jazzdma), but I wrote the current
instance of it, nad it is fine.

powerpc has various iommu, but actually enables ARCH_HAS_SG_CHAIN
unconditionally.

> The issue is that I'm not sure how to 
> determine what constitutes a horrible legacy IOMMU, at least with respect 
> to not being able to use scatterlist chaining.

It basically means someone is iterating using manual pointer arithmetics
over a multi-element scatterlist instead of using the sg_next and
for_each_sg helpers.
