Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849AB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kiFtOrw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849AB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbeGWNeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:34:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34917 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387956AbeGWNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:34:09 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so792941oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YxlAy4AVdefMtO4348qcH8D7Xq5kPHwrbqPswzbOznE=;
        b=kiFtOrw3wiyTG1K09IWZ+YUPHSJZHPVcweHu2R0jDTugrKpSGwi1s4lz3jDLag8haj
         Fy8N2IdSWNYepw6S5mCUqGqgdO2rFk9rCOpihyl5GwinS3sy2K6hotIcIzZabbY/kJ2y
         ets/jnPOrevs1XXFLx2nknBE7EY8+a/nfkDQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YxlAy4AVdefMtO4348qcH8D7Xq5kPHwrbqPswzbOznE=;
        b=CcUKX0MqMBqCE/BjNfLZ8pqMxC/xjhY2RCqefESQX/q1p3nEacUMlPbRwZ/nQb8gz5
         JL73CO6DXe112eDdHIVwhl3k+6HlDbcz2CFa2+iyIsdTF74NVgDWsDard007V9H7c1bF
         p+wmp8FL9vAKDrhh89Ae3Fv4Vo20FWh8D+DsbbpK4vWZ2eFYT4BMSy3R+N9ul7bW+JZs
         f8lrHWLT521cIN/Z2+abcw1zPoNJ3NX58jG7wAKLNGLuGiuhCIW9ngZBMekOLTAqgHmQ
         N5/GMo3/KnslzNaM8PkLBlQnsrvPPZwOppAM+GQBt/BxfOhaB90zjNesdtQDTtBr9PZA
         B77Q==
X-Gm-Message-State: AOUpUlF6yPtMh4CrM7IpwtGQKOoTM0EH8yMTrdB2994F/cSyMJlQrIj0
        xBnu6tVgZjwZV9ATarz20y1BUz0JBQXYcjmSWmGBBw==
X-Google-Smtp-Source: AAOMgpeiMBJ8SeC5n/WKfF/wYPoYuUInRXV+iTvd3dTRKpMNdxp+hnRT5ZCFQX+njLLaWMyHk1Z9cuqQygLINEN8dW4=
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr8917431oif.104.1532349189253;
 Mon, 23 Jul 2018 05:33:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 05:33:08
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com> <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Jul 2018 14:33:08 +0200
Message-ID: <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 2:22 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jul 23, 2018 at 2:12 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Mon, Jul 23, 2018 at 10:11 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Mon, Jul 23, 2018 at 9:59 AM, syzbot
>>> <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1324f794400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000
>>>
>>>
>>> Hi fuse maintainers,
>>>
>>> We are seeing a bunch of such deadlocks in fuse on syzbot. As far as I
>>> understand this is mostly working-as-intended (parts about deadlocks
>>> in Documentation/filesystems/fuse.txt). The intended way to resolve
>>> this is aborting connections via fusectl, right?
>>
>> Yes.  Alternative is with "umount -f".
>>
>>> The doc says "Under
>>> the fuse control filesystem each connection has a directory named by a
>>> unique number". The question is: if I start a process and this process
>>> can mount fuse, how do I kill it? I mean: totally and certainly get
>>> rid of it right away? How do I find these unique numbers for the
>>> mounts it created?
>>
>> It is the device number found in st_dev for the mount.  Other than
>> doing stat(2) it is possible to find out the device number by reading
>> /proc/$PID/mountinfo  (third field).
>
> Thanks. I will try to figure out fusectl connection numbers and see if
> it's possible to integrate aborting into syzkaller.
>
>>> Taking into account that there is usually no
>>> operator attached to each server, I wonder if kernel could somehow
>>> auto-abort fuse on kill?
>>
>> Depends on what the fuse server is sleeping on.   If it's trying to
>> acquire an inode lock (e.g. unlink(2)), which is classical way to
>> deadlock a fuse filesystem, then it will go into an uninterruptible
>> sleep.  There's no way in which that process can be killed except to
>> force a release of the offending lock, which can only be done by
>> aborting the request that is being performed while holding that lock.
>
> I understand that it is not killed today, but I am asking if we can
> make it killable. It's all code that we can change, and if a human
> operator can do it, it can be done pure programmatically on kill too,
> right?

Hmm, you mean if a process is in an uninterruptible sleep trying to
acquire a lock on a fuse filesystem and is killed, then the fuse
filesystem should be aborted?

Even if we'd manage to implement that, it's a large backward
incompatibility risk.

I don't argue that it can be done, but I would definitely argue *if*
it should be done.

Thanks,
Miklos
