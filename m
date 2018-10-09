Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803FEC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352B32087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352B32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIOhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:37:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:41722 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeJIOhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:37:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 00:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,359,1534834800"; 
   d="asc'?scan'208";a="264081649"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2018 00:20:56 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen\@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
In-Reply-To: <BL0PR02MB5633850DAB27466B4D5D6F44A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com> <871s8zptow.fsf@linux.intel.com> <BL0PR02MB5633850DAB27466B4D5D6F44A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Tue, 09 Oct 2018 10:20:52 +0300
Message-ID: <87tvlvoaaz.fsf@linux.intel.com>
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

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>> Please let us know if you have any suggestions / comments on this patch=
 series.
>>> If you feel this patch series are okay, can we proceed with them?
>>
>>I really don't like this dwc3-specific timer. The best way here would be
>>to add a timer on udc/core.c which can be reused by any udc. This would
>>mean, of course, teaching udc/core about streams and lettting it do part
>>of the handling.
>>
>
> Thanks for spending your time in reviewing this patch. The reason for add=
ing the
> timer is when streams are enabled there could be chances for the host and=
 gadget
> controller to become out of sync, the gadget may wait for the host to iss=
ue prime
> transaction and the host may wait for the gadget to issue ERDY. To avoid =
such a
> potential deadlock conditions, timeout needs to be implemented in dwc3 dr=
iver.

"in dwc3 driver" is an implementation choice. The situation you describe
could happen with any UDC, right?

> After timeout occurs, gadget will first stop transfer and restart the tra=
nsfer again.
> This issue is mentioned in databook 2.90A section 9.5.2. I am not aware o=
f how
> other controllers are handling the streams, but since this issue looks mo=
re like a

We should get in touch with other UDC authors. We have at least Renesas,
net2280, bcd_udc and mtu3 supporting superspeed.

> dwc3 specific issue, I think it would be more convincing to add the timer=
 in dwc3
> gadget driver rather than adding in udc framework. Also we are stopping t=
he timer

why? When the situation you describe is something that can happen with
any udc, why should we reimplement the solution on all UDCs supporting
streams when we can give generic support for handling certain
situations?

> when a valid StreamEvnt is found, which would be difficult to handle if t=
he timer is

Why difficult? udc-core would call:

mod_timer(gadget->stream_timeout_timer, msecs_to_jiffies(50));

Once you receive stream event, dwc3 would call:

if (timer_pending(dwc->gadget.stream_timeout_timer))
	del_timer(dwc->gadget.stream_timeout_timer);

Why is that difficult? You could even avoid anything to be written in
dwc3 and put the del_timer() inside usb_gadget_giveback_request()
itself. That why, dwc3 doesn't even have to know that there's a timer
running. Also, you're timer function, instead of calling dwc3's private
functions, should be relying on the gadget API.

Your timer, apparently, should be fired per-request, then your timer
function would call:

usb_ep_dequeue(request);
usb_ep_queue(request);

If the timer expires. This would work for any UDC, not only dwc3. Then,
this is something we document for all UDCs and they'd have to adhere to
the API.

In summary, not that many changes needed to dwc3. Nothing related to
timers inside dwc3. Almost everythin can, and should, be done
generically.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlu8VtQACgkQzL64meEa
mQaxGw//bafmw8cp0DNNzmkKdCWsZyhJ486+anJgz+CgxQrohMs2JDwoHkIxRq+u
GnG2cR2fnwS2hTTIo4prJPyqJoQjAmzjHar/QHatkBqeJVXCBuYhA0DP2RrQ/s57
5C/phtSg1PQlgirSfZrIxCv7T0n+LaFyYWuFrW+Bgwi2GJKCMFVlo0q3MFaOSxds
/U/BeNsGKoLon3wQFH/KGB73+7d9HH61BnpSSNrHFhUiHgJJxYHZmUCkr0YjwTDY
gql8lV4PnmM+Fhh4pQ6dZr2H4ZWPr2Z6Gxv3scej4+JWF1OdwrEr9d/dUa453RXT
ss4R+k0aLh2JTVLphROTCO9CHi683jxhIGdWGVeSrEIJ5jETUj1QtAyyM6g163ui
uR4xrnviEFRfm/qVS6VJzQigccDTMHL/83d7mJRO9Pt5Hmt6oHVqF+jHmRKAkPOg
73SBFepHOW2nrpEoU4Hmg4CqzO0z5ouR1FJCZZ4pXl/CpuzCb1OjLo485rflaCLK
giTAO7wZl1mSNEn8tq5yh8Qxeb8cZhpfNKJrcGp2tY/jFg6nidfk7yCt9nFWpbIl
c+7Gy7NcRcwVFvJ4sydjdmBIR/uzYzoEnyqCuURcCaZRueSG9bwLysKzsFfRVwdL
+rkOJhB3LsNMaX56wpyRrSYJo3F6F9Z55UrCMEVf6NV4L6N6gV0=
=OjZJ
-----END PGP SIGNATURE-----
--=-=-=--
