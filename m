Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5304DC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E0216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E0216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHCFJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:09:23 -0400
Received: from foss.arm.com ([217.140.101.70]:37120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeHCFJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:09:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987D218A;
        Thu,  2 Aug 2018 20:15:12 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC003F5BA;
        Thu,  2 Aug 2018 20:15:11 -0700 (PDT)
Subject: Re: [RFC 0/2] harden alloc_pages against bogus nid
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801145020.8c76a490c1bf9bef5f87078a@linux-foundation.org>
 <d9f8e9d1-2fb8-6016-5081-7e3213b23ed4@arm.com>
 <20180801171414.30e54a106733ccaaa566388d@linux-foundation.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <a38071b1-6068-c5ca-d408-736bdb8e7073@arm.com>
Date:   Thu, 2 Aug 2018 22:15:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180801171414.30e54a106733ccaaa566388d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/01/2018 07:14 PM, Andrew Morton wrote:
> On Wed, 1 Aug 2018 17:56:46 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
>> Hi,
>>
>> On 08/01/2018 04:50 PM, Andrew Morton wrote:
>>> On Wed,  1 Aug 2018 15:04:16 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>
>>>> The thread "avoid alloc memory on offline node"
>>>>
>>>> https://lkml.org/lkml/2018/6/7/251
>>>>
>>>> Asked at one point why the kzalloc_node was crashing rather than
>>>> returning memory from a valid node. The thread ended up fixing
>>>> the immediate causes of the crash but left open the case of bad
>>>> proximity values being in DSDT tables without corrisponding
>>>> SRAT/SLIT entries as is happening on another machine.
>>>>
>>>> Its also easy to fix that, but we should also harden the allocator
>>>> sufficiently that it doesn't crash when passed an invalid node id.
>>>> There are a couple possible ways to do this, and i've attached two
>>>> separate patches which individually fix that problem.
>>>>
>>>> The first detects the offline node before calling
>>>> the new_slab code path when it becomes apparent that the allocation isn't
>>>> going to succeed. The second actually hardens node_zonelist() and
>>>> prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
>>>> zonelist. This latter case happens if the node has never been initialized
>>>> or is possibly out of range. There are other places (NODE_DATA &
>>>> online_node) which should be checking if the node id's are > MAX_NUMNODES.
>>>>
>>>
>>> What is it that leads to a caller requesting memory from an invalid
>>> node?  A race against offlining?  If so then that's a lack of
>>> appropriate locking, isn't it?
>>
>> There were a couple unrelated cases, both having to do with the PXN
>> associated with a PCI port. The first case AFAIK, the domain wasn't
>> really invalid if the entire SRAT was parsed and nodes created even when
>> there weren't associated CPUs. The second case (a different machine) is
>> simply a PXN value that is completely invalid (no associated
>> SLIT/SRAT/etc entries) due to firmware making a mistake when a socket
>> isn't populated.
>>
>> There have been a few other suggested or merged patches for the
>> individual problems above, this set is just an attempt at avoiding a
>> full crash if/when another similar problem happens.
> 
> Please add the above info to the changelog.

Sure.

> 
>>
>>>
>>> I don't see a problem with emitting a warning and then selecting a
>>> different node so we can keep running.  But we do want that warning, so
>>> we can understand the root cause and fix it?
>>
>> Yes, we do want to know when an invalid id is passed, i will add the
>> VM_WARN in the first one.
>>
>> The second one I wasn't sure about as failing prepare_alloc_pages()
>> generates a couple of error messages, but the system then continues
>> operation.
>>
>> I guess my question though is which method (or both/something else?) is
>> the preferred way to harden this up?
> 
> The first patch looked neater.  Can we get a WARN_ON in there as well?
> 

Yes,

Thanks,
