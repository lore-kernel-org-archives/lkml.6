Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeCMBNG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:13:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932211AbeCMBNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:13:04 -0400
From: NeilBrown <neilb@suse.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 13 Mar 2018 12:12:51 +1100
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
In-Reply-To: <20180312200540.GO30522@ZenIV.linux.org.uk>
References: <20180223040814.GA30522@ZenIV.linux.org.uk> <87h8q7erlo.fsf@linutronix.de> <20180223150928.GC30522@ZenIV.linux.org.uk> <20180223174216.GD30522@ZenIV.linux.org.uk> <20180223201317.GG30522@ZenIV.linux.org.uk> <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com> <20180224002248.GH30522@ZenIV.linux.org.uk> <20180225073950.GI30522@ZenIV.linux.org.uk> <87bmgbnhar.fsf_-_@linutronix.de> <20180312191351.GN30522@ZenIV.linux.org.uk> <20180312200540.GO30522@ZenIV.linux.org.uk>
Message-ID: <87o9jsdbho.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Mar 12 2018, Al Viro wrote:

> On Mon, Mar 12, 2018 at 07:13:51PM +0000, Al Viro wrote:
>
>> There's an unpleasant area around the ->s_root vs. NFS.  There's
>> code that makes assumptions about ->s_root that are simply not true
>> for NFS.  Is path_connected() correct wrt NFS multiple imports from
>> the same server?  Ditto for mnt_already_visible() (that one might
>> be mitigated at the moment, but probably won't last).  Eric, am
>> I missing something subtle in there?
>
> BTW, another thing spotted while trying to document the stuff:
> Neil's "VFS: don't keep disconnected dentries on d_anon" has a subtle
> side effect I hadn't spotted when applying.  Namely, for
> DCACHE_DISCONNECTED non-directory IS_ROOT dentries we now have
> d_unhashed() true.  That makes d_find_alias() logics around
> discon_alias dead code:
>                 if (S_ISDIR(inode->i_mode) || !d_unhashed(alias)) {
>                         if (IS_ROOT(alias) &&
>                             (alias->d_flags & DCACHE_DISCONNECTED)) {
>                                 discon_alias = alias;
>                         } else {
>                                 __dget_dlock(alias);
>                                 spin_unlock(&alias->d_lock);
>                                 return alias;
>                         }
>                 }

I agree that this code is now more complex than needed.

>
> Directory case is a red herring - we'll end up picking one and only
> alias, whether it's IS_ROOT/disconnected or not.  For non-directories,
> though, IS_ROOT and disconnected implies d_unhashed() now, so we might
> as well turn that into
> 	if directory
> 		return d_find_any_alias
> 	else
> 		return the first hashed alias

Yes, this looks like a good simplification.

>
> Does any of the d_find_alias() callers want those dentries?  That is,
> non-directories from d_obtain_alias() still not attached to a parent;
> note that exportfs_decode_fh() is *not* one of such places - we don't
> use d_find_alias() there at all.  If there's no such caller, we can
> bloody well just drop the discon_alias logics and be done with that;
> if there is, that commit has introduced a bug.  I might have missed
> a part of threads related to that patch, so my apologies if it had
> been discussed.
>
> Neil, what's the situation there?  A lot of those callers clearly treat
> the "only disconnected IS_ROOT alias exist" same as "no aliases at all";
> it looks like the change might have been the right thing, but it sure
> as hell shouldn't be an undocumented side effect...

Many of the callers really want a name, which these disconnected
dentries didn't have, so the new code is more correct in those cases.

d_find_alias() is documented as returning a hashed dentry (for
non-directories) and I suspect most people would be surprised to find
that a disconnected dentry with no name was considered to be "hashed",
so I think the patch could be seen as fixing the documentation.

Of the three users that you didn't classify as "clearly" not wanting the
disconnected dentries:

>	     * ceph invalidate_aliases()

This wants to ensure the dentries are discarded on final dput().  This
is already the case for disconnected dentries, so it doesn't need to be
told about them.  Code is correct.


>	     * cap_inode_getsecurity()

If this gets invoked when the nfsd server calls vfs_getxattr() on a
disconnected dentry, it will return -EINVAL.  This looks like a
potential bug.
nfsd only calls vfs_getxattr() in nfsd4_is_junction() so this bug would
not affect many use cases.
I think cap_inode_getsecurity() should really be calling
d_find_any_alias().

>	     * selinux inode_doinit_with_dentry() (two call sites, very alike)

I'm less sure about this one, but I think it probably wants
d_find_any_alias() as well.  Like cap_inode_getsecurity() it only wants
a dentry so that it can pass something to __vfs_getxattr(),
and that only wants a dentry so it can pass something to ->get.

Possibly we should rename d_find_alias() to d_find_hashed_alias() so that
people need to make a conscious choice between d_find_hashed_alias() and
d_find_any_alias() ??

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqnJZQACgkQOeye3VZi
gblDEhAAlWdrf+aYfBXT6XpbI6tFzdF+ilHlLeM+n+aX9qIhSw4XDEjwDofiCH8k
1OR/AgC3/r8aODf/ePvBge0tgT5fwF0PtXjKyVzt15nmLngyzsc+xdcGgg3bmpQR
lFS9oM/ofcsbmdYomLwGdwT60CfAWeSedGXoTFf/EHrxMWzZVxaPJydvvaYjSw3/
vmC1xYbs1Y4ur6wLNfxryD5svToK+tGi+WtcX5Z5jazmOhCO9mPtWeb+70+MInF/
Uj2d76CTsGcFVE3IA6YoWzg/0YTSJTOxqM87C9/RcQc6OmbZMadoA97nWkDtfNYT
S84gY019hhjGVKZFvzM9OIXo0ENg3erY7xO+L0F9ympbNMp/HF4rK8P3xNNQajN5
E0MooyF5LJyEDqsRtqd7nEGRJ0AjPPx+UaRWv0X9nPsLvlTY2dI8U9EVX2E5OiQc
anJukKYzrqfQd7FHNPpKleQNgse5eXWIRUiflSqY3LgvWoSADeS37WGj1xTJ25wd
Pw41qnHACVotMeLHtUBQrrTwyyDy0/eJNH6sQ4KNbIJzu11AGctxIOlQrTM1ibvF
J5rDM9BBKrSMrmBQn+Zp3AlnT85GAqcTE+q+15uqx9pAGF46Sm/eiSX+mYi2gjby
8s00/acRWnnS2CGIZUp8xClCf1otiptO0rRiaUVeNYymVK3yb+s=
=56F3
-----END PGP SIGNATURE-----
--=-=-=--
