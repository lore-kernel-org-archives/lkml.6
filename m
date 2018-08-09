Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0675AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6A223A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC6A223A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeHJCHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:07:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbeHJCHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:07:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54E14AF40;
        Thu,  9 Aug 2018 23:40:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 10 Aug 2018 09:40:35 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs/locks: change all *_conflict() functions to return a new enum.
In-Reply-To: <20180809130959.GH23873@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble> <153378028114.1220.3708291796442871726.stgit@noble> <20180809130959.GH23873@fieldses.org>
Message-ID: <87d0urrtvw.fsf@notabene.neil.brown.name>
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

On Thu, Aug 09 2018, J. Bruce Fields wrote:

> On Thu, Aug 09, 2018 at 12:04:41PM +1000, NeilBrown wrote:
>> In a future patch we will need to differentiate between conflicts that
>> are "transitive" and those that aren't.
>> A "transitive" conflict is defined as one where any lock that
>> conflicts with the first (newly requested) lock would conflict with
>> the existing lock.
>>=20
>> So change posix_locks_conflict(), flock_locks_conflict() (both
>> currently returning int) and leases_conflict() (currently returning
>> bool) to return "enum conflict".
>> Add locks_transitive_overlap() to make it possible to compute the
>> correct conflict for posix locks.
>>=20
>> The FL_NO_CONFLICT value is zero, so current code which only tests the
>> truth value of these functions will still work the same way.
>>=20
>> And convert some
>>    return (foo);
>> to
>>    return foo;
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  fs/locks.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++-------=
-------
>>  1 file changed, 49 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index b4812da2a374..d06658b2dc7a 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -139,6 +139,16 @@
>>  #define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
>>  #define IS_REMOTELCK(fl)	(fl->fl_pid <=3D 0)
>>=20=20
>> +/* A transitive conflict is one where the first lock conflicts with
>> + * the second lock, and any other lock that conflicts with the
>> + * first lock, also conflicts with the second lock.
>> + */
>> +enum conflict {
>> +	FL_NO_CONFLICT =3D 0,
>> +	FL_CONFLICT,
>> +	FL_TRANSITIVE_CONFLICT,
>> +};
>> +
>>  static inline bool is_remote_lock(struct file *filp)
>>  {
>>  	return likely(!(filp->f_path.dentry->d_sb->s_flags & SB_NOREMOTELOCK));
>> @@ -612,6 +622,15 @@ static inline int locks_overlap(struct file_lock *f=
l1, struct file_lock *fl2)
>>  		(fl2->fl_end >=3D fl1->fl_start));
>>  }
>>=20=20
>> +/* Check for transitive-overlap - true if any lock that overlaps
>> + * the first lock must overlap the seconds
>> + */
>> +static inline bool locks_transitive_overlap(struct file_lock *fl1,
>> +					    struct file_lock *fl2)
>> +{
>> +	return (fl1->fl_start >=3D fl2->fl_start) &&
>> +		(fl1->fl_end <=3D fl2->fl_end);
>> +}
>>  /*
>>   * Check whether two locks have the same owner.
>>   */
>> @@ -793,47 +812,61 @@ locks_delete_lock_ctx(struct file_lock *fl, struct=
 list_head *dispose)
>>  /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
>>   * checks for shared/exclusive status of overlapping locks.
>>   */
>> -static int locks_conflict(struct file_lock *caller_fl, struct file_lock=
 *sys_fl)
