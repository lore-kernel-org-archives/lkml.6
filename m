Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A3420851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfAv+5xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfAQUzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:55:38 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:40402 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:55:38 -0500
Received: by mail-ua1-f44.google.com with SMTP id n7so3957404uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=reCBh5Fpml3zEC6N9H9XczP0nmnsrLLAqEIK8yVL100=;
        b=qfAv+5xg2+Xr/TmNjDkTQwMZdaWQhL86MYo4Z7vwne4OKlvQ25JPqJirD5S+is+QiA
         FcQX3/Y4Z0TELKX7wzBJrMb6FFTOBVw2x8McHLvQcqOalmUZKcNsvGGleLEO7K9Gt5zc
         JYO1ctsL13Ow+/NWIlEon13r9t5yEit9fPMPqZ/Xn1FV45UbppR0X481VVHaxSkjwCgl
         Esf++V4TPJjzwOIogVuj9gUnhHcIxjYTi3+q0UEnlHPP/9v3DEkx5sXitDr/T/H6IKae
         jvIQNEy4QgRJZ10WGpcSV/OA8VxpGA/A8U2U8mIYPd9/f85wR7SGhTI2op8l0M+WpA46
         DDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=reCBh5Fpml3zEC6N9H9XczP0nmnsrLLAqEIK8yVL100=;
        b=clTRHPE0YLeCOIkfW/fNAB9j6vBM8e0K/1zD+RQc/9woRAd3UzgrmQtQvC8qBMjoT0
         owrnTlKIZHWQiuXtrQ2HvyJ7K1t/I6NcirOjD1CZHEgl33GzR02ZUD95q7rtwINpB04N
         BdMJNKbi8rOXD/4cREBK/Qde79yd7fAflUZlYEh85ch9Zuycplqv8nTC4E45f57cC90D
         wevE62sn81zTdTeSqgQQwHoYOo2Xft9tX5WT+APN3EYIrtd3gRfXSlEKa0GQ1ZREpGBI
         9IlSaNlUEEuaQcImhvtg3kjmBWF/bLR3966gBaK/q3ApTqwUIQrcADSOy+Qb6nsl6Yrv
         xrUw==
X-Gm-Message-State: AJcUukeQGHGFOqYddwCbTEb/mAqumu0ckrSAFgyw4wNca8I3uZEwp7MC
        tJ4BAEwHLvpZElRrPCPjCZfP5H2Jfi4jMbqY7IthwZGA
X-Google-Smtp-Source: ALg8bN7thQ3IGH+hTZbxpu05bZErlmgH36nvyoeG357oBPpPXOmJAYKAf1uIFB8aJeK0Rb3tMihCmNQiGqSaCttwBe8=
X-Received: by 2002:ab0:e03:: with SMTP id g3mr6340431uak.62.1547758536750;
 Thu, 17 Jan 2019 12:55:36 -0800 (PST)
MIME-Version: 1.0
From:   Volodymyr Boyko <boyko.cxx@gmail.com>
Date:   Thu, 17 Jan 2019 22:55:26 +0200
Message-ID: <CAHy8DWa2_6L58nsJhWvF7a-4AttqQvdS5XSQpqaTgk-RDuPWOA@mail.gmail.com>
Subject: EINTR on 'wait'
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

According to http://pubs.opengroup.org/onlinepubs/009695399/functions/wait.html:
>
> The wait() function shall fail if:
> [ECHILD]
> The calling process has no existing unwaited-for child processes.
> [EINTR]
> The function was interrupted by a signal. The value of the location pointed to by stat_loc is undefined.
and  man -e 7 signal:
>
> If a signal handler is invoked while a system call or library function call is blocked, then either:
>
>       * the call is automatically restarted after the signal handler returns; or
>
>       * the call fails with the error EINTR.

> If a blocked call to one of the following interfaces is interrupted by a signal handler, then the call will be automatically restarted after the signal  handler  returns  if  the
>       SA_RESTART flag was used; otherwise the call will fail with the error EINTR:
>
>  * wait(2), wait3(2), wait4(2), waitid(2), and waitpid(2).

So from my understanding of above, if we are blocked in 'wait' and
receiving a signal (SIGCHLD), the call should return with value -1 and
errno set to EINTR.
But the following snippet behaves differently on linux 4.15.0-43
and freebsd 11.2:
>
> #include <stdlib.h>
> #include <unistd.h>
> #include <signal.h>
> #include <stdio.h>
> #include <string.h>
> #include <errno.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> static void sigchld_handler(int signo)
> {
>     const char *const msg = "\nSIGCHLD";
>     (void)signo;
>     write(STDERR_FILENO, msg, strlen(msg));
> }
> int main(void)
> {
>     pid_t wait_ret = 0, pid = 0;
>     int status = 0, ret = -1;
>
>
>
>     sigaction(SIGCHLD, &(struct sigaction){
>        .sa_handler = sigchld_handler,
>     }, NULL);
>
>
>
>     if ((pid = fork()) < 0)
>     {
>        perror("\nfork: ");
>        goto Exit;
>     }
>     if (!pid)
>     {
>        sleep(3);
>        return 0;
>     }
>     if ((wait_ret = wait(&status)) < 0)
>     {
>        perror("\nwait: ");
>        goto Exit;
>     }
>     fprintf(stderr, "\nwait done, pid %d", wait_ret);
>     ret = 0;
> Exit:
>     fprintf(stderr, "\n");
>     return ret;
> }

freebsd and solaris do share my understanding:
>
> SIGCHLD
> wait: : Interrupted system call

but linux:
>
> SIGCHLD
> wait done, pid <child pid>

As to me, it deserves a deeper investigation (if it already is not
proved to be or not to be an issue - I haven't found any mention about
this yet, though dug only a little). if it's really Linux's
nonconformity to POSIX, it should be at least noted in 'wait' manuals.

Thanks.
