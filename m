Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1830C2175F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830C2175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeIMWDu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeIMWDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11F4688310;
        Thu, 13 Sep 2018 16:53:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F9D60BE5;
        Thu, 13 Sep 2018 16:53:30 +0000 (UTC)
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C8FEC4BB74;
        Thu, 13 Sep 2018 16:53:30 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
From:   Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for intermediate page-table entries on arm64
Message-Id: <0D8B76BD-C09D-4B51-97DD-3DB57EB85DB6@redhat.com>
Date:   Thu, 13 Sep 2018 12:53:30 -0400 (EDT)
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com> <3dd55e21-7424-071a-0f7e-d24fc2396f2a@redhat.com> <20180905122828.GF20186@arm.com> <f8ba271b-87c0-29ef-1216-77d5d391d5c8@redhat.com> <20180913155301.GA20290@arm.com>
To:     Will Deacon <will.deacon@arm.com>
In-Reply-To: <20180913155301.GA20290@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Thread-Topic: Avoid synchronous TLB invalidation for intermediate page-table entries on arm64
Thread-Index: 96yrucdXXM5rlTCkK5FJKI6wRWKfOA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Sep 2018 16:53:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tnx

-- 
Computer Architect


> On Sep 13, 2018, at 11:52, Will Deacon <will.deacon@arm.com> wrote:
> 
>> On Fri, Sep 07, 2018 at 02:36:08AM -0400, Jon Masters wrote:
>>> On 09/05/2018 08:28 AM, Will Deacon wrote:
>>>> On Tue, Sep 04, 2018 at 02:38:02PM -0400, Jon Masters wrote:
>>>>> On 08/24/2018 11:52 AM, Will Deacon wrote:
>>>>> 
>>>>> I hacked up this RFC on the back of the recent changes to the mmu_gather
>>>>> stuff in mainline. It's had a bit of testing and it looks pretty good so
>>>>> far.
>>>> 
>>>> I will request the server folks go and test this. You'll probably
>>>> remember a couple of parts we've seen where aggressive walker caches
>>>> ended up (correctly) seeing stale page table entries and we had all
>>>> manner of horrifically hard to debug problems. We have some fairly nice
>>>> reproducers that were able to find this last time that we can test.
>>> 
>>> Cheers, Jon, that would be very helpful. You're probably best off using
>>> my (rebasing) tlb branch rather than picking the RFC:
>>> 
>>>  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tlb
>>> 
>>> Let me know if you'd prefer something stable (I can tag it with a date).
>> 
>> That would be useful. I've prodded each of the Arm server SoC vendors I
>> work with via our weekly call to have them each specifically check this.
>> A tag would be helpful to that effort I expect. They all claim to be
>> watching this thread now, so we'll see if they see cabbages here.
> 
> This is now all queued up in the (stable) arm64 for-next/core branch:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
> 
> so that's the best place to grab the patches.
> 
> Will
