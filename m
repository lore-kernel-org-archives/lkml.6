Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290821928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbeLUQZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:25:22 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49070 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeLUQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:25:21 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gaNbz-0000lk-1O; Fri, 21 Dec 2018 09:25:19 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gaNbx-0004Yu-Nv; Fri, 21 Dec 2018 09:25:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
        <87a7mut9cm.fsf@xmission.com>
        <2f4a2d58-dc7b-3a8f-65aa-9db432ce0a1e@redhat.com>
        <877ehjkq07.fsf@xmission.com>
        <20181112205439.GF32577@ZenIV.linux.org.uk>
        <20181217231000.GA30610@ZenIV.linux.org.uk>
Date:   Fri, 21 Dec 2018 10:25:08 -0600
In-Reply-To: <20181217231000.GA30610@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 17 Dec 2018 23:10:00 +0000")
Message-ID: <87efaa97a3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gaNbx-0004Yu-Nv;;;mid=<87efaa97a3.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AcxsipWQ+aOM/aEjrQBXYcEOe9oAatBw=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [git pull] mount API series
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Nov 12, 2018 at 08:54:39PM +0000, Al Viro wrote:
>> On Sun, Nov 11, 2018 at 08:07:20PM -0600, Eric W. Biederman wrote:
>> > Steven Whitehouse <swhiteho@redhat.com> writes:
>> 
>> > > Can you share some details of what this NULL dereference is? David and
>> > > Al have been working on the changes as requested by Linus later in
>> > > this thread, and they'd like to tidy up this issue too at the same
>> > > time if possible. We are not asking you to actually provide a fix, in
>> > > case you are too busy to do so, however it would be good to know what
>> > > the issue is so that we can make sure that it is resolved in the next
>> > > round of patches,
>> > 
>> > https://lore.kernel.org/lkml/87bm7n5k1r.fsf@xmission.com/
>> 
>> Thought it had been dealt with, but you are right - oops is still there
>> and obviously needs fixing.  However, looking at that place in mainline...
>> How does that thing manage to work?  Look:
>>         /* Notice when we are propagating across user namespaces */
>>         if (m->mnt_ns->user_ns != user_ns)
>>                 type |= CL_UNPRIVILEGED;
>>         child = copy_tree(last_source, last_source->mnt.mnt_root, type);
>>         if (IS_ERR(child))
>>                 return PTR_ERR(child);
>>         child->mnt.mnt_flags &= ~MNT_LOCKED;
>>         mnt_set_mountpoint(m, mp, child);
>>         last_dest = m;
>>         last_source = child;

[Moved this question up as it's answer is a good foundation for the
rest]

> FWIW, I don't believe that CL_UNPRIVELEGED approach is workable; the logics
> we want is, AFAICS, "when destination is not yours, whatever you attach to
> it should be all locked".  Correct?

Kinda sorta.

There is a tree of privilege.  Mount namespaces owned by a more
privileged user_ns can propagate to slaves in a mount namespace owned by
less privileged user_ns.  Because the required permission for the making
the initial mount are insufficient a mount can not propagate from a less
privileged mount namespace to a more privileged mount namespace.

When propagating from a more privileged mount namespace to a less
privileged mount namespace we want to maintain some properties.

1) That mounts that propogate together are locked together.
2) That the mount flags readonly, nodev, nosuid, and noexec
   when set in a more privileged mount namespace are not changeable
   in a less privileged mount namespace.

>> OK, we'd created the copy to be attached to the next candidate mountpoint.
>> If we have e.g. a 4-element peer group, we'll start with what we'd been
>> asked to mount, then call that sucker three times, getting a copy for
>> each of those mountpoints.  Right?  Now, what happens if the 1st, 3rd and
>> 4th members live in your namespace, with the second one being
>> elsewhere?

As I understand the question we have a bug in the mount propagation
tree.  All peers need to be in mount namespaces that share a user
namespace.

Further copy_tree fundamentally needs to copy from either a peer node to
a peer node or a master node to a slave node to achieve the correct
results when setting up the propagation tree.

So I don't currently see how the logic in propgate_mnt could
possibly get into a problematic situation.

