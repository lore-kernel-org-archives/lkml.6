Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F19C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 23:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF40C21A66
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 23:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT7vhVCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF40C21A66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeHLCCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 22:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbeHLCCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 22:02:18 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA46D21A8D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534029990;
        bh=ajaMJ1i8uZ9hlSa9t4FQ4nZLBm4fAPOvowPjl609RwE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qT7vhVCoH8s49JY6YLXf311y0Qy5hbKqhklAVpW/+P/9HQTUxKsIcmo9JtOL/eUaU
         TwrosvrQJyv00oqh5QwBQLH14jvai6/FUYyetbyBqxLfPw/2DkvX7feh/o46xH1Mmx
         5hn2KWjFLWI2ZPhSsw2tFL63S+LVlMA2w71FK4gs=
Received: by mail-wm0-f50.google.com with SMTP id y2-v6so5294465wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 16:26:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlH3XyI9hEelTyMyC40AFvp9kfnTJu4nwlP/1mno5cn7TutveQVc
        4IOUlwBzT1hlq3k7n7WK1T/rKbs2KTP40RsZMJI5gA==
X-Google-Smtp-Source: AA+uWPza/mkwWBrgJT6RlQpRCi3hX4Gxd85Plv0qN1llnn2itZUii8aTw+HWSuzJrpsn+8wAPxReO5/RRBjmbSLg6Hs=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr4523497wmq.36.1534029988197;
 Sat, 11 Aug 2018 16:26:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 16:26:07 -0700 (PDT)
In-Reply-To: <5152.1534018808@warthog.procyon.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk>
 <87in4n9zg0.fsf@xmission.com> <27374.1533824694@warthog.procyon.org.uk>
 <CAJfpegvWE9htLjqeR6=2BWBSuvJzJpWcjBC_EmX_k1RCGXTfbw@mail.gmail.com> <5152.1534018808@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 11 Aug 2018 16:26:07 -0700
X-Gmail-Original-Message-ID: <CALCETrXQgOXbV+XWtgtJSBFXymY3yRdBdkr4PYHGJBsq6zhk2g@mail.gmail.com>
Message-ID: <CALCETrXQgOXbV+XWtgtJSBFXymY3yRdBdkr4PYHGJBsq6zhk2g@mail.gmail.com>
Subject: Re: [PATCH 28/33] vfs: syscall: Add fsconfig() for configuring and
 managing a context [ver #11]
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 1:20 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> You can determine at fsopen() time whether the filesystem is able to
>> support the O_EXCL behavior?  If so, then it's trivial to enable this
>> conditionally.  I think that's what Eric is asking for, it's obviously
>> not fair to ask for a change in behavior of the legacy interface.
>
> It's not trivial, see btrfs and nfs :-/
>

I'm not convinced that btrfs and nfs are the same situation.  As far
as I can tell, in NFS's case, NFS shares superblocks as an
implementation detail.  With Al's example, someone can do:

mount -t nfs4 wank.example.org:/foo/bar /mnt/a
mount -t nfs4 wank.example.org:/baz/barf /mnt/b
mount -t nfs4 wank.example.org:/foo/bar -o wsize=16384 /mnt/c

or equivalently create three fscontexts and FSCONFIG_CMD_CREATE all of
them, and the kernel creates one superblock for /mnt/a and /mnt/b and
a second one for /mnt/c.  That seems like a good optimization, but I
think it really is just an optimization.  In any sane implementation,
all three calls should succeed, and it should in general be possible
to create as many totally fresh mounts of the same network file system
as anyone wants.

Given this example, I think that it may be important to give
FSCONFIG_CMD_RECONFIGURE a very clear definition, and possibly a
definition that doesn't use the word superblock.  After all, if
someone does FSCONFIG_CMD_RECONFIGURE on /mnt/a, if it really
reconfigures a *superblock*, then it will change /mnt/b as a side
effect but will not change /mnt/c.  This seems like a mistake.

But I think that btrfs is quite a bit different.  With btrfs, I can do:

mount -t btrfs /dev/sda1 -o subvol=a /mnt/a
mount -t btrfs /dev/sda1 -o subvol=b /mnt/b

and I get two mounts, each pointing at a different subvolume, that
(I'm pretty sure) share a superblock

mount -t btrfs /dev/sda1 -o subvol=c,foo=bar /mnt/c

where foo is a per-superblock option, it probably gets ignored.  If I
set up /dev/mapper/foo as a linear alias for /dev/sda1 and I do:

mount -t btrfs /dev/mapper/foo -o subvol=d /mnt/d

then I get a fresh superblock.  If /dev/sda1 is still mounted and the
various O_EXCL-like checks don'e catch it, then I get massive
corruption.

The btrfs case seems quite fragile to me, and it seems like a bit of
an abuse of mount(2).  (Of course, basically everything anyone does
with mount(2) is a bit of an abuse.)

I would hope that the new fs mounting API would clean this up.  The
NFS case seems just fine, but for btrfs, it seems like maybe the whole
CMD_CREATE operation should be more fine grained.  There seem to be
*two* actions going on in a btrfs mount.  First there's the act of
instantiating the filesystem driver backed by the device (I think this
is open_ctree()), and *then* there's the act of instantiating a dentry
tree pointing at some subvolume, etc.

ZFS seems to handle this quite nicely.  First you fire up a zpool, and
then you start mounting its volumes.
