Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEAFC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E5220834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 07:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO7CMcNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E5220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeLATBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLATBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:01:08 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E3220834;
        Sat,  1 Dec 2018 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543650554;
        bh=Abv++2fiQQEqp7wkR5iwdFuCIeeGI7h9XrLivv4XiWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DO7CMcNtESV2z06j2duaTKYA06Z4+cY7rjbDGFk7HJ9ZPlycZ8ty0db8SRR1BES1Q
         z1Kx9+dHT4NC5fp20z43IVrJ9rW4Rkc2P+WATQ0k6f/GC1GnM2wdf/9Rq88gcoNykJ
         DOUjsgNkkqIvPTsvO2NhUdP/Gk2W6jx3ITTql4hY=
Date:   Sat, 1 Dec 2018 02:49:09 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181201074909.GC213156@sasha-vm>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181130215005.GP19305@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 08:50:05AM +1100, Dave Chinner wrote:
>On Fri, Nov 30, 2018 at 05:14:41AM -0500, Sasha Levin wrote:
>> On Fri, Nov 30, 2018 at 09:22:03AM +0100, Greg KH wrote:
>> >On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
>> >>I stopped my tests at 5 billion ops yesterday (i.e. 20 billion ops
>> >>aggregate) to focus on testing the copy_file_range() changes, but
>> >>Darrick's tests are still ongoing and have passed 40 billion ops in
>> >>aggregate over the past few days.
>> >>
>> >>The reason we are running these so long is that we've seen fsx data
>> >>corruption failures after 12+ hours of runtime and hundreds of
>> >>millions of ops. Hence the testing for backported fixes will need to
>> >>replicate these test runs across multiple configurations for
>> >>multiple days before we have any confidence that we've actually
>> >>fixed the data corruptions and not introduced any new ones.
>> >>
>> >>If you pull only a small subset of the fixes, the fsx will still
>> >>fail and we have no real way of actually verifying that there have
>> >>been no regression introduced by the backport.  IOWs, there's a
>> >>/massive/ amount of QA needed for ensuring that these backports work
>> >>correctly.
>> >>
>> >>Right now the XFS developers don't have the time or resources
>> >>available to validate stable backports are correct and regression
>> >>fre because we are focussed on ensuring the upstream fixes we've
>> >>already made (and are still writing) are solid and reliable.
>> >
>> >Ok, that's fine, so users of XFS should wait until the 4.20 release
>> >before relying on it?  :)
>>
>> It's getting to the point that with the amount of known issues with XFS
>> on LTS kernels it makes sense to mark it as CONFIG_BROKEN.
>
>Really? Where are the bug reports?

In 'git log'! You report these every time you fix something in upstream
xfs but don't backport it to stable trees:

$ git log --oneline v4.18-rc1..v4.18 fs/xfs
d4a34e165557 xfs: properly handle free inodes in extent hint validators
9991274fddb9 xfs: Initialize variables in xfs_alloc_get_rec before using them
d8cb5e423789 xfs: fix fdblocks accounting w/ RMAPBT per-AG reservation
e53c4b598372 xfs: ensure post-EOF zeroing happens after zeroing part of a file
a3a374bf1889 xfs: fix off-by-one error in xfs_rtalloc_query_range
232d0a24b0fc xfs: fix uninitialized field in rtbitmap fsmap backend
5bd88d153998 xfs: recheck reflink state after grabbing ILOCK_SHARED for a write
f62cb48e4319 xfs: don't allow insert-range to shift extents past the maximum offset
aafe12cee0b1 xfs: don't trip over negative free space in xfs_reserve_blocks
10ee25268e1f xfs: allow empty transactions while frozen
e53946dbd31a xfs: xfs_iflush_abort() can be called twice on cluster writeback failure
23fcb3340d03 xfs: More robust inode extent count validation
e2ac836307e3 xfs: simplify xfs_bmap_punch_delalloc_range

Since I'm assuming that at least some of them are based on actual issues
users hit, and some of those apply to stable kernels, why would users
want to use an XFS version which is knowingly buggy?

--
Thanks,
Sasha