>> +static enum conflict locks_conflict(struct file_lock *caller_fl,
>> +				    struct file_lock *sys_fl)
>>  {
>>  	if (sys_fl->fl_type =3D=3D F_WRLCK)
>> -		return 1;
>> +		return FL_TRANSITIVE_CONFLICT;
>>  	if (caller_fl->fl_type =3D=3D F_WRLCK)
>> -		return 1;
>> -	return 0;
>> +		return FL_CONFLICT;
>> +	return FL_NO_CONFLICT;
>>  }
>>=20=20
>>  /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
>>   * checking before calling the locks_conflict().
>>   */
>> -static int posix_locks_conflict(struct file_lock *caller_fl, struct fil=
e_lock *sys_fl)
>> +static enum conflict posix_locks_conflict(struct file_lock *caller_fl,
>> +					  struct file_lock *sys_fl)
>>  {
>>  	/* POSIX locks owned by the same process do not conflict with
>>  	 * each other.
>>  	 */
>>  	if (posix_same_owner(caller_fl, sys_fl))
>> -		return (0);
>> +		return FL_NO_CONFLICT;
>>=20=20
>>  	/* Check whether they overlap */
>>  	if (!locks_overlap(caller_fl, sys_fl))
>> -		return 0;
>> +		return FL_NO_CONFLICT;
>>=20=20
>> -	return (locks_conflict(caller_fl, sys_fl));
>> +	switch (locks_conflict(caller_fl, sys_fl)) {
>> +	default:
>> +	case FL_NO_CONFLICT:
>> +		return FL_NO_CONFLICT;
>> +	case FL_CONFLICT:
>> +		return FL_CONFLICT;
>
> If I'm understanding the logic here and in locks_conflict correctly,
> you're telling me that in the case where sys_fl is a read lock, and
> caller_fl is a write lock, then any lock which conflicts with sys_fl
> must conflict with caller_fl?  Or do I have that backwards?  It doesn't
> sound right, in any case.

As I was writing this code, I was thinking that I'd probably end up
getting something backwards....
Let's see.  I wrote:

>> +/* A transitive conflict is one where the first lock conflicts with
>> + * the second lock, and any other lock that conflicts with the
>> + * first lock, also conflicts with the second lock.
>> + */

caller_fl is first and sys_fl is second.

if sys_fl, the second, is a read lock, and caller_fl, the first, is a
write lock, they clearly conflict but any other lock that conflict
with caller_fl (The write lock) would *not* necessarily conflict with
the read lock.  So this situation is *not*  FL_TRANSITIVE_CONFLICT.

locks_conflict() only returns FL_TRANSITIVE_CONFLICT when sys_fl (the
second) is a write lock, which it isn't in this case.  So I think that
this case is handled correctly.
posix_locks_conflict() will return FL_CONFLICT, but not
FL_TRANSITIVE_CONFLICT.

Have I convinced you, or have I missed your point?

Thanks,
NeilBrown


>
> --b.
>
>> +	case FL_TRANSITIVE_CONFLICT:
>> +		if (locks_transitive_overlap(caller_fl, sys_fl))
>> +			return FL_TRANSITIVE_CONFLICT;
>> +		else
>> +			return FL_CONFLICT;
>> +	}
>>  }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlts0PMACgkQOeye3VZi
gbkanA/+OcY8v/5/aMt6pw45V2Q3P6W2O2oaUHU1eqC0SehcYoOivJ7xTykB1Jqk
Tl6dLs2x/A7AkyFDUt5S2zEq8qQhAsH3k0WTznYvCSov+DGBd/jQ2Bb+Vk5NqEiU
frPrgHrY1IIthCA7nx2Z6e9u+noynn1J8g+uWj+qZ78p2B5n4LFcSKEw49H6DpjO
GCMbhz0lXYyR90XXgNgqseK2r1s0QCS4Fo6jodxAwkXXvMs6yn13jzdaEWw45C1p
YTizgE5Rs1+I81UJgETDegIS6d/GzIqK113vKj53PlIat/C+u6NOZEv93g7XiJ1B
NbaPMq49k5FFPFPNIus3sWM0yze7EC1lzFtV2ydk6DsCPbHm7FhN1shl/1QvYnw6
4B8gvm0N7rBVpoFb1+5VsLG82OZSX+uDCinWM1IERn5+opMD3dsDqXtSveurB3/g
tXA/rwEuSkZIEYR456/W8Gt5mlcNhudDnhojN/7mVtDTSob78uj3vEjuUXhc85+6
eWUQIgqoQqmPvpuYEGPyjlq3iNP12ahcv516QuIe3Y7n0RodnnKGCwFc5BiajpKC
q379qSxVlxaTPWf9tpDL76NR9vtrYYINSaksD+12J76VO9MbDxB03K39yZsiFwth
SvTk7RPahly2MyhKwFQOmBGnXv2Ioteg74ooVKYSKrqcNkCQ0sI=
=lLDt
-----END PGP SIGNATURE-----
--=-=-=--
