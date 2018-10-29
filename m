Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3317C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E84F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJ2Kmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:42:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:36632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727939AbeJ2Kmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:42:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3C41ACD9;
        Mon, 29 Oct 2018 01:56:19 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 29 Oct 2018 12:56:11 +1100
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9 v3] locks: avoid thundering-herd wake-ups
In-Reply-To: <41db4227fdc5deb7703c6425c2f36589b355a7ca.camel@kernel.org>
References: <154033435272.29542.13985568983074440924.stgit@noble> <41db4227fdc5deb7703c6425c2f36589b355a7ca.camel@kernel.org>
Message-ID: <87sh0p3490.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26 2018, Jeff Layton wrote:

> On Wed, 2018-10-24 at 09:43 +1100, NeilBrown wrote:
>> This took longer that I had wanted, due to various reasons - sorry.
>> And I'm now posting it in a merge window, which is not ideal.  I don't
>> expect it to be included in this merge window and I won't be at all
>> impatient for review, but I didn't want to delay it further.
>>=20
>> Testing found some problems, particularly the need to use
>> locks_copy_lock in NFS.  And there was a small thinko in there that
>> effectively removed all the speed gains :-(
>>=20
>> But this version:
>>  - shows excellent scalability with lots of threads on lots of CPUs
>>    contending on a single file
>>  - avoids the problems that Bruce found
>>  - seems to work.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>> ---
>>=20
>> NeilBrown (9):
>>       fs/locks: rename some lists and pointers.
>>       fs/locks: split out __locks_wake_up_blocks().
>>       NFS: use locks_copy_lock() to copy locks.
>>       fs/locks: allow a lock request to block other requests.
>>       fs/locks: always delete_block after waiting.
>>       fs/locks: change all *_conflict() functions to return bool.
>>       fs/locks: create a tree of dependent requests.
>>       locks: merge posix_unblock_lock() and locks_delete_block()
>>       VFS: locks: remove unnecessary white space.
>>=20
>>=20
>>  fs/cifs/file.c                  |    4 -
>>  fs/lockd/svclock.c              |    2=20
>>  fs/locks.c                      |  231 ++++++++++++++++++++++----------=
-------
>>  fs/nfs/nfs4proc.c               |    6 +
>>  fs/nfsd/nfs4state.c             |    6 +
>>  include/linux/fs.h              |   11 +-
>>  include/trace/events/filelock.h |   16 +--
>>  7 files changed, 153 insertions(+), 123 deletions(-)
>>=20
>> --
>> Signature
>>=20
>
>
> I built a kernel with these patches and ran the cthon04 lock tests and
> got this on lock test 1 after a long hang (the test passed though):

I've been looking deeper into this, and I cannot see how this can
happen.

This is an unlock request, happening when a file is closed.
locks_delete_block() will only be called from locks_lock_inode_wait()
after posix_lock_inode() (or possible flock_lock_inode()) returns
FILE_LOCK_DEFERRED.

But these only return FILE_LOCK_DEFERRED when fl_type !=3D F_UNLCK.
(or possibly if FL_ACCESS and FL_SLEEP are both set - that would be
 weird).

So this shouldn't happen - an unlock request should never result in
locks_delete_block() being called.
But if it can, I'll need to change do_flock() in gfs2/file.c to use a
properly initialized 'struct file_lock', rather than a manifest
constant.  Maybe I should do that anyway.

Any ideas? I'll try running connectathon myself later and see if I can
reproduce it.

Thanks,
NeilBrown

>
> [ 1694.787367] BUG: unable to handle kernel NULL pointer dereference at 0=
00000000000002c
> [ 1694.789546] PGD 118ff0067 P4D 118ff0067 PUD 135915067 PMD 0=20
> [ 1694.790772] Oops: 0000 [#1] SMP NOPTI
> [ 1694.791749] CPU: 7 PID: 1514 Comm: tlocklfs Not tainted 4.19.0+ #56
> [ 1694.792876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
> [ 1694.795179] RIP: 0010:__locks_delete_block+0x14/0x90
> [ 1694.796203] Code: 01 a1 e9 9f 4f d8 ff 0f 1f 44 00 00 66 2e 0f 1f 84 0=
0 00 00 00 00 0f 1f 44 00 00 8b 05 29 9d 58 01 55 53 48 89 fb 85 c0 75 5a <=
48> 8b 43 20 48 85 c0 74 20 48 8b 53 18 48 89 10 48 85 d2 74 04 48
> [ 1694.799277] RSP: 0018:ffff9d21c1f63cb8 EFLAGS: 00010202
> [ 1694.800374] RAX: 0000000000000001 RBX: 000000000000000c RCX: aaaaaaaaa=
aaaaaad
> [ 1694.801682] RDX: 0000000000000001 RSI: ffffffff9f7b0c38 RDI: 000000000=
0000246
> [ 1694.802996] RBP: 000000000000000c R08: 0000000000000000 R09: 000000000=
0000001
> [ 1694.804317] R10: 0000000000000001 R11: ffffffffa0bdc188 R12: ffff9d21c=
1f63dd8
> [ 1694.805633] R13: ffff9d21c1f63e00 R14: ffffffff9f3241a8 R15: ffff8d0b5=
aef72e0
> [ 1694.806941] FS:  00007efc8699c740(0000) GS:ffff8d0b7ba00000(0000) knlG=
S:0000000000000000
> [ 1694.808380] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1694.809550] CR2: 000000000000002c CR3: 000000011e0d8000 CR4: 000000000=
00006e0
> [ 1694.810888] Call Trace:
> [ 1694.811692]  __locks_wake_up_blocks+0x2d/0x80
> [ 1694.812713]  locks_delete_block+0x1d/0x40
> [ 1694.813691]  locks_lock_inode_wait+0x9c/0x1c0
> [ 1694.814731]  nfs4_proc_lock+0x120/0x440 [nfsv4]
> [ 1694.815786]  ? nfs_put_lock_context+0x25/0x80 [nfs]
> [ 1694.816866]  ? do_unlk+0x98/0xe0 [nfs]
> [ 1694.817818]  locks_remove_posix+0xba/0x1d0
> [ 1694.818811]  ? _cond_resched+0x15/0x30
> [ 1694.819768]  ? wait_on_commit+0x38/0xb0 [nfs]
> [ 1694.820787]  ? process_echoes+0x60/0x60
> [ 1694.821752]  ? __nfs_commit_inode+0xc2/0x1c0 [nfs]
> [ 1694.822819]  filp_close+0x56/0x70
> [ 1694.823712]  __x64_sys_close+0x1e/0x50
> [ 1694.824661]  do_syscall_64+0x60/0x1f0
> [ 1694.825599]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1694.826731] RIP: 0033:0x7efc8616c0a4
> [ 1694.827673] Code: eb 89 e8 af f6 01 00 66 2e 0f 1f 84 00 00 00 00 00 0=
f 1f 44 00 00 8b 05 aa e7 2c 00 48 63 ff 85 c0 75 13 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 44 f3 c3 66 90 48 83 ec 18 48 89 7c 24 08 e8
> [ 1694.830929] RSP: 002b:00007ffc70beb7b8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000003
> [ 1694.832371] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efc8=
616c0a4
> [ 1694.833784] RDX: 0000000000000000 RSI: 00007efc864378a0 RDI: 000000000=
0000009
> [ 1694.835183] RBP: 00007ffc70beb7d0 R08: 00007efc864378a0 R09: 00007efc8=
699c740
> [ 1694.836560] R10: 00000000000006b4 R11: 0000000000000246 R12: 000000000=
0401000
> [ 1694.837941] R13: 00007ffc70beb990 R14: 0000000000000000 R15: 000000000=
0000000
> [ 1694.839322] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs =
fscache nfsd auth_rpcgss nfs_acl lockd grace ip6t_rpfilter ip6t_REJECT nf_r=
eject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge =
stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_secu=
rity iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6=
table_filter ip6_tables sunrpc joydev virtio_balloon i2c_piix4 pcspkr edac_=
mce_amd xfs libcrc32c serio_raw virtio_blk qxl drm_kms_helper virtio_net tt=
m net_failover virtio_console failover drm ata_generic pata_acpi floppy qem=
u_fw_cfg
> [ 1694.849736] CR2: 000000000000002c
> [ 1694.850813] ---[ end trace da2f469c62deb564 ]---
>
> --=20
> Jeff Layton <jlayton@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvWaLwACgkQOeye3VZi
gbkGCA//ST1av9eQ1SZTLcVodjlV7tczBXNDrdO/U1APT3wvTpsaTLqOlxA1si7I
nnhjjsiCfy47AR5dKagjN6J+cmx/OHTsPGCt65ntIUAIb4bW3czRc4qGqYp4C8UD
UNsIVptJB/8/JY0Wn544AMpDavi9ARpcJraPaELeXzvceIKEZeyDnRrwrA4duO/a
BxohAA94Z6MY1Xypa5bA7oo7c6ROM4IHBaO5pjWOrwckOLmqMMRUqApiZ0jt34dW
NzpyTIA90i3g+ZNGjbjtM6Qfyq+WD3adGxrbtCAvdb1uzlnXEsZ48UqnfyDNHmEV
FR9FtwBttL0Hr5AynuEqIy9RIkPQzkDi/SSFfwA+fRtCxJKrmKYAnGB6W0q6Ga48
aXvK7Wl2So/v1kebpUjxPDf4SX5mR/0r2T5kwHFzSzPJJTmsP9ZiJej/+xaSZAs7
tmca+si2L41kWN1r0f0LHFx6A2Hx4cRkUDato5t3Fkx0ynpRShbKLL1MlsmaAvQO
Pvymj5sAm+MXxVuHm5aWxKkjeSefvRxfqwwKfgoi1vTx2Y3/A1ydp4UOBueHTcaK
rNyzWm6QpMy1UIjmVusyUPFovEvXytT1ozSsXIxxjvjIbqu7hp71MGTu4LJTjBOo
PZntkZr430wCiCpbl3wBLXyJPV0x+QouNgSq3o2C6QAyF3d78Aw=
=Zw3V
-----END PGP SIGNATURE-----
--=-=-=--
