Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C571121745
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C571121745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeHMWEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:04:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:46556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728781AbeHMWEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:04:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE3D5AF74;
        Mon, 13 Aug 2018 19:20:37 +0000 (UTC)
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
To:     dsterba@suse.cz, Naohiro Aota <naota@elisp.net>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180813184251.GC24025@twin.jikos.cz>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <86bddb14-104e-182b-29a1-6ab8150f09a8@suse.com>
Date:   Mon, 13 Aug 2018 21:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180813184251.GC24025@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 08:42 PM, David Sterba wrote:
> On Fri, Aug 10, 2018 at 03:04:33AM +0900, Naohiro Aota wrote:
>> This series adds zoned block device support to btrfs.
> 
> Yay, thanks!
> 
> As this a RFC, I'll give you some. The code looks ok for what it claims
> to do, I'll skip style and unimportant implementation details for now as
> there are bigger questions.
> 
> The zoned devices bring some constraints so not all filesystem features
> cannot be expected to work, so this rules out any form of in-place
> updates like NODATACOW.
> 
> Then there's list of 'how will zoned device work with feature X'?
> 
> You disable fallocate and DIO. I haven't looked closer at the fallocate
> case, but DIO could work in the sense that open() will open the file but
> any write will fallback to buffered writes. This is implemented so it
> would need to be wired together.
> 
> Mixed device types are not allowed, and I tend to agree with that,
> though this could work in principle.  Just that the chunk allocator
> would have to be aware of the device types and tweaked to allocate from
> the same group. The btrfs code is not ready for that in terms of the
> allocator capabilities and configuration options.
> 
> Device replace is disabled, but the changlog suggests there's a way to
> make it work, so it's a matter of implementation. And this should be
> implemented at the time of merge.
> 
How would a device replace work in general?
While I do understand that device replace is possible with RAID 
thingies, I somewhat fail to see how could do a device replacement 
without RAID functionality.
Is it even possible?
If so, how would it be different from a simple umount?

> RAID5/6 + zoned support is highly desired and lack of it could be
> considered a NAK for the whole series. The drive sizes are expected to
> be several terabytes, that sounds be too risky to lack the redundancy
> options (RAID1 is not sufficient here).
> 
That really depends on the allocator.
If we can make the RAID code to work with zone-sized stripes it should 
be pretty trivial. I can have a look at that; RAID support was on my 
agenda anyway (albeit for MD, not for btrfs).

> The changelog does not explain why this does not or cannot work, so I
> cannot reason about that or possibly suggest workarounds or solutions.
> But I think it should work in principle.
> 
As mentioned, it really should work for zone-sized stripes. I'm not sure 
we can make it to work with stripes less than zone sizes.

> As this is first post and RFC I don't expect that everything is
> implemented, but at least the known missing points should be documented.
> You've implemented lots of the low-level zoned support and extent
> allocation, so even if the raid56 might be difficult, it should be the
> smaller part.
> 
FYI, I've run a simple stress-test on a zoned device (git clone linus && 
make) and haven't found any issue with those; compilation ran without a 
problem, and with quite decent speed.
Good job!

Cheers,

Hannes
