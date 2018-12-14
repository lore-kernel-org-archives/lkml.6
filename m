Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11841C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC4E20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goOedK9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeLNOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:18:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45634 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:18:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so5422743wrr.12;
        Fri, 14 Dec 2018 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7rqhSO8+E10MLauT7aBOEB4o/+Qd0pzjea6zP4u5FM=;
        b=goOedK9BMIr4NGjgQw/M4Khi0c4RMF6WFqgt4p70T3wtFn9lXr4KopZywuvAXgCIJm
         BOxrTuCUahF098aeFs0kS4IoOsAQXYBJTrvi0jq8rAUDP7iA9Kkq7qalNYBFEs3Udve7
         640UkXi+U8dOBg6N6zci4QhS22BuLwXzfQCB8VXy3MKybgsp5D2pIMva5SXVzCuoMstN
         7WbE/EcCqJrRAib0NtDQfcqYjDAAu5/KvYRzFnHGFW//ZMhIJNw/M/Rok+bewZAy4vRI
         mqkiBOpg79L4Q6YCric+RrsrodOSABVHmceUlRCqN5jq0fYcWFNJJ4rMKJkvnp4XXV+B
         by6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7rqhSO8+E10MLauT7aBOEB4o/+Qd0pzjea6zP4u5FM=;
        b=ZpDGhpRAVi9TCsFJQOPp5Hzh7SQoH4hXmHXiFeGQKuCpeokauDSosnaTv3zqZoU95v
         HxKYxn/pcWvkAZdCccQdOvNFzay/ka+IIaUXarBp+mIccPicTiBgw1tsssMKSxVUXDj+
         djHc2J1g4QDGZQe4jROxbxfgq5hbAwDv4f78BtDONtVx9uVI6H44l3jFnxNSGoMIZzlq
         3gyzt89iEf7SOqx83cwa1Zb1VXzql7HGuLG6YSxN2IXeMXTI5JnCrUJuOWUvJqS+MGEW
         YX9Yi86Mtp/OJKJPpjPklKXnghndzIDABiEG2lHdTKaYMwcNYNMjIbepoMh9RYsFuYE9
         X1Rg==
X-Gm-Message-State: AA+aEWYijM2JHEoj25JTSFk3ngzYryL5ar8dDrENDqf14Jip0sl3aJYz
        719DsZEJn0u6wAfIiPOdH50=
X-Google-Smtp-Source: AFSGD/X2jzl+quQyfbIffk95jnmRkQO6VFl2LcpPbvnJhLgIpbM4RTQ06OKvnuwkh1yzo2VE12/aLw==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr2873654wrf.206.1544797136800;
        Fri, 14 Dec 2018 06:18:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v133sm4130312wmf.19.2018.12.14.06.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 06:18:56 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:18:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] thermal: tegra: remove unnecessary warnings
Message-ID: <20181214141855.GC23379@ulmo>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-2-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <1544780993-20744-2-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 05:49:50PM +0800, Wei Ni wrote:
> Convert warnings to info as not all platforms may
> have all the thresholds and sensors enabled.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwTu88ACgkQ3SOs138+
s6HyeA/9Hbpg/h06eVIY3q7v790VEtaJDqATatMu0O+LJmOoG5E5jKRV9sCtNcs/
BvSchLZF38VKsNwzNCNWBCvRHy6IYwRkgU6Gjdkp86ffkZuETIgmtcbp7ML+IlrN
ezR0C/IXeEtu2kwyk2glUfvZpd7t3DF1knVlnXKl8eJNXOKW6NkGEHNCpsBwK+mh
ERnQs2Fs//Cr6takvlI1CRVkgUiNu3Q+j3IdVL7qabUtWI5vYAZLn5ml4cds71Qe
jnrOzbgSgN+DpTIb+J1C2pbHbHatBwTZmeJNoGr468k/OW7+jOdpLoajJMVdWMTy
QFf2V9/nOivlIXEKPDU0TXr8eZHgw1NGX9DCMuL3/GhqFE2f8ipwlEr8YNWcJNXB
KWKkqvy92aZfE3gX6ggEyQzNq6g+5MjNErsNQzEs1dXHChfwbXMQ1ZUYeJk/HcPs
OwIZYJTsgWr0n8C1QT/N0LftekvXAq+CkJzH6I/ZSPb3m6n2SA/qRGfnG4HILzT4
BASYIhHQaUw1oeVKYQp5spQYfSdFGsw3gupIwSBq/5r5d8SROeReLhAiUPQUzXfQ
70F6YLBgv1pCcV2Jd2ovPvT58TiYL2xbdmO4mN+H2lgOu6wpu2Tiw4xR8ImzATqz
0Kl3y3eIa80hGzl8hgUv5ahem//Emst6fGhE7N/TzM9kd9NPCNY=
=CsGw
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
