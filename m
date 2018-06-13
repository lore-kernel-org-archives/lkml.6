Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E9E94C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0320020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B0320020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935523AbeFMMDM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:03:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35887 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935106AbeFMMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E67BEAEF3;
        Wed, 13 Jun 2018 12:03:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Zhouyang Jia' <jiazhouyang09@gmail.com>
Date:   Wed, 13 Jun 2018 22:02:55 +1000
Cc:     Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "lustre-devel\@lists.lustre.org" <lustre-devel@lists.lustre.org>,
        "devel\@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: lustre: add error handling for try_module_get
In-Reply-To: <ed5d91f54b5a4776a66df87b645b0ee9@AcuMS.aculab.com>
References: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com> <ed5d91f54b5a4776a66df87b645b0ee9@AcuMS.aculab.com>
Message-ID: <87k1r2j3m8.fsf@notabene.neil.brown.name>
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

On Wed, Jun 13 2018, David Laight wrote:

> From: Zhouyang Jia
>> Sent: 12 June 2018 05:49
>>=20
>> When try_module_get fails, the lack of error-handling code may
>> cause unexpected results.
>>=20
>> This patch adds error-handling code after calling try_module_get.
> ...
>> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
>> @@ -2422,7 +2422,10 @@ ksocknal_base_startup(void)
>>=20
>>  	/* flag lists/ptrs/locks initialised */
>>  	ksocknal_data.ksnd_init =3D SOCKNAL_INIT_DATA;
>> -	try_module_get(THIS_MODULE);
>> +	if (!try_module_get(THIS_MODULE)) {
>> +		CERROR("%s: cannot get module\n", __func__);
>> +		goto failed;
>> +	}
>
>
> Can try_module_get(THIS_MODULE) ever fail?

Yes.

> Since you are running code in 'THIS_MODULE' the caller must have a
> reference that can't go away.

Not necessarily, though it does usually work that way.

try_module_get() can fail while the exit function is running, but it is
safe to run code in the module until the exit function completes.
So if the exit function takes a lock, then other code can safely run
code in the module while holding the lock, but not holding a reference
to the module.  If this code calls try_module_get(), it could fail.

That is exactly what is happening here.
ksoclnd_exit() calls lnet_unregister_lnd() which takes
the_lnet.ln_lnd_mutex.

ksocknal_base_startup() is called from ksocknal_startup()
which is the_ksocklnd.lnd_startup and is called, from
lnet_startup_lndni(), with that lock held.

> So try_module_get() just increments the count that is already greater
> than zero.
>
> Similarly module_put(THIS_MODULE) must never be able to release the
> last reference.

It can if a suitable lock is held.

> Any such calls that aren't in error paths after try_module_get() are
> probably buggy.
Being in an error path doesn't make it safe.
module_put(THIS_MODULE) can only be safe if a lock is held which
prevents the exit function from completing.  Some code outside the
module must release the lock.

Having said that, I don't really like this approach.  I much prefer for
the module reference to be taken and put outside of the module - it
seems less error-prone.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlshB+8ACgkQOeye3VZi
gbkCZw/9FrECKIQT3G+ijzOoxZD5El9y460/0CJEZ+X+XECNJw5BGGh4oj46H5SF
Xb5bRcXdQ3gX76stT/rcJ6rhS2Az6KvVdBA9B1gJQtysFiu9nLU6AqPm5+2S0XkK
zN0YCh5+RRHBiY8BPjzP7rciOYiIBj+S4rb/GDRoGhh+2JL2hiyUYBRqNLcdtrjL
VBNnnUaSD/YO8B37uyQkErrRVXsPh5qUOZF6zMCO+1l3ltdtLUB5/mP+4robNaXk
VKB9IspcbXncde8ES/ND1nlFm0Hb8d26a5bYWOA+iVj8I4x0/x0Zphb8d2pIETfc
28m6zlF6hqgwBWFy4M6igSfboWoAx4TzXNA81XZjeVw5Ar/oCo3bbOsNaGM48uTG
dWznJ65lEXADIox+o81oarjcY9kDZr6vkvK9KsfPUM2KfetX8TQsGakmlKdBS4t6
S1+fG3IvvRi4c3/XUVdqa0DT7X3yFlGspOOzCHLmEsLRSJzKit3bXIFERwoLRpS6
/4ntc7ry/jL7ssYu1u7F3H4OP7VLpOLGXP9XSjcsdrg6RmwGL56MumuGnT+vJ9kA
hxJukz8g6ImK4yeWtDgfNZCTK3XRRO8dNPUsAj2TBm+uAddJ/nGv6BDp+1iNK8Or
57mxVq7cuD/LSwqrxRb5C2oVT4f4aRbEgf9AnI53BZsFF7FDadc=
=1gn9
-----END PGP SIGNATURE-----
--=-=-=--
