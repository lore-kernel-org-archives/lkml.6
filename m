Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7FE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7FE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeLCRd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:33:29 -0500
Received: from verein.lst.de ([213.95.11.211]:38579 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeLCRd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:33:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 50D8268AFE; Mon,  3 Dec 2018 18:33:22 +0100 (CET)
Date:   Mon, 3 Dec 2018 18:33:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, Qian Cai <cai@gmx.us>,
        netdev@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Message-ID: <20181203173322.GB8282@lst.de>
References: <20181130175449.2625-1-cai@gmx.us> <b22d2ad6-2638-96d7-1df2-24701589202f@arm.com> <20181201163657.GA19557@lst.de> <53ab96d7-5dc9-e1a9-4cf2-bb8bf80a3acf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ab96d7-5dc9-e1a9-4cf2-bb8bf80a3acf@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:56:11AM +0000, John Garry wrote:
> On 01/12/2018 16:36, Christoph Hellwig wrote:
>> On Fri, Nov 30, 2018 at 07:39:50PM +0000, Robin Murphy wrote:
>>> I was assuming the point was to also add something like
>>>
>>> 	default 131072 if HNS_ENET
>>>
>>> so that DMA debug doesn't require too much thought from the user. If they
>>> still have to notice the overflow message and empirically figure out a
>>> value that does work, rebuilding the kernel each time is far less
>>> convenient than simply adding "dma_debug_entries=..." to their kernel
>>> command line and rebooting, which they can do today. If they do already
>>> know up-front that the default will need overriding and what the
>>> appropriate value is, then the command line still seems seems just as
>>> convenient.
>>
>> I'm not so fond of random drivers changing the defaults.  My idea
>> was rather to have the config option so that the defconfig files for
>> the Hisilicon SOCs with this hardware could select a larger number
>> without making a total mess of the kernel configuration.
>>
>> If we really have to we could do different defaults, but I'd still
>> much rather do this on a arch/platform basis than specific drivers.
>
> As I understand, some drivers could even use much more than this (131072), 
> to such a point where I can't imagine that we would want to set an arch 
> default to support them. For this HNS_ENET case, it is arm64 specific so it 
> would be an arch defconfig.

But I'm not sure we could always do the right thing for everyone.

I think we might be better of trying to just dynamically allocate
entries when we run out of them instead of coming up with a perfect
number.
