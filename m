Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CAAC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9602221748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9602221748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeI1NG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbeI1NG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1DA9AFCF;
        Fri, 28 Sep 2018 06:44:40 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: When purging persistent grants,
 keep them in the buffer
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
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
 <878eaad1-b63e-7e9b-f4c3-1ec3825d91e1@eikelenboom.it>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7060a367-7e87-49af-1bd3-c5506364c0a1@suse.com>
Date:   Fri, 28 Sep 2018 08:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <878eaad1-b63e-7e9b-f4c3-1ec3825d91e1@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2018 00:03, Sander Eikelenboom wrote:
> On 27/09/18 23:48, Boris Ostrovsky wrote:
>> On 9/27/18 5:37 PM, Jens Axboe wrote:
>>> On 9/27/18 2:33 PM, Sander Eikelenboom wrote:
>>>> On 27/09/18 21:06, Boris Ostrovsky wrote:
>>>>> On 9/27/18 2:56 PM, Jens Axboe wrote:
>>>>>> On 9/27/18 12:52 PM, Sander Eikelenboom wrote:
>>>>>>> On 27/09/18 16:26, Jens Axboe wrote:
>>>>>>>> On 9/27/18 1:12 AM, Juergen Gross wrote:
>>>>>>>>> On 22/09/18 21:55, Boris Ostrovsky wrote:
>>>>>>>>>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>>>>> added support for purging persistent grants when they are not in use. As
>>>>>>>>>> part of the purge, the grants were removed from the grant buffer, This
>>>>>>>>>> eventually causes the buffer to become empty, with BUG_ON triggered in
>>>>>>>>>> get_free_grant(). This can be observed even on an idle system, within
>>>>>>>>>> 20-30 minutes.
>>>>>>>>>>
>>>>>>>>>> We should keep the grants in the buffer when purging, and only free the
>>>>>>>>>> grant ref.
>>>>>>>>>>
>>>>>>>>>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>>>>> Since Konrad is out, I'm going to queue this up for 4.19.
>>>>>>>>
>>>>>>> Hi Boris/Juergen.
>>>>>>>
>>>>>>> Last week i tested a linux-4.19-rc4 kernel with xen-next and this patch from Boris pulled on top. 
>>>>>>> Unfortunately it made a VM hang (probably because it's rootFS is shuffled from under it's feet 
>>>>> What do you mean by "rootFS is shuffled from under it's feet " ?
>>>> Assumption that block-front getting borked and either a kernel crash or rootfs becoming mounted readonly. Didn't (try) to check though.
>>>>
>>>>>>> and it gave these in dom0 dmesg:
>>>>>>>
>>>>>>> [ 9251.696090] xen-blkback: requesting a grant already in use
>>>>>>> [ 9251.705861] xen-blkback: trying to add a gref that's already in the tree
>>>>>>> [ 9251.715781] xen-blkback: requesting a grant already in use
>>>>>>> [ 9251.725756] xen-blkback: trying to add a gref that's already in the tree
>>>>>>> [ 9251.735698] xen-blkback: requesting a grant already in use
>>>>>>> [ 9251.745573] xen-blkback: trying to add a gref that's already in the tree
>>>>>>>
>>>>>>> The VM was a HVM with 4 vcpu's and 2 phy disks:
>>>>>>> xen-blkback: backend/vbd/14/768: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>>>> xen-blkback: backend/vbd/14/832: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>>>>
>>>>>>>
>>>>>>> Currently i have been running 4.19-rc5 with xen-next on top and commit
>>>>>>> a46b53672b2c reverted, for a couple of days. That seems to run stable
>>>>>>> for me (since it's a small box so i'm not hit by what a46b53672b2c
>>>>>>> tried to fix.
>>>>>>>
>>>>>>> If you can come up with a debug patch i can give that a spin tomorrow
>>>>>>> evening or in the weekend, so we are hopefully still in time for the
>>>>>>> 4.19 release.
>>>>>> At this late in the game, might make more sense to simply revert the
>>>>>> buggy commit.  Especially since what is currently out there doesn't fix
>>>>>> the issue for you.
>>>> Don't know if Boris or Juergen have a hunch about the issue, if not
>>>> perhaps a revert is the best.
>>> Anyone? Unless I hear otherwise, I'll revert the series tomorrow.
>>
>> Juergen may have something to say by tomorrow, but from my perspective,
>> given that we are coming up on rc6 --- yes.
>>
>> I looked at the patches again and didn't see anything obvious.
>>
>> -boris
> 
> Could also be that what i hit is a latent bug, 
> that is not caused by these patches but merely got uncovered by them.
> 
> xl dmesg also shows quite some:
>     (XEN) [2018-09-24 03:15:46.847] grant_table.c:1755:d14v0 Expanding d14 grant table from 19 to 20 frames
>     (XEN) [2018-09-24 03:15:46.849] grant_table.c:1755:d14v0 Expanding d14 grant table from 20 to 21 frames
> (and has done that for ages on my box not leading to any direct problems to my knowledge)
> 
> I don't know if there could be related and something around the (persistent) grants for block devices could be leaking under some conditions?

I could reproduce the issue Boris has seen and I have found the fault
in his patch. Just testing a fix.


Juergen
