Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-229392-1518021502-2-4784846359285241008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: ip6-bisect.log
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518021501; b=C0hPJSy/mmMTEr71vWDOYW6xPvLAyzGClatOnLzv3Im6zvv
    1ue06apKG3u+akwFIMSWmW5/aB0MQPYN3pmDdgucPkXoSWW3AEjj831bQfkfNgz7
    Xmdkwhcwqnuk6HPl+vXjHlm0J37Q5gAT6p45v1EdrT889x5NiLJTC3+GL+Vfzp1U
    nYu/voBWztCzYosqV9wjCv01NKx9x0kYm01rKBesNx992v2nLJAiz6K/dtVKazjd
    RIYgCW335RVIjP14ONmz9MJO8AGQJJ2RNCZOyUeBinDl0/yGsE5Q6aPIaof1b05Y
    i/TBvdtws4PJsBtaLWFXTf9s2VCtfzpkQs+iQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :content-type:mime-version:sender:list-id; s=arctest; t=
    1518021501; bh=aJS2QDWW8/WOqPSaNFAmUrnBcMfdK4Kwi3WX0LJuhoc=; b=A
    W0rwR64TtUbPSiQLSg0xz/eLOhDAnMO1rEF3K8MSmkeDF4IJEygxb8nROmdxBJ+S
    rguYwq6WiG4D4qSZw0wu3OrZwwzdCIRUyfTGa4PqC9ZEoVYUeZbbo7lw2taGRLvO
    Ys99lx2F7+P5S+hv2P4h8JsREkazhHe8VLXnaHnD4RXVWekba5ibPYB7YoBpHtPx
    Qek0Lkyw92uwTgzF2rdtxynTpzwopY4SKA7ebnNcNyhGA/E5xgmDnqkZcUxyNgib
    SY8YkfVv28FjoLZfmg5qq4LxxVxzMqw46f2asXI+t0DSHltt3ByZ7cUAQi7hD2bQ
    CLZc8GfqPz0+AzSWxC8ew==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeBGQiT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 11:38:19 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:51530
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbeBGQiS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 11:38:18 -0500
Message-ID: <1518021487.2100.2.camel@debian.org>
Subject: Regression for ip6-in-ip4 IPsec tunnel in 4.14.16
From: Yves-Alexis Perez <corsac@debian.org>
To: Mike Maloney <maloney@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, debian-kernel@lists.debian.org
Date: Wed, 07 Feb 2018 17:38:07 +0100
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-L1rlN2cFfKF51vgztWia"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-L1rlN2cFfKF51vgztWia
Content-Type: multipart/mixed; boundary="=-8+Gs/Tr7DZ3otw6bh12O"


--=-8+Gs/Tr7DZ3otw6bh12O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

I noticed a regression in 4.14.16 stable kernel (I assume it's also
present in mainline).

I'm using an IPsec setup where I tunnel all my IP trafic to a gateway.
The tunnel can use either IPv6 or IPv4 (depending on what's available
locally) and will route both IPv4 and IPv6 (my gateway will assign both
family addresses).

The tunnel doesn't use ESP directly but rather encapsulates in UDP.

Starting with 4.14.16, IPv6 traffic is broken. When trying a simple ping
to an IPv6 address I get:

ping: sendmsg: Invalid argument

I bisected 4.14.15 to 4.14.16 and got the attached bisect log, which
ends with 8278804e05f6bcfe3fdfea4a404020752ead15a6 as the offending
commit. The -EINVAL is consistent with the =E2=80=9CInvalid argument=E2=80=
=9D return
from ping. I didn't try yet on a pure IPv6 setup (without IPsec
tunneling) but will followup when I have a chance to test it.

Reverting that commit on top of 4.14.17 fixes the problem.

If you need more info, please ask.

