Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967606AbeE2WCB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:02:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:44837 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966823AbeE2WB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:01:58 -0400
From: NeilBrown <neilb@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Date: Wed, 30 May 2018 08:01:48 +1000
Cc: changbin.du@intel.com, akpm@linux-foundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] scripts/faddr2line: show the code context
In-Reply-To: <20180529172430.GB12180@hirez.programming.kicks-ass.net>
References: <1521444205-2259-1-git-send-email-changbin.du@intel.com> <20180529160332.GD12258@hirez.programming.kicks-ass.net> <20180529162636.GW12235@hirez.programming.kicks-ass.net> <20180529170710.q33dcw5l7a4bwd4t@treble> <20180529172430.GB12180@hirez.programming.kicks-ass.net>
Message-ID: <87sh6aunn7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 29 2018, Peter Zijlstra wrote:

> On Tue, May 29, 2018 at 12:07:10PM -0500, Josh Poimboeuf wrote:
>> Yeah, this change really should have been an optional arg.  It hurt the
>> readability and compactness of the output.  The above looks good to me.
>>=20
>> Care to send a proper patch?  If you send it to Linus he might apply it
>> directly as he did with my original patches.
>
> ---
> From: Peter Zijlstra (Intel) <peterz@infraded.org>
>
> Commit 6870c0165feaa5 ("scripts/faddr2line: show the code context")
> radically altered the output format of the faddr2line tool. And while
> the new list output format might have merrit it broke my vim usage and
> was hard to read.
>
> Make the new format optional; using a '--list' argument and attempt to
> make the output slightly easier to read by adding a little whitespace to
> separate the different files and explicitly mark the line in question.

Not commenting on your code but on the original patch.....
I've recently noticed that ADDR2LINE sometimes outputs
  (discriminator 2)
or similar at the end of the line.  This messes up the parsing.

I hacked it to work so I could keep debugging with

=2D		local file_lines=3D$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_=
prefix\(\./\)*; ;")
+		local file_lines=3D$(${ADDR2LINE} -fpie $objfile $addr | sed -e "s; $dir=
_prefix\(\./\)*; ;" -e "s/(discriminator [0-9]*)//")

but someone should probably find out exactly what sort of messages
ADDR2LINE produces, and make sure they are all parsed correctly.
(maybe that someone should be me, but not today).

Thanks,
NeilBrown


>
> Cc: Changbin Du <changbin.du@intel.com>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Fixes: 6870c0165feaa5 ("scripts/faddr2line: show the code context")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  scripts/faddr2line | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 1876a741087c..a0149db00be7 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -56,7 +56,7 @@ command -v ${SIZE} >/dev/null 2>&1 || die "size isn't i=
nstalled"
>  command -v ${NM} >/dev/null 2>&1 || die "nm isn't installed"
>=20=20
>  usage() {
> -	echo "usage: faddr2line <object file> <func+offset> <func+offset>..." >=
&2
> +	echo "usage: faddr2line [--list] <object file> <func+offset> <func+offs=
et>..." >&2
>  	exit 1
>  }
>=20=20
> @@ -166,15 +166,25 @@ __faddr2line() {
>  		local file_lines=3D$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_=
prefix\(\./\)*; ;")
>  		[[ -z $file_lines ]] && return
>=20=20
> +		if [[ $LIST =3D 0 ]]; then
> +			echo "$file_lines" | while read -r line
> +			do
> +				echo $line
> +			done
> +			DONE=3D1;
> +			return
> +		fi
> +
>  		# show each line with context
>  		echo "$file_lines" | while read -r line
>  		do
> +			echo
>  			echo $line
>  			n=3D$(echo $line | sed 's/.*:\([0-9]\+\).*/\1/g')
>  			n1=3D$[$n-5]
>  			n2=3D$[$n+5]
>  			f=3D$(echo $line | sed 's/.*at \(.\+\):.*/\1/g')
> -			awk 'NR>=3Dstrtonum("'$n1'") && NR<=3Dstrtonum("'$n2'") {printf("%d\t=
%s\n", NR, $0)}' $f
> +			awk 'NR>=3Dstrtonum("'$n1'") && NR<=3Dstrtonum("'$n2'") { if (NR=3D=
=3D'$n') printf(">%d<", NR); else printf(" %d ", NR); printf("\t%s\n", $0)}=
' $f
>  		done
>=20=20
>  		DONE=3D1
> @@ -185,6 +195,10 @@ __faddr2line() {
>  [[ $# -lt 2 ]] && usage
>=20=20
>  objfile=3D$1
> +
> +LIST=3D0
> +[[ "$objfile" =3D=3D "--list" ]] && LIST=3D1 && shift && objfile=3D$1
> +
>  [[ ! -f $objfile ]] && die "can't find objfile $objfile"
>  shift
>=20=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsNzcwACgkQOeye3VZi
gbkNXQ//WoTGlhzD5mBW5GN4u6JZ+9DHzj2USQSQibv0iXXQ8fZRn3D7hoNd5nWd
NFfGh4/y0XR1XP2ffuqBBilvMk/Uzop9aI608RRejI9Z5LOyhQRVqITcsJ15DbDV
v7lvZjjBgUO9tm3xrEQCUQ9mJBS+EPpZk7hx4SagdAbxlt0hvNcnfC7TAR6XF0FP
XkBQODwQOKK+nUlhchV2P7CEBTUHUoNXiGBKxdkB/hjazhvoUM3/wXtOHhlr9Rde
I6k/MI7ybYU5jle2SXRh1kEmhNe4t/s7w0UfWn26Kt9sCYa0k2TbrAJt/U1OwI+r
/NKiUpIBIQ08WA8YLCJ/YXu45opv0FVXnaXD1be3+VTnSJG35LAp/ie4SqiBc+rz
oir4UJXiDSage64lsvibWB5rswp6H3avIeOdYE1GNtENq836xbHf8FAFhu3FLbDq
vQ3dKnSObYyDgQtwdaI1LWV/+fwbjwd72yhNR+wGxx+8FqKyfllb6bln9hcVmFCC
FOFLk46e64oFVSfVYYkwlVLV7bpA9N8RO//Y7u0U5kiq0VPQ6W5Ig6Ve5+0q6qTh
NAtNsIIp4iipBwlcCdZHcobRTUz+5Pv0D+zriUgcqp1uaRwdC8vasm+iz2wHta54
b0m0OHMTPMnW3Wn4k+xKPcVyyLxE9bF56aVo+TZ4V64wkR+OKbU=
=oYEm
-----END PGP SIGNATURE-----
--=-=-=--
