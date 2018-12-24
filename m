Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B261C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DB320869
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545649586;
	bh=BRomJ5ltLCuko+OcgtZlW+U8rx/LMjslqA4DUOAzjR0=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=jThJdAvGHi9JYt9017ZIdE+10MREsJJ3bD4+AvAx6bRes8mEeB8y62HZK3n/6s49q
	 +i/C2/ZCmW2Enuen07jRSiJMXSQ9M7XtSAI+fUC+gkPACTlOP4ez7WchyexnAXCVlf
	 fPx6VL7Df+T16OuzPekATvJT6Y1ACrao968MWAU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLXLGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:06:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbeLXLGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:06:24 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C83720869;
        Mon, 24 Dec 2018 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545649583;
        bh=BRomJ5ltLCuko+OcgtZlW+U8rx/LMjslqA4DUOAzjR0=;
        h=Subject:From:To:Cc:Date:From;
        b=vUnJvFfU3ZUslRDGSzZt72O3E6K5D7+RwYedqFt0FDXYNwG3dc8eGtXuL/JnyFB8Y
         KAxY7Wrs/DEPpV37R6LOxc4sr5magOp6ysjqO7DsaNbSyX67P7I1mr3pb8NtT4Q+5J
         HWcHBNvuMc+X0It7pKcIzKctYDUzabcmG3wqSrfE=
Message-ID: <9d429d110c16472f531e9dcd0a2ac6dfcdc0ad20.camel@kernel.org>
Subject: [GIT PULL] File locking changes for v4.21
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, Neil Brown <neilb@suse.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Dec 2018 06:06:16 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ru0KElZuTLd7IFTILkFS"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ru0KElZuTLd7IFTILkFS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit
ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v4.21-1

for you to fetch changes up to 052b8cfa4070caa53125cd589da0cfe744132a94:

  locks: Use inode_is_open_for_write (2018-12-17 07:19:46 -0500)

----------------------------------------------------------------

The main change in this set is Neil Brown's work to reduce the
thundering herd problem when a heavily-contended file lock is released.
Previously we'd always wake up all waiters when this occurred. With this
set, we'll now we only wake up waiters that were blocked on the range
being released.

----------------------------------------------------------------
NeilBrown (12):
      fs/locks: rename some lists and pointers.
      fs/locks: split out __locks_wake_up_blocks().
      NFS: use locks_copy_lock() to copy locks.
      gfs2: properly initial file_lock used for unlock.
      ocfs2: properly initial file_lock used for unlock.
      fs/locks: use properly initialized file_lock when unlocking.
      fs/locks: allow a lock request to block other requests.
      fs/locks: always delete_block after waiting.
      fs/locks: change all *_conflict() functions to return bool.
      fs/locks: create a tree of dependent requests.
      fs/locks: merge posix_unblock_lock() and locks_delete_block()
      fs/locks: remove unnecessary white space.

Nikolay Borisov (1):
      locks: Use inode_is_open_for_write

 fs/cifs/file.c                  |   4 +-
 fs/gfs2/file.c                  |  10 +-
 fs/lockd/svclock.c              |   2 +-
 fs/locks.c                      | 344 +++++++++++++++++++++++++-----------=
----
 fs/nfs/nfs4proc.c               |   6 +-
 fs/nfsd/nfs4state.c             |   6 +-
 fs/ocfs2/locks.c                |  10 +-
 include/linux/fs.h              |  13 +-
 include/trace/events/filelock.h |  16 +-
 9 files changed, 253 insertions(+), 158 deletions(-)
--=20
Jeff Layton <jlayton@kernel.org>

--=-ru0KElZuTLd7IFTILkFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAlwgvagTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFblSD/4iyCFMD/gYMm1nB2bKbVjzbJvlUT+H
pSoq7aDqf9wmm9kfBBILHd8J7fgbiEYBGfj2OyT0Ttp6JDduF+fX0jhzJ4bkg0zH
qV+wSWEtg06aq80WAj32ioaPv3seQfB6P6WMRowcsLWsjGYagUaxAOtwFcJ1JkS0
RkCQkA+9KGvaFJAVYaC30M67gLWmwNU+gGaIPEBBr6s1116dJI4XNtsjq1KX5f/L
C8l5urdW+/NKG03858exJsVPxp/RbCwbpUhL7AoU/bmzquyYj8i9oSTFen5wbUKV
pTpiJshabCey/b4JfctM149d+DJDFDno+ijgihDeS4ndFIHdLDqm1ECuTuJYxwnt
tmtPcgkW+LtDHZEj6ke+ZrgkY33t4pQqmeVBe4mOfnE7RY6TEtLm7Mi+gVEMVZq/
ujesQ4yjVYDaS6c1w4Yhl3SzKKghzNGWSXw5U8OBtc1uekfTdHeI3QCD68J9+IbB
KsGx8up5pbI+5cOOdDmltyROEUnyS9fJ3gJUNKcfzVXBYrZ1urt1DgcHbzoTVPSk
dplAdXlAYIl/qAeB13wjUXRR+g0A9/A3064ofMZhiTGt68Ijn1j0gOyF3MoO8hJG
FrwAHbl90BiPcwNENMhHotDmHXlU2W+vlRr1poMgSkbff5gVwOPuSWQvVHkjhnTJ
WFVKYVM8M523Ug==
=sMmO
-----END PGP SIGNATURE-----

--=-ru0KElZuTLd7IFTILkFS--

