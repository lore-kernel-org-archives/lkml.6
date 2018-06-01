Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeFALMQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:12:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51456 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeFALMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:12:14 -0400
Date: Fri, 1 Jun 2018 14:12:12 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org,
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
Message-ID: <20180601111211.GA3423@altlinux.org>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
 <20180601031210.GA30533@altlinux.org>
 <20180601084114.xgvtg7nmihdavnnd@ast-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20180601084114.xgvtg7nmihdavnnd@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:41:16AM -0400, Alexei Starovoitov wrote:
> On Fri, Jun 01, 2018 at 06:12:10AM +0300, Dmitry V. Levin wrote:
> > Hi,
> >=20
> > Looks like the ABI bug in bpf_map_info and bpf_prog info introduced
> > in 4.16 is going to slip into 4.17, causing extra pain to 32-bit
> > userspace.  I'm adding Linus to this thread in hope it might help
> > to get a fix applied before 4.17 is released.
>=20
> The issue identified in patch 1 is valid.
> These two fields won't be properly accessible by 32-bit user space
> on 64-bit kernel.

Yes, and currently there is no way to build a 32-bit userspace that would
work properly both with 32-bit and 64-bit kernels.

> But the fix in patch 1 is wrong.

Please elaborate.

> The patch 2 is completely unnecessary.

The patch 2 doesn't have to be backported to 4.16, but if it was
implemented in 4.16, there would be no bug to discuss.  That is,
the patch 2 is a good policy that would help to avoid this class of bugs
in the future.

Alexei, looks like your Acked-by on the buggy commit
52775b33bb5072fbc07b02c0cf4fe8da1f7ee7cd affects your judgement.
If this is the case, please refer patch 2 to other people who are less bias=
ed.

> Everyone can also see that the patches are still marked as 'new' in patch=
works
> meaning that we didn't process them.
> At the moment many networking folks are traveling to netconf
> and we only had a chance to discuss this set last night.
> We'll try to send a fix in coming days.
> But regardless whether 4.17 is realesed this sunday or not
> we're not going to rush wrong patch in without proper code review
> and discussion.
> That future patch either will land in 4.17 (if it's dealyed into next sun=
day)
> or it will be sent to stable.

Note that the fix was submitted to netdev on 2018-05-27.
One week is surely enough to make this bug fixed, isn't it?

> To speed up the situation next time please report the issue that you find
> to public netdev mailing list instead of using proprietary distro emails.

Please explain to me and to the public what do you mean by making this
statement.

I do believe strace developers are free to discuss among themselves
using whatever means of communication they find appropriate.

I do believe the issue was properly reported to netdev, see
https://lkml.kernel.org/r/20180527112835.GA9118@asgard.redhat.com
https://lkml.kernel.org/r/20180527112842.GA18204@asgard.redhat.com

I'd like to use this opportunity to thank Eugene for submitting the fix
the same day the issue was identified as a kernel bug.

Alexei, please do not exclude my email address from this discussion.
Thanks.

> > On Wed, May 30, 2018 at 09:18:58PM +0300, Dmitry V. Levin wrote:
> > > On Sun, May 27, 2018 at 01:28:42PM +0200, Eugene Syromiatnikov wrote:
> > > > Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog=
 info
