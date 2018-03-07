Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELv5vhbhoYmyvfuNFEY0iqy48sqtrqbyJFeTCGjehcQ5k52AFyzrdbtNWCL4+cHIxe6jIghf
ARC-Seal: i=1; a=rsa-sha256; t=1520406900; cv=none;
        d=google.com; s=arc-20160816;
        b=WsOhpt+8apwFIj8PbDzHISOSRy4vxkqSa0aLITi7KTXqTHE3OhCurr9Ff1NvuiMcba
         UrgAfr6d5+FBSBUxnjpV0ROJhb80GYcZ+yYJ+TzY4krlSIKOhi0QIvX7jxkxHcs9gHD/
         xQU5/jjB1FvZ+vUM3zFUifnOcLnPtTH3qc8Ho22qeVnzVKKOF1+sLQa19YQJIwXOJAAi
         7IPtZiVOkpd0nfHxTpdNLiLNMe57Nmoe2gaGxLbtH4/rLO7vieU+8C5UAUPeIQtCX1PA
         19AWfMY37S9gvuJgdOWpwWqJmuF7tqySVEuzi5amMpWmkedp//MRUiOMx+2lmXVjes7H
         PTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=RNpMAXxeCw6kDw//SPFGI6lwHyLXR6vEhy/l/xLP71s=;
        b=xoqM/cyraeQ1MUrKzEWNsBUmG/i4SKIKfLImt8DRfThAuzxXIKHiWp/Aj1xDTF3UOO
         1DSnU41Fw/0qTOdaVR4JfjzfzvoFgmPTb36ZHfGA+Vk2dpPChik5+vlIuGVw8oi0qlQu
         G1Po/IJYE0RJZd553lLmI6RkYBFOoeG38LgjZxZYWisTk2oC+rkT2NZu0dWmIm6zhqoI
         Rmq1n6IiAXLu9wGr6y6NRJkobLftXPDhJkJpL5i9ScqQFLGOI3Vss9AXtKwZ0SRmGLDT
         cPhcSHR7XBIs8roo5p6lVsxkaL+fxNujqBBFDHqbhFThu6EdDtxmO6OTAgiSURbDFGvD
         XhnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Wed, 7 Mar 2018 08:14:58 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 054/108] mtd: cfi: convert inline functions to
 macros
Message-ID: <20180307081458.4f311a45@bbrezillon>
In-Reply-To: <1520216572.2786.64.camel@codethink.co.uk>
References: <20180215151222.267507937@linuxfoundation.org>
	<20180215151229.973271532@linuxfoundation.org>
	<1520216572.2786.64.camel@codethink.co.uk>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592481046728605284?=
X-GMAIL-MSGID: =?utf-8?q?1594262186694844716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 05 Mar 2018 02:22:52 +0000
Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:

> On Thu, 2018-02-15 at 16:16 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.=C2=A0=C2=A0If anyone has any objections, pleas=
e let me know.
> >=20
> > ------------------
> >=20
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > commit 9e343e87d2c4c707ef8fae2844864d4dde3a2d13 upstream. =20
> [...]
> > -static inline int map_word_andequal(struct map_info *map, map_word val=
1, map_word val2, map_word val3)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; i < map_words(map); i++) {
> > -		if ((val1.x[i] & val2.x[i]) !=3D val3.x[i])
> > -			return 0;
> > -	}
> > -
> > -	return 1;
> > -} =20
> [...]
> > +#define map_word_andequal(map, val1, val2, val3)			\
> > +({									\
> > +	int i, ret =3D 1;							\
> > +	for (i =3D 0; i < map_words(map); i++) {				\
> > +		if (((val1).x[i] & (val2).x[i]) !=3D (val2).x[i]) {	\ =20
> [...]
>=20
> The right-hand side of this comparison is now using val2 instead of
> val3.  (This bug seems to be unfixed upstream.)

Indeed. This being said, it's not buggy since all users of
map_word_andequal() pass the same value to val2 and val3.

Maybe we should just patch the macro and all call-sites to remove val3.

>=20
> Ben.
>=20



--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
