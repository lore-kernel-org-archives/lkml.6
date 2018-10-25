Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD20C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7312082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7312082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJZESv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:18:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZESv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:18:51 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 886451B52;
        Thu, 25 Oct 2018 19:44:43 +0000 (UTC)
Date:   Thu, 25 Oct 2018 12:44:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-Id: <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
In-Reply-To: <20181025092352.GP18839@dhcp22.suse.cz>
References: <20181023164302.20436-1-guro@fb.com>
        <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
        <20181025092352.GP18839@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 11:23:52 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 24-10-18 15:19:50, Andrew Morton wrote:
> > On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
> > > with a relatively small number of objects") leads to a regression on
> > > his setup: periodically the majority of the pagecache is evicted
> > > without an obvious reason, while before the change the amount of free
> > > memory was balancing around the watermark.
> > > 
> > > The reason behind is that the mentioned above change created some
> > > minimal background pressure on the inode cache. The problem is that
> > > if an inode is considered to be reclaimed, all belonging pagecache
> > > page are stripped, no matter how many of them are there. So, if a huge
> > > multi-gigabyte file is cached in the memory, and the goal is to
> > > reclaim only few slab objects (unused inodes), we still can eventually
> > > evict all gigabytes of the pagecache at once.
> > > 
> > > The workload described by Spock has few large non-mapped files in the
> > > pagecache, so it's especially noticeable.
> > > 
> > > To solve the problem let's postpone the reclaim of inodes, which have
> > > more than 1 attached page. Let's wait until the pagecache pages will
> > > be evicted naturally by scanning the corresponding LRU lists, and only
> > > then reclaim the inode structure.
> > 
> > Is this regression serious enough to warrant fixing 4.19.1?
> 
> Let's not forget about stable tree(s) which backported 172b06c32b94. I
> would suggest reverting there.

Yup.  Sasha, can you please take care of this?
