Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeFAFia (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 01:38:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFAFi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 01:38:26 -0400
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 01 Jun 2018 15:38:15 +1000
Cc: James Simmons <jsimmons@infradead.org>,
        "devel\@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Drokin\, Oleg" <oleg.drokin@intel.com>,
        "Hammond\, John" <john.hammond@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 6/6] staging: lustre: mdc: use large xattr buffers for old servers
In-Reply-To: <AE3B1D00-46A8-42FA-9025-2E680C185294@intel.com>
References: <1527603705-30450-1-git-send-email-jsimmons@infradead.org> <1527603705-30450-7-git-send-email-jsimmons@infradead.org> <20180531165426.GA23414@kroah.com> <AE3B1D00-46A8-42FA-9025-2E680C185294@intel.com>
Message-ID: <87po1brrqw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 31 2018, Dilger, Andreas wrote:

> On May 31, 2018, at 18:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org=
> wrote:
>>=20
>> On Tue, May 29, 2018 at 10:21:45AM -0400, James Simmons wrote:
>>> From: "John L. Hammond" <john.hammond@intel.com>
>>>=20
>>> Pre 2.10.1 MDTs will crash when they receive a listxattr (MDS_GETXATTR
>>> with OBD_MD_FLXATTRLS) RPC for an orphan or dead object. So for
>>> clients connected to these older MDTs, try to avoid sending listxattr
>>> RPCs by making the bulk getxattr (MDS_GETXATTR with OBD_MD_FLXATTRALL)
>>> more likely to succeed and thereby reducing the chances of falling
>>> back to listxattr.
>>>=20
>>> +#if LUSTRE_VERSION_CODE < OBD_OCD_VERSION(3, 0, 53, 0)
>>=20
>> Why are you adding pointless version checks to mainline?  Please don't
>> add new ones of these, you need to be working on removing the existing
>> ones.
>
> These are not Linux kernel version checks, but rather Lustre release vers=
ion
> checks.  This allows us to remove workarounds like this in the future when
> they are no longer needed, rather than accumulating cruft forever.  It's =
like
> the separation of NFSv2 vs NFSv3 vs NFSv4.

It looks very different to the separation of NFSv{2,3,4}.  Those are
conditionally compiled on a whole-file basis.
If we ever want to remove this code it should be hard to search for
occurances of OBD_OCD_VERSION() in the code, we don't need the C
preprocessor to be able to remove them for us.
In this particular example:

+	if (exp->exp_connect_data.ocd_version < OBD_OCD_VERSION(2, 10, 1, 0))
+		min_buf_size =3D exp->exp_connect_data.ocd_max_easize;

if you want to be able to compile without that one test, you could arrange
that OBD_OSC_VERSION(2, 10, 1, 0) evaluates to 0.
As ocd_version is unsigned, the comparison will always be false, and
the compiler will optimize the code away.

As a general rule, you need a very good reason to have #if or #ifdef in
.c files.  They are usually OK in .h files.

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsQ28cACgkQOeye3VZi
gbnE9RAAsuK3f3V/XGHEJjuOk8LPOLn9XXikXqyVL1XYD2daVRtVgCIiDpAuupF0
tlB9DiUclx0Umnck4ygjp+umICip0q/O9Q+KvkJ+8+6TzfdJX8i+XsmgKrzodsax
VJF+xFwLotBd2Lb1jFMMO4Sm29NP6GXIfd3rTI6V8I95/mYMIGoI1K4oZP7713Z7
BCd9/ZB6etc6iJMvvmmM+cvjglt7F2C8dL0sxC8jThp680LdOiDGYmo08Q0cYNjs
T0UvaAUGH8czLz0v/hY0e0l7Dik1c8fvvVE/uF448sEhdFHvUCRwkUpV8YTveceS
Q2QpE+od8vh9ssx7XPAppVv0u9+sDgQcF2n7dbm2B2YNISAlnpnP6qMwDoj35Y45
rYbrw0nJdiSfS8LyerRd4xb04R6KuMQ9kcilvbYgNtFyJt/xE+xXCmNhYWhWm3Ka
8Hnq1EmPXVCQWrhYWQTKAa0IN1AIsibj9safOnFTk0/nD5U3I65GlC3y7z+EUw7B
6QlcnJ+AUzdxggeWoLXchxGtCBFBo5Z43qO9gSR28HEezOLtEKJPLsNe5i+aIYga
zzTxQU0RYvVH7sADfBrJMeseTHbv7abQLHBihvT6sAyAFwjnm1J4VYu9sRKd8eOd
JBRbFYHTOA8qj4uoggL3/0DRThzCR4lIEml+zJ3M5eLFnZqraqQ=
=tiiu
-----END PGP SIGNATURE-----
--=-=-=--
