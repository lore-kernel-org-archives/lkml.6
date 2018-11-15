Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB387C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B256021582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="O2zJyhEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B256021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeKPC6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:58:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39344 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388599AbeKPC6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:58:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so15297882qkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=uLBaME+z+5Pze8g23tyaHgMkaeZ+LhfDm+7GQpfFWhA=;
        b=O2zJyhExnVt1vqXzzqI/bEIRglKKRvxYZUxyIBJedZCXKsntILdPTgP6lPdFJmGO6M
         1bessEKmXkJThC0AZOG3Ie3jzdMVGf2yqpFLu8VxuBUufuIMHptrWtYgyIY6WjjuZQhn
         aAYfN/jY7/VM5FQ3pnJw6yeOhwocnZyQsF6sCzN/NYMWA/l56jf3x81KU50cCPt/7s5n
         t1odCYm7zjJoqNWw/MzV+GZGt031QhV+st3Z53MNggn/MfcPPnN07qGxyYsv6zuk/NH9
         XcCDXobUnpZyGqUsG633oFlCCrqZbBis5XtKre5BEpQmpxc2LZqSA4qq0kesDp0JDHHM
         5gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=uLBaME+z+5Pze8g23tyaHgMkaeZ+LhfDm+7GQpfFWhA=;
        b=V95vEcfk0+24vjKuRTvZ4gB8Zox1zuh+MYkWhNnD9bbFIF0XNvbVNhLkwCvfE10ylu
         9INhvU2lA4UXzrcGAJgtWW+7TlOedjrM3/hQ3Uk9yO02z+7EvtwoSQ2VeRxOtCvZFGaw
         o6BiJDUEj2kCAMgTJXEju3bX+SPgyB86W4Wwh3NoHUFlVi8dNoWQs0i0+/OxB/RFtvF4
         0YURu9M1+leShq6NJKnDTpkHhEWHoH76ExC3Eo1mmV6LfkPvgB+DSl8BXWuqDoGvYOOY
         8FspLGTGjC9KlzKWOwXBRRwT2ZHhjqOn25AfWoELvFoYPA8WVXhF3wy1I4rVVUGNnOU5
         yj9w==
X-Gm-Message-State: AGRZ1gIsWkBjf0BV5bkJQRPRWVXyfaUyMRhgIUU6EkM4u10nccn9xahs
        aNgTP5qx7hHsBZbFE3lG1Wa1VQ==
X-Google-Smtp-Source: AJdET5eekFgTPqYWBvBrbPBcSGNI4Nzsy+mQbrZT2mcZ7SKYiM57C9ISYe46huHug1XxHVmzj+wXRA==
X-Received: by 2002:aed:3ae4:: with SMTP id o91mr6757776qte.251.1542300596296;
        Thu, 15 Nov 2018 08:49:56 -0800 (PST)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id a185sm9530844qkb.1.2018.11.15.08.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 08:49:55 -0800 (PST)
Message-ID: <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Nov 2018 11:49:53 -0500
In-Reply-To: <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
References: <20181113093048.236201-1-acourbot@chromium.org>
         <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
         <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-6S0umYBXH8V0Ck7nbbNE"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6S0umYBXH8V0Ck7nbbNE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 14 novembre 2018 =C3=A0 13:12 +0900, Alexandre Courbot a =C3=A9=
crit :
> On Wed, Nov 14, 2018 at 3:54 AM Nicolas Dufresne <nicolas@ndufresne.ca> w=
rote:
> >=20
> >=20
> > Le mar. 13 nov. 2018 04 h 30, Alexandre Courbot <acourbot@chromium.org>=
 a =C3=A9crit :
> > > The last buffer is often signaled by an empty buffer with the
> > > V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
> > > bytesused field set to the full size of the OPB, which leads
> > > user-space to believe that the buffer actually contains useful data. =
Fix
> > > this by passing the number of bytes reported used by the firmware.
> >=20
> > That means the driver does not know on time which one is last. Why not =
just returned EPIPE to userspace on DQBUF and ovoid this useless roundtrip =
?
>=20
> Sorry, I don't understand what you mean. EPIPE is supposed to be
> returned after a buffer with V4L2_BUF_FLAG_LAST is made available for
> dequeue. This patch amends the code that prepares this LAST-flagged
> buffer. How could we avoid a roundtrip in this case?

Maybe it has changed, but when this was introduced, we found that some
firmware (Exynos MFC) could not know which one is last. Instead, it
gets an event saying there will be no more buffers.

Sending buffers with payload size to 0 just for the sake of setting the
V4L2_BUF_FLAG_LAST was considered a waste. Specially that after that,
every polls should return EPIPE. So in the end, we decided the it
should just unblock the userspace and return EPIPE.

If you look at the related GStreamer code, it completely ignores the
LAST flag. With fake buffer of size 0, userspace will endup dequeuing
and throwing away. This is not useful to the process of terminating the
decoding. To me, this LAST flag is not useful in this context.

Nicolas

--=-6S0umYBXH8V0Ck7nbbNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCW+2jsgAKCRBxUwItrAao
HCgqAKCnBb2eMP0cPmS+6Ou7ivPc9pPkyQCgxqkUwibgiWW3BLK4Dr3dRV6WVN4=
=DhZl
-----END PGP SIGNATURE-----

--=-6S0umYBXH8V0Ck7nbbNE--

