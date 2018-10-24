Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBDBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4052075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4052075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJYHY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:24:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYHY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:24:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 145651814;
        Wed, 24 Oct 2018 22:54:56 +0000 (UTC)
Date:   Wed, 24 Oct 2018 15:54:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        yang.s@alibaba-inc.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm,oom: Use timeout based back off.
Message-Id: <20181024155454.4e63191fbfaa0441f2e62f56@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1810221406400.120157@chino.kir.corp.google.com>
References: <1540033021-3258-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <alpine.DEB.2.21.1810221406400.120157@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 14:11:10 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> > Michal has been refusing timeout based approach, but I don't think this
> > is something we have to be frayed around the edge about possibility of
> > overlooking races/bugs just because Michal does not want to use timeout.
> > I believe that timeout based back off is the only approach we can use
> > for now.
> > 
> 
> I've proposed patches that have been running for months in a production 
> environment that make the oom killer useful without serially killing many 
> processes unnecessarily.  At this point, it is *much* easier to just fork 
> the oom killer logic rather than continue to invest time into fixing it in 
> Linux.  That's unfortunate because I'm sure you realize how problematic 
> the current implementation is, how abusive it is, and have seen its 
> effects yourself.  I admire your persistance in trying to fix the issues 
> surrounding the oom killer, but have come to the conclusion that forking 
> it is a much better use of time.

The oom killer is, I think, fairly standalone and it shouldn't be too
hard to add the infrastructure to make the whole thing pluggable.  At
runtime, not at build time.

But it is a last resort - it will result in fragmented effort and
difficult decisions for everyone regarding which should be used.

There has been a lot of heat and noise and confusion and handwaving in
all of this.  What we're crying out for is simple testcases which
everyone can run.  Find a problem, write the testcase, distribute that.
Develop a solution for that testcase then move on to the next one.

