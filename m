Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFFC2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="QUcGPe6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFFC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGROEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:04:49 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36799 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbeGROEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:04:48 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so3961697qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version;
        bh=FrxFjTF1SSvDnNRrUqEvEiWrVmxNXVkcHmzFPcgzoLM=;
        b=QUcGPe6FgZG+A4pPcYPIlpYDZMKGCE80DpoxKK1oTyYfoaXtUOkyvG3T5VRCSD0FCV
         DTLjYrMnp1yv0muV6rFJ9i8Ivl5XlRR6stVDRO7t6iLi6v2nnyieg7W+zv4mxkXDw57a
         H6ony26b7NL6baxv4LnvuUyH7Id4NuGyrpJ0WJXMOOo/BdyvzmMsBBXSKLCeJ/PAyXYh
         hjf5Cl1RxcpNk1cUo2/CiJrTsmP/pbDNESUOehJOUOpEgQSobDS6TkAGhRtVxpvR2cjq
         zjrnPykbQ9u1rIGG3H90dEQ2QiUSppvGB+hPRUXNeJlopPE0cXKT0Dv9jh8Su04bfBhm
         CKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version;
        bh=FrxFjTF1SSvDnNRrUqEvEiWrVmxNXVkcHmzFPcgzoLM=;
        b=lpunhuu5RGH4X1OPPWFdTGREUGC2QUlw7eJreiiTc6EIJQIw2B6MHnYNvVJOXmF9cq
         bHOcETr2ICdaYoy/5xzwt1BWGjZfnTIF2TvWiGTwrRqE+NdjP7YLQIgsp9n9YI9DOjRn
         tJf/KmUET7zczCdw2zkBnVJEp2ibA8MckoRoKVhHfZYws3iekau5HI+ObFpvYPlOppuR
         wR4hO0f/OU0TEGTdnqao+/GzzJR8ze5qGFq3NJ+V8BdIR1oxEpmlwyMan4bdZLdfJmgH
         ZvV0vXRQ9Y4uVIy1F0MM6eo9JHWGdLbfwRHSJMHl0flS+O5xKjgVPU1ZVq5gFUmcurkl
         M4CQ==
X-Gm-Message-State: AOUpUlFwXZuzgkd6WJAd58BeP0Qx37RQtjrLk/TYBA1xvuwW1d71k3qM
        WVYcmduMcmauKs5eDynvobauyQ==
X-Google-Smtp-Source: AAOMgpd6rFZ9OYDaFLiJnNsRzA5o2cqtJ/z5rgj8AtOsX4aIIzPd4vqV/hmFrR+gLt8dbsYla2mSdA==
X-Received: by 2002:aed:22ae:: with SMTP id p43-v6mr5588303qtc.393.1531920412201;
        Wed, 18 Jul 2018 06:26:52 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id y142-v6sm3174252qka.5.2018.07.18.06.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 06:26:50 -0700 (PDT)
Message-ID: <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
Subject: Re: [PATCH] venus: vdec: fix decoded data size
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <vgarodia@codeaurora.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org
Date:   Wed, 18 Jul 2018 09:26:49 -0400
In-Reply-To: <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
         <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-fKYfImwMbR0HkN/Oa7w8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fKYfImwMbR0HkN/Oa7w8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 18 juillet 2018 =C3=A0 14:31 +0300, Stanimir Varbanov a =C3=A9c=
rit :
> Hi Vikash,
>=20
> On 07/02/2018 10:44 AM, Vikash Garodia wrote:
> > Exisiting code returns the max of the decoded
> > size and buffer size. It turns out that buffer
> > size is always greater due to hardware alignment
> > requirement. As a result, payload size given to
> > client is incorrect. This change ensures that
> > the bytesused is assigned to actual payload size.
> >=20
> > Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
> > Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> > ---
> >  drivers/media/platform/qcom/venus/vdec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/media/platform/qcom/venus/vdec.c
> > b/drivers/media/platform/qcom/venus/vdec.c
> > index d079aeb..ada1d2f 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst
> > *inst, unsigned int buf_type,
> > =20
> >  		vb =3D &vbuf->vb2_buf;
> >  		vb->planes[0].bytesused =3D
> > -			max_t(unsigned int, opb_sz, bytesused);
> > +			min_t(unsigned int, opb_sz, bytesused);
>=20
> Most probably my intension was to avoid bytesused =3D=3D 0, but that is
> allowed from v4l2 driver -> userspace direction

It remains bad practice since it was used by decoders to indicate the
last buffer. Some userspace (some GStreamer versions) will stop working
if you start returning 0.

>=20
> Could you drop min/max_t macros at all and use bytesused directly
> i.e.
>=20
> vb2_set_plane_payload(vb, 0, bytesused)

--=-fKYfImwMbR0HkN/Oa7w8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCW09AGQAKCRBxUwItrAao
HM7XAKDWXjbEjj3x65ftmCkFjkZXJJv/lwCfZf8yTBfGAvNVjUwn/e4272azGSw=
=jRgp
-----END PGP SIGNATURE-----

--=-fKYfImwMbR0HkN/Oa7w8--

