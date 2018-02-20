Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeBTTf6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:35:58 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:39833 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeBTTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:35:56 -0500
X-Google-Smtp-Source: AH8x227fWIFkanQ0k3RjLQzv2jFst9Crr7cYpoRatYfOSljS+AqGenwHoDBtuKJuA/YrfHonVzb8mw==
Date: Tue, 20 Feb 2018 11:35:47 -0800
From: Tejun Heo <tj@kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Subject: Re: A "domain invalid" cgroup *can* sometimes have member tasks
Message-ID: <20180220193547.GB170644@devbig577.frc2.facebook.com>
References: <CAKgNAkgEa9ZEHzoRWv7Y71eFVuFsy8Z4zSazZv9u7NRrx3xG9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkgEa9ZEHzoRWv7Y71eFVuFsy8Z4zSazZv9u7NRrx3xG9Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 08:26:59PM +0100, Michael Kerrisk (man-pages) wrote:
> Hello Tejun
> 
> According to Documentation/cgroup-v2.txt, a "domain invalid" cgroup
> can't have member tasks. And indeed this is generally not permitted.
> 
> However, someone recently showed me a scenario where a "domain
> invalid" cgroup can have member processes. See the following example:
> 
> # mkdir -p /sys/fs/cgroup/unified/grp0/grp1
> # sleep 1000 &
> [1] 10549
> # echo 10549 > /sys/fs/cgroup/unified/grp0/grp1/cgroup.procs
> # echo threaded > /sys/fs/cgroup/unified/grp0/cgroup.type
> # cat /sys/fs/cgroup/unified/grp0/cgroup.type
> threaded
> # cat /sys/fs/cgroup/unified/grp0/grp1/cgroup.type
> domain invalid
> # cat /sys/fs/cgroup/unified/grp0/grp1/cgroup.threads
> 10549
> 
> From the above, we see that the cgroup grp0/grp1 is of type "domain
> invalid" and has a member thread. This seems to be a violation of the
> documented rules, and is I assume a bug, since in the above scenario,
> we are denied from adding further tasks to the grp0/grp1 cgroup:
> 
> # sleep 2000 &
> [2] 10553
> # echo 10553 > /sys/fs/cgroup/unified/grp0/grp1/cgroup.procs
> sh: echo: write error: Operation not supported
> 
> Could you comment please?

Hmm... nr_populated_domain_children check should have caught that
condition and rejected it.  Will look into what's going on.

Thanks.

-- 
tejun
