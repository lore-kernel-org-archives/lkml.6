Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7214E21C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfRMNQ9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7214E21C3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeHIJjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:39:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46738 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeHIJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:39:35 -0400
Received: by mail-qk0-f193.google.com with SMTP id 191-v6so3356278qki.13;
        Thu, 09 Aug 2018 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+psD0vvXvEYpboGU5d/bYxEwYMPTfqAERH7O6PL0kCY=;
        b=tfRMNQ9Xv+HlWvCG1XOdPy7JZoZ/j/7hK+dbwMiQMnI2xb+aV9vUl/jni9dEJoOyGX
         +ozw/nw733qTps51AR2HNaMEOEemMsQd4BRfVxCYpbvYjmMudrK1BI9Qn8rP9+OnuYzR
         kgv3Ebc6wZW6MhoVmbH3QJEa+4N8PknhubQntkEjlwMf+d9u3QMqtnjA7EvxsFGDUnNq
         6FowS6JCsVp938rPfE2PsZ9F86m3NlrGf3BfzHezmqmF/nM8fwi499ENWPHlt/YE4VBc
         3bhb+i4yKjytS+QYkufjdYksCiXmo5yR83gT3+nQxOowl0CB7NJCD/nf1EkRTBucocIG
         UX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+psD0vvXvEYpboGU5d/bYxEwYMPTfqAERH7O6PL0kCY=;
        b=nYWB6j+n6IKhizZ+g81qDaesYkhE4ypoG2sgpmZySlaZUM1ymKlWaTkoU9hNGjYzfC
         ScJzUjZbIkJrPQbbZ2ylI1wqTNyMpJ9VR5PAXGO+rIhHECPkVLKNjvBIV8niYLY0CNCp
         GuBnZlmPEdG01b90kmxm1OVWG2nKIxPNAG++18GyjbXoNLexOiwoxVuJU5+r9P9KaL5p
         /uBROnMeX7BhSogcJhi9wED2UAH8gjM2LakzwN2mbKYvcd6hd/UzoiUuepy3CKiKchx6
         JrBZ9ebg2F5nnfzESkcDYStd6Df59qmIzFAxJ9ZIy6w5wngJwW6xZqUnCJ0wiiq4c8+X
         NLvA==
X-Gm-Message-State: AOUpUlG4jRGhqGx05+oRjbeKw4UNO0N59mwKKZPbu9r3QinMeb0LCmE7
        LQZG/4vFXPVdOH2M4VP9568UMprJ5Mwj9pHSJQw=
X-Google-Smtp-Source: AA+uWPyJkfSdJyBI8VUPuPf6NeogL2hMRCFCowrATOeWbbqGGfxCAGqa0N7oNnebTK5+ak36CeMW67kbGYeZfmZrgHM=
X-Received: by 2002:a37:4150:: with SMTP id o77-v6mr770523qka.78.1533798965545;
 Thu, 09 Aug 2018 00:16:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f192:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 00:16:05 -0700 (PDT)
In-Reply-To: <20180608142712.32460-1-khorenko@virtuozzo.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Thu, 9 Aug 2018 15:16:05 +0800
Message-ID: <CADJHv_uWB=kS0=rFnaAUFk1X+xy3BWHH=6pOk+uJQNBQS04hcg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs/lock: show locks info owned by dead/invisible processes
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vasily Averin <vvs@virtuozzo.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like this missed v4.18 ?

Thanks,
Murphy

On Fri, Jun 8, 2018 at 10:27 PM, Konstantin Khorenko
<khorenko@virtuozzo.com> wrote:
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
> --
> 2.15.1
>
