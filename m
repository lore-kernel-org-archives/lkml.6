Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCDB218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM2RGHWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCDB218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHJWik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbeHJWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:38:39 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24F222443
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533931638;
        bh=4TWk2KCw4NLl03Adr9PJS4UEz6MH/1QFKlWVAfEqv88=;
        h=In-Reply-To:References:From:Date:Subject:To:From;
        b=cM2RGHWBkqxquM6xf+ewTV1bJ1PQ4BB40c7ZYHSMSAs47lSIgthXkCkFv3mY5LSDR
         Tq3hO6kn9E8EquWtHu1orw6kXbkI/yyuX+YJc39YEo6P3dYyHc8J+gDJ+mI1ZRT/QP
         eajYu6i2/LEqCd+wEIp2I92SFmetmnDCys6dJst4=
Received: by mail-wr1-f48.google.com with SMTP id u12-v6so9274981wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:07:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlGLqzszCnJBaBH+x6yOuHHrD36rx6ncsc8XFny6erNaihbEj3BW
        zbVynuw48AgTaFOirHPNoXAjixvuGxxSulNiTDvj8w==
X-Google-Smtp-Source: AA+uWPyK/DZT9hsqr2W4Wdt5ydBHyQtGZ2PCkiyoZWWRcBKyuIg/rTHqyTzmlhKXiQ5L8C1KqClQMMG2VDEt5x4hCGg=
X-Received: by 2002:adf:eec9:: with SMTP id a9-v6mr5323189wrp.21.1533931635210;
 Fri, 10 Aug 2018 13:07:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 13:06:54 -0700 (PDT)
In-Reply-To: <20180810161400.GA627@thunk.org>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk> <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 10 Aug 2018 13:06:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
Message-ID: <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
Subject: Re: BUG: Mount ignores mount options
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, SELinux-NSA <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>,
        Linux API <linux-api@vger.kernel.org>,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 9:14 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> And I'm not really sure it helps the container use
> case, since the whole point is they want their "guest" to be able to
> blithely run "mount /dev/sda1 -o noxattr /mnt" and not worry about the
> fact that in some other container, someone had run "mount /dev/sda1 -o
> xattr /mnt".  But having the second mount fail because of conflicting
> mount option breaks the illusion that containers are functionally as
> rich as VM's.

If the same block device is visible, with rw access, in two different
containers, I don't see any anything good can happen.  Sure, with the
current somewhat erratic semantics of mount(2), something kind of sort
of reasonable happens if they both mount it.  But if one or both of
them try to use, say, tune2fs or fsck, it's not going to go well.  And
a situation where they mount with different options and the result
depends on the order of the mounts is just plain bad.

I see four sane ways to deal with this:

1. Don't put the block device in the container at all.  The container
manager mounts it.

2. Use seccomp or a similar mechanism to intercept and emulate the
mount request.

3. Teach the filesystem driver to do something sensible.  This will
inherently be per-fs, and probably involves some serious magic or
allowing filesystem-specific vfsmount options.

4. Introduce a concept of a special kind of fake block device that
refers to an existing superblock, doesn't allow direct read or write,
and does the right thing when mounted.  Not obviously worth the
effort.

It seems to me that the current approach mostly involves crossing our fingers.
