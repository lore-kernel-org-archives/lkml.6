Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0F42174E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNmDRJ9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0F42174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeHMTcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbeHMTcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:32:19 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B99F218D7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534178957;
        bh=DHcC8YNu26vSp8BWXL6tQCND0PEZ5HNZ/rtN6KISf5s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iNmDRJ9qVC5leYzp45bXDMXn+j1oG9suhWwO5fm7L+1+kXMgRe2LkA3y/bHkEjNEB
         v2tD0whYGj+d1ycewQGr/dXZxf04GklrMbb2Uers/VUFi6R9tNxY4VlnvQF7T4MykA
         aLcY2dlM9r83dWIY+YAfn9F1LI+fyXpqNKsOhcjs=
Received: by mail-wr1-f48.google.com with SMTP id g6-v6so14880224wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:49:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlFiACqzvXl73rpS5ZiArvkLplHPq8r4x4+ezf0jfQXhE96LX5pb
        lHwFJ05PUMTfiUpU2iCEJOrCZsjK2BrL27SVSXH4KQ==
X-Google-Smtp-Source: AA+uWPz0/o+XyY2k1YLXFqepBao7iY+hmKc0D2fLFZT9wwWLZOckhZ4hf0e9Rwxb2tiRG3T/iwyOxb333Q/VYoJ5htQ=
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr11463178wre.29.1534178954097;
 Mon, 13 Aug 2018 09:49:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:48:53 -0700 (PDT)
In-Reply-To: <20180813173502.1a7a1d9c@alans-desktop>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk> <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org> <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180813173502.1a7a1d9c@alans-desktop>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 Aug 2018 09:48:53 -0700
X-Gmail-Original-Message-ID: <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
Message-ID: <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
Subject: Re: BUG: Mount ignores mount options
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
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

On Mon, Aug 13, 2018 at 9:35 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> If the same block device is visible, with rw access, in two different
>> containers, I don't see any anything good can happen.  Sure, with the
>
> At the raw level there are lots of use cases involving high performance
> data capture, media streaming and the like.
>
> At the file system layer you can use GFS2 for example.

Ugh.  I even thought of this case, and I should have been a bit more precise:

I would consider the GFS2 case to be essentially equivalent to the NFS
case.  I think we can probably divide all the filesystems into three
or four types:

pseudo file systems: Multiple instantiations of the same fs driver
pointing at the same backing store give separate filesystems.  (Same
backing store includes the case where there isn't any backing store.)
tmpfs is an example.  This isn't particularly interesting.

network-like file systems: Multiple instantiations of the same fs
driver pointing at the same backing store are expected.  This includes
NFS, GFS2, AFS, CIFS, etc.  This is only really interesting to the
extent that, if the fs driver internally wants to share state between
multiple instantiations, it should be smart enough to make sure the
options are compatible or that it can otherwise handle mismatched
options correctly.  NFS does this right.

non-network-like filesystems: There are complicated ones like btrfs
and ZFS and simple ones like ext4.  In either case, multiple totally
separate instantiations of the driver sharing the backing store will
lead to corruption.  In cases like ext4, we seem to support it for
legacy reasons, because we're afraid that there are scripts that try
to mount the same block device more than once, and I think the new API
has no need to support this.  In cases like btrfs, we also seem to
support multiple user requests for "mounts" with the same underlying
block devices because we need it for full functionality.  But I think
this is because our API is wrong.

Are there cases I'm missing?  It sounds like the API could be improved
to fully model the last case, and everything will work nicely.
