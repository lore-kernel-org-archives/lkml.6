Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8443BECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E4820883
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="X1oHlgk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E4820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeIXFBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:01:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40487 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeIXFBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:01:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id o2-v6so1646070wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=veY3DIzuLIepLCYO9Wcec3nIJiqYgs2lei4shrUyG9w=;
        b=X1oHlgk4XjET8Zqx22gtk+x85+TN/xMX4zWrIrUozbl6m8F0wBa7urg1tddcfPiN9a
         NpMefl8go172GLeypBXTwwSZSrzDDLRCRcaLqDOq1LFV6LpXlOXpmb8w0ZAKZ4bXoC1o
         T2hg/13V8jcHRub8PLRPitwHu5h/xcTMTPLXqEzoSx5r+f7phB3kFnKxIecaXMZLyb/B
         7ymi8WBnO2Q0kqGS0mFCBits72mEfA58EmGuZxXz4PXnfrf1RDSU6Mp0ghZPUE+IEsVP
         TdJDf4/lPYNUTNr+1d78gmCQNcoAvPEQBHGvN+7SmtUzaaxfH8Li+FylreD1iuTiKyT8
         md/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=veY3DIzuLIepLCYO9Wcec3nIJiqYgs2lei4shrUyG9w=;
        b=IOcCLyUB0xgJ6OhFIkVQkEzUOr9qqWVrfY/qZrCbjn/D2AEMR5rdbzdF3HnKrA33Vn
         ICzOgpIVwvk14Q/62F9N9TAVZpM6Pms1kAJmRrDOwsQStYE8xBw+WooknlN6OC9FgPl9
         B6WrQVPY1eplKPA6UkdlrrmEElDzdYBXBAusapCB6pw+WtkqmkE+UXKmjNRFfsHoQ4We
         SiSGv4FlGGO6llKqc9BL0BI/2iX9++WSmV4MV/zUUMnJ4GJlj7dnb+uCTQprmVGIn58+
         28H3Vy11TxnkqqlhA+7oEQvKt8lN9m7OtD9VnRAl23MPDPquFCjSwKffewrMdP6qf2wt
         exFA==
X-Gm-Message-State: APzg51B7aQBTEyySUsMQGAJmg3pMNNCTiGJKlNvmc95W5JDghI58C/6Z
        Q5GQyd/jlnG8glgOH9A9xRcnMA==
X-Google-Smtp-Source: ACcGV62NGAlkvqZi57pIh2dG6XUjuJM7/dqEPbLTqnL3WlqmghCDeRzHNBl4cEob4HKVm2kjfYFaVQ==
X-Received: by 2002:a7b:c18a:: with SMTP id y10-v6mr5534288wmi.87.1537743712881;
        Sun, 23 Sep 2018 16:01:52 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:f4ce:f891:f419:cd9d])
        by smtp.gmail.com with ESMTPSA id v133-v6sm12920711wma.36.2018.09.23.16.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 16:01:51 -0700 (PDT)
Date:   Mon, 24 Sep 2018 01:01:51 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Message-ID: <20180923230150.32qbjhnnzy56x3yy@brauner.io>
References: <20180922161406.6beo2ob6ki2otrjx@brauner.io>
 <20180922132106.wfa6xaxwbu276qka@brauner.io>
 <20180921155455.flkf5vdrm3vgn6do@brauner.io>
 <20180920151214.15484-6-mszeredi@redhat.com>
 <20180920151214.15484-1-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
 <20311.1537548756@warthog.procyon.org.uk>
 <8221.1537631312@warthog.procyon.org.uk>
 <3868.1537742717@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glbgympmb4iviibk"
Content-Disposition: inline
In-Reply-To: <3868.1537742717@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--glbgympmb4iviibk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2018 at 11:45:17PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
>=20
> > Of course, I'm not sure what the reasons for all of the other arguments=
 to
> > this function are since it's not yet implemented.
>=20
> Well, dfd, path and atflags are pretty standard.  atflags conveys things =
like
> AT_EMPTY_PATH or AT_SYMLINK_NOFOLLOW and dfd conveys a file descriptor
> pointing to a vfs object or AT_FDCWD.
>=20
> > Seems that attr_values and attr_mask could be compacted to a single
> > attr_mask maybe?
>=20
> If you don't have a mask, you can't really do recursion.  Without the mas=
k,
> you have to supply the entire set of options absolutely - and this would =
get
> stamped on everything in the target range.
>=20
> With a mask in combination with the set of desired values, you can turn o=
n or
> off a specific subset of the attributes without affecting the rest - with=
out
> needing to know the rest.

Ok, understood. What about passing the different attrs as a struct?

struct mount_attr {
        unsigned int attr_cmd,
        unsigned int attr_values,
        unsigned int attr_mask,

};

mount_setattr(int dfd, const char *path, unsigned int atflags,
              struct mount_attr *attr);

I find that to be a little cleaner in all honesty.
One could also add a version argument similar to what we currently do
for vfs fcaps so that kernel and userspace can easily navigate
compabitility when a new member gets added or removed in later releases.

Christian

--glbgympmb4iviibk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAluoG10ACgkQjrBW1T7s
sS3UbhAApTh25hvwZzNlE/pffrckUmo8cNLOhy5M5kKpT970GkroRVSzYCFiWm+8
KB1cEZeOKCUq2stSTD7WKn5j7uBsmCJkrWhQyG0/hJOuRKfc4YWI5ubezs+7XipW
gG/ZNNz/Jp7BJ0Murtb9p8N4xxRjcezu2faBPVfso99mmvg9l0yCUfKXON99MJwd
OVX/Tm10r06rDig8Ya/APVERhozkz4T8S//VHlUbaXqqO/Makzhvhth9tuwvFuO/
NK/4h3xnL3RyVLWLKyIivebEExR3TgKLiCgWXaL5LWVBiOvvJcZ/CmDAVU+LWqHP
UHsRtz2Y0cmaHuoWeHyFQIQ6mL5EFgO3SBa3pISB64V79FcwDaKAu9+ZTHwl1f0r
SPz+kA2z7vUKqgVN/RCYMNnoIk8VtZBpLt5S4SSf0WnepIuZ4FIQ4+4ZrOFd+Qmy
ereXDCnkaMsNEnhpt0tthC1Aitrv1vLZIgP9Uifq6r3y8rO3O7rKNYMo9Q1s3M5W
Ivn+dG6fFtiZLNVDphNAsHA1NbM3J+fCEKD42/7xzmsmb72TzLWH1nSE9cTsC02r
8dmmdeeI7LTN+w7/xaLKq43TW/ro0fbqsZCFcSFgCFrWpUDi7noEeqF9Md3i9F9+
9BfcDpPGLByw7D9HHgxcBci4NSZi0wB777lOx+LjIKd9TTjP4Cw=
=pdAY
-----END PGP SIGNATURE-----

--glbgympmb4iviibk--
