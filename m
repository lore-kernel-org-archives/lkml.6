Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeFADMQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 23:12:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56254 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFADMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 23:12:13 -0400
Date: Fri, 1 Jun 2018 06:12:10 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix alignment of netns_dev/netns_ino fields
 in bpf_{map,prog}_info
Message-ID: <20180601031210.GA30533@altlinux.org>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Lawrence Brakmo <brakmo@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20180527112842.GA18204@asgard.redhat.com>
 <20180530181857.GA6744@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20180530181857.GA6744@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Looks like the ABI bug in bpf_map_info and bpf_prog info introduced
in 4.16 is going to slip into 4.17, causing extra pain to 32-bit
userspace.  I'm adding Linus to this thread in hope it might help
to get a fix applied before 4.17 is released.

On Wed, May 30, 2018 at 09:18:58PM +0300, Dmitry V. Levin wrote:
> On Sun, May 27, 2018 at 01:28:42PM +0200, Eugene Syromiatnikov wrote:
> > Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog info
> > has broken compat, as offsets of these fields are different in 32-bit
> > and 64-bit ABIs.  One fix (other than implementing compat support in
> > syscall in order to handle this discrepancy) is to use __aligned_u64
> > instead of __u64 for these fields.
> >=20
> > Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> > Fixes: 52775b33bb507 ("bpf: offload: report device information about
> > offloaded maps")
> > Fixes: 675fc275a3a2d ("bpf: offload: report device information for
> > offloaded programs")
> >=20
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
>=20
> Reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>
> Cc: <stable@vger.kernel.org> # v4.16+
>=20
> Thanks,
>=20
> > ---
> >  include/uapi/linux/bpf.h       | 8 ++++----
> >  tools/include/uapi/linux/bpf.h | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c5ec897..903010a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
> >  	__aligned_u64 map_ids;
> >  	char name[BPF_OBJ_NAME_LEN];
> >  	__u32 ifindex;
> > -	__u64 netns_dev;
> > -	__u64 netns_ino;
> > +	__aligned_u64 netns_dev;
> > +	__aligned_u64 netns_ino;
> >  } __attribute__((aligned(8)));
> > =20
> >  struct bpf_map_info {
> > @@ -1030,8 +1030,8 @@ struct bpf_map_info {
> >  	__u32 map_flags;
> >  	char  name[BPF_OBJ_NAME_LEN];
> >  	__u32 ifindex;
> > -	__u64 netns_dev;
> > -	__u64 netns_ino;
> > +	__aligned_u64 netns_dev;
> > +	__aligned_u64 netns_ino;
> >  } __attribute__((aligned(8)));
> > =20
> >  /* User bpf_sock_addr struct to access socket fields and sockaddr stru=
ct passed
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index c5ec897..903010a 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
> >  	__aligned_u64 map_ids;
> >  	char name[BPF_OBJ_NAME_LEN];
> >  	__u32 ifindex;
> > -	__u64 netns_dev;
> > -	__u64 netns_ino;
> > +	__aligned_u64 netns_dev;
> > +	__aligned_u64 netns_ino;
> >  } __attribute__((aligned(8)));
> > =20
> >  struct bpf_map_info {
> > @@ -1030,8 +1030,8 @@ struct bpf_map_info {
> >  	__u32 map_flags;
> >  	char  name[BPF_OBJ_NAME_LEN];
> >  	__u32 ifindex;
> > -	__u64 netns_dev;
> > -	__u64 netns_ino;
> > +	__aligned_u64 netns_dev;
> > +	__aligned_u64 netns_ino;
> >  } __attribute__((aligned(8)));
> > =20
> >  /* User bpf_sock_addr struct to access socket fields and sockaddr stru=
ct passed


--=20
ldv

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbELmKAAoJEAVFT+BVnCUIeAMQAKd7h6atQs/84EERWY1O7z6R
ym9xFMU19YLsuCcCIQqk8/2iCvsYugFYqLwipCv84koNNW12CHJrbxD7UDP8Se7m
9LmgFDrPgFKBc6sX2WDntjK85rNAdygjnUZnrEVvJz6jqUhCTu0DsNcXdqrBcu4D
ugBQLzJ0z4M6uh4wVIMVWt8T34LgaNb6FUbecaTDUVCS8LrcGMWH0Ses8joS1voR
gGDFpUZTKEbofkGMCCvM1K7QxLmZofysCcE4XkDID9TjHD9BoK15LTTckmdzoqqG
0KxLlKR19txiOthVTBQxyVyFflxZSyiFzEJFPXsxbDxf9s+i2l21JFVpjJ4g5juE
cJFQ3fb2uptBp0seHvchZYeFOrmRhEuoZeFNzJleTVodcvGpBunijA4bEGA855e7
s679LqN6kP59/yuVhTtM1KxfhEAA2ja3EJuWurk9uaXtprPHR6dENh+YgP0fS8HI
ooTcGDxEZfr+Yi03WtSX/6JDuH5WyQ1fZYp8FfB0Dnyit882FMxYqJAARCQT6Lsm
LMlBmEIoj2jKYkeC7moyBR4ki+qGH/6FW2OBhY2qfOLFHJxpsbfZt8NL/TyXLy0X
JvhEEIy0UH14zSGH/tD+aHGtadt/KJ50YU8pHE3prm8af8JvQ1oqRpAorozBWtEk
9TqaMz84brlbAPOMawg1
=Prna
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
