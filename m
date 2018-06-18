Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF33C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53C020836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53C020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935610AbeFRUay convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:30:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754801AbeFRUaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E844180125CE;
        Mon, 18 Jun 2018 20:30:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-111.rdu2.redhat.com [10.10.121.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4A497C42;
        Mon, 18 Jun 2018 20:30:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <87in6kptqt.fsf@xmission.com>
References: <87in6kptqt.fsf@xmission.com> <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #8]
From:   David Howells <dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Mon, 18 Jun 2018 21:30:50 +0100
Message-ID: <3949.1529353850@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 18 Jun 2018 20:30:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 18 Jun 2018 20:30:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> I have read through these patches and I noticed a significant issue.
> 
> Today in mount_bdev we do something that looks like:
> 
> mount_bdev(...)
> {
> 	s = sget(..., bdev);
> 	if (s->s_root) {
>         	/* Noop */
>         } else {
>         	err = fill_super(s, ...);
>                 if (err) {
>                 	deactivate_locked_super(s);
>                         return ERR_PTR(err);
>                 }
>                 s->s_flags |= SB_ATTIVE;
>                 bdev->bd_super = s;
>         }
>         return dget(s->s_root);
> }
> 
> The key point is that we don't process the mount options at all if
> a super block already exists in the kernel.  Similar to what
> your fscontext changes are doing (after parsing the options).

Actually, no, that's not the case.

The fscontext code *requires* you to parse the parameters *before* any attempt
to access the superblock is made.  Note that this will actually be a problem
for, say, ext4 which passes a text string stored in the superblock through the
parser *before* parsing the mount syscall data.  Fun.

I'm intending to deal with that particular case by having ext4 create multiple
private contexts, one filled in from the user data, and then a second one
filled in from the superblock string.  These can then be validated one against
the other before the super_block struct is published.

And if the super_block struct already exists, the user's specified parameters
can be validated against that.

> Your fscontext changes do not improve upon this area of the mount api at
> all and that concerns me.  This is an area where people can and already
> do shoot themselves in their feet.

This *will* be dealt with, but I wanted to get the core changes upstream
before tackling all the filesystems.  The legacy wrapper is just that and
should be got rid of when all the filesystems have been converted.

> ...
>
> Creating a new mount and finding an old mount are the same operation in
> the kernel today.  This is fundamentally confusing.  In the new api
> could we please separate these two operations?
>
> Perhaps someting like:
> x create
> x find
> 
> With the "x create" case failing if the filesystem already exists,
> still allowing "x find"?  And with the "x find" case failing if
> the superblock is not already created in the kernel.

No.  What you're suggesting introduces a userspace-userspace and a
userspace-kernel race - unless you're willing to let userspace lock against
superblock creation by other parties.

Further, some filesystems *have* to be parameterised before you can do the
check for the superblock.  Network filesystems, for example, where you have to
set the network parameters upfront and the key to the superblock might not be
known until you've queried the server.

> That should make it clear to a userspace program what is going on
> and give it a chance to mount a filesystem anyway.

That said, I'm willing to provide a "fail if already extant" option if we
think that's actually likely to be of use.  However, you'd still have to
provide parameters before the check can be made.

> In a similar vein could we please clarify the rules for changing mount
> options for an existing superblock are in the new api?

You mean remount/reconfigure?  Note that we have to provide backward
compatibility with every single filesystem.

> Today mount assumes that it has to provide all of the existing options to
> reconfigure a mount.  What people want to do and what most filesystems
> support is just specifying the options that need to be changed.  Can we
> please make this the rule of how this are expected to work for fscontext?
> That only changing mount options need to be specified before: "x
> reconfigure"

Fine by me - but it must *also* support every option being specified if that
is what mount currently does.

I don't really want to supply extra parsers if I can avoid it.  Miklós, for
example wanted a different, incompatible interface, so you'd do:

	write(fd, "o +foo");
	write(fd, "o -bar");
	write(fd, "x reconfig");

sort of thing to enable or disable options... but this assumes that options
are binary and requires a separate parser to the one that does the initial
configuration - and you still have to support the old remount data parse.

I'm okay with specifying that you should just specify the options you want to
change and that the normal way to 'disable' something is to prefix it with
"no".

I guess I could pass a flag through to indicate that this came from
sys_mount(MS_REMOUNT) rather than the new method.

David
