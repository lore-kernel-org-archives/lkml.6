Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDFBeR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeDFBeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:34:15 -0400
From: NeilBrown <neilb@suse.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?=
        <andreas.gruenbacher@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 06 Apr 2018 11:33:58 +1000
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, Thomas Graf <tgraf@suug.ch>,
        Tom Herbert <tom@quantonium.net>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [Cluster-devel] [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
In-Reply-To: <CAHpGcMKxDNOkMMKB1_9H0ob-502cD89E-94a18prp91y_a52GA@mail.gmail.com>
References: <20180329120612.6104-1-agruenba@redhat.com> <1366548861.16037365.1522856788263.JavaMail.zimbra@redhat.com> <20180404154859.GA12104@gondor.apana.org.au> <CAHpGcMKxDNOkMMKB1_9H0ob-502cD89E-94a18prp91y_a52GA@mail.gmail.com>
Message-ID: <871sftxgmx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04 2018, Andreas Gr=C3=BCnbacher wrote:

> Herbert Xu <herbert@gondor.apana.org.au> schrieb am Mi. 4. Apr. 2018 um
> 17:51:
>
>> On Wed, Apr 04, 2018 at 11:46:28AM -0400, Bob Peterson wrote:
>> >
>> > The patches look good. The big question is whether to add them to this
>> > merge window while it's still open. Opinions?
>>
>> We're still hashing out the rhashtable interface so I don't think now is
>> the time to rush things.
>
>
> Fair enough. No matter how rhashtable_walk_peek changes, we=E2=80=98ll st=
ill need
> these two patches to fix the glock dump though.

Those two patches look fine to me and don't depend on changes to
rhashtable, so it is up to you when they go upstream.

However, I think the code can be substantially simplified, particularly
once we make rhashtable a little cleverer.
So this is what I'll probably be doing for a similar situation in
lustre....

Having examined seqfile closely, it is apparent that if ->start never
changes *ppos, and if ->next always increments it (except maybe on error)
then

1/ ->next is only ever given a 'pos' that was returned by the previous
   call to ->start or ->next.  So it should *always* return the next
   object, after the one previously returned by ->start or ->next.  It
   never needs to 'seek'. The 'traverse()' function in seq_file.c does
   any seeking needed.  ->next needs to increase 'pos' and when walking
   a dynamic list, it is easiest if it just increments it.

2/ ->start is only called with a pos of:
    0 - in this case it should rewind to the start
    the last pos passed to ->start of ->next
         In this case it should return the same thing that was
         returned last time.  If it no longer exists, then
         the following one should be returned.
    one more than the last pos passed to ->start or ->next
         In this case it should return the object after the
         last one returned.

The proposed enhancement to rhashtable_walk* is to add a
rhashtable_walk_prev() which returns the previously returned object,
if it is still in the table, or NULL. It also enhances
rhashtable_walk_start() so that if the previously returned object is
still in the table, it is preserved as the current cursor.
This means that if you take some action to ensure that the
previously returned object remains in the table until the next ->start,
then you can reliably walk the table with no duplicates or omissions
(unless a concurrent rehash causes duplicates)
If you don't keep the object in the table and it gets removed, then
the 'skip' counter is used to find your place, and you might get
duplicates or omissions.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrGzogACgkQOeye3VZi
gblBuA/9FSMWwFf+WbZ0Jb8VBoyP3mumk037eDjUE+CjHkhswmRbMPi/9CRDl6Nf
oIrMMlderVB3Q7ze1pIDZGPr1iOD6tI9RdHz2bWB41xWXZJqlabvgc30nbsNW84T
rPGdZfMQKx1OAPrV7+JXq9kFiQqyefPiSvBLxO4yciROh0dXJ5XvLAuIFTnwrH6k
8InQmX17Verhtn/d13npQ4qMIaUroui74yi3b2nvSPpA5elwJVHgHgv1WWMMl7wQ
JNaDiHPJc3jQKsk7zdyMv/f3nvy4JD+sNpm3C9eAey44aObXdx93mgouTgdA9XXQ
3FKlIlbTo1UPI07vf1lgXugPNpNF0PTsUrSRae06iI+F91g0UIfCd/grpuR2BwKY
i7Bch9rv6b+uPCin3Jv6aPJuWV4PcrpRVcRJQWtsKjlUbppLiFeA2FvQjOA/V8cT
8DJh4KKUEFJsUZBEIs2L7T9EJrqsb71V2JDF+1CpG47lrVkP1H7BPjOC2rj/PyFW
exNsfmY4LU9pavoN9zOQz4NWBWo8klkHjNzirK8WNy0PtZakt6XhaxEH7FSXN4AS
nfbXX7sTmKhjAjTbOCCq5xpuK61PbMWFmv4H78CDT2pNFqV1IpmTOajOyR0K/xUM
zQKnPaNZSRgFqs49RrphroQxXpbjqEQpJ9jjoKFzm4WS69LLEX8=
=u53V
-----END PGP SIGNATURE-----
--=-=-=--
