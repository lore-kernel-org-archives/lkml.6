Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A050E21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="EBiCLMkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A050E21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=eikelenboom.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeI1EXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:23:55 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:59706 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1EXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nAA5gZzK6Eav+CxcfPDuLKGaxWLCW6/PJgLgIrkzg2w=; b=EBiCLMkp1Uvnz4V0+A7iTk4V+B
        S/3wGwRVkR1FFl3uPoPObP7frsd0Aa4F3U3q/vs+Dl22Bub/IcM4eChD+RZRGUFRhhLjNdnn7tx5L
        +VQ+7ju+9tID6O8uAebZ4hqA1GBaJyAIjJ7s8OyvLyW1B4iMHkV2pVyQOoT/YU1IpUKo=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:45300 helo=[172.16.1.49])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1g5eNX-0007Cr-Pe; Fri, 28 Sep 2018 00:03:23 +0200
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: When purging persistent grants,
 keep them in the buffer
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
 <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
 <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
 <00030538-e1ce-28ad-3548-8e3b07083b05@eikelenboom.it>
 <b181cc24-16fc-ac94-24f8-1955efa6565d@kernel.dk>
 <04bc976c-9991-e24b-4994-55540b06f133@oracle.com>
 <4f53cd6f-0a73-ccdc-c816-1225aebd8d58@eikelenboom.it>
 <1d3d7e32-22d1-83aa-af0a-7ed6e628f5e5@kernel.dk>
 <63d2a50f-c22e-1b99-8354-7feca9e089e5@oracle.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <878eaad1-b63e-7e9b-f4c3-1ec3825d91e1@eikelenboom.it>
Date:   Fri, 28 Sep 2018 00:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <63d2a50f-c22e-1b99-8354-7feca9e089e5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 23:48, Boris Ostrovsky wrote:
> On 9/27/18 5:37 PM, Jens Axboe wrote:
>> On 9/27/18 2:33 PM, Sander Eikelenboom wrote:
>>> On 27/09/18 21:06, Boris Ostrovsky wrote:
>>>> On 9/27/18 2:56 PM, Jens Axboe wrote:
>>>>> On 9/27/18 12:52 PM, Sander Eikelenboom wrote:
>>>>>> On 27/09/18 16:26, Jens Axboe wrote:
>>>>>>> On 9/27/18 1:12 AM, Juergen Gross wrote:
>>>>>>>> On 22/09/18 21:55, Boris Ostrovsky wrote:
>>>>>>>>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>>>> added support for purging persistent grants when they are not in use. As
>>>>>>>>> part of the purge, the grants were removed from the grant buffer, This
>>>>>>>>> eventually causes the buffer to become empty, with BUG_ON triggered in
>>>>>>>>> get_free_grant(). This can be observed even on an idle system, within
>>>>>>>>> 20-30 minutes.
>>>>>>>>>
>>>>>>>>> We should keep the grants in the buffer when purging, and only free the
>>>>>>>>> grant ref.
>>>>>>>>>
>>>>>>>>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>>>> Since Konrad is out, I'm going to queue this up for 4.19.
>>>>>>>
>>>>>> Hi Boris/Juergen.
>>>>>>
>>>>>> Last week i tested a linux-4.19-rc4 kernel with xen-next and this patch from Boris pulled on top. 
>>>>>> Unfortunately it made a VM hang (probably because it's rootFS is shuffled from under it's feet 
>>>> What do you mean by "rootFS is shuffled from under it's feet " ?
>>> Assumption that block-front getting borked and either a kernel crash or rootfs becoming mounted readonly. Didn't (try) to check though.
>>>
>>>>>> and it gave these in dom0 dmesg:
>>>>>>
>>>>>> [ 9251.696090] xen-blkback: requesting a grant already in use
>>>>>> [ 9251.705861] xen-blkback: trying to add a gref that's already in the tree
>>>>>> [ 9251.715781] xen-blkback: requesting a grant already in use
>>>>>> [ 9251.725756] xen-blkback: trying to add a gref that's already in the tree
>>>>>> [ 9251.735698] xen-blkback: requesting a grant already in use
>>>>>> [ 9251.745573] xen-blkback: trying to add a gref that's already in the tree
>>>>>>
>>>>>> The VM was a HVM with 4 vcpu's and 2 phy disks:
>>>>>> xen-blkback: backend/vbd/14/768: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>>> xen-blkback: backend/vbd/14/832: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>>>
>>>>>>
>>>>>> Currently i have been running 4.19-rc5 with xen-next on top and commit
>>>>>> a46b53672b2c reverted, for a couple of days. That seems to run stable
>>>>>> for me (since it's a small box so i'm not hit by what a46b53672b2c
>>>>>> tried to fix.
>>>>>>
>>>>>> If you can come up with a debug patch i can give that a spin tomorrow
>>>>>> evening or in the weekend, so we are hopefully still in time for the
>>>>>> 4.19 release.
>>>>> At this late in the game, might make more sense to simply revert the
>>>>> buggy commit.  Especially since what is currently out there doesn't fix
>>>>> the issue for you.
>>> Don't know if Boris or Juergen have a hunch about the issue, if not
>>> perhaps a revert is the best.
>> Anyone? Unless I hear otherwise, I'll revert the series tomorrow.
> 
> Juergen may have something to say by tomorrow, but from my perspective,
> given that we are coming up on rc6 --- yes.
> 
> I looked at the patches again and didn't see anything obvious.
> 
> -boris

Could also be that what i hit is a latent bug, 
that is not caused by these patches but merely got uncovered by them.

xl dmesg also shows quite some:
    (XEN) [2018-09-24 03:15:46.847] grant_table.c:1755:d14v0 Expanding d14 grant table from 19 to 20 frames
    (XEN) [2018-09-24 03:15:46.849] grant_table.c:1755:d14v0 Expanding d14 grant table from 20 to 21 frames
(and has done that for ages on my box not leading to any direct problems to my knowledge)

I don't know if there could be related and something around the (persistent) grants for block devices could be leaking under some conditions?

--
Sander

