Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeAaVzV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:55:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753240AbeAaVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:55:20 -0500
Date: Wed, 31 Jan 2018 15:55:18 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc: Petr Mladek <pmladek@suse.com>, jikos@kernel.org, mbenes@suse.cz,
        Jason Baron <jbaron@akamai.com>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 6/6] livepatch: Add atomic replace
Message-ID: <20180131215518.cwcxs2atfuzimyxt@treble>
References: <20180125160203.28959-1-pmladek@suse.com>
 <20180125160203.28959-7-pmladek@suse.com>
 <3e93e7b5-3077-9f03-ae89-55394e70da39@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e93e7b5-3077-9f03-ae89-55394e70da39@virtuozzo.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 01:33:04PM +0300, Evgenii Shatokhin wrote:
> >    + The callbacks from the replaced patches are not called. It would be
> >      pretty hard to define a reasonable semantic and implement it.
> 
> At least, it surely simplifies error handling, if these callbacks are not
> called.
> 
> Anyway, I guess, this restriction should be mentioned explicitly in the
> docs. I think this is not obvious for the patch developers (esp. those
> familiar with RPM spec files and such ;-) ).
> 
> What concerns me is that downgrading of the cumulative patches with
> callbacks becomes much more difficult this way.
> 
> I mean, suppose a user has v1 of a cumulative patch installed. Then a newer
> version, v2, is released. They install it and find that it is buggy (very
> unfortunate but might still happen). Now they cannot atomically replace v2
> back with v1, because the callbacks from v1 cannot clean up after v2.
> 
> It will be needed to unload v2 explicitly and then load v1 back, which is
> more fragile. The loading failures are much more unlikely with livepatch
> than with the old kpatch, but they are still possible.
> 
> I have no good solution to this though.

I think the solution is to build a v3, which is basically identical to
v1, except it also has callbacks for cleaning up after v2, if necessary.

It should also be smart enough to deal with the case that v2 was not
installed beforehand.

-- 
Josh
