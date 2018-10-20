Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF8C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314A21470
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C314A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJTMNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 08:13:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeJTMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 08:13:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id q40-v6so40700745qte.0;
        Fri, 19 Oct 2018 21:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOqe8DV/lyxO6EOK7R9RWl/4ZUWIgIsOcW9wNDNPKuk=;
        b=Gfb/iozNr7COR0LC4wEOOs6jEbJYQIgVJLDtt2RGCfT3dOv4cJhpRg3THQDscqh/HH
         4ZouNTtja3pxgJzhBHShlYgY3EuM/luZhZ3ybqnysuzdkD/ih7ph93uYpMBe8+wSv3/M
         sqpo+YtJJ0BcP1VNbzf1tt13fxf749DAVyea2FSPsh0btE80jrB4KGUCFbuYUtrMhvGY
         AJpfdLkUgggHtAZNsrneQWxEwNIQn4bAOycd+n+ViLwCXrYEhsXQULx7/U9Lb4RUwFlO
         /r1vQMejdp21G/LFE9Mxc1zYMIYKKvpuY1O1v9JlHQjIPBHkCsJxjANGBgC/tP5LOuq0
         UprA==
X-Gm-Message-State: ABuFfohyJNc8XGJOxWwuBJ9ESkXWkwiwsWSE+zJQDjVvPZ2JfwQAplyJ
        JBqnKFWs4+hO3UtvdM7WFJE=
X-Google-Smtp-Source: ACcGV60mHyyI63LvpJKnXbXm1cLBNhIgTrL3EeUG9O6YLV+bU6H1i1+qi1hpYCPhufyqNFhT5vByyw==
X-Received: by 2002:ac8:27c5:: with SMTP id x5-v6mr34816570qtx.61.1540008255735;
        Fri, 19 Oct 2018 21:04:15 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:180::1:fa1e])
        by smtp.gmail.com with ESMTPSA id m68-v6sm4339062qkm.90.2018.10.19.21.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 21:04:14 -0700 (PDT)
Date:   Sat, 20 Oct 2018 00:04:11 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181020040411.GA41962@dennisz-mbp>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
 <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
 <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
 <14614.1539964356@turing-police.cc.vt.edu>
 <20181019222100.GA20900@dennisz-mbp.dhcp.thefacebook.com>
 <19715.1540003639@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19715.1540003639@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:47:19PM -0400, valdis.kletnieks@vt.edu wrote:
> On Fri, 19 Oct 2018 18:21:00 -0400, Dennis Zhou said:
> 
> > Do you by chance run any encryption or anything on top of your hard
> > drive or ssd?
> 
> ext4 on an LVM LV that's part of a PV that's inside a cryptLUKS partition on a hard drive..
> 
> So lots of nested levels there.
> 

Awesome, that explains why I wasn't able to easily reproduce the bug!

> > I thought of another issue that may explain what's going on. It has to
> > do with how a bio can go through make_request() several times. However,
> > I do association on the first entry, but subsequent requests may go to
> > separate queues. Therefore association and the blk_get_rl() returns the
> > wrong request_list. It may be that a particular blkg doesn't have a
> > fully initialized request_list.
> 
> > Thanks for being patient with me. Would you be able to try the following
> > on Jens' for-4.20/block branch? His tree is available here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> No problem.  I've managed to trip over issues that took a *lot* longer to resolve
> (I think back around 2.5.47 or so, the PCMCIA slot in my Dell Latitude kept finding
> different ways to explode the kernel for close to 8-9 months...)
> 
> I checked, and linux-next was all of 1 commit behind jens' for-4.20 tree, so
> I applied it to that (I had a linux-next tree that works, but I'm a git idiot so
> figuring out how to graft that tree on was going to take a while...)
> 

That's great it worked this time, but in the future it may be worth
taking the time to switch trees. As for-next carries a lot of stuff that
has limited testing, it is nice to help limit the footprint of possible
adverse interactions and to for sure determine it exists solely say
within Jens' for-4.20/block tree.

For future reference, something like the following works as a way to
keep multiple remotes in the same repo.

git remote add block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
git fetch
git checkout -b for-4.20/block -t block/for-4.20/block

This checks out the for-4.20/block branch from the remote block as a
local branch called for-4.20/block.

> Result:
> 
> Script started on 2018-10-19 22:29:32-04:00
> [root@turing-police x86_64]# uname -a
> Linux turing-police.cc.vt.edu 4.19.0-rc8-next-20181019-dirty #641 SMP PREEMPT Fri Oct 19 21:18:19 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
> [root@turing-police x86_64]# rpm -Uvh --force dracut-049-4.git20181010.fc30.x86_64.rpm
> Verifying...                          ################################# [100%]
> warning: Unable to get systemd shutdown inhibition lock: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
> Preparing...                          ################################# [100%]
> Updating / installing...
>    1:dracut-049-4.git20181010.fc30    ################################# [100%]
> [root@turing-police x86_64]# exit
> exit
> 
> Script done on 2018-10-19 22:29:59-04:00
> 
> System stable, RPM works, dnf works, some good-sized compiles worked.
> 
> Looks like it's time to commit that, and add these:
> 
> Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> :)

Fantastic! Thanks for working with me and reporting the issue on
for-next. I'll run the series with the above tomorrow to Jens.

Thanks,
Dennis
