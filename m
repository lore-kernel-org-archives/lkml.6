Return-Path: <kernel-hardening-return-12597-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELunSYrs4PnE+fGQeswCj0TZIEenP2VD1ABNZU4RP4jFq7sDNObG6f9i5owIzMwgilpfSjqY
ARC-Seal: i=1; a=rsa-sha256; t=1521034321; cv=none;
        d=google.com; s=arc-20160816;
        b=ypUgcOi7wXVn9Dc11nO6ys35TDEUZRA8sf5Ux0lpok7vcn1VXE8K1n8vPbs0ccv9fe
         YS3Xi7sz7YZtciNkk/TgJ2uuoAVD3w1MbKsfv342LXyVlzfIm6C9HV4rb5UqRUUucbSK
         hUpqu3LUt5bmWv5mN3puEXr4bNHR7iDjFwAGaK0PXOJAotH+w+5lQCY3Yh+NMtNi0qLl
         i0mFHJy6vX3oVed6ZEIX6KuC6yI3TDdlMLQo0e+eJTShrgj6a3S/kqnDkoF178CPPxR9
         Hq6JFhxaVO2v+kq9cqzzHw9ys2sj67aLCO2TCnwd+47WiwKhWb/Wd4o3F7GLDMLdyi1h
         +v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=F2D01kHEw6N7U7On8zd5JKBD4Fq5MNBIwrY9NQZ3d6c=;
        b=xwlSeayOv8Lca34AKbGnJFjXphDzme98jUUOQpCVRCaOcHNOW6ez6GKyK3Pa8p3xzf
         Mrgv97KeAFnRcE6SdSGLOkX8jWb93ZkoNrYJShMHGhTZyhWbqMO3oyBCbbJChXAA2Xet
         g5GLM0in4nYnFawacLAH5YA9z7F36VBYBC6FjtBqo/iKwK0JFdleSPmU6OrovLTkLsbV
         XVuGCe58ZTxhCcoAv7uR7tU/L7SnNFOoxGHyuSFa4hjXMpr4tg0X+ALX+2ul5Xpg2JQ1
         ZZqjhu3OK+HHuJ0AuC/VtzOe7QSJYfBaxacmlBlx8o8AXPhdYnGCQPPcFrrf11SHAty1
         KYEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chronox.de header.s=strato-dkim-0002 header.b=E5ODsd7S;
       spf=pass (google.com: domain of kernel-hardening-return-12597-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12597-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chronox.de header.s=strato-dkim-0002 header.b=E5ODsd7S;
       spf=pass (google.com: domain of kernel-hardening-return-12597-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12597-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq7UitqoI1j72u2V/AXnS74hsOoMO59NEAAKweXfYQ==
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] crypto: ctr: avoid VLA use
Date: Wed, 14 Mar 2018 14:31:27 +0100
Message-ID: <4726635.XOh0VtZf4O@tauon.chronox.de>
In-Reply-To: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1594920084582705547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, 14. M=E4rz 2018, 14:17:30 CET schrieb Salvatore Mesoraca:

Hi Salvatore,

>  	if (walk.nbytes) {
> -		crypto_ctr_crypt_final(&walk, child);
> -		err =3D blkcipher_walk_done(desc, &walk, 0);
> +		err =3D crypto_ctr_crypt_final(&walk, child);
> +		err =3D blkcipher_walk_done(desc, &walk, err);

I guess you either want to handle the error from crypto_ctr_crypt_final or =
do=20
an err |=3D blkcipher_walk_done.

>  	}
>=20
>  	return err;



Ciao
Stephan
