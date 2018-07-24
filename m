Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF60C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321D620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="parsyu2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321D620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeGXQY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:24:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41595 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeGXQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:24:59 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so8129829oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+HKEVsXmIk19WxUqQP4wbDNwV6Kbp7/8zkgIPr5CPf0=;
        b=parsyu2JOaZA2hY+cB6KYreq72T8B0Wbnpb+jeeft1Yhu/58r3K5OzVdH8IaCJD2Ds
         vxJEr+RZd7FBCXCLRmvJ/Xok/00c1IINzG63E+fP3OpItAxI+pAbKpgR0XPRH8M+3XQI
         PfHB1KD/OvkUncokGZRRysBfTcep4Sm2os4AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+HKEVsXmIk19WxUqQP4wbDNwV6Kbp7/8zkgIPr5CPf0=;
        b=mPHTEQDIbFDLxyUjtMUyvcwkuNcXC3EiFztML095OICWSl2rxWYEbPsZNP2D75Tbor
         KJiF2K/fCp8cuFc9es5pc6DUfRKnKHIf6OYyPWtiobIeqyGQXLRwSp80dV2RsTzrEpPU
         kJ6IOFt6x2f9G6Ta340SxO42Y7B69rGWfnZQywqr2E+xO54fFp9Nb5x8+LPAFyf3IbWH
         OairFpEevnIJ1J4n2GWt4SGxMze5s5ipTnaEOKws4lfsVEtIoyzTHU+5cVCJNDseHbbi
         mYBcLKGLDyn9JxtsokvHbDS6+CJyRlCszFjKLM8xDndDEcB/YvLXTXXzZ+XsLjjIGlda
         huBA==
X-Gm-Message-State: AOUpUlGVic2PiwJHnGhgYIoba0Qti71K7WCEs6D8Rc9nYjOdYGqF4Oha
        3zWgMBp33dnGHGLFV6eDjmaROOWymutE5xcwi0U2Cg==
X-Google-Smtp-Source: AAOMgpf6wrbuvvZi/V/WPQElAeaRYUwOxcapBs36ZDa2oC3IOIw6wGWGK6Q6O9jxq9LUrv+00uUJwNY4GJm5T3EsvdI=
X-Received: by 2002:aca:a64d:: with SMTP id p74-v6mr3398478oie.149.1532445480762;
 Tue, 24 Jul 2018 08:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:17:59
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
 <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
 <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com> <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Jul 2018 17:17:59 +0200
Message-ID: <CAJfpegtXhRmSTxEbvGZGUCORoxKvsjeJEfFtUEzGuC76ZE3rmA@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 5:19 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jul 23, 2018 at 5:09 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Mon, Jul 23, 2018 at 3:37 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Mon, Jul 23, 2018 at 3:05 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>>> Biggest conceptual problem: your definition of fuse-server is weak.
>>>> Take the following example: process A is holding the fuse device fd
>>>> and is forwarding requests and replies to/from process B via a pipe.
>>>> So basically A is just a proxy that does nothing interesting, the
>>>> "real" server is B.  But according to your definition B is not a
>>>> server, only A is.
>>>
>>> I proposed to abort fuse conn when all fuse device fd's are "killed"
>>> (all processes having the fd opened are killed). So if _only_ process
>>> B is killed, then, yes, it will still hang. However if A is killed or
>>> both A and B (say, process group, everything inside of pid namespace,
>>> etc) then the deadlock will be autoresolved without human
>>> intervention.
>>
>> Okay, so you're saying:
>>
>> 1) when process gets SIGKILL and is uninterruptible sleep mark process as doomed
>> 2) for a particular fuse instance find set of fuse device fd
>> references that are in non-doomed tasks; if there are none then abort
>> fuse instance
>>
>> Right?
>
>
> Yes, something like this.
> Perhaps checking for "uninterruptible sleep" is excessive. If it has
> SIGKILL pending it's pretty much doomed already. This info should be
> already available for tasks.
> Not saying that it's better, but what I described was the other way
> around: when a task killed it drops a reference to all opened fuse
> fds, when the last fd is dropped, the connection can be aborted.

struct task_struct {
[...]
    struct files_struct        *files;
[...]
};

struct files_struct {
[...]
    struct fdtable __rcu *fdt;
[...]
};

struct fdtable {
[...]
    struct file __rcu **fd;      /* current fd array */
[...]
};

So there we have an array of pointers to struct files.  Suppose we'd
magically be able to find files that point to fuse devices upon
receiving SIGKILL, what would we do with them?  We can't close them:
other tasks might still be pointing to the same files_struct.

We could do a global search for non-doomed tasks referencing the same
fuse device, but I have no clue how we'd go about doing that without
racing with forks, fd sending, etc...

Thanks,
Miklos
