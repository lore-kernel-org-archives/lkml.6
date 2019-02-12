Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0013C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AFE222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if2pEUA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfBLXAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:00:50 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36104 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfBLXAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:00:49 -0500
Received: by mail-yb1-f196.google.com with SMTP id h40so173660ybj.3;
        Tue, 12 Feb 2019 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Bk+hZLg0NcmYxKxG+QNUS/UhkllGqbgqD2AzvS3AOuk=;
        b=if2pEUA/iispgWAXstTw4fdcCBPLhDx9uplIFdD5mVN2BHGd2JbG+2777ir82utoTJ
         4bgwgrkWwgw5S9dsVBIlYyajhTidgDld6PD70fewKudxEJlu9LYFZ49S0wh4ZM691bo1
         qKG22JArW6JKt3HBPDkpS6NLZVkZXk0ZQt/rA+uvj69K5rHM3wzpHp+7fNpD3yd6d6m4
         0XOuFs7Mv5uwnnadyiUQXHvPduBp5PVBM3sdbgGcd8d8BB0KemHOuBjAGeantg8gW4Hl
         fBdXWUBR4Vb7wUoEUYSu3V1WhdieykqrTFab0T/WHuPjNAJIg8cNmpL4WTnYcB9b3RFy
         rkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Bk+hZLg0NcmYxKxG+QNUS/UhkllGqbgqD2AzvS3AOuk=;
        b=tC6d4RijZWAnxlkT86Uf3EaG9NlhiSrmhonUsAJoYh3cVYaSZ1bGQ6uIL9BxNpaT38
         fJ3sZW9iYVIaHRVQF1gCMoyHTSTsnz35fL5L5olbqnZcReH2KVB/SQNvm2HowEXZIRMG
         dBIxlRta0joFdc9V6afC2s+3FGuEFCw47Uh0G+dIdcCyDNgFfBTnX0DKQmE84TgoHvB5
         La7xYLxmp4b0RZw/5WSHZT7AgeLZKHcYRBRUE52ddLNNxWmdvUxcSZQ5xHfAla36bp0v
         jJ2uyAj1tFl2CdH5HHD2wpaY6cm4apzIuwPnlRcP6TgfMM16HSZHeZ/S0SQ/Sz/lKxrN
         HIEw==
X-Gm-Message-State: AHQUAubuVoOjeWdWm1iGhbNcWw8gcVpv956dY4qkammAl6PlYDfTt0vE
        I1tycllxR4IIhyARim+H1EHjeaYf/YkYug==
X-Google-Smtp-Source: AHgI3IbjCcjk+pin+STBJpZt6cAlAQERmLGu6ZdsZt1bJCX9rFRNfiOe5uK5IPtgypBSku2e3Avwig==
X-Received: by 2002:a25:800c:: with SMTP id m12mr4990428ybk.93.1550012447962;
        Tue, 12 Feb 2019 15:00:47 -0800 (PST)
Received: from [127.0.0.1] (c-73-120-18-128.hsd1.tn.comcast.net. [73.120.18.128])
        by smtp.gmail.com with ESMTPSA id q11sm3765149ywl.99.2019.02.12.15.00.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 15:00:47 -0800 (PST)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-4-demiobenour@gmail.com>
 <20190212203809.GK2217@ZenIV.linux.org.uk>
From:   "Demi M. Obenour" <demiobenour@gmail.com>
Openpgp: preference=signencrypt
Subject: Re: [PATCH 4/4] Return -EINVAL if userspace passes bogus flags to
 open()
Message-ID: <ce981281-bb3a-a539-8d5a-b2d88107d4c0@gmail.com>
Date:   Tue, 12 Feb 2019 18:00:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212203809.GK2217@ZenIV.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6z3eDRomUoICfopK7sXJ71tceJ9PE28t5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6z3eDRomUoICfopK7sXJ71tceJ9PE28t5
Content-Type: multipart/mixed; boundary="fRv3Va28yBlsAQzFnvmZizGA0RsArkMwY";
 protected-headers="v1"
From: "Demi M. Obenour" <demiobenour@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <ce981281-bb3a-a539-8d5a-b2d88107d4c0@gmail.com>
Subject: Re: [PATCH 4/4] Return -EINVAL if userspace passes bogus flags to
 open()
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-4-demiobenour@gmail.com>
 <20190212203809.GK2217@ZenIV.linux.org.uk>
In-Reply-To: <20190212203809.GK2217@ZenIV.linux.org.uk>

--fRv3Va28yBlsAQzFnvmZizGA0RsArkMwY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2/12/19 3:38 PM, Al Viro wrote:
> On Tue, Feb 12, 2019 at 09:54:47AM -0500, demiobenour@gmail.com wrote:
>> From: "Demi M. Obenour" <demiobenour@gmail.com>
>>
>> While testing the O_PATHSTATIC patch, I discovered that Linux does not=

>> return any error if an invalid flag is passed to open(2).  This preven=
ts
>> adding new flags without a (minor) risk of breaking userspace.
>> Therefore, add a check for invalid flags, and return -EINVAL if any ar=
e
>> found.
>=20
> ... which would qualtify as userland ABI breakage all by itself.
>=20
I suspect that very few (if any) programs pass invalid flags to open().
Additionally, O_DIRECT was added in Linux 2.4, even though it had
previously been ignored.  If someone knows of a real program that does,
I can instead create an open2() syscall, but I would prefer to avoid that=
=2E


--fRv3Va28yBlsAQzFnvmZizGA0RsArkMwY--

--6z3eDRomUoICfopK7sXJ71tceJ9PE28t5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAlxjUBwACgkQsoi1X/+c
IsGozQ//SmIGyfpXyUpUQW56wYTui24CRQ1SM7FaKj5E/yMWzM1LTzJQvlnsN7mc
i6TGPkYWHoxvHDzEositaV6WJ7HIa/DFo1fwZNoRo/HpIN1fq8TE4aAgP41Tur1Z
DhHI75Fo7Q6fEaiSSCI0Ce2QmP35LDC+TlvvODDLdoRLw79zWD7LtZWi0NJOrzBe
9otEA8BOf9W0dpgOQgi6Am73y8JQGhoae057koiGaYOXFISI9d1Wb2zQM4np+YZA
aUKoaaIO6ClB4n2X48V252YYMi4RqJvUu5MW7ngVY1JFnmguIQOLlQSP6rsMOtCf
U+2h8YpJOzi+XKFL65ZFSVE6T2H22xT6zRq73fWUUZ/PJ0qxKTN298OAYHzqSU7d
1PI6bLnsy+IAY5vobuqCmFhBJtqfW9o17b/BB7C5xC5dB8ksenPho23JH/uLiuIg
fcoHGNaYnTVJ2HnwOdFhz52TUOKs79llMSsAPzq+ZnceNb8XqQYdqPtBRKrwjrak
iFfzDGpYrGJfxxV1WDbJ8gTxpixM3l+UcxfWbaJXLODoDvUMRJJO28ECkMAMpD4C
+5nnxcplO8UeyS4Jt9O7czWg0Te2QvEcR4p9OxUQ4gb5UM0GMYOyH3miPO/3WlUa
ycIt2CH5nkWixQ9f98py1GVckYjsjQoSQF4f5QS4NYlpRXlOj44=
=LveP
-----END PGP SIGNATURE-----

--6z3eDRomUoICfopK7sXJ71tceJ9PE28t5--
