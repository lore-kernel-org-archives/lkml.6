Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D539C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8AB208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8AB208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbeG0Rld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:41:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbeG0Rld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:41:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16586ED1;
        Fri, 27 Jul 2018 09:18:57 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CB8A3F6A8;
        Fri, 27 Jul 2018 09:18:55 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com>
 <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com>
 <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
 <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
 <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com>
 <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <642cefaf-9ce7-bf0f-e6b6-e2e520e2427b@arm.com>
Date:   Fri, 27 Jul 2018 17:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/18 13:56, Ganapatrao Kulkarni wrote:
[...]
>>> did you get any chance to look in to this issue?
>>> i am waiting for your suggestion/patch for this issue!
>>
>>
>> I got as far as [1], but I wasn't sure how much I liked it, since it still
>> seems a little invasive for such a specific case (plus I can't remember if
>> it's actually been debugged or not). I think in the end I started wondering
>> whether it's even worth bothering with the 32-bit optimisation for PCIe
>> devices - 4 extra bytes worth of TLP is surely a lot less significant than
>> every transaction taking up to 50% more bus cycles was for legacy PCI.
> 
> how about tracking previous attempt to get 32bit range iova and avoid
> further attempts, if it was failed. Later Resume attempts once
> replenish happens.
> Created patch for the same [2]

Ooh, that's a much neater implementation of essentially the same concept 
- now why couldn't I think of that? :)

Looks like it should be possible to make it entirely self-contained too, 
since alloc_iova() is in a position to both test and update the flag 
based on the limit_pfn passed in.

Robin.

> 
> [2] https://github.com/gpkulkarni/linux/commit/e2343a3e1f55cdeb5694103dd354bcb881dc65c3
> note, the testing of this patch is in progress.
> 
>>
>> Robin.
>>
>> [1]
>> http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a8e0e4af10ebebb3669750e05bf0028e5bd6afe8
> 
> thanks
> Ganapat
> 
