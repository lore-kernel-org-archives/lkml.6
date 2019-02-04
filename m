Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB125C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6B2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfBDORO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:17:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:36260 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfBDORN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:17:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 06:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="asc'?scan'208";a="141431596"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2019 06:17:07 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3 driver.
In-Reply-To: <20190204114502.GA28608@kroah.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com> <1548935553-452-3-git-send-email-pawell@cadence.com> <20190204114502.GA28608@kroah.com>
Date:   Mon, 04 Feb 2019 16:17:00 +0200
Message-ID: <87y36vmyeb.fsf@linux.intel.com>
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

Greg KH <gregkh@linuxfoundation.org> writes:
> On Thu, Jan 31, 2019 at 11:52:29AM +0000, Pawel Laszczak wrote:
>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>> to driver/usb/common/debug.c file. These moved functions include:
>>     dwc3_decode_get_status
>>     dwc3_decode_set_clear_feature
>>     dwc3_decode_set_address
>>     dwc3_decode_get_set_descriptor
>>     dwc3_decode_get_configuration
>>     dwc3_decode_set_configuration
>>     dwc3_decode_get_intf
>>     dwc3_decode_set_intf
>>     dwc3_decode_synch_frame
>>     dwc3_decode_set_sel
>>     dwc3_decode_set_isoch_delay
>>     dwc3_decode_ctrl
>>=20
>> These functions are used also in inroduced cdns3 driver.
>>=20
>> All functions prefixes were changed from dwc3 to usb.
>
> Ick, why?

moving dwc3-specific code into generic code.

>> Also, function's parameters has been extended according to the name
>> of fields in standard SETUP packet.
>> Additionally, patch adds usb_decode_ctrl function to
>> include/linux/usb/ch9.h file.
>
> Why ch9.h?  It's not something that is specified in the spec, it's a
> usb-specific thing :)

agree.

>> +/**
>> + * usb_decode_ctrl - Returns human readable representation of control r=
equest.
>> + * @str: buffer to return a human-readable representation of control re=
quest.
>> + *       This buffer should have about 200 bytes.
>
> "about 200 bytes" is not very specific.
>
> Pass in the length so we know we don't overflow it.

agree.

>> + * @bRequestType: matches the USB bmRequestType field
>> + * @bRequest: matches the USB bRequest field
>> + * @wValue: matches the USB wValue field (CPU byte order)
>> + * @wIndex: matches the USB wIndex field (CPU byte order)
>> + * @wLength: matches the USB wLength field (CPU byte order)
>> + *
>> + * Function returns decoded, formatted and human-readable description of
>> + * control request packet.
>> + *
>> + * Important: wValue, wIndex, wLength parameters before invoking this f=
unction
>> + * should be processed by le16_to_cpu macro.
>> + */
>> +const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bRequest,
>> +			    __u16 wValue,  __u16 wIndex, __u16 wLength);
>
> Why are you returning a value, isn't the data stored in str?  Why not
> just return an int saying if the call succeeded or not?

There is one detail here. The usage scenario for this is for
tracepoints. When dealing with tracepoints we want to delay decoding of
the data into strings until print-time. I guess it's best to illustrate
with an example:

DECLARE_EVENT_CLASS(dwc3_log_ctrl,
	TP_PROTO(struct usb_ctrlrequest *ctrl),
	TP_ARGS(ctrl),
	TP_STRUCT__entry(
		__field(__u8, bRequestType)
		__field(__u8, bRequest)
		__field(__u16, wValue)
		__field(__u16, wIndex)
		__field(__u16, wLength)
		__dynamic_array(char, str, DWC3_MSG_MAX)
	),
	TP_fast_assign(
		__entry->bRequestType =3D ctrl->bRequestType;
		__entry->bRequest =3D ctrl->bRequest;
		__entry->wValue =3D le16_to_cpu(ctrl->wValue);
		__entry->wIndex =3D le16_to_cpu(ctrl->wIndex);
		__entry->wLength =3D le16_to_cpu(ctrl->wLength);
	),
	TP_printk("%s", dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
					__entry->bRequestType,
					__entry->bRequest, __entry->wValue,
					__entry->wIndex, __entry->wLength)
	)
);

The above is the code is today (well, I've added buffer size as an
argument). If I make dwc3_decode_ctrl() return an integer, I can't call
it from TP_printk() time. I'd have to move it to TP_fast_assign() time
which is supposed to be, simply, a copy of the necessary data. IOW, I
would have this:

DECLARE_EVENT_CLASS(dwc3_log_ctrl,
	TP_PROTO(struct usb_ctrlrequest *ctrl),
	TP_ARGS(ctrl),
	TP_STRUCT__entry(
		__dynamic_array(char, str, DWC3_MSG_MAX)
	),
	TP_fast_assign(
		dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
				ctrl->bRequestType,
				ctrl->bRequest,
                                le16_to_cpu(ctrl->wValue),
				le16_to_cpu(ctrl->wIndex),
                                le16_to_cpu(ctrl->wLength));
	),
	TP_printk("%s", __get_str(str)
	)
);

Essentially, we end up moving decoding of the tracepoint to the time it
is captured; IOW, we reintroduce regular latency of string formatting.

What we could do, is move all functions called by dwc3_decode_ctrl() to
return int, but leave dwc3_decode_ctrl() returning a pointer to str just
so we continue decoding the data at printing time.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxYSVwACgkQzL64meEa
mQYMAg/9GRynhyFknrnHfzpIDuI7ppCIBy4YOBd0LtU7TkwS72pB2FssCdls0yr1
apKfiI3E33CKAm+bCRXzVpSfe/w0cC/5P4ERacKLhH86MKbP+WHgsZbHc5U0NpSW
5GnBIY5zUjNfLlBGZ8ljRvWgsDHVMEPQtXyPU1GRJ9LyMGSdBdWCKRAMA2z+rqEb
1HsugGWdT5tE8oHWe6o+5dnbkKMHFwVMT2AQwm/grl0FvZ9GZ8rDGRUyy0wZFmA3
FOkdtnb2/j6QBvdz2Fpi/TWDVzHQUhi0w77izBmJeMvfgORTdLdTiH4AcVrqcrgd
ncZHz+nUoWC85jq9Pc/MCQ0F9Ts7uZaqAJo0Zl8dtSoSKpXSWHaKdWWRnZ28XCx2
HptOxuoNC16cFfuKOJa5Gl7KHANKiUyE7s1QWGvIYC2qReuAVCeeFycTNRkp0omR
GYmFn9+4L0aBLMWZa/E0q/kRd8txWi1+kjoMW47MgPAr3C+8DZolzaByfsn1SX8f
HTrVTIesZ4872l8RSjN5j5os7J4F1Wb//Xbq1Jsc9nw1NLyLJcYGZcYsp6R6Iir3
xsXb/gQkjF6btg68QYeF6PLFmMT4ktXlm1DxtuZI+PoCv/lyTZmCO1MNr1+wqvKf
Xav2TQtvOeARWYWZVG1Me6iiU+2+sSsghuhQivAHugV3CM3pvSc=
=vcs9
-----END PGP SIGNATURE-----
--=-=-=--
