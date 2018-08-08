Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C193521772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C193521772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHHRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:21:19 -0400
Received: from foss.arm.com ([217.140.101.70]:40342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeHHRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:21:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6717D18A;
        Wed,  8 Aug 2018 08:01:16 -0700 (PDT)
Received: from e120077-lin.cambridge.arm.com (e120077-lin.cambridge.arm.com [10.2.207.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A8B3F5D4;
        Wed,  8 Aug 2018 08:01:13 -0700 (PDT)
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        libc-alpha@sourceware.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>, linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
From:   "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Openpgp: preference=signencrypt
Message-ID: <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com>
Date:   Wed, 8 Aug 2018 16:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/18 15:12, Mikulas Patocka wrote:
> 
> 
> On Wed, 8 Aug 2018, Catalin Marinas wrote:
> 
>> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
>>> 	while (1) {
>>> 		start = (unsigned)random() % (LEN + 1);
>>> 		end = (unsigned)random() % (LEN + 1);
>>> 		if (start > end)
>>> 			continue;
>>> 		for (i = start; i < end; i++)
>>> 			data[i] = val++;
>>> 		memcpy(map + start, data + start, end - start);
>>> 		if (memcmp(map, data, LEN)) {
>>
>> It may be worth trying to do a memcmp(map+start, data+start, end-start)
>> here to see whether the hazard logic fails when the writes are unaligned
>> but the reads are not.
>>
>> This problem may as well appear if you do byte writes and read longs
>> back (and I consider this a hardware problem on this specific board).
> 
> I triad to insert usleep(10000) between the memcpy and memcmp, but the 
> same corruption occurs. So, it can't be read-after-write hazard. It is 
> caused by the improper handling of hazard between the overlapping writes 
> inside memcpy.
> 
> Mikulas
> 

I don't think you've told us what form the corruption takes.  Does it
lose some bytes?  Modify values beyond the copy range?  Write completely
arbitrary values?

The overlapping writes in memcpy never write different values to the
same location, so I still feel this must be some sort of HW issue, not a
SW one.

R.
