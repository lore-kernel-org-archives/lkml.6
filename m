Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212512064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212512064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKBCWD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:22:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeKBCWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:22:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 884F330832D1;
        Thu,  1 Nov 2018 17:18:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78E1F1054FD9;
        Thu,  1 Nov 2018 17:18:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
References: <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com> <20181031053355.GQ32577@ZenIV.linux.org.uk> <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com> <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, swhiteho@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ebiederm@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] mount API series
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28155.1541092687.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 01 Nov 2018 17:18:07 +0000
Message-ID: <28156.1541092687@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 01 Nov 2018 17:18:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Exactly because it splits up what used to be an atomic sequence,

No.  What we have upstream now is most definitely *not* atomic.  That said,
some of the steps of the sequence are atomic in their own right:

 - Creation and initialisation of the superblock
 - Creation of the vfsmount
 - Attachment of a new vfsmount

and these units have not changed.  What I have done is to extract the
parameter processing and move it to the front and provided a way to provide
more exotic parameters more easily.  This means that all parse errors are
found before we start creating objects and applying parameters (which is a bug
in some of our existing remount operations that this fixes).

Also, as the parameters are passed one at a time, I've also inserted a
validation step so that the parameter set as a whole can be checked for
inter-parameter consistency before any object creation is performed.

Note further that upstream, remount/reconfiguration is *not* atomic, but with
these changes that becomes closer to being realisable.  I've looked into how
to do it for btrfs using RCU and a CoW'd struct with the settings in, but
that's a much bigger, more intrusive change that doesn't need to be coupled to
the mount API changes.

> I worry about the intermediate states having issues (the refcounting things
> we've already seen, for example), but I also worry about the fact that it
> completely changes the model, and that that makes things like security hooks
> fundamentally different.

A lot of the recent bugs aren't from fsopen()/fsconfig()/fsmount() at all, but
rather from the open_tree() syscall and, to a lesser extent, the move_mount()
syscall.

Would you be willing to take just the *internal* fs_context changes and leave
the UAPI for the next window?  I have patches that make NFS and BTRFS use it,
which would then allow me to remove nearly 1000 lines of LSM code[1], but I
can't reasonably ask Trond and Chris to take them unless there's some schedule
to get the core dependencies in.

[1] See the "security: Remove the set_mnt_opts and clone_mnt_opts ops" commit
    here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=btrfs-mount-api

> The latter may not be a "bug" in the sense that it's all intentional,
> but it does mean that I see *one* mount-time security hook now having
> been replaced by *five* security hooks.

That's not really accurate.  I'm adding:

 (1) security_fs_context_parse_param()
 (2) security_fs_context_validate()
 (3) security_sb_get_tree()
 (4) security_sb_reconfigure()
 (5) security_sb_mountpoint()
 (6) security_move_mount()

Hook (1) allows individual mount parameters to examined/removed and then (2)
allows the whole set to be checked for consistency.  This is just parameter
parsing and checking.

Then (3) allows super_block::security to be initialised and (4) allows an
LSM's sb parameters to be reconfigured by remount (or changes to be
prohibited).  These use the context set up by (1) and checked by (2).

Finally, (5) is used to check that a mountpoint may be used and (6) to see if
a mount may be moved.

Further, I'm actually removing more than one:

 (1) security_sb_kern_mount()
 (2) security_sb_remount()
 (3) security_sb_copy_data()
 (4) security_sb_set_mnt_opts()
 (5) security_sb_clone_mnt_opts()
 (6) security_sb_parse_opts_str()

But four of them are only applicable to NFS and BTRFS, and can only be removed
after those have been dealt with.

> And that's ignoring the alloc/dup/free ones.

Yes, for the record, I'm adding:

 (7) security_fs_context_alloc()
 (8) security_fs_context_dup()
 (9) security_fs_context_free()

to allow the LSM to store data in the fs_context.

> As far as I can tell, the patch-series simply added the hooks. It made
> no attempt at making sure that previous hooks had sane semantics.

Ummm...  I can't say that what's upstream has sane semantics - that's not
really the focus of these patches.  What I've tried to do is to retain the
behaviour where possible.

> Do they?  So now a system that has an old mount hook can be bypassed by
> simplky using the new model instead.

Not so easily.  The LSM is *still* being consulted and I think both in SELinux
and Smack the same rules will still be applied.

There's a case in AppArmor that requires a rejigging of the FSM compiler to
make it work, and I discussed this with John Johansen at the LSS in Edinburgh
last week, but we can simply disallow the use of the new API with AppArmor.

> I dunno. The patches are illegible in this regard (and I don't blame
> the fsmount ones, I blame the security subsystem that just is full of
> random indirection to random sub-security systems, which in turn just
> have hash lookups for data structures set up by other operations
> entirely).
> 
> Eric was pointing out bugs as late as the weekend before the merge
> window opened. That, to me, does not say "ready for the merge window".

Actually, Alan Jenkins has been mostly the one pointing out the bugs and I
think we've got them all.  Leastways, I haven't heard more from him.

FWIW, the patches have been in linux-next for about two cycles now.

David
