Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB681C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B76A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897661;
	bh=xTuXXB5YtjBF11lIKd4CuYwEvWKbEI03kTClzl76U6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xfOJPxNfwv7HlEWR4b0+iNpo+jrmvhDpZ9Jaj4US7y7VwhwVOiL4qswUD0FH6pl+E
	 hJbSVA/+dTlbQfNhnsdWeHmPsT5S4Wic8dfyzYdRi0h6QsFy4MpINzrKrcSupRKEvs
	 1xQcelcMuak1o7SiQHhhxGJxFGRImuZV/DIDRopA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfBKPHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:37604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391386AbfBKPHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7426ACF8;
        Mon, 11 Feb 2019 15:07:35 +0000 (UTC)
Date:   Mon, 11 Feb 2019 16:07:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Yong-Taek Lee <ytk.lee@samsung.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm, oom: Tolerate processes sharing mm with different
 view of oom_score_adj.
Message-ID: <20190211150734.GF15609@dhcp22.suse.cz>
References: <88e10029-f3d9-5bb5-be46-a3547c54de28@I-love.SAKURA.ne.jp>
 <20190116121915.GJ24149@dhcp22.suse.cz>
 <6118fa8a-7344-b4b2-36ce-d77d495fba69@i-love.sakura.ne.jp>
 <20190116134131.GP24149@dhcp22.suse.cz>
 <20190117155159.GA4087@dhcp22.suse.cz>
 <edad66e0-1947-eb42-f4db-7f826d3157d7@i-love.sakura.ne.jp>
 <20190131071130.GM18811@dhcp22.suse.cz>
 <5fd73d87-3e4b-f793-1976-b937955663e3@i-love.sakura.ne.jp>
 <20190201091433.GH11599@dhcp22.suse.cz>
 <643b94c2-d720-fa95-d6ee-4f0ea6e2686a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643b94c2-d720-fa95-d6ee-4f0ea6e2686a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02-02-19 20:06:07, Tetsuo Handa wrote:
> int main(int argc, char *argv[])
> {
> 	printf("PID=%d\n", getpid());
> 	if (vfork() == 0) {
> 		clone(thread1, malloc(8192) + 8192,
> 		      CLONE_VM | CLONE_FS | CLONE_FILES, NULL);
> 		sleep(1);
> 		_exit(0);
> 	}
> 	return 0;
> }

This program is not correct AFAIU:
   Standard description
       (From POSIX.1) The vfork() function has the same effect as
       fork(2), except that the behavior is undefined if the process
       created by vfork() either modifies any data other than a variable
       of type pid_t used to store the return value from vfork(), or
       returns from the function in which vfork() was called, or calls
       any other function before successfully calling _exit(2) or one of
       the exec(3) family of functions.
> 
>   PID=8802
>   [ 1138.425255] updating oom_score_adj for 8802 (a.out) from 0 to 1000 because it shares mm with 8804 (a.out). Report if this is unexpected.
> 
> Current loop to enforce same oom_score_adj is 99%+ ending in vain.
> And even your "eventually" will remove this loop.

But it keeps the semantic of the mm shared processes share the same
oomd_score_adj so that we do not have to add kludges to the OOM code to
handle with potential corner cases.

Really, this nagging is both unproductive and annoying. You are right
that the printk is overzealous and it can be dropped. The printk is
more than two years old and we haven't heard anybody to care. So the
first and the most obvious thing to do is to remove it. The patch is
trivial and if I was not buried in the backlog I would have posted it
already.  Regarding a potentially expensive for_each_process. This is
unfortunate but the thing we have to pay for in other paths as well
(e.g. exit path) so closing this only here just doesn't really help
much if you are concerned about security and potential stalls will
explode the machine scenarios.. So even though this sucks it is not
earth shattering. CLONE_VM withtout CLONE_SIGHAND simply sucks and
nobody should be using this threading model.

So, please calm down, try to be more productive and try to understand
what people try to tell you rather than shout around "i want my pony".
-- 
Michal Hocko
SUSE Labs
