Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262B320B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262B320B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeGKKZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeGKKZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:25:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABD43ACF5;
        Wed, 11 Jul 2018 10:21:40 +0000 (UTC)
Date:   Wed, 11 Jul 2018 12:21:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180711102139.GG20050@dhcp22.suse.cz>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz>
 <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-07-18 12:09:17, Waiman Long wrote:
> On 07/10/2018 10:27 AM, Michal Hocko wrote:
> > On Mon 09-07-18 12:01:04, Waiman Long wrote:
> >> On 07/09/2018 04:19 AM, Michal Hocko wrote:
[...]
> >>> percentage has turned out to be a really wrong unit for many tunables
> >>> over time. Even 1% can be just too much on really large machines.
> >> Yes, that is true. Do you have any suggestion of what kind of unit
> >> should be used? I can scale down the unit to 0.1% of the system memory.
> >> Alternatively, one unit can be 10k/cpu thread, so a 20-thread system
> >> corresponds to 200k, etc.
> > I simply think this is a strange user interface. How much is a
> > reasonable number? How can any admin figure that out?
> 
> Without the optional enforcement, the limit is essentially just a
> notification mechanism where the system signals that there is something
> wrong going on and the system administrator need to take a look. So it
> is perfectly OK if the limit is sufficiently high that normally we won't
> need to use that many negative dentries. The goal is to prevent negative
> dentries from consuming a significant portion of the system memory.

So again. How do you tell the right number?

> I am going to reduce the granularity of each unit to 1/1000 of the total
> system memory so that for large system with TB of memory, a smaller
> amount of memory can be specified.

It is just a matter of time for this to be too coarse as well.
-- 
Michal Hocko
SUSE Labs
