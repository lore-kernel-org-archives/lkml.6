Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZoAQWWGPRB7v8NrAllHK5+xf2rgXwS5EkUpt8tWNOIh6VGr+Qvah/PEHYoPbnrX6JnM77Gr
ARC-Seal: i=1; a=rsa-sha256; t=1525394100; cv=none;
        d=google.com; s=arc-20160816;
        b=eTu+/33yqLXoN6+f0V1+tCW9JLTlKQ3IZD5MRwEe3w5nzOrW+pGDbpC5oS07DXSoYy
         bw+csUv491Hcd67vo3nkR9SOLON7aES/FCyR1YmQlKgYQ0ZwMBokr5HPhXJJ42ykkAPA
         81zTHiqgwkSwSBqp5CfpkUMo+NJCmtDMivPuwgSa6DzJ6IH8n09E1fyoNk2ctyV/U/3J
         Nwf/FuT2BmXuuAV+3aOXa8NkATgTUpYsyYoeesfJ/DhRKvMcb09Wo7VWcRG0Mm183i5W
         FHEx3SpM6WRjQvjdyI7fm8dfJUZDdzyNZsRDq172GX676GL8xZ4fH7nnKIHYkrXrzMy1
         qM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=ye39Fz/IT0aOPUtLSHxhy8w6PfUYlTMuDMrRF8PXb/Y=;
        b=u62W+XLm2X20nQ2ckJdKhnPqWsTNeNlY2H6nKNhkjPJfINdbc1HtKmT0kjvPeTu4BQ
         3Eo0kshRQOp6TFTw9cNxPqUBzEnVHEijp7hpg+H8tHTuKD6KLt1a9av3xA+5g3TD/wNV
         RlVvZLOkRlgx3x6+2kq1uykS/b0/HnFkBUdsDzcrq/V1DRWnY5+xdUYDyAZuWL4/jbcf
         B13qX/hY9Wmtl027kQZUCXIWV5AtXLPWQ54CZOjzYyIXDiozeRhujyOhX4AgihXgtFcD
         oSB/PIYzhx8pvnOe0a8fPWdejUk1gTc6BXaDT7Pna0DLo//KjQUhIqugupGROVXdu0Vq
         ZtAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Fri, 04 May 2018 10:34:51 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Dilger <andreas.dilger@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 10/10] staging: lustre: fix error deref in ll_splice_alias().
In-Reply-To: <alpine.LFD.2.21.1805020403530.2551@casper.infradead.org>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675919.17843.11688659715084804936.stgit@noble> <alpine.LFD.2.21.1805020403530.2551@casper.infradead.org>
Message-ID: <87d0ycfec4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232390798280014?=
X-GMAIL-MSGID: =?utf-8?q?1599491644289831418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 02 2018, James Simmons wrote:

>> d_splice_alias() can return an ERR_PTR().
>> If it does while debugging is enabled, the following
>> CDEBUG() will dereference that error and crash.
>>=20
>> So add appropriate checking, and provide a separate
>> debug message for the error case.
>
> Yeah!!! It fixed the issues. Thank you.

:-)
So I've made it "Reported-and-tested-by: James"

Thanks,
NeilBrown


>
> Reviewed-by: James Simmons <jsimmons@infradead.org>
>=20=20
>> Reported-by: James Simmons <jsimmons@infradead.org>
>> Fixes: e9d4f0b9f559 ("staging: lustre: llite: use d_splice_alias for dir=
ectories.")
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  drivers/staging/lustre/lustre/llite/namei.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/stagi=
ng/lustre/lustre/llite/namei.c
>> index 6c9ec462eb41..24a6873d86a2 100644
>> --- a/drivers/staging/lustre/lustre/llite/namei.c
>> +++ b/drivers/staging/lustre/lustre/llite/namei.c
>> @@ -442,11 +442,15 @@ struct dentry *ll_splice_alias(struct inode *inode=
, struct dentry *de)
>>  	} else {
>>  		struct dentry *new =3D d_splice_alias(inode, de);
>>=20=20
>> +		if (IS_ERR(new))
>> +			CDEBUG(D_DENTRY, "splice inode %p as %pd gives error %lu\n",
>> +			       inode, de, PTR_ERR(new));
>>  		if (new)
>>  			de =3D new;
>>  	}
>> -	CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
>> -	       de, d_inode(de), d_count(de), de->d_flags);
>> +	if (!IS_ERR(de))
>> +		CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
>> +		       de, d_inode(de), d_count(de), de->d_flags);
>>  	return de;
>>  }
>>=20=20
>>=20
>>=20
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrqqsACgkQOeye3VZi
gbl2CA//QeoHQARQk3FPfe38vYXX18Hw8Z+vxHNLqKLnXs35N7FirGkOasT3oig/
+CGdHW8Hzc2MVtul3KuK/bc4SD/cjYKZp2emMZlLYaGkx6bDCUrW04M/IiU3LAbj
NTujJoLwTFBcNNh3m8Q3kQEEFATtnIx/KDjvql1owLH3nsYT/Q/tMYKwcmDK1bW/
7L8RNuQZrUTd8ioxWNk9wZsq4qgKdJEoO2DBrtzhDOddbStgh1vDJd6yJRk4CCQW
Eavq2LvAjRlWo9HguGwTpdggTMWqODej5qb6fsTvn44+EQSBHBXCb6ita5XknVBP
JLBPyr9fmbV0O53+js9qIMElPxQ/qpclWlTbdH1ZDMKeOFqpDadcoCLHS059bQ38
Q9GUsLZOYuD7kbzdqjH2HpSNJUvAIlxi9Iby6KbQXOh1SrHJRqpm3K3aSF5lkHPl
wFBWCjlNgH2fzF8Y01Ds6AsPy3oR+T+9YjZhfiXclTSpi0SydhqXVuS8DWWZNO4V
PpcvxBx755zKUyTmzOK0wHlWni+ZFXjti1vdhi5cnWiexiN53oLgHbWHFJ+9YUQi
fm2X6Ju5/FIMb/EmSNqh6OebNZrTcCircL8+JTxOCOPaKHo+O09wEbDI3kPPiWd4
5rHNMM5EEswU4k0lAZQ3s1Hzt9tTIsjhNmO1BqlHYRxTfxrBB0U=
=9nUO
-----END PGP SIGNATURE-----
--=-=-=--
