Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDAFC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBA820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="c4ExxR4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBA820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeGYSJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:09:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34520 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeGYSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:09:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so5709498pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qhAT/hogCvA8J6t7p47o2rYymiXnXmqIH6infHl1ISc=;
        b=c4ExxR4L5qRmWep8wxCVg1votKxyquc1Az7d54FNCls41owZiAJQjFD1tjCDXtxnVm
         dZxLxERANuFXTYzHDFAfZPKYQElCrjBg/zm4GDWsDRKnF31j0p//8Y5LP36mS6zaGNHE
         /WkTwhXP0H9RmyReu0TAjbpu5rsOSM9EwvQ3sYQCA/ipiP11FlD5UrJ4SoTTrnvBZqGN
         tsRngG1jNYYPBnP+M3ZZIHils+xhGC3wK/BfUqOeaCNBRGlbzH/1QKGenvdFjyFHixdP
         mTpmw9Mrsx4EV/TKjnpU5tmzEUzOITWK1yHTR14pleTExPppWwiiPNCiSz67fDPbsk/D
         OBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qhAT/hogCvA8J6t7p47o2rYymiXnXmqIH6infHl1ISc=;
        b=Wlamf3JGLLu2OEwrkUzozimG7kZH288Ld+EwiL/kkUl1BMWdW8O73Xv9R35vgVCelx
         IofBTuiaHfxBkSx6EK+P1vGkCiZ/gxpVh8uSKdxxiCuT51mDVtvrQb1EmdZCfHK5EZhl
         ShNi8ncJhYjfosS1hvgFWZ2t+Azbw+NsCUsJYrP8lNiUMHMJ+xcSwacGozuAWkXCVZxe
         bCIvWRaJTOGZO8vpVAEnVACMAzF2wGr1gHxdEdDwcTcHRZ6HZunY7NxxVqlmKsa1uN0K
         HTalSvYPlEsc+nQxTFCzkAjln+Ca+ePNB8na2Qeu1pJQ294oJ2gD0SuzSlUksn0EwVGQ
         pESA==
X-Gm-Message-State: AOUpUlHeUUS8oxZD7AmpU0wDJ8kSw+QrGqTxh8cfS0wXjLmQFzYEx4Gm
        NKNM8gQX16y0+O1nZSedVE/dmA==
X-Google-Smtp-Source: AAOMgpdPx5CJ4MgFOT3brL50fyvlmr+GVV1zLAovFC5enJkQC/FuzxwGOMTTWUA6fC3PiJOgFvCIGQ==
X-Received: by 2002:a62:748:: with SMTP id b69-v6mr22836621pfd.177.1532537802478;
        Wed, 25 Jul 2018 09:56:42 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u42-v6sm24040515pgn.1.2018.07.25.09.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 09:56:41 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <713ACC41-2AC3-4594-8548-8981161087A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_92669391-F660-4EB2-BCF0-04E10AF73749";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Why inode number is zero in writeback?
Date:   Wed, 25 Jul 2018 10:56:36 -0600
In-Reply-To: <CAC1xz-R3PEEUdVQ9mONaO+ko=JEUUiO-GzPH4=E4aXWM1n2eKw@mail.gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Ilya Plenne <libbkmz.dev@gmail.com>
References: <CAC1xz-R3PEEUdVQ9mONaO+ko=JEUUiO-GzPH4=E4aXWM1n2eKw@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_92669391-F660-4EB2-BCF0-04E10AF73749
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 25, 2018, at 6:01 AM, Ilya Plenne <libbkmz.dev@gmail.com> wrote:
>=20
> I'm researching linux kernel. Right now only for v3.10.61, it's just
> proof of concept.
>=20
> I need to pass-through some hints to hardware about what kind of data
> in particular WRITE\READ operation. E.g. read inodes bitmap or write
> journal block or write user data or something else...
> I'm assuming that at driver level I can reach bio struct from
> request_queue struct just for now. For testing purposes I'm using
> virtio_blk driver under qemu.

