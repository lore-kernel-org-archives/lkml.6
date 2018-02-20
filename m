Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBTT1X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:27:23 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36934 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeBTT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:27:21 -0500
X-Google-Smtp-Source: AH8x227/OGyJJ6eoV5eGFQSTiyY0t5DnvVj1hirCI+IzFb9omKot2AYGSlFA4daP4EzbWwTiDI6m8oc7SvCkTvy1PO8=
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Tue, 20 Feb 2018 20:26:59 +0100
Message-ID: <CAKgNAkgEa9ZEHzoRWv7Y71eFVuFsy8Z4zSazZv9u7NRrx3xG9Q@mail.gmail.com>
Subject: A "domain invalid" cgroup *can* sometimes have member tasks
To: Tejun Heo <tj@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun

According to Documentation/cgroup-v2.txt, a "domain invalid" cgroup
can't have member tasks. And indeed this is generally not permitted.

However, someone recently showed me a scenario where a "domain
invalid" cgroup can have member processes. See the following example:

# mkdir -p /sys/fs/cgroup/unified/grp0/grp1
# sleep 1000 &
[1] 10549
# echo 10549 > /sys/fs/cgroup/unified/grp0/grp1/cgroup.procs
# echo threaded > /sys/fs/cgroup/unified/grp0/cgroup.type
# cat /sys/fs/cgroup/unified/grp0/cgroup.type
threaded
# cat /sys/fs/cgroup/unified/grp0/grp1/cgroup.type
domain invalid
# cat /sys/fs/cgroup/unified/grp0/grp1/cgroup.threads
10549

>From the above, we see that the cgroup grp0/grp1 is of type "domain
invalid" and has a member thread. This seems to be a violation of the
documented rules, and is I assume a bug, since in the above scenario,
we are denied from adding further tasks to the grp0/grp1 cgroup:

# sleep 2000 &
[2] 10553
# echo 10553 > /sys/fs/cgroup/unified/grp0/grp1/cgroup.procs
sh: echo: write error: Operation not supported

Could you comment please?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
