Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75535C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BE2218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfADXOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:14:03 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54456 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADXOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 18:14:02 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1F9FC72CC6C;
        Sat,  5 Jan 2019 02:13:59 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 11A607CC755; Sat,  5 Jan 2019 02:13:59 +0300 (MSK)
Date:   Sat, 5 Jan 2019 02:13:59 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Martin Lau <kafai@fb.com>, Eugene Syromyatnikov <evgsyr@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: "bpf: Improve the info.func_info and info.func_info_rec_size
 behavior" breaks strace self tests
Message-ID: <20190104231358.GC29869@altlinux.org>
References: <20190103114613.GB3957@osiris>
 <20190103191158.yu4cjkb3wd3zvpqk@kafai-mbp>
 <20190103224118.GA4491@osiris>
 <20190103235248.kxvhhwq4brcdxzps@kafai-mbp>
 <20190104092524.GC4396@osiris>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20190104092524.GC4396@osiris>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 10:25:24AM +0100, Heiko Carstens wrote:
> On Thu, Jan 03, 2019 at 11:52:51PM +0000, Martin Lau wrote:
> > On Thu, Jan 03, 2019 at 11:41:18PM +0100, Heiko Carstens wrote:
> > > On Thu, Jan 03, 2019 at 07:12:05PM +0000, Martin Lau wrote:
> > > > On Thu, Jan 03, 2019 at 12:46:13PM +0100, Heiko Carstens wrote:
> > > > > Hello,
> > > > >=20
> > > > > the kernel commit 7337224fc150 ("bpf: Improve the info.func_info =
and
> > > > > info.func_info_rec_size behavior") breaks one of strace's self te=
sts:
> > > > >=20
> > > > > FAIL: bpf-obj_get_info_by_fd-prog-v.gen
> ...
> > I am running against linux-next.  I don't see how root and non-root aff=
ect
> > thing here.  I guess the test has been running without jit so far?
>=20
> Yes, it was disabled. Enabling jit and adding your memset fix leads to
> what you report with 2) below.
>=20
> > 1) root or not, if jit is enabled,
> >    without the memset() fix in the bpf-obj_get_info_by_fd.c in my last =
email,
> >    they all failed:
> >    [root@arch-fb-vm1 tests]# ./bpf-obj_get_info_by_fd-prog-v.gen.test
> >    BPF_OBJ_GET_INFO_BY_FD prog 2 failed: Bad address
> >    bpf-obj_get_info_by_fd-prog-v.gen.test: skipped test: ../bpf-obj_get=
_info_by_fd-prog-v exited with code 77
> >=20
> >    Please fix this first.
> >=20
> > 2) After having the memset fix:
> >    Root or not, for jited program, if I run
> >    ./bpf-obj_get_info_by_fd-prog-v.gen.test, they failed.  If I read the
> >    init.sh correclty, it fails because there is a diff between the
> >    ./bpf-obj_get_info_by_fd-prog-v stdout and the "strace -o log".  I t=
hink
> >    "strace -o log" only has the /* bytes 104..151 */ part if some bytes
> >    are non-zero?
> >=20
> >    Regardless, the test program "bpf-obj_get_info_by_fd.c" is telling
> >    the kernel that the userspace "info" is in size 168 bytes.
> >    The kernel then tells as much details as possible about
> >    a bpf prog in "info".  I don't see a ABI breakage here.
> >=20
> >    I believe the test just happens to work so far because it has been r=
unning
> >    without jit?
> >=20
> >    If I run it with jit enabled:
> > -bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, =
info_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D=
"\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog=
_insns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_t=
ime=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D0 =3D> 1, map_ids=3D[=
], name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D=
0}}}, 16) =3D 0
> > -bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, =
info_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D=
"\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog=
_insns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_t=
ime=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D2 =3D> 1, map_ids=3D[=
36], name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=
=3D0}}}, 16) =3D 0
> > +bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, =
info_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D=
"\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog=
_insns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_t=
ime=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D0 =3D> 1, map_ids=3D[=
], name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=3D=
0, /* bytes 104..167 */ "\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0
> > +bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D4<anon_inode:bpf-prog>, =
info_len=3D168, info=3D{type=3DBPF_PROG_TYPE_SOCKET_FILTER, id=3D35, tag=3D=
"\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=3D0 =3D> 110, jited_prog=
_insns=3DNULL, xlated_prog_len=3D0 =3D> 120, xlated_prog_insns=3D[], load_t=
ime=3D2476906063975, created_by_uid=3D0, nr_map_ids=3D2 =3D> 1, map_ids=3D[=
36], name=3D"test_prog", ifindex=3D0, netns_dev=3Dmakedev(0, 0), netns_ino=
=3D0, /* bytes 104..167 */ "\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) =3D 0
> >=20
> >   The diff comes in as early as byte 104-th which is the nr_jited_ksyms=
 =3D=3D 1.
> >=20
> >   Please fix the test program.  A protential fix is in bpf-obj_get_info=
_by_fd.c
> >   to printf the non-zero "/* bytes 104..1xx */..." the same way as the
> >   "strace -o log" does.
>=20
> Thanks a lot for looking into this!
> Eugene, Dmitry will you take care of fixing this?

Thanks for reporting this!

AFAICT, the test in question was specifically designed to check whether
the strace printer of BPF_OBJ_GET_INFO_BY_FD command is up to date with
the kernel, and this failure means strace has to be updated for new
features added after v4.20.  Eugene, please correct me if I'm wrong.


--=20
ldv

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcL+i2AAoJEAVFT+BVnCUIevwP/2bsS5d2bqWXADMRrFetm3pB
V60wGiy4bNU3s3DsgipWOGni1xKHaC22DSJxpovQLWE6lcps9D6EE1Axes4totCa
5OviAgsmLjIJFS5ndi9wCwTQuTFmA0ecVHnvOa7TSbIwY+xcY4InE96T/uj56teQ
Vo8mxmuzWycv4BwSAwH9sPtfV+XA+oA+35578dMQxy4lkC0JPymmImhBKv8eS6y3
cQHTMputrRUtiTXZOkhmk+Mz0ilVvM+kE/V68wuL9e6He8YLE9Vnc01iFYK4WLP8
3iFpro2sMUPDFvGct1nazM2sIxHyVfEZsaFnD6up9RMrLLbpYXpXRhzxqYWOJ7FA
uocffoU/V38MoLHxnyB4qaan6mU9wlX6EIrk8iO/e/r2RGErn1OpvKoc61wrYrIi
pJTmOokKPi6ZzWimoc/DxFQhEkpfgQl4amx5uxe12uLFGieEfUeY888sjKYCADdM
hMoEG/8ncAhfnUxlgj3HtHul+JYhRa8o9mjZBlFPHmOGbtKcnzNFhnKkca9Llh/Q
INm0vbGis5ELyxfSfRp6WE6x+NBpewpaxOw9WTqYxFFAMYDx1ZhdDmok8bSFv0g4
syisRwA4jELS+sNGwuDEjo5+EkOlY77gHOKWHwm9v5xAgy9WzJCSkcuv7zPcMSGK
PWJ02UEMlwkWNlPHpJNd
=TLTa
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
