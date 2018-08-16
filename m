Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A6DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78884214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78884214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbeHPIP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:15:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeHPIP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:15:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A82B2AD06;
        Thu, 16 Aug 2018 05:20:07 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 16 Aug 2018 15:19:59 +1000
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc\@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [BUG][BISECT] NFSv4 root failures after "fs/locks: allow a lock request to block other requests."
In-Reply-To: <8acb99be800a1842278f754986a17d6fc93af409.camel@kernel.org>
References: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com> <8acb99be800a1842278f754986a17d6fc93af409.camel@kernel.org>
Message-ID: <87o9e2anwg.fsf@notabene.neil.brown.name>
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

On Wed, Aug 15 2018, Jeff Layton wrote:

> On Wed, 2018-08-15 at 14:28 +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>=20
>> Bisect pointed commit ce3147990450a68b3f549088b30f087742a08b5d
>> ("fs/locks: allow a lock request to block other requests.") to failure
>> boot of NFSv4 with root on several boards.
>>=20
>> Log is here:
>> https://krzk.eu/#/builders/21/builds/836/steps/12/logs/serial0
>>=20
>> With several errors:
>> kernel BUG at ../fs/locks.c:336!
>> Unable to handle kernel NULL pointer dereference at virtual address 0000=
0004
>>=20
>> Configuration:
>> 1. exynos_defconfig
>> 2. Arch ARM Linux
>> 3. Boards:
>> a. Odroid family (ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC)
>> b. Toradex Colibri VF50 (ARMv7, UP, Cortex-A5)
>> 4. Systemd: v236, 238
>> 5. All boards boot from TFTP with NFS root (NFSv4)
>>=20
>> On Colibri VF50 I got slightly different errors:
>> [   11.663204] Internal error: Oops - undefined instruction: 0 [#1] ARM
>> [   12.455273] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000004
>> and only with some specific GCC (v6.3) or with other conditions which
>> I did not bisect yet. Maybe Colibri's failure is unrelated to that
>> commit.
>>=20
>> Best regards,
>> Krzysztof

Thanks a lot for the report Krzysztof!!

>
> The BUG is due to a lock being freed when the fl_blocked list wasn't
> empty (implying that there were still blocked locks waiting on it).
>
> There are a number of calls to locks_delete_lock_ctx in posix_lock_inode
> and I don't think the fl_blocked list is being handled properly with all
> of them. It only transplants the blocked locks to a new lock when there
> are surviving locks on the list, and that may not be the case when the
> whole file is being unlocked.

locks_delete_lock_ctx() calls locks_unlink_lock_ctx() which calls
locks_wake_up_block() which doesn't only wake_up the blocks, but also
detached them. When that function completes, ->fl_blocked must be empty.

The trace shows the locks_free_lock() call at the end of fcntl_setlk64()
as the problematic call.
This suggests that do_lock_file_wait() exited with ->fl_blocked
non-empty, which it shouldn't.

I think we need to insert a call to locks_wake_up_block() in
do_lock_file_wait() before it returns.
I cannot find a sequence that would make this necessary, but
it isn't surprising that there might be one.

I'll dig through the code a bit more later and make sure I understand
what is happening.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlt1CX8ACgkQOeye3VZi
gbmzlRAAk2m+Da7jlPd3bZsAFMEg/mNhyNH3ZKpOLv4kLuHIHf51bX0DqFNsJaro
XzAuTbgpj8o1EycMhV2uwMAhUVk5GvqUebcQUZa0XTcRTyrwGMlc+2WgtJrPBU9y
/Jgnnro68Zo+rYdvy+YFQKjXFvhKwNWEeqeqMH3v62eO2gIyjatL+Vpgyim+U5zn
S0uxVLl31wWXU9YSLJW/8SKXbfJJnxKIJ1YmwChFsr5HaKPnIk3Nct+hAU43Qv2C
1PmBNZjQOIzN3qqZJM5Crj5IDsFnNoIgxhOromgX2tUQ34iksWyKbg63lRuG4x79
UKXbZMxon8JPyMfQpXq+lwrBbpfawTVNnYT0T+c6/ZA3avwI97CgVybgXRcFu8sw
S5GdSh1ZfXMH8F3yFp13JD6pb7gqlxWjNwBXF1jQNPdJOflTNN+OyfjEyW87v6vG
Jqbt3g5utzLmo8BvipaIJkoQ8eoHXyNn/13TTHIABQeLRYJ0aQpena4kvA6eo7SA
ZxDlxt2o66qB6DzmxI7ez+uCBtKNeIg16WBn2i9pF4QgxOujHU/dEkUH/vg0qJjA
CBADZOSTtOKkzp7t/3vrS21tpSvwhJ4Jb6M1PL+yDMP2OelNr2LV6Y4p75a8XOeB
D+fw90Ug5nvZUaWoKWzsQbr/NvhQsDdXWnBc1iXhzmecFsR9gsE=
=qiMl
-----END PGP SIGNATURE-----
--=-=-=--
