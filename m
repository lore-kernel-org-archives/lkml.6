Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258C8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF002081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF002081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeLKRFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:05:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbeLKRFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:05:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B6298667E;
        Tue, 11 Dec 2018 17:05:52 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-117-107.phx2.redhat.com [10.3.117.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E277608F7;
        Tue, 11 Dec 2018 17:05:52 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id 67E0318035D; Tue, 11 Dec 2018 12:05:51 -0500 (EST)
Date:   Tue, 11 Dec 2018 12:05:51 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     NeilBrown <neilb@suse.com>, Jeff Layton <jlayton@kernel.org>,
        Martin Wilck <mwilck@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>, lkp@01.org
Subject: Re: [LKP] [fs/locks]  fd7732e033:  stress-ng.eventfd.ops 21.9%
 improvement
Message-ID: <20181211170551.GB32360@parsley.fieldses.org>
References: <20181211091429.GO23332@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211091429.GO23332@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 11 Dec 2018 17:05:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:14:29PM +0800, kernel test robot wrote:
> FYI, we noticed a 21.9% improvement of stress-ng.eventfd.ops due to commit:

So, doesn't sound like a problem, but just looking into it out of
curiosity.....

I love that you do this, but these reports can be hard to figure out
sometimes.  The graphs especially could use better labeling.

> commit: fd7732e033e30b3a586923b57e338c859e17858a ("fs/locks: create a tree of dependent requests.")
> https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-next
> 
> in testcase: stress-ng
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 1s
> 	class: filesystem
> 	ucode: 0xb00002e
> 	cpufreq_governor: performance

Looking at the man page for stress-ng, it doesn't say much about what it
actually does.  It does say not to use stress-ng as a benchmark.  I
can't tell if it does file locking--the man pages does document some
options which ask for locking (--flock, --locka, --lockf) but I don't
see any evidence in the yaml file or elsewhere that those options are in
use?

These graphs could really use units on the axes.  Also:

>                                  stress-ng.fcntl.ops                            
>                                                                                 
>   120000 +-+----------------------------------------------------------------+   
>          O     O    O O O      O   O O O O  O O O O O O  O   O              |   
>   110000 +-O O    O       O O    O                         O                |   
>   100000 +-+                                                                |   
>          |                                                                  |   
>    90000 +-+                                                                |   
>    80000 +-+                                                                |   
>          |                                                                  |   
>    70000 +-+                                                                |   
>    60000 +-+                                                                |   
>          |                                                                  |   
>    50000 +-+                                                                |   
>    40000 +-+                                                                |   
>          |. .+.+..+.+.   .+.+..+.+. .+.+.+..+. .+.   .+.. .+.   .+.      .+.|   
>    30000 +-+----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                              stress-ng.fcntl.ops_per_sec                        
>                                                                                 
>   120000 +-+----------------------------------------------------------------+   
>          O     O    O O O      O   O O O O  O O O O O O  O   O              |   
>   110000 +-O O    O       O O    O                         O                |   
>   100000 +-+                                                                |   
>          |                                                                  |   
>    90000 +-+                                                                |   
>    80000 +-+                                                                |   
>          |                                                                  |   
>    70000 +-+                                                                |   
>    60000 +-+                                                                |   
>          |                                                                  |   
>    50000 +-+                                                                |   
>    40000 +-+                                                                |   
>          |. .+.+..+.+.   .+.+..+.+. .+.+.+..+. .+.   .+.. .+.   .+.      .+.|   
>    30000 +-+----------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample

I see O's, not but any *'s.  And what are the +'s?

--b.