Please see the following articles/threads for similar developments
that are already present in Linux:

 https://lwn.net/Articles/685499/
 https://www.usenix.org/system/files/conference/fast18/fast18-rho.pdf
 https://lwn.net/Articles/726477/

    commit c75b1d9421f80f4143e389d2d50ddfc8a28c8c35
    Author:     Jens Axboe <axboe@kernel.dk>
    AuthorDate: Tue Jun 27 11:47:04 2017 -0600
    Commit:     Jens Axboe <axboe@kernel.dk>
    CommitDate: Tue Jun 27 12:05:22 2017 -0600

    fs: add fcntl() interface for setting/getting write life time hints

This patch was landed in kernel 4.12, so you would be well advised to
update your testing to at least that kernel.  If there is a specific
reason to use the 3.10 kernel (e.g. RHEL7 requirement) then it would
be best to backport this patch series to the older kernel, rather than
making a different set of interfaces that will conflict with newer
kernels.

If you want to add additional streams (e.g. for different types of
filesystem metadata), you should modify nvme_configure_directives()
to remove the BLK_MAX_WRITE_HINTS limit to nr_streams, and then use
stream IDs > BLK_MAX_WRITE_HINTS - 1 for the filesystem-specific IDs.
Alternately, add a separate value BLK_MIN_WRITE_HITS =3D 5, and check
that against ctrl->nssa, and increase the value of BLK_MAX_WRITE_HITS
to 16 or similar (not too large, as there is an array in the queue
based on this value to track stream usage stats).

You still wouldn't be able to pass larger hints (stream IDs) from
userspace, but it would be enough to pass hints directly from ext4.
Using higher stream IDs would also avoid conflicts with user supplied
IDs, and doesn't affect operation otherwise.

There would need to be some way to map the higher IDs to lower ones
if there weren't enough distinct IDs in the device.  One option is to
encode the filesystem stream ID into the high 8 bits of the fields,
and the fallback hint into the low 8 (really 3) bits of the fields.
The fallback hint would be set manually (e.g. journal and bitmap use
the WRITE_LIFE_SHORT hint, inode uses WRITE_LIFE_MEDIUM, etc.).
It isn't clear whether "user data" has a good fallback hint or not,
but that is always true even if you segregate it into its own class
(it will intermingle short- and long-term files), so it could just
fall back to WRITE_LIFE_NONE.

Alternately, you could expand enum rw_hint to have a few generic
internal IDs not accessible from userspace, like WRITE_LIFE_INODE,
WRITE_LIFE_BITMAP, WRITE_LIFE_JOURNAL, WRITE_LIFE_DIRECTORY, and
WRITE_LIFE_TREE, etc. that could be used by multiple filesystems.

Cheers, Andreas

> Here what I have done:
>=20
> 1. I've created FS with this command: mkfs.ext4 -b 4096 -E
> lazy_itable_init=3D0,lazy_journal_init=3D0 -m 0 /dev/vda
> 2. I've mounted it using this command: mount -o
> rw,nosuid,nodev,discard,noauto_da_alloc,data=3Dordered /dev/vda /mnt
> 3. Added breakpoint in virtio_blk.c:377 and will skip writes related =
to journal
> 4. Execute this dd command: dd if=3D/dev/urandom of=3D/mnt/foo2 bs=3D764=
 count=3D34
> 5. Wait for breakpoint hit and will analyze backtrace under writeback =
subsystem.
>=20
> Here is the backtrace:
>=20
> #0  virtblk_request (q=3D0x87ab8000) at drivers/block/virtio_blk.c:377
> #1  0x801c0b4c in __blk_run_queue_uncond (q=3D<optimized out>) at
> block/blk-core.c:312
> #2  __blk_run_queue (q=3D0x87ab8000) at block/blk-core.c:329
> #3  0x801c0c94 in queue_unplugged (q=3D0x87ab8000, depth=3D<optimized
> out>, from_schedule=3D<optimized out>) at block/blk-core.c:2920
> #4  0x801c3a98 in blk_flush_plug_list (plug=3D<optimized out>,
> from_schedule=3Dfalse) at block/blk-core.c:3030
> #5  0x801c3d9c in blk_finish_plug (plug=3D0x8785fd8c) at =
block/blk-core.c:3037
> #6  0x80091644 in generic_writepages (mapping=3D<optimized out>,
> wbc=3D0x8785fde0) at mm/page-writeback.c:1910
> #7  0x80092a88 in do_writepages (mapping=3D<optimized out>,
> wbc=3D<optimized out>) at mm/page-writeback.c:1923
> #8  0x800e7084 in __writeback_single_inode (inode=3D0x8740c290,
> wbc=3D0x8785fde0) at fs/fs-writeback.c:454
> #9  0x800e7360 in writeback_sb_inodes (sb=3D0x87811000, wb=3D0x87ab81b0,=

