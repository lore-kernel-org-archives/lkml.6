Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C61C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEF520883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEF520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeGLI4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:56:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbeGLI4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:56:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2D59AD0A;
        Thu, 12 Jul 2018 08:48:08 +0000 (UTC)
Date:   Thu, 12 Jul 2018 10:48:07 +0200
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
Message-ID: <20180712084807.GF32648@dhcp22.suse.cz>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz>
 <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
 <20180711102139.GG20050@dhcp22.suse.cz>
 <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 11:13:58, Waiman Long wrote:
> On 07/11/2018 06:21 AM, Michal Hocko wrote:
> > On Tue 10-07-18 12:09:17, Waiman Long wrote:
> >> On 07/10/2018 10:27 AM, Michal Hocko wrote:
> >>> On Mon 09-07-18 12:01:04, Waiman Long wrote:
> >>>> On 07/09/2018 04:19 AM, Michal Hocko wrote:
> > [...]
> >>>>> percentage has turned out to be a really wrong unit for many tunables
> >>>>> over time. Even 1% can be just too much on really large machines.
> >>>> Yes, that is true. Do you have any suggestion of what kind of unit
> >>>> should be used? I can scale down the unit to 0.1% of the system memory.
> >>>> Alternatively, one unit can be 10k/cpu thread, so a 20-thread system
> >>>> corresponds to 200k, etc.
> >>> I simply think this is a strange user interface. How much is a
> >>> reasonable number? How can any admin figure that out?
> >> Without the optional enforcement, the limit is essentially just a
> >> notification mechanism where the system signals that there is something
> >> wrong going on and the system administrator need to take a look. So it
> >> is perfectly OK if the limit is sufficiently high that normally we won't
> >> need to use that many negative dentries. The goal is to prevent negative
> >> dentries from consuming a significant portion of the system memory.
> > So again. How do you tell the right number?
> 
> I guess it will be more a trial and error kind of adjustment as the
> right figure will depend on the kind of workloads being run on the
> system. So unless the enforcement option is turned on, setting a limit
> that is too small won't have too much impact over than a slight
> performance drop because of the invocation of the slowpaths and the
> warning messages in the console. Whenever a non-zero value is written
> into "neg-dentry-limit", an informational message will be printed about
> what the actual negative dentry limits
> will be. It can be compared against the current negative dentry number
> (5th number) from "dentry-state" to see if there is enough safe margin
> to avoid false positive warning.

What you wrote above is exactly the reason why I do not like yet another
tunable. If you cannot give a reasonable cook book on how to tune this
properly then nobody will really use it and we will eventually find
out that we have a user visible API which might simply make further
development harder and which will be hard to get rid of because you
never know who is going to use it for strange purposes.

Really, negative entries are a cache and if we do not shrink that cache
properly then this should be fixed rather than giving up and pretending
that the admin is the one to control that.
-- 
Michal Hocko
SUSE Labs
