Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A0CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD35D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Grev2y/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD35D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeGZK2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:28:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37438 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbeGZK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:28:54 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so1717587oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wgkDB5feRXNC5Soq1tGPC03sJitTi8zmsSbhym3idY0=;
        b=Grev2y/opSG6xbf7Xa4Gxut63kmCKcw0WV3sd1d+Ec1Bl1FtHZn9ZGTXLvBC1eICkP
         u1drlfljtV34XzfdRAyXGOu/YtO/MyuECl8SxZ9CWgl3zZsO/WXUY6c+1MwXnHWnTT/A
         9SIHXUu3YGgYWKwkyVdLzN4OtFEirvz/4GXEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wgkDB5feRXNC5Soq1tGPC03sJitTi8zmsSbhym3idY0=;
        b=XJE6Pjs7ExVL+wt77BkfTb5lo77JLP7jvFaqjl9D+yqboSNodL/4zN2hcBhKSXnfKG
         T90KyNu52njMyTj35JuMoe1evcUmWTzCzE7oR+5pfagPmVHwyb7fjEJPYiBAoPVyo6O7
         Av2QJQJCl5o6n6NLnUafTK+tOJ+x0qXbrfY0gZMpee2kXEwGBIFdF32wgLqfF7FGFdJB
         39cU14X6gltmwvF12t5oE2loEiLQnacxW5VeQMUHXv1DleFutYBbUiLDd6nWMBg7dnL6
         knoaz39o/WCU7B7my37LIYiOigZTxSUlgQuuyLCPefuktCUSo7LkFC0fXfm2mW9YN5+S
         lDRg==
X-Gm-Message-State: AOUpUlHt3iMI6djI4/v7mrGACKGE1a9G/spEtaEO2JjSi7N/HwO/2b7D
        50KqUlwE3/Aq4hcHO2t0PUQqWAm7H6Js0Katj+WAYQ==
X-Google-Smtp-Source: AAOMgpf/Nh3T2ZYspfl6Ala3DZkXlqt4+NGnbam+XXOTp5nOO7WCRsVyC4i3DB/pGd1fyWwNVbTWgGAkUYyao2S5ST4=
X-Received: by 2002:aca:d04b:: with SMTP id h72-v6mr1033922oig.17.1532596380011;
 Thu, 26 Jul 2018 02:13:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:12:59
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CAJfpegvp8xEJc2-MkQvS-HEhtTAt-sZb1VvDPPUx1c+FdqcjEg@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com>
 <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
 <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
 <CACT4Y+YiGEX7_naGDTDNWCKnjQAisYrmBOYNejasfidaCRP7xA@mail.gmail.com>
 <CAJfpegtXhRmSTxEbvGZGUCORoxKvsjeJEfFtUEzGuC76ZE3rmA@mail.gmail.com>
 <CACT4Y+ZZ_v6izsiCGym=r+MiRmxaFE=eH54dz7t0BOQ7VxTNiw@mail.gmail.com> <CAJfpegvp8xEJc2-MkQvS-HEhtTAt-sZb1VvDPPUx1c+FdqcjEg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jul 2018 11:12:59 +0200
Message-ID: <CAJfpegsbfRSYtjVGtGjik=1UNnh=T1AmBjpvNU3G382FxD-sNQ@mail.gmail.com>
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

On Thu, Jul 26, 2018 at 10:44 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Wed, Jul 25, 2018 at 11:12 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Tue, Jul 24, 2018 at 5:17 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:

>> Maybe more waits in fuse need to be interruptible? E.g. request_wait_answer?
>
> That's an interesting aspect.  Making request_wait_answer always be
> killable would help with the issue you raise (killing set of processes
> taking part in deadlock should resolve deadlock), but it breaks
> another aspect of the interface.
>
> Namely that userspace filesystems expect some serialization from
> kernel when performing operations.  If we allow killing of a process
> in the middle of an fs operation, then that serialization is no longer
> there, which can break the server.
>
> One solution to that is to duplicate all locking in the server
> (libfuse normally), but it would not solve the issue for legacy
> libfuse or legacy non-libfuse servers.  It would also be difficult to
> test.  Also it doesn't solve the problem of killing the server, as
> that alone doesn't resolve the deadlock.

Umm, we can actually do better.   Duplicate all vfs locking in the
fuse kernel implementation: when killing a task that has an
outstanding request, return immediately (which results in releasing
the VFS level lock and hence the deadlock) but hold onto our own lock
until the reply from the userspace server comes back.

Need to think about the details; this might not be easy to do this
properly.   Notably memory management locks (page->lock, mmap_sem,
etc) are notoriously tricky.

Thanks,
MIklos
