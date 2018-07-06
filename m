Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3370CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59A222B47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59A222B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeGFW21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:28:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54244 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeGFW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:28:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fbZD4-00082f-NW; Fri, 06 Jul 2018 22:28:14 +0000
Date:   Fri, 6 Jul 2018 23:28:14 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Waiman Long <longman@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20180706222814.GE30522@ZenIV.linux.org.uk>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530905572-817-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:32:45PM -0400, Waiman Long wrote:

> With a 4.18 based kernel, the positive & negative dentries lookup rates
> (lookups per second) after initial boot on a 2-socket 24-core 48-thread
> 64GB memory system with and without the patch were as follows: `
> 
>   Metric                    w/o patch  neg_dentry_pc=0  neg_dentry_pc=1
>   ------                    ---------  ---------------  ---------------
>   Positive dentry lookup      584299       586749	   582670
>   Negative dentry lookup     1422204      1439994	  1438440
>   Negative dentry creation    643535       652194	   641841
> 
> For the lookup rate, there isn't any signifcant difference with or
> without the patch or with a zero or non-zero value of neg_dentry_pc.

Sigh...  What I *still* don't see (after all the iterations of the patchset)
is any performance data on workloads that would be likely to feel the impact.
Anything that seriously hits INCLUDE_PATH, for starters...
