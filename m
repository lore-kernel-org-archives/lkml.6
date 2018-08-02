Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E489C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D93208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hpDnHZ2w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hpDnHZ2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D93208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeHBEMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:12:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48180 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeHBEMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:12:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B6AA1602B7; Thu,  2 Aug 2018 02:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533176591;
        bh=JN5I1dnxDyziBpQOLN5udr7oKu/3RV3FSL2Ye4jtXuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hpDnHZ2wGMjlv0aba6xpYMICvo+FLRjHjB+S6QnZUgrfPCAV5fthrYaENbMXWdRIg
         hgMknB/SmTj2KMFwjdJn5VPQiXheHh3axyJre3AM806ClKKbXLKSEB7AbXiJknCqsQ
         1L1s5nkDJBu2+tFyEiPrQRmUzvjhM28SlfTKbbMg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F3DEF6079C;
        Thu,  2 Aug 2018 02:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533176591;
        bh=JN5I1dnxDyziBpQOLN5udr7oKu/3RV3FSL2Ye4jtXuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hpDnHZ2wGMjlv0aba6xpYMICvo+FLRjHjB+S6QnZUgrfPCAV5fthrYaENbMXWdRIg
         hgMknB/SmTj2KMFwjdJn5VPQiXheHh3axyJre3AM806ClKKbXLKSEB7AbXiJknCqsQ
         1L1s5nkDJBu2+tFyEiPrQRmUzvjhM28SlfTKbbMg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 19:23:10 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        wen.xu@gatech.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Remounting filesystem read-only
In-Reply-To: <20180728074704.GA4203@magnolia>
References: <366cf3ac534bbadaaa61714a43006ac7@codeaurora.org>
 <e9869d6cd358e9de395d730ab7b3aa60@codeaurora.org>
 <20180727195213.GE13922@thunk.org>
 <c121825198eba667c09fc53fa9b4fd3a@codeaurora.org>
 <20180728001823.GA28432@thunk.org> <20180728074704.GA4203@magnolia>
Message-ID: <91cab9ba274131c4701fe4c1ce444d6b@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-28 00:47, Darrick J. Wong wrote:
> On Fri, Jul 27, 2018 at 08:18:23PM -0400, Theodore Y. Ts'o wrote:
>> On Fri, Jul 27, 2018 at 01:34:31PM -0700, Sodagudi Prasad wrote:
>> > > The error should be pretty clear: "Inode table for bg 0 marked as
>> > > needing zeroing".  That should never happen.
>> >
>> > Can you provide any debug patch to detect when this corruption is happening?
>> > Source of this corruption and how this is partition getting corrupted?
>> > Or which file system operation lead to this corruption?
>> 
>> Do you have a reliable repro?  If it's a one-off, it can be caused by
>> *anything*.  Crappy hardware, a bug in some proprietary, binary-only
>> GPU driver dereferencing some wild pointer that corrupts kernel
>> memory, etc.
>> 
>> Asking for a debug patch is like asking for "can you create technology
>> that can detect when a cockroach enter my house?"
> 
> Well, ext4 *could* add metadata read and write verifiers to complain
> loudly in dmesg about stuff that shouldn't be there, so at least we'd
> know when we're writing cockroaches into the house... :)
> 
> --D
> 
Hi Ted,

Below change fixed this issue. Thanks for your support.

https://github.com/torvalds/linux/commit/5012284700775a4e6e3fbe7eac4c543c4874b559

"ext4: fix check to prevent initializing reserved inodes"

-Thanks, Prasad

>> So if you have a reliable repro, then we know what operations might be
>> triggering the corruption, and then you work on creating a minimal
>> repro, and only *then* when we have a restricted set of possibilities
>> that might be the cause (for example, if removing a GPU call makes the
>> problem go away, then the patch would need to be in the proprietary
>> GPU driver....)
>> 
>> > I am digging code a bit around this warning to understand more.
>> 
>> The warning means that a flag in block group descriptor #0 is set
>> that should never be set.  How did the flag get set?  There is any
>> number of things that could cause that.
>> 
>> You might want to look at the block group descriptor via dumpe2fs or
>> debugfs, to see if it's just a single bit getting flipped, or if the
>> entire block group descriptor is garbage.  Note that under normal code
>> paths, the flag *never* gets set by ext4 kernel code.  The flag will
>> get set on non-block group 0 block group descriptors by ext4, and the
>> ext4 kernel code will only clear the flag.
>> 
>> Of course, if there is a bug in some driver that dereferences a
>> pointer widely, all bets are off.
>> 
>> 					- Ted

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