>> We have
>> 	source_mnt: that'll go on top of the 1st mountpoint
>> 	copy of source_mnt: that'll go on top of the 2nd mountpoint
>> 	copy of copy of source_mnt: that'll go on top of the 3rd mountpoint
>> 	copy of copy of copy of source_mnt: that'll go on top of the 4th one
>> And AFAICS your logics there has just made sure that everything except the
>> source_mnt will have MNT_LOCK_... all over the place.  IOW, the effect of
>> CL_UNPRIVELEGED is cumulative.
>> 
>> How the hell does that code avoid this randomness?  Note had the members of
>> that peer group been in a different order, you would've gotten a different result.
>> What am I missing here?

I believe it is that members of a peer group are guaranteed to share
a user namepace, or else they can't be peers.

>> Oops is a separate story, and a regression in its own right; it needs to be
>> fixed.  But I would really like to sort out the semantics of the existing
>> code in that area, so that we don't end up with patch conflicts.
>
> Ping?

Apologies for the delay I have been on my own deep dive and I initially
misunderstood the question.  For some reason I thought you were implying
that f2ebb3a921c1 ("smarter propagate_mnt()") changed the logic and
introduced the bug.  So I didn't understand why you were asking me.

> If so, the natural place to deal with that would be in commit_tree() after
> propagate_mnt() has created all copies, not while creating those copies.
> That, after all, is where we mark all those struct mount as belonging to
> namespace...

Alternatively we could add a new mount propagation flag call it
MNT_PRIV_BORDER that would mean that we don't need to look at mount
namespaces when considering the propgation tree.  We would just need
to notice that the slave we are propagating to sets MNT_PRIV_BORDER
and set CL_UNPRIVILEGED when creating the copy.

Then it would only be necessary to set MNT_BRIV_BORDER when we
are creating a slave with CL_UNPRIVLEGED is set.  That would
keep all of the information in the mount propagation tree avoiding
and let us ignore namespaces when performing mount propagation.

I think that would work better when propagating to unconnected mounts.

It raises the possibility of creating mount propagation trees
with surprising properties if someone deliberately copies from a less
privileged mount namespace to a more privileged mount namespace.  But
as the user is asking for that deliberately I don't think we care.  If
we do care we can always do something when we attach the floating island
of mounts to a mount namespace.

The ammended invariant would be that peers either all have
MNT_PRIV_BORDER set or have MNT_PRIV_BORDER clear.

A patch of I am thinking the code below.

> Again, this is quite independent from the oops you've reported (and that,
> BTW, can be triggered without any userns involvement - commit_tree() itself
> will oops just fine if parent's ->mnt_ns is NULL, userns or no userns).
> I think I understand how to deal with that thing, but it's a separate
> story; handling of MNT_LOCK... is a problem that exists in the mainline
> and whatever fix we come up with for this one will need to be backportable.

Yes that is oopsable even without logic introduced by 132c94e31b8b
("vfs: Carefully propogate mounts across user namespaces")

> Al "resurfaced from long and thoroughly nasty dive through the LSM gutter
> and finally getting around to more pleasant stuff" Viro

Do you have any guess when you will be posting the patches that resulted
from that deep dive for review?

Eric

diff --git a/fs/namespace.c b/fs/namespace.c
index f195ee3c5aad..c6faa7513c6c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1046,6 +1046,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 		list_add(&mnt->mnt_slave, &old->mnt_slave_list);
 		mnt->mnt_master = old;
 		CLEAR_MNT_SHARED(mnt);
+		if (flag & CL_UNPRIVILEGED)
+			mnt->mnt.mnt_flags |= MNT_PRIV_BORDER;
 	} else if (!(flag & CL_PRIVATE)) {
 		if ((flag & CL_MAKE_SHARED) || IS_MNT_SHARED(old))
 			list_add(&mnt->mnt_share, &old->mnt_share);
diff --git a/fs/pnode.c b/fs/pnode.c
index 53d411a371ce..1654e6198690 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -260,7 +260,7 @@ static int propagate_one(struct mount *m)
 	}
 		
 	/* Notice when we are propagating across user namespaces */
-	if (m->mnt_ns->user_ns != user_ns)
+	if ((type == CL_SHARED) && (m->mnt.mnt_flags & MNT_PRIV_BORDER))
 		type |= CL_UNPRIVILEGED;
 	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
 	if (IS_ERR(child))
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1f38e0201d05..4bf65f42ae57 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -52,6 +52,7 @@ struct mnt_namespace;
 			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
 
 #define MNT_INTERNAL	0x4000
+#define MNT_PRIV_BORDER	0x8000	/* Propagation from greater to lesser privilege */
 
 #define MNT_LOCK_ATIME		0x040000
 #define MNT_LOCK_NOEXEC		0x080000

