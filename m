Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59FB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59FB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeLEJBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:01:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:52970 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeLEJBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:01:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 01:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="asc'?scan'208";a="123096314"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2018 01:01:45 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        martin.petersen@oracle.com, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        v.anuragkumar@gmail.com, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH v7 05/10] usb: dwc3: make controller clear transfer resources after complete
In-Reply-To: <1543662811-5194-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1543662811-5194-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Wed, 05 Dec 2018 11:01:37 +0200
Message-ID: <878t142vpq.fsf@linux.intel.com>
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

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> @@ -2487,6 +2497,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *d=
wc,
>  	}
>=20=20
>  	switch (event->endpoint_event) {
> +	case DWC3_DEPEVT_XFERCOMPLETE:
> +		if (!dep->stream_capable)
> +			break;
> +		dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
> +		/* Fall Through */

instead, let's add a proper handler for this:

dwc3_gadget_endpoint_transfer_complete(dep, event);

That handler should be "self-sufficient". IOW, we shouldn't have this
fall through here. This means that the other patch where you modify
dwc3_gadget_transfer_in_progress() shouldn't be necessary, since that
event shouldn't run for stream capable endpoints.

While rewriting the patches, please rebase on my testing/next as I have
applied a few of the patches in this series.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwHk/EACgkQzL64meEa
mQZUHg/+PRlIWWGQLUO9kDDrS7skRCVrHgyE3hR6y3QggB0XgQj2F7+soB1TlxRC
BJdjXDQiiJtFm69Du80UbD4XMDre/2EGiv8JHIIigvVjkHENzF5cNu4nzBfjpEbF
keb17zVbkXK5ffDq/KemVag+a0uu5DNp1JYOVL3jqD1EJhkYiVFFfoL4/uAICgw9
bk5TuoZiWtoLKiXpeAa5Bx8ZEAB7lgw6GFkNsUQRvchO/7uyidmRv99J4Hm9l2Ld
q6CU2izuswPyzepiRuZzvdNJPd3gQvsIfpyjsR7poMm6gEdCCgruOgT2r4eawX41
1t1Kzf0BigyG27nkoRgK7YYVZ3GvefGiA3ybnEut+qY+pEJ4+oIFYWkYXf9mILON
KpG4lYxk0F7ItGZWm+/86DflGTJl4UIjWcdnmcd3DXjME+cTuOr4g+70HYZfrw56
F4Sh+scpOOwMRAiJ4XbwIuj78VyFykpWi4zTpKkgkWtey9I3e9sFFABOzMuOo0yW
SyAufcpXZhU5qUSAPInU0CoF0rexZzcWTJuamvVnlL53AImZmxNTxRb8bRsq3unD
/AiMlI+XMSFoBK4238NSCN8D4FFtAkYculLyg71G6DhrwQyyYzRodcqHusLqA6Va
uw61Z08aH+nnc/Fq7jHy3mvc2WuAqnmKxNSo0A2l62CwIQO6jJU=
=PHEt
-----END PGP SIGNATURE-----
--=-=-=--