Regards,
--=20
Yves-Alexis
--=-8+Gs/Tr7DZ3otw6bh12O
Content-Disposition: attachment; filename="ip6-bisect.log"
Content-Type: text/x-log; name="ip6-bisect.log"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyBiYWQ6IFs2YzcwMDc2NjY3ZjI0NmRjMjAwYzdhM2U5YWVhYmQyZjhmMzg4NDE2XSBMaW51eCA0
LjE0LjE2CiMgZ29vZDogW2ExNjEzNGIwODIzNDZiN2U3YzM0ZjU5NGEwNzYzZWFmYWNkY2VhOTJd
IExpbnV4IDQuMTQuMTUKZ2l0IGJpc2VjdCBzdGFydCAndjQuMTQuMTYnICd2NC4xNC4xNScKIyBi
YWQ6IFs3MmQ0ZjNhYmQ2ZDM1MjFmNWNkOTc4YjYzZjkzMDEwNTFmMTI3ODEyXSByODE2OTogZml4
IG1lbW9yeSBjb3JydXB0aW9uIG9uIHJldHJpZXZhbCBvZiBoYXJkd2FyZSBzdGF0aXN0aWNzLgpn
aXQgYmlzZWN0IGJhZCA3MmQ0ZjNhYmQ2ZDM1MjFmNWNkOTc4YjYzZjkzMDEwNTFmMTI3ODEyCiMg
Z29vZDogWzI5NWJjZmJiY2Y1YTc0MWU5MTAzNjA1YzMyNTIyNzZlZDIxNDMzYmJdIEFSTTogbmV0
OiBicGY6IGNvcnJlY3Qgc3RhY2sgbGF5b3V0IGRvY3VtZW50YXRpb24KZ2l0IGJpc2VjdCBnb29k
IDI5NWJjZmJiY2Y1YTc0MWU5MTAzNjA1YzMyNTIyNzZlZDIxNDMzYmIKIyBiYWQ6IFs4Mjc4ODA0
ZTA1ZjZiY2ZlM2ZkZmVhNGE0MDQwMjA3NTJlYWQxNWE2XSBpcHY2OiBmaXggdWRwdjYgc2VuZG1z
ZyBjcmFzaCBjYXVzZWQgYnkgdG9vIHNtYWxsIE1UVQpnaXQgYmlzZWN0IGJhZCA4Mjc4ODA0ZTA1
ZjZiY2ZlM2ZkZmVhNGE0MDQwMjA3NTJlYWQxNWE2CiMgZ29vZDogWzlhZDk3MGM4YTEzNTk1ZTM4
ZDNhZjk4MTE0YmNiYmVjNmQ4YTViZTRdIGRybS92YzQ6IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UgaW4gdmM0X3NhdmVfaGFuZ19zdGF0ZSgpCmdpdCBiaXNlY3QgZ29vZCA5YWQ5NzBjOGEx
MzU5NWUzOGQzYWY5ODExNGJjYmJlYzZkOGE1YmU0CiMgZ29vZDogWzQyZDY4YmYyYTQyMzgxNjQy
ZWE1YWU0NjBjNmE1ZDg2YTU2MjEzZjBdIGlwdjQ6IE1ha2UgbmVpZ2ggbG9va3VwIGtleXMgZm9y
IGxvb3BiYWNrL3BvaW50LXRvLXBvaW50IGRldmljZXMgYmUgSU5BRERSX0FOWQpnaXQgYmlzZWN0
IGdvb2QgNDJkNjhiZjJhNDIzODE2NDJlYTVhZTQ2MGM2YTVkODZhNTYyMTNmMAojIGdvb2Q6IFsy
Mjk1YjNkZDU0M2Y5YTVhMTgzNGU0MjY1ZDUwNmE1YmMwODE5OTgzXSBpcHY2OiBGaXggZ2V0c29j
a29wdCgpIGZvciBzb2NrZXRzIHdpdGggZGVmYXVsdCBJUFY2X0FVVE9GTE9XTEFCRUwKZ2l0IGJp
c2VjdCBnb29kIDIyOTViM2RkNTQzZjlhNWExODM0ZTQyNjVkNTA2YTViYzA4MTk5ODMKIyBmaXJz
dCBiYWQgY29tbWl0OiBbODI3ODgwNGUwNWY2YmNmZTNmZGZlYTRhNDA0MDIwNzUyZWFkMTVhNl0g
aXB2NjogZml4IHVkcHY2IHNlbmRtc2cgY3Jhc2ggY2F1c2VkIGJ5IHRvbyBzbWFsbCBNVFUK


--=-8+Gs/Tr7DZ3otw6bh12O--

--=-L1rlN2cFfKF51vgztWia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlp7K28ACgkQ3rYcyPpX
RFvWegf9Ex1DIVvXam8ohFGGmIXbnruVY5kLjJJEH1R89M0O5CK4XBkYJGrY7HBh
WC+6XEi33rdXm1tYa4WULmmVrIllEQVSQUx5uLxKnm7y1Ok8Bm0pCVqsPnmre50H
MuGDtDQ/erQRe8mgkQVMc9uiNShyDzaM9LJsEzG/JUJ44qNsR7uieMQtEEGr1CJ/
djlFphgYu1Ie5pjEH6c7Nx5i/djV8/l0CaroN5Aop75b5VIK0oOykJp3LtU8lgvL
ERc/oE7CTkDuCi7spECJzDZXeROEa4js+h9Vwh6UuPXW9l4vx/r/yKiJR76i1HF1
lLG1cVz+4NbpsWa1HXXhUKSWQ3lTlA==
=9jN8
-----END PGP SIGNATURE-----

--=-L1rlN2cFfKF51vgztWia--