> > > > has broken compat, as offsets of these fields are different in 32-b=
it
> > > > and 64-bit ABIs.  One fix (other than implementing compat support in
> > > > syscall in order to handle this discrepancy) is to use __aligned_u64
> > > > instead of __u64 for these fields.
> > > >=20
> > > > Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > Fixes: 52775b33bb507 ("bpf: offload: report device information about
> > > > offloaded maps")
> > > > Fixes: 675fc275a3a2d ("bpf: offload: report device information for
> > > > offloaded programs")
> > > >=20
> > > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > >=20
> > > Reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>
> > > Cc: <stable@vger.kernel.org> # v4.16+
> > >=20
> > > Thanks,
> > >=20
> > > > ---
> > > >  include/uapi/linux/bpf.h       | 8 ++++----
> > > >  tools/include/uapi/linux/bpf.h | 8 ++++----
> > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index c5ec897..903010a 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
> > > >  	__aligned_u64 map_ids;
> > > >  	char name[BPF_OBJ_NAME_LEN];
> > > >  	__u32 ifindex;
> > > > -	__u64 netns_dev;
> > > > -	__u64 netns_ino;
> > > > +	__aligned_u64 netns_dev;
> > > > +	__aligned_u64 netns_ino;
> > > >  } __attribute__((aligned(8)));
> > > > =20
> > > >  struct bpf_map_info {
> > > > @@ -1030,8 +1030,8 @@ struct bpf_map_info {
> > > >  	__u32 map_flags;
> > > >  	char  name[BPF_OBJ_NAME_LEN];
> > > >  	__u32 ifindex;
> > > > -	__u64 netns_dev;
> > > > -	__u64 netns_ino;
> > > > +	__aligned_u64 netns_dev;
> > > > +	__aligned_u64 netns_ino;
> > > >  } __attribute__((aligned(8)));
> > > > =20
> > > >  /* User bpf_sock_addr struct to access socket fields and sockaddr =
struct passed
> > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/li=
nux/bpf.h
> > > > index c5ec897..903010a 100644
> > > > --- a/tools/include/uapi/linux/bpf.h
> > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
> > > >  	__aligned_u64 map_ids;
> > > >  	char name[BPF_OBJ_NAME_LEN];
> > > >  	__u32 ifindex;
> > > > -	__u64 netns_dev;
> > > > -	__u64 netns_ino;
> > > > +	__aligned_u64 netns_dev;
> > > > +	__aligned_u64 netns_ino;
> > > >  } __attribute__((aligned(8)));
> > > > =20
> > > >  struct bpf_map_info {
> > > > @@ -1030,8 +1030,8 @@ struct bpf_map_info {
> > > >  	__u32 map_flags;
> > > >  	char  name[BPF_OBJ_NAME_LEN];
> > > >  	__u32 ifindex;
> > > > -	__u64 netns_dev;
> > > > -	__u64 netns_ino;
> > > > +	__aligned_u64 netns_dev;
> > > > +	__aligned_u64 netns_ino;
> > > >  } __attribute__((aligned(8)));
> > > > =20
> > > >  /* User bpf_sock_addr struct to access socket fields and sockaddr =
struct passed


--=20
ldv

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbESoLAAoJEAVFT+BVnCUI2OMQAKomu2JjWOFKk06BMDvz7FTq
ZDNltEBjY/ZyHN5vZRXOyRscPPbVinNVpkYp7TRhsM974EX6ZXe+q6K3hogxGuvx
6ZZ+0gz0CUab5GhAMb0T8jREcy2mgxRoV66XQRrTz0LGBwMENRO1OQo8jChjWExC
EO94Uct9UqD4CsPz8EnK3dNuN28GsXqNgqyRcnkJ5DPoObfbIVzBhfraVsar4B8n
aKdXSfy1c8kaDegTIyIJgHrAz+IJg0DYn8rfVrUXPAX6tgOpcRAnrjIn0LNPh00+
Cq8JCm2wkBluYfV1va31HCwILJq4xl0UzpDMbl623PC9v705h/qLK/VDOrLhZYep
TMwXqFNkzLPB4TUustTtcE/1QjrHRXoDIOT3all2yKSvXIsKCEWr9G8VtxxHkY0u
WYonFtEHlGCCpuhygKfPGZD1np+JSmEOeuXQTQm3oo+FL0aElnWvjTU8MLdyyScU
PVPsN1MCkgTix3yF5nPAQz1DA2sLAuhfT3WsBH62gvL0ahzbQzrTI6gb00rQIcY3
HyjVV3O820s/BzED9Uzj69lfK4ma4ihF4CJEcrN3V7hAA2pA6KEzrNHB1/QARlAy
I1tjhuBR0aRZLzIKmAELuV7pwHBQsJhVFGbKCIGdQXVRPUjZymYg3273OYf1LU3v
sSTSs6sicSY1KXZPbPZa
=bwqt
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
