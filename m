Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED06BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8309206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfANQwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:52:44 -0500
Received: from foss.arm.com ([217.140.101.70]:37492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANQwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:52:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C8EA78;
        Mon, 14 Jan 2019 08:52:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C21A3F5BD;
        Mon, 14 Jan 2019 08:52:42 -0800 (PST)
Subject: Re: remove block layer bounce buffering for MMC
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190114095804.27978-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
Date:   Mon, 14 Jan 2019 16:52:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 09:57, Christoph Hellwig wrote:
> Hi everyone,
> 
> this series converts the remaining MMC host drivers to properly kmap the
> scatterlist entries it does PIO operations on, and then goes on to
> remove the usage of block layer bounce buffering (which I plan to remove
> eventually) from the MMC layer.
> 
> As a bonus I've converted various drivers to the proper scatterlist
> helpers so that at least in theory they are ready for chained
> scatterlists.
> 
> All the changes are compile tested only as I don't have any of the
> hardware, so a careful review would be appreciated.

One general point for the kmap() conversions - it's not obvious (to me 
at least) whether or how that would work for a segment where sg->length 
 > PAGE_SIZE. Or is there some cast-iron guarantee from the MMC 
mid-layer that it will never let the block layer generate such things in 
the first place?

Robin.
