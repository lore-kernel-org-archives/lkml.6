Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB39C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD55520870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547192630;
	bh=P7/eCl0g/kp9mD4KX8LJlQTcogE5xZbkz4wcAn06H+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=EoNBaCnOkQM3L9sRZHCcsJHsMzHvVt9jjgdLAU8u9ZKNKhtHoRSjXSZ14tmiYdN1k
	 0MsI5R2FYRCMQ3T1y1SkQap895MDzoFFuJkGLbHgAGHhLFHSkv9C9e086gsOo8LXW9
	 WQWI934iOmUIfbg9gaxBnkz9GLhAxu3F+DRLdDMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfAKHnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:43:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:28927 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfAKHns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:43:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 23:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,464,1539673200"; 
   d="asc'?scan'208";a="126821168"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2019 23:43:46 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fail request submission if it was already queued
In-Reply-To: <20190111060212.7390-1-mgautam@codeaurora.org>
References: <20190111060212.7390-1-mgautam@codeaurora.org>
Date:   Fri, 11 Jan 2019 09:43:41 +0200
Message-ID: <87pnt3od02.fsf@linux.intel.com>
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


Hi,

Manu Gautam <mgautam@codeaurora.org> writes:
> If a function driver tries to re-submit an already queued request,
> it can results in corruption of pending/started request lists.
> Catch such conditions and fail the request submission to DCD.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 679c12e14522..51716c6b286a 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1290,6 +1290,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *=
dep, struct dwc3_request *req)
>  				&req->request, req->dep->name))
>  		return -EINVAL;
>=20=20
> +	if (req->request.status =3D=3D -EINPROGRESS) {

this test is really not enough. What if gadget driver set status to
EINPROGRESS before submission? A better check would involve making sure
req isn't part of dep->pending_list or dep->started_list or
dep->cancelled_list. It's clear that this won't work very well as the
amount of requests grow.

Anyway, which gadget driver did this? Why is it only affecting dwc3?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlw4SS0ACgkQzL64meEa
mQa3hA//bnVIRjIdt9cCTa1TdxjxLIm7gWgUTTKIBCAHaV+rBsldkCu20tECdlxL
/BURIZonF7CS4WgGj6hth2ZoPwP9KzMorvo5FG824mLPVJ6AkOssZOVD+HjezLyB
q+ixy90CIiZgYBtKObY6zTo7IxiuwIKL/E/sDzxn75bosJa6JBdkDtgi5oeirynF
5Xse1ODym+/CzxXABOMmOGTS+ymyhhSBHLdhVuafua8SUKNxrL7xnhrX6kEQ+DjD
Unu2Ws1QrK+gp0HzEtzaIyfrFKk20rfFw5trwhTfjjws2W+xCFFWX90qjbFd3aQt
0+HEW34N+NBBThRVN4yT8tSnRmp1FS3x8OPOpWPIa5gwJCCzhGwEs/D7BB1fuab9
yk9XYhgDC/u3heDK/C8McPF0V74kSLZAnL2ZYgNXEbBlHKTNrLZebIVIygVAWs/F
GqPuL/lupJ54totYQvbIs+5a0s4QBW9EXaLa5YY0Kjqc3fZ/vYMfcHYZTO2Gzk9n
p0vW9z54mCmPWvGOukx8HTFSHq3P4agXvwHJ7n6vxwx/J2FzED3YRmxYHTEtLjf6
6dqmDoA2BC52Z1bj7Q3Vf/qd15j5eltjm2WKHrkSroYHqH+ht7cxh1olMJ+bL+cm
VbXHxz41nX1fww4WYI4enUEbS0sys0BMV8RQQ3lzNXPwA0bCs8c=
=+Cqs
-----END PGP SIGNATURE-----
--=-=-=--
