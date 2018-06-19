Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1488C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABBB20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="gmvFI3gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABBB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030239AbeFSQ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:57:19 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:43124 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966655AbeFSQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2559; q=dns/txt; s=iport;
  t=1529427438; x=1530637038;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=I4i0frt2oWmgcx9KrunCeNXhIt6iOiAZaxhL76kFwZE=;
  b=gmvFI3gZZcU0eCwUl+fMWjydzmXXHhBIfgqH8a/hkgMYAAfrXgOODS5Q
   EGneJmj2DpJrlVbny/aKPN4mBWEoPLgSp9RQk2A4ckNe4ufTFt+9E76r1
   csJvdYNoUGPMCdXmSmFvauCdiVK9TT/ruPCRUYCU28hay/j6oTKSSeoc/
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B1AgAANSlb/5pdJa1dGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJYn8og3mUVYFXKZZzCxgLhEkCgm4hOBQBAgEBAQEBAQJ?=
 =?us-ascii?q?tHAyFKQEBBAEiFUEQCxgCAiYCAigvBgEMCAEBgyEBgX8PrCOCHIRbg22BYwU?=
 =?us-ascii?q?Ud4dJgVQ/gTOCaIMTAwKEXoJVAo0mi3kJhX2FJ4NlBogFhTgriWqHPoFYIYF?=
 =?us-ascii?q?SMxoIGxVIDoIogiEXiFmFXh8wAYoJK4IbAQE?=
X-IronPort-AV: E=Sophos;i="5.51,243,1526342400"; 
   d="scan'208";a="131838401"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 16:57:17 +0000
Received: from [10.24.50.236] ([10.24.50.236])
        by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id w5JGvF0I028583;
        Tue, 19 Jun 2018 16:57:15 GMT
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
To:     "Guilherme G. Piccoli" <guilherme@gpiccoli.net>,
        mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-kernel@external.cisco.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Mauro Rodrigues <maurosr@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org
References: <20180618165706.42679-1-danielwa@cisco.com>
 <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
 <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
 <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
From:   Daniel Walker <danielwa@cisco.com>
Message-ID: <6d321d8a-432d-d41d-cc08-144764d644b2@cisco.com>
Date:   Tue, 19 Jun 2018 09:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 09:26 AM, Guilherme G. Piccoli wrote:
>> [...]
>> What your doing is changing the phb_id to some transformation of "reg" for
>> all platforms except which have "ibm,opal-phbid". This is what we observe.
>> This is a radical altering of the prior phb_id selection before your patch.
>>
>> The question is, was that your intent ? We are expecting these numbers
>> aren't getting altered in this way, this is why we have the patch. Your
>> patch description appears to suggest you want this type of selection for
>> "... pSeries and PowerNV cases)." , so I am assuming you did this by
>> mistake. Also I don't see a reason to make this change for all platforms.
> It was the intent - whenever we have device-tree information, the idea is to
> use it to have more consistent numbering across reboots and PCI hotplugs.
> The reason to change that originally is hotplugging a PCI device added
> the device with a different PHB/Domain value, and network predictable naming
> messed-up interfaces' names, leading to a machine without networking.

Ok ..

>
>
>> [...]
>>
>> We have already done this, that is how we determined your patch was changing
>> the domain values. There isn't much to tell w.r.t this issue on our side, we
>> are expecting the domain numbers are set a specific way and they aren't
>> getting set that way. The drivers which are looking for PCI devices are not
>> in kernel space, and the PCI domain values are getting taken from userspace.
>>
> Oh okay, I imagined it was some crazy userspace-based PCI domain scheme
> that led you to report the issue - confirmed heheh
> So, you expect the old behavior right? Incremental PHB numbering.
> I think we could have a kernel config option to allow that, this way
> you could rebuild your kernel with that option and keep the old behavior.
>
> This idea needs to be validated by the maintainers, or perhaps they could
> propose another way to keep the old behavior to interested parties.
>
> [Looping linux-pci too - original thread at:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/174760.html]

I didn't look into changing the behavior on our side because it didn't 
look like the intent of the patch was to make a global change. I can 
take a look at changing this behavior on our side , given that this was 
intended by your changes.

However, they're may be other platforms or drivers which depend on these 
numbers getting set a certain way, so there may be other userspace 
dependencies on these values.

Daniel

