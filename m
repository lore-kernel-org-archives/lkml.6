Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D2025C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901BA208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901BA208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964869AbeFNLNu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:13:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964838AbeFNLNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:13:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CA7A859A8;
        Thu, 14 Jun 2018 11:13:46 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FCAD111D3CB;
        Thu, 14 Jun 2018 11:13:45 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Konstantin Khorenko" <khorenko@virtuozzo.com>,
        "Jeff Layton" <jlayton@kernel.org>
Cc:     "Kirill Gorkunov" <kgorkunov@virtuozzo.com>,
        "Andrey Vagin" <avagin@virtuozzo.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Vasily Averin" <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs/lock: show locks info owned by dead/invisible
 processes
Date:   Thu, 14 Jun 2018 07:13:22 -0400
Message-ID: <98D5E5F1-65D6-44C1-9E7C-C5A9043BC29F@redhat.com>
In-Reply-To: <20180608142712.32460-1-khorenko@virtuozzo.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 14 Jun 2018 11:13:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 14 Jun 2018 11:13:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bcodding@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Jun 2018, at 10:27, Konstantin Khorenko wrote:

> The behavior has been changed after 9d5b86ac13c5 ("fs/locks: Remove 
> fl_nspid
> and use fs-specific l_pid for remote locks")
> and now /proc/$PID/fdinfo/$FD does not show the info about the lock
> * if the flock owner process is dead and its pid has been already 
> freed
> or
> * if the lock owner is not visible in current pidns.
>
> CRIU uses this interface to store locks info during dump and thus can 
> break
> on v4.13 and newer.
>
> So let's show info about locks anyway in described cases (like it was 
> before
> 9d5b86ac13c5), but show pid number saved in file_lock struct if we are 
> in
> init_pid_ns (patch 1) or just zero otherwise (patch 2) like we do with 
> SID.
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
>   fs/lock: skip lock owner pid translation in case we are in 
> init_pid_ns
>   fs/lock: show locks taken by processes from another pidns


These look good to me too.  It makes sense that we treat pid numbers out 
of
our namespace in the same way we'd treat remote pids, by returning 0 
instead
of skipping their display altogether.  You can add my

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

to these two.

Ben
