Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeDCCaQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:30:16 -0400
Received: from ozlabs.org ([103.22.144.67]:43445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeDCCaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:30:14 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 12:29:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180403122919.3c503f74@canb.auug.org.au>
In-Reply-To: <20180314101704.51aaae7f@canb.auug.org.au>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180131095446.443670dc@canb.auug.org.au>
        <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
        <20180201092551.759f32be@canb.auug.org.au>
        <20180314101704.51aaae7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6D4vWARE+glh+6FsOjzXU2."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6D4vWARE+glh+6FsOjzXU2.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Ping?

On Wed, 14 Mar 2018 10:17:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 1 Feb 2018 09:25:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > On Tue, 30 Jan 2018 16:25:35 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wro=
te: =20
> > >
> > > On 01/31, Stephen Rothwell wrote:   =20
> > > >=20
> > > > On Tue, 30 Jan 2018 14:32:20 -0800 Jaegeuk Kim <jaegeuk@kernel.org>=
 wrote:     =20
> > > > >
> > > > > Could you please consider the below pull request?
> > > > >=20
> > > > > Thanks,
> > > > >=20
> > > > > The following changes since commit ace52288edf0cb5e7a52b681f057f8=
6224c49c27:
> > > > >=20
> > > > >   Merge tag 'for-linus-20171218' of git://git.infradead.org/linux=
-mtd (2017-12-18 16:18:01 -0800)
> > > > >=20
> > > > > are available in the Git repository at:
> > > > >=20
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git =
tags/f2fs-for-4.16-rc1
> > > > >=20
> > > > > for you to fetch changes up to 1c1d35df71104c76a4a2e25862926f22c3=
34c9d6:
> > > > >=20
> > > > >   f2fs: support inode creation time (2018-01-25 14:10:39 -0800)  =
   =20
> > > >=20
> > > > This has an interesting conflict with the btrfs tree:
> > > >=20
> > > > -------------------------------------------------------------------=
----
> > > > After merging the f2fs tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >=20
> > > > /home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_fill_super':
> > > > /home/sfr/next/next/fs/f2fs/super.c:2563:18: error: 'SB_I_CGROUPWB'=
 undeclared (first use in this function); did you mean 'S_CGROUPWB'?
> > > >   sb->s_iflags |=3D SB_I_CGROUPWB;
> > > >                   ^~~~~~~~~~~~~
> > > >                   S_CGROUPWB
> > > >=20
> > > > Caused by commit
> > > >=20
> > > >   578c647879f7 ("f2fs: implement cgroup writeback support")
> > > >=20
> > > > interacting with commit
> > > >=20
> > > >   34934189a3dd ("cgroup, writeback: replace SB_I_CGROUPWB with per-=
inode S_CGROUPWB"
> > > >=20
> > > > from the btrfs tree.
> > > >=20
> > > > I have reverted the f2fs tree commit for today, but a better resolu=
tion
> > > > would be appreciated.
> > > > -------------------------------------------------------------------=
----
> > > >=20
> > > > I have seen no response to the above email and have been reverting =
that
> > > > commit since Jan 18.     =20
> > >=20
> > > I think this can be addressed by:
> > >=20
> > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > index 89c838bfb067..c743b73976d0 100644
> > > --- a/fs/f2fs/inode.c
> > > +++ b/fs/f2fs/inode.c
> > > @@ -48,9 +48,10 @@ void f2fs_set_inode_flags(struct inode *inode)
> > >                 new_fl |=3D S_DIRSYNC;
> > >         if (f2fs_encrypted_inode(inode))
> > >                 new_fl |=3D S_ENCRYPTED;
> > > +       new_fl |=3D S_CGROUPWB;
> > >         inode_set_flags(inode, new_fl,
> > >                         S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSY=
NC|
> > > -                       S_ENCRYPTED);
> > > +                       S_ENCRYPTED|S_CGROUPWB);
> > >  }
> > >=20
> > >  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode =
*ri)
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 8173ae688814..ebcd58476fc7 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -2560,7 +2560,6 @@ static int f2fs_fill_super(struct super_block *=
sb, void *data, int silent)
> > >         sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
> > >                 (test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
> > >         memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
> > > -       sb->s_iflags |=3D SB_I_CGROUPWB;
> > >=20
> > >         /* init f2fs-specific super block info */
> > >         sbi->valid_super_block =3D valid_super_block;
> > >    =20
> >=20
> > I have applied that (by hand) as a merge fix patch for the merge of teh
> > btrfs tree for today.  Thanks for the resolution. =20
>=20
> I am still applying this to the merge of the btrfs tree every day ...
>=20
> Commit
>   578c647879f7 ("f2fs: implement cgroup writeback support")
> was merged into Linus' tree on Jan 31.
>=20
> Here is the actual merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 1 Feb 2018 09:21:06 +1100
> Subject: [PATCH] f2fs: fixup for cgroup/writeback change
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/f2fs/inode.c | 3 ++-
>  fs/f2fs/super.c | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 205add3d0f3a..f34652c4288f 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -48,9 +48,10 @@ void f2fs_set_inode_flags(struct inode *inode)
>  		new_fl |=3D S_DIRSYNC;
>  	if (f2fs_encrypted_inode(inode))
>  		new_fl |=3D S_ENCRYPTED;
> +	new_fl |=3D S_CGROUPWB;
>  	inode_set_flags(inode, new_fl,
>  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
> -			S_ENCRYPTED);
> +			S_ENCRYPTED|S_CGROUPWB);
>  }
> =20
>  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8173ae688814..ebcd58476fc7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2560,7 +2560,6 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>  	sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>  	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
> -	sb->s_iflags |=3D SB_I_CGROUPWB;
> =20
>  	/* init f2fs-specific super block info */
>  	sbi->valid_super_block =3D valid_super_block;
> --=20
> 2.15.1

--=20
Cheers,
Stephen Rothwell

--Sig_/6D4vWARE+glh+6FsOjzXU2.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrC5v8ACgkQAVBC80lX
0Gzikgf/QdTzz7lCg1m1zQQchknDi13qqNeVtH8t4iZTKY1N35uP2OLT9LF1TVDu
QRKCoSGrWIOIVGIVcxYQieGyjWonEAp0/i1kYNFn8uOvUiKaqVIRg+iB2ajBAL0k
DW3lRoraqrGyjZx171UXdMaAWYkG3xB42lWbRZ1UwQT9ITEO+a9rZmSw24Skebu4
sDxl5Di5tr3R/C2DqRGRkRY5Q5l5S1qcmBR/+0CcOJKdtDXhT51HalCSeKb0uW81
gCOJvu7P+zEGjntOEI+zcOR/cfyl4sVDr1WoieFqcpPcqpNqfxAmza02pJYV5aJm
jTwkV9qbYtzWHWmLJlok3lboj0G3kg==
=kGqX
-----END PGP SIGNATURE-----

--Sig_/6D4vWARE+glh+6FsOjzXU2.--
