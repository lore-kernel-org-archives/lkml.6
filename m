Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A251C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025D02084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjmfl7yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025D02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeJZEyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeJZEyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:54:32 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6EB20834;
        Thu, 25 Oct 2018 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540498820;
        bh=xtZ0LyeUF5KczhKMgQOQiXW6JQjsvHt6oTwd+XpojpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kjmfl7ykeGCrvkAS+UZ/zelcpLFs01WuVs4F/w5FT4x1dw//9EIa+fKekumJvkcOD
         FdB1OAPgEevdLNdnCtJVBJelOkTTNv5SgiBNmoTufhr7WStzg3Nrx12wOFdEKaoNnM
         K5H67MKmOrqImMD4Rb7nzYnNAVuD7XnamZ3jNFMw=
Date:   Thu, 25 Oct 2018 16:20:14 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-ID: <20181025202014.GA216405@sasha-vm>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
 <20181025092352.GP18839@dhcp22.suse.cz>
 <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:44:42PM -0700, Andrew Morton wrote:
>On Thu, 25 Oct 2018 11:23:52 +0200 Michal Hocko <mhocko@kernel.org> wrote:
>
>> On Wed 24-10-18 15:19:50, Andrew Morton wrote:
>> > On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com> wrote:
>> >
>> > > Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
>> > > with a relatively small number of objects") leads to a regression on
>> > > his setup: periodically the majority of the pagecache is evicted
>> > > without an obvious reason, while before the change the amount of free
>> > > memory was balancing around the watermark.
>> > >
>> > > The reason behind is that the mentioned above change created some
>> > > minimal background pressure on the inode cache. The problem is that
>> > > if an inode is considered to be reclaimed, all belonging pagecache
>> > > page are stripped, no matter how many of them are there. So, if a huge
>> > > multi-gigabyte file is cached in the memory, and the goal is to
>> > > reclaim only few slab objects (unused inodes), we still can eventually
>> > > evict all gigabytes of the pagecache at once.
>> > >
>> > > The workload described by Spock has few large non-mapped files in the
>> > > pagecache, so it's especially noticeable.
>> > >
>> > > To solve the problem let's postpone the reclaim of inodes, which have
>> > > more than 1 attached page. Let's wait until the pagecache pages will
>> > > be evicted naturally by scanning the corresponding LRU lists, and only
>> > > then reclaim the inode structure.
>> >
>> > Is this regression serious enough to warrant fixing 4.19.1?
>>
>> Let's not forget about stable tree(s) which backported 172b06c32b94. I
>> would suggest reverting there.
>
>Yup.  Sasha, can you please take care of this?

Sure, I'll revert it from current stable trees.

Should 172b06c32b94 and this commit be backported once Roman confirms
the issue is fixed? As far as I understand 172b06c32b94 addressed an
issue FB were seeing in their fleet and needed to be fixed.


--
Thanks,
Sasha
