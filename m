Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0873AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB5920672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="oEm7STF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB5920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLGTtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:49:23 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:35152 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLGTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:49:22 -0500
Received: from [192.168.111.102] (p4FD9776D.dip0.t-ipconnect.de [79.217.119.109])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id wB7JnHNL001942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Dec 2018 20:49:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1544212157;
        bh=/wK1YvJlWtWyBxOQ/rdCW6ztv2Fg5WKPLTlD4jmyDjM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oEm7STF5N5vSr5RJuv/pGoyOhWn7ptZTNoorlBZyy0piHZ7L6sIDSWFJEjDDHrmg7
         bcnUy0b9YYqt+YOq21rXmKbOeq8Hf++ozv97X2DEzFHiDz0EbczlMyjRgdSE0s/zyV
         f5oPAQB7DLTj3vs/ForWxiS5bk8LWHI28/LFBjIA=
Subject: Re: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 spNrcZJf1pbo3EKkCwUPAltq51ramtYzOu4K
Message-ID: <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
Date:   Fri, 7 Dec 2018 20:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207175811.GZ2217@ZenIV.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="l5YgmPO2bSmQxA58JiydjvYXRvGowIcPQ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l5YgmPO2bSmQxA58JiydjvYXRvGowIcPQ
Content-Type: multipart/mixed; boundary="eJJ0Z8v6Q76d596JmBeiISQmUqJxTILsC";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Message-ID: <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
Subject: Re: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
In-Reply-To: <20181207175811.GZ2217@ZenIV.linux.org.uk>

--eJJ0Z8v6Q76d596JmBeiISQmUqJxTILsC
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable



On 07.12.18 18:58, Al Viro wrote:
> On Fri, Dec 07, 2018 at 05:10:15PM +0100, Alexander Lochmann wrote:
>>
>> inode.i_flags might be altered without proper
>> synchronisation when the inode belongs to devtmpfs.
>> blkdev_write_iter() starts writing via __generic_file_write_iter()
>> which sets S_NOSEC bit without any synchronisation.
>> The following stacktrace shows how to get there:
>> 13: entry_SYSENTER_32:460
>> 12: do_fast_syscall_32:410
>> 11: _static_cpu_has:146
>> 10: do_syscall_32_irqs_on:322
>> 09: SyS_pwrite64:636
>> 08: SYSC_pwrite64:650
>> 07: fdput:38
>> 06: vfs_write:560
>> 05: __vfs_write:512
>> 04: new_sync_write:500
>> 03: blkdev_write_iter:1977
>> 02: __generic_file_write_iter:2897
>> 01: file_remove_privs:1818
>> 00: inode_has_no_xattr:3163
>> If S_NOSEC is *not* set, i_rwsem is acquired around
>> __generic_file_write_iter().
>=20
>> +	 * Ensure excl. access to i_flags in __generic_file_write_iter().
>> +	 * Otherwise, it would race with chmod adding SUID bit.
>> +	 */
>=20
> _What_ SUID bit?  We are talking about a write to block device, for fsc=
k sake...
>=20
That's the way I understood Jan's explanation:
"
Thinking more about this I'm not sure if this is actually the right
solution. Because for example the write(2) can set S_NOSEC flag wrongly
when it would race with chmod adding SUID bit. So probably we rather need=

to acquire i_rwsem in blkdev_write_iter() if file does not have S_NOSEC s=
et
(we don't want to acquire it unconditionally as that would heavily impact=

scalability of block device writes).

								Honza"

If I'm mistaking, pls help me with fixing it.

- Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--eJJ0Z8v6Q76d596JmBeiISQmUqJxTILsC--

--l5YgmPO2bSmQxA58JiydjvYXRvGowIcPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAlwKzr0ACgkQWT7tBbw+
9v1EBw/9FNKzY+z9lnJoHUWN70eCHosRhG7sWAmUwBkATgGFDtAYB686Fy0RT2GX
BEJ2mJVZr7k2oE81QOfqs24gtk7OJqagl8xbJPYXVLNMXQ8sD2sIxvb0G8QDgJqc
KtMq6jf9GnaxCuSSyC6sBxrbHn80BU6fTQJwEPpv2OQzWSlXbKdzKgq3DkKo7V4a
u/R0A+3W9EivFm8rQHl4X10RwiNgkJ3EFx+wtTV4q29neOPxTcsxveidI6bJ3lq1
oMmxMY1jOXD32aYxi0M2DI/7OGbuPDRcoB/+TO9zxcylKO2rbyY/EriEH7bm0LUR
trUgBvRLJULa86DJcFLmJ2GxDC8Bl27Aevj71G94OhL35VUCZh3lvHY436QqJRvi
30L9I61e/f74XyXvZ/LmnYI89UQDtJAZYPmiuP2hRtf9ZEjCJ+FpYYb3CbG6RvmJ
3u9RhebfhbQg++V499wUdljB3rBkdQ63tuR4VjFmzHm7xyMoQI65llTmkhQP/r0X
xX/DA40jiGxZ3b3NuNVQM6PN5JGjoogu2+TFyA1dslFy+4md6a0fyklKXriIHaQh
9z9xb4nNd2AjepAZz3OHQfb4YUANaq//VMXsO+CEGUIgl6ZIlc9mAgYLfIvrKHVD
7SxA2UQuyOtaZ/jH738fokacRnFBgRaHjg/UIAgRvYZnDIcJ5Ms=
=t7Uu
-----END PGP SIGNATURE-----

--l5YgmPO2bSmQxA58JiydjvYXRvGowIcPQ--
