Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F075C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1486B2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1486B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeKFLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:10:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeKFLKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:10:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D1B6ACBF;
        Tue,  6 Nov 2018 01:48:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 06 Nov 2018 12:48:02 +1100
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] gfs2: properly initial file_lock used for unlock.
In-Reply-To: <efbaeb736e4738bb7a0e2f8529bf1db8459bbe56.camel@kernel.org>
References: <154138128401.31651.1381177427603557514.stgit@noble> <154138144777.31651.4516223215037533891.stgit@noble> <efbaeb736e4738bb7a0e2f8529bf1db8459bbe56.camel@kernel.org>
Message-ID: <875zxbyo19.fsf@notabene.neil.brown.name>
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

On Mon, Nov 05 2018, Jeff Layton wrote:

> On Mon, 2018-11-05 at 12:30 +1100, NeilBrown wrote:
>> Rather than assuming all-zeros is sufficient, use the available API to
>> initialize the file_lock structure use for unlock.
>> VFS-level changes will soon make it important that the
>> list_heads in file_lock are always properly initialized.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  fs/gfs2/file.c |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
>> index 45a17b770d97..271f847705e3 100644
>> --- a/fs/gfs2/file.c
>> +++ b/fs/gfs2/file.c
>> @@ -1199,13 +1199,13 @@ static int do_flock(struct file *file, int cmd, =
struct file_lock *fl)
>>  	mutex_lock(&fp->f_fl_mutex);
>>=20=20
>>  	if (gfs2_holder_initialized(fl_gh)) {
>> +		struct file_lock request;
>>  		if (fl_gh->gh_state =3D=3D state)
>>  			goto out;
>> -		locks_lock_file_wait(file,
>> -				     &(struct file_lock) {
>> -					     .fl_type =3D F_UNLCK,
>> -					     .fl_flags =3D FL_FLOCK
>> -				     });
>> +		locks_init_lock(&request);
>> +		request.fl_type =3D F_UNLOCK;
>
> F_UNLCK ?
>
> The ocfs2 patch has the same bug.

Anyone would think that I hadn't even compile tested.....

This is true for OCFS2 :-( but I had actually compile-tested with GFS2
enabled.
But CONFIG_DLM *wasn't* enabled, so GFS2 was compiled without locking
support.
I guess there is a good reason that GFS2 doesn't require DLM.

Do you want me to resend the series, to will you just update those
patches.

Sorry about that,
NeilBrown


>
>> +		request.fl_flags =3D FL_FLOCK;
>> +		locks_lock_file_wait(file, &request);
>>  		gfs2_glock_dq(fl_gh);
>>  		gfs2_holder_reinit(state, flags, fl_gh);
>>  	} else {
>>=20
>>=20
>
> --=20
> Jeff Layton <jlayton@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvg8tMACgkQOeye3VZi
gbkhQQ//eLcB4n71oQCYnQWrs7I2oUvPruxuNIr3QboGNlUEGSgdFPTkgKB4vCwr
AY2uL/Vj0DBj/nO7dPLwP5kSX9CsKZj/VbmXu9ovTPAQSvfHhfufi7y7Z58I7lV8
5jf3g0LE23eFyuQtS+eBkt9mcAhNSGKPxNKWrwyNCxYUgCejYtLpOrV2rkN/vEAU
gloWPJ1Mtirf0gYrHLgTa7lSgtrNFgCMwgIrQzb/8xwNXfEGE76Y0gg/1T+synXy
4vJafaF+sM6Od8YZ4zUpT/oQdwUDqyJsCa0CjFyFXVXi60MfI8UFStagxKnx2Ta9
jJ09tPwLllHfHT3UVLaycybbKpXcXU95TWKOX008F8jKduVMkLApscZc0BLrEUjN
5DtRKl8skmfUMvJuVKJcPVTZ0seaUNmQD2LaXTcnxfJAlZaqIYYshLUAH7d2FSEO
cU7W4rsJqzosQaS5yTEpehwQubwDd012uBRhG0MzPfVWVBGHwXTimATZ8tVuxYOT
pLRbDL6/XwIOzrunoEeZoGYQid0ZJ8FewukWfjtItwP+k7B66mx0yTIUCcOx72vK
SFhVawad3UzS7e4MXO4yfnTvM6vD82hAVDhHkC3Bh2aMemXwZKwfuCqwUpXDZuTW
I6A1Swnxh+CaL0d8gaTm78MQD5hNTtJ/wEnlk3seF1KDQ1pzAco=
=jAnm
-----END PGP SIGNATURE-----
--=-=-=--
