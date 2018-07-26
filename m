Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6DD2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GnBBjlko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6DD2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeGZKAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:00:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40804 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:00:15 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so1588630oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vKG4nx8cj6QtsEqL/MXK9fjLzuVHKFfzTjQcaA+mqkI=;
        b=GnBBjlkoRq7M8SdNoORFXszqNsUhiCPy6r87Hul0NlCYSjKG2JU3felJUzTsQTIxWR
         c34if0YboUYToGg8WUYoUQlzUvDRqVsu8PRC3t9AjzKKzAzMIYoUwzyeE0LuhmuSSVc4
         Iqpd37LBV1Vi+YKsQo8kCikKmr8IaGuz3e4Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vKG4nx8cj6QtsEqL/MXK9fjLzuVHKFfzTjQcaA+mqkI=;
        b=RCjTZTp6dx3zRCwULcwVW1Rj11uBZ6U7lqF94qxAzqvr/GWbld8K8nBjuoA/3JEQrC
         dqgNY2svTxTAps6eUASh/BloG5uiWW2XftisE/fhaVhCbHLobRgk8I/5lzub3ANeULAb
         4XA+3IVVI0OSJVTghHGZHNyjWym2zzp8hBHysX4r0LjDq54bjG7APJV8+Az/VDcvu3d6
         gS3MeLHjriFWMN1NWcbELaQ66FlW3xMnTdeCDxJoh18O1d5qUHudzCg5bfKbN/zph8yX
         /MvC/aCPL/yqjIgW6hSmaCblXJ+PQkHg+cS7Zv6pJdgA/tt1zYf8UtwkIJf0ywuXoJk4
         kjsw==
X-Gm-Message-State: AOUpUlEJeMS95RLTqGeHBEZCmWPyv8zqohsVWYpVOOe7/A4KuzQqYdTf
        +MeD4cTWq0lvfW5V9tUX2fNub+NVDIM/StJIok+o9g==
X-Google-Smtp-Source: AAOMgpcIoifq2cobyl1fPNCs9CY2l++YdM/MUyFkHWu5f6mmVGOMrBB3x5YcbHrmE8WEOdkVZGXdzujU27rA5KCA3nc=
X-Received: by 2002:aca:ce0f:: with SMTP id e15-v6mr1067359oig.13.1532594666833;
 Thu, 26 Jul 2018 01:44:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 01:44:26
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CACT4Y+ZZ_v6izsiCGym=r+MiRmxaFE=eH54dz7t0BOQ7VxTNiw@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
 <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
 <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
 <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com>
 <CAJfpegtXhRmSTxEbvGZGUCORoxKvsjeJEfFtUEzGuC76ZE3rmA@mail.gmail.com> <CACT4Y+ZZ_v6izsiCGym=r+MiRmxaFE=eH54dz7t0BOQ7VxTNiw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jul 2018 10:44:26 +0200
Message-ID: <CAJfpegvp8xEJc2-MkQvS-HEhtTAt-sZb1VvDPPUx1c+FdqcjEg@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_reverse_inval_entry
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:12 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Jul 24, 2018 at 5:17 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>> Biggest conceptual problem: your definition of fuse-server is weak.
>>>>>> Take the following example: process A is holding the fuse device fd
>>>>>> and is forwarding requests and replies to/from process B via a pipe.
>>>>>> So basically A is just a proxy that does nothing interesting, the
>>>>>> "real" server is B.  But according to your definition B is not a
>>>>>> server, only A is.
>>>>>
>>>>> I proposed to abort fuse conn when all fuse device fd's are "killed"
>>>>> (all processes having the fd opened are killed). So if _only_ process
>>>>> B is killed, then, yes, it will still hang. However if A is killed or
>>>>> both A and B (say, process group, everything inside of pid namespace,
>>>>> etc) then the deadlock will be autoresolved without human
>>>>> intervention.
>>>>
>>>> Okay, so you're saying:
>>>>
>>>> 1) when process gets SIGKILL and is uninterruptible sleep mark process as doomed
>>>> 2) for a particular fuse instance find set of fuse device fd
>>>> references that are in non-doomed tasks; if there are none then abort
>>>> fuse instance
>>>>
>>>> Right?
>>>
>>>
>>> Yes, something like this.
>>> Perhaps checking for "uninterruptible sleep" is excessive. If it has
>>> SIGKILL pending it's pretty much doomed already. This info should be
>>> already available for tasks.
>>> Not saying that it's better, but what I described was the other way
>>> around: when a task killed it drops a reference to all opened fuse
>>> fds, when the last fd is dropped, the connection can be aborted.
>>
>> struct task_struct {
>> [...]
>>     struct files_struct        *files;
>> [...]
>> };
>>
>> struct files_struct {
>> [...]
>>     struct fdtable __rcu *fdt;
>> [...]
>> };
>>
>> struct fdtable {
>> [...]
>>     struct file __rcu **fd;      /* current fd array */
>> [...]
>> };
>>
>> So there we have an array of pointers to struct files.  Suppose we'd
>> magically be able to find files that point to fuse devices upon
>> receiving SIGKILL, what would we do with them?  We can't close them:
>> other tasks might still be pointing to the same files_struct.
>>
>> We could do a global search for non-doomed tasks referencing the same
>> fuse device, but I have no clue how we'd go about doing that without
>> racing with forks, fd sending, etc...
>
>
> Good questions for which I don't have answers.
>
> Maybe more waits in fuse need to be interruptible? E.g. request_wait_answer?

That's an interesting aspect.  Making request_wait_answer always be
killable would help with the issue you raise (killing set of processes
taking part in deadlock should resolve deadlock), but it breaks
another aspect of the interface.

Namely that userspace filesystems expect some serialization from
kernel when performing operations.  If we allow killing of a process
in the middle of an fs operation, then that serialization is no longer
there, which can break the server.

One solution to that is to duplicate all locking in the server
(libfuse normally), but it would not solve the issue for legacy
libfuse or legacy non-libfuse servers.  It would also be difficult to
test.  Also it doesn't solve the problem of killing the server, as
that alone doesn't resolve the deadlock.

Thanks,
Miklos
