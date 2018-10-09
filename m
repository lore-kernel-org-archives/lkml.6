Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C11C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC06821479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC06821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJIU2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:28:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:7741 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJIU2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:28:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 06:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,360,1534834800"; 
   d="asc'?scan'208";a="76597359"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga007.fm.intel.com with ESMTP; 09 Oct 2018 06:04:14 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen\@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
In-Reply-To: <BL0PR02MB56334E88A0D23DC1FA9905B0A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com> <871s8zptow.fsf@linux.intel.com> <BL0PR02MB5633850DAB27466B4D5D6F44A7E70@BL0PR02MB5633.namprd02.prod.outlook.com> <87tvlvoaaz.fsf@linux.intel.com> <BL0PR02MB56334E88A0D23DC1FA9905B0A7E70@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Tue, 09 Oct 2018 16:04:10 +0300
Message-ID: <87h8hvnuet.fsf@linux.intel.com>
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
>>> Thanks for spending your time in reviewing this patch. The reason for a=
dding the
>>> timer is when streams are enabled there could be chances for the host a=
nd gadget
>>> controller to become out of sync, the gadget may wait for the host to i=
ssue prime
>>> transaction and the host may wait for the gadget to issue ERDY. To avoi=
d such a
>>> potential deadlock conditions, timeout needs to be implemented in dwc3 =
driver.
>>
>>"in dwc3 driver" is an implementation choice. The situation you describe
>>could happen with any UDC, right?
>>
>
> Yes this could happen to other UDC drivers also, unless controller is cap=
able of handling
>
>>> After timeout occurs, gadget will first stop transfer and restart the t=
ransfer again.
>>> This issue is mentioned in databook 2.90A section 9.5.2. I am not aware=
 of how
>>> other controllers are handling the streams, but since this issue looks =
more like a
>>
>>We should get in touch with other UDC authors. We have at least Renesas,
>>net2280, bcd_udc and mtu3 supporting superspeed.
>>
>
> Thanks for pointing other drivers. Will refer these drivers to see how th=
ey are handling streams
>=20=20
>>> dwc3 specific issue, I think it would be more convincing to add the tim=
er in dwc3
>>> gadget driver rather than adding in udc framework. Also we are stopping=
 the timer
>>
>>why? When the situation you describe is something that can happen with
>>any udc, why should we reimplement the solution on all UDCs supporting
>>streams when we can give generic support for handling certain
>>situations?
>>
>
> I agree with you. As you suggested will work on implementing changes in U=
DC
>
>>> when a valid StreamEvnt is found, which would be difficult to handle if=
 the timer is
>>
>>Why difficult? udc-core would call:
>>
>>mod_timer(gadget->stream_timeout_timer, msecs_to_jiffies(50));
>>
>>Once you receive stream event, dwc3 would call:
>>
>>if (timer_pending(dwc->gadget.stream_timeout_timer))
>>	del_timer(dwc->gadget.stream_timeout_timer);
>>
>>Why is that difficult? You could even avoid anything to be written in
>>dwc3 and put the del_timer() inside usb_gadget_giveback_request()
>>itself. That why, dwc3 doesn't even have to know that there's a timer
>>running. Also, you're timer function, instead of calling dwc3's private
>>functions, should be relying on the gadget API.
>>
>>Your timer, apparently, should be fired per-request, then your timer
>>function would call:
>>
>>usb_ep_dequeue(request);
>>usb_ep_queue(request);
>>
>>If the timer expires. This would work for any UDC, not only dwc3. Then,
>>this is something we document for all UDCs and they'd have to adhere to
>>the API.
>>
>>In summary, not that many changes needed to dwc3. Nothing related to
>>timers inside dwc3. Almost everythin can, and should, be done
>>generically.
>
> Thanks a lot for giving a detailed explanation. Will implement the timeout
> changes into UDC core.

no problem. I just wanna make sure that this work happens in one place
and one place only :)

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlu8p0oACgkQzL64meEa
mQZLKBAAyJeX0i/Y7B/OFnvq5DX72v0PU9dS2vfBb8S5b6Sc5WhgaaYU6iRkiE8p
AVtew4O98SmTnvEHdPtSyDgGSQvIC6BTi/GGf/FAmbeY+4MfbxMA8WjQIXderW3y
lY1ghPB5LYaabyww6jDHAbOtExP4Sf6X8tRLQxZjzcUKwR/gk8r3iJDKlmCFa0qD
kJS9NdY4SNxF2LCkp1Nd+zu+x8VzmQGyO2Up9VCc/z3B5n3mVXRXqGkSq44zHy0A
D006c+Vg1tiEDaLxVRU2DemURbQwBFasyhnV75xk7jBPR6cTUsT8iLAI3u73yoJi
1AkGxhPpRgmN9ku12vY+knOKJtzW5xuXxkwMEu6I6dlFHRffUlZJijURAlm4bhh1
3auPV0dbH9UWrysKOR4OY3jj7i0UBesgP5B/nrFAjvFjl0ZMMHBMfzAJXafSBiJB
58CW0XUKToPcoa4neFRCEkLfYKzErlEcAcEezod1SKPcfeA5c1ikXJmNTEpWw4rE
a2hYmO7+jLSdRuPf5oq1LSJewdij6USAXBzd3xvVH5OFtYLrNqrJ2fDU9M6zDSpi
tuXgn7x7G7Iq+ppoMjZ67PZdX0o0YmvE0HKsB7zYyChZdAASYPP8gnDCt2gOGZZP
qgePahCfA7UsQ7zwcnyr676LaaEVtEFuwseI9nG0Y+hZSzt6NF8=
=389S
-----END PGP SIGNATURE-----
--=-=-=--
