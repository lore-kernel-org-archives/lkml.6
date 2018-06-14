Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E6ACBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8EA208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Z7kH68u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8EA208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754997AbeFNKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754857AbeFNKlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:41:21 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BDA208CB;
        Thu, 14 Jun 2018 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528972881;
        bh=GSLLYrtGeb9CojeSy2RWtQ5ZoBNxTgwm6fujxy4HvNk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=0Z7kH68uFNcYFy9d8T7MzyvQfbGYv4iCuYexiXq7gDd88jkajt9poDW9l3wxzOrtv
         uk2bFR0nDZKM5Bl8h8xgtAsPmI7/KX+gYVFWyrCXYq/LIA/t1nkhGmwcAAotDP9hcl
         Z6oJUQQ6olRsukPH7rFxUXbACNhJsjsMymJ8MrV4=
Message-ID: <8f1ff99c80db2df5947bd7880028818e2e878fdd.camel@kernel.org>
Subject: Re: [PATCH 0/2] fs/lock: show locks info owned by dead/invisible
 processes
From:   Jeff Layton <jlayton@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Jun 2018 06:41:18 -0400
In-Reply-To: <20180608142712.32460-1-khorenko@virtuozzo.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 17:27 +0300, Konstantin Khorenko wrote:
> The behavior has been changed after 9d5b86ac13c5 ("fs/locks: Remove fl_nspid
> and use fs-specific l_pid for remote locks")
> and now /proc/$PID/fdinfo/$FD does not show the info about the lock
> * if the flock owner process is dead and its pid has been already freed
> or
> * if the lock owner is not visible in current pidns.
> 
> CRIU uses this interface to store locks info during dump and thus can break
> on v4.13 and newer.
> 
> So let's show info about locks anyway in described cases (like it was before
> 9d5b86ac13c5), but show pid number saved in file_lock struct if we are in
> init_pid_ns (patch 1) or just zero otherwise (patch 2) like we do with SID.
> 
> Reproducer:
> process A       process A1      process A2
> fork()--------->
> exit()          open()
>                 flock()
>                 fork()--------->
>                 exit()          sleep()
> 
> Before the patch:
> ================
> (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
> pos:    4
> flags:  02100002
> mnt_id: 257
> lock:   (root@vz7)/:
> 
> After the patch:
> ===============
> (root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
> pos:    4
> flags:  02100002
> mnt_id: 295
> lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF
> 
> ===============
> # cat flock1.c
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/file.h>
> #include <fcntl.h>
> 
> int main(void)
> {
>         int fd;
>         int err;
>         pid_t child_pid;
> 
>         child_pid = fork();
>         if (child_pid == -1)
>                 perror("fork failed");
>         if (child_pid) {
>                 exit(0);
>         }
> 
>         fd = open("/tmp/a", O_CREAT | O_RDWR);
>         if (fd == -1)
>                 perror("Failed to open the file");
> 
>         err = flock(fd, LOCK_EX);
>         if (err == -1)
>                 perror("flock failed");
> 
>         child_pid = fork();
>         if (child_pid == -1)
>                 perror("fork failed");
>         if (child_pid)
>                 exit(0);
> 
>         sleep(10000);
> 
>         return 0;
> }
> 
> Konstantin Khorenko (2):
>   fs/lock: skip lock owner pid translation in case we are in init_pid_ns
>   fs/lock: show locks taken by processes from another pidns
> 
>  fs/locks.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

These look fine to me. I'll plan to pick them up for v4.19 unless anyone
has objections.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