> work=3D0x8785fea4) at fs/fs-writeback.c:678
> #10 0x800e757c in __writeback_inodes_wb (wb=3D0x1 <__vectors_start>,
> work=3D0x3ff) at fs/fs-writeback.c:723
> #11 0x800e7760 in wb_writeback (wb=3D0x87ab81b0, work=3D0x8785fea4) at
> fs/fs-writeback.c:854
> #12 0x800e838c in wb_check_old_data_flush (wb=3D<optimized out>) at
> fs/fs-writeback.c:969
> #13 wb_do_writeback (wb=3D0x87ab81b0, force_wait=3D0) at =
fs/fs-writeback.c:1010
> #14 0x800e848c in bdi_writeback_workfn (work=3D0x87ab81bc) at
> fs/fs-writeback.c:1040
> #15 0x80039d34 in process_one_work (worker=3D0x87816180,
> work=3D0x87ab81bc) at kernel/workqueue.c:2189
> #16 0x8003a40c in worker_thread (__worker=3D0x1 <__vectors_start>) at
> kernel/workqueue.c:2313
> #17 0x8003f714 in kthread (_create=3D0x87845e20) at =
kernel/kthread.c:200
> #18 0x8000dfb8 in ret_from_fork () at =
arch/arm/kernel/entry-common.S:91
>=20
> Ok, here we go... At frame #8 we have not optimized inode variable for
> inspection:
> p (*inode)->i_ino
> $7 =3D 0
>=20
> Can anyone explain me what this inode is about? Where can I found
> information regarding this kind of inodes? And how can I track the
> inode number for writeback operations?
>=20
>=20
>=20
>=20
> PS. That's my first email in linux kernel mailing list... I'm sorry if
> I have done something wrong


Cheers, Andreas






--Apple-Mail=_92669391-F660-4EB2-BCF0-04E10AF73749
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAltYq8UACgkQcqXauRfM
H+D1TxAAiqKc+eiAGF74fywwQKsOU1v8TKKElGtYJo5+GLQWpr89+FVnSffipMa5
pCC6lxitl/hrW1XoLcCm0fWYtwuv9pQNLI+N5QYRHzTZn0bMQzeSHSKTYko6YNZ3
gKJKtKHjqJZfJ9Sw91JUfYoVBmAf6Aeew+TGroY5yj39ERZOmPxhRHy0YT/Iva9N
ohHS6IXczsvENvxVet4JH3S7Snn8ze59nijDG/WCW1Q5IUNPGKJmBIidZcjAez6H
Ts/t4j4G0Qzu0ylcy8hU8euWO+syT91u6eeYevl4Z2002jgEmQdMEhhIKYgAYjmd
pfLYO81SZao3ksRda80t/DG9lV15ctF4Nnp/rLxN1TcNK3c7PjB1bKDJRBqItxnv
1zGtm1T98hTyc13MXcw6O4LLLN+8m+nkua5uVFRtf5SyH1rd7Ar8VMjwtGYds05G
OqWdL/hCnoueaggTcPwa+rqKZ2C8ZVaZ6BAJKPcPqUMLG+ci+Paidvp8q2gHGhu7
Zhd7AWQg57r/svnrbCT9w1D33Uf+Oqk4do9Ag8z5RIkaZNgK5eVVq907qq0EiEmX
ZZ/lwgYt1Jlyg2TdIPwhZ5Q+ROsWkKIDCzzsrhIk3lGZFALsT5zuQYvAQmv4Bf/x
gnOi0pND6otCffYxldFY5Cj4bTDL6s+C2tkAImAuSM8Hb91ezws=
=HrZU
-----END PGP SIGNATURE-----

--Apple-Mail=_92669391-F660-4EB2-BCF0-04E10AF73749--
