Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FBCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E862081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E862081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeK2X44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:56:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:61844 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeK2X44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:56:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 04:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="asc'?scan'208";a="278767462"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2018 04:51:36 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capable endpoints
In-Reply-To: <BL0PR02MB563317DEAFAD7C06B52FC23DA7D10@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1539436498-24892-2-git-send-email-anurag.kumar.vulisha@xilinx.com> <87k1lfiwx3.fsf@linux.intel.com> <BL0PR02MB563317DEAFAD7C06B52FC23DA7D10@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Thu, 29 Nov 2018 14:51:32 +0200
Message-ID: <87h8g0yrl7.fsf@linux.intel.com>
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
>>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
>>> index af88b48..41cc23b 100644
>>> --- a/drivers/usb/gadget/udc/core.c
>>> +++ b/drivers/usb/gadget/udc/core.c
>>> @@ -52,6 +52,24 @@ static int udc_bind_to_driver(struct usb_udc *udc,
>>>  /* -------------------------------------------------------------------=
------ */
>>>
>>>  /**
>>> + * usb_ep_stream_timeout - callback function for endpoint stream timeo=
ut timer
>>> + * @arg: pointer to struct timer_list
>>> + *
>>> + * This function gets called only when bulk streams are enabled in the=
 endpoint
>>> + * and only after ep->stream_timeout_timer has expired. The timer gets=
 expired
>>> + * only when the gadget controller failed to find a valid stream event=
 for this
>>> + * endpoint. On timer expiry, this function calls the endpoint-specifi=
c timeout
>>> + * handler registered to endpoint ops->stream_timeout API.
>>> + */
>>> +static void usb_ep_stream_timeout(struct timer_list *arg)
>>> +{
>>> +	struct usb_ep *ep =3D from_timer(ep, arg, stream_timeout_timer);
>>> +
>>> +	if (ep->stream_capable && ep->ops->stream_timeout)
>>
>>why is the timer only for stream endpoints? What if we want to run this
>>on non-stream capable eps?
>>
>
> I have seen this issue only with stream capable eps between PRIME &
> EPRDY. But this issue can potentially occur with non-stream endpoints
> also. Will remove this stream capable checks in next series of patch.

you're adding support for transfer timeouts, which some gadgets may want
regardless of endpoint type. One use is to correct cases of streams
going out of sync.

>>> +		ep->ops->stream_timeout(ep);
>>
>>you don't ned an extra operation here, ep_dequeue should be enough.
>>
>
> I think issuing ep_dequeue() would be more trickier than calling ep->ops-=
>stream_timeout().
> This is because, every gadget driver has their own way of handling ep_deq=
ueue. Some
> drivers (like dwc3) may sleep for an event (wait_event_lock_irq) in the e=
p_dequeue routine.

not anymore. There's, now, a requirement that ->dequeue can be called
from any context.

> Since we are calling ep_dequeue from timer timeout callback which is in s=
oftirq context,
> sleeping or waiting for an event would hang the system. Also adding ep->o=
ps->stream_timeout()
> would make the gadget drivers handle the issue in better way based on the=
ir implementation.

no problems

> Another advantage is the drivers which doesn't have this timeout issue do=
esn't have to register the
> timeout handler and can avoid the logic of deleting the timer for every r=
equest. So, I think
> ep->ops->stream_timeout() would be better than having a generic handler w=
hich does
> ep_dequeue() & ep_queue(). Please provide your suggestion on this impleme=
ntation.

call ep_dequeue()

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlv/4NQACgkQzL64meEa
mQaiwA//Ue5yvbElCDJQo5PRqexmbMqcB2q3FcIJOPsHk2SOEqgtT9v6CA9MtDdR
1EzvCRZM2GzvjysWShCP4555joiMWhMfBYKU/Va1y9ZCwXFLvzKdmdZzQlsNmQU2
9tkTkCzvbB9j5oK1WlcjKidQ+Xz3s3ccymayA3n7ZYw1/G27vliPfVPc8p7KMwor
50i19EyyPsSNF2D3QPbnknvdZqGoLs1k1tuyYJfmxvr5n0nBV4vqsJ4lpvcqQBox
Jp/Uu5V3/jkcrQFbQiipJRCvrSGxLSeP437K8X6KqQlOlQNrkxHHQTzDOgBGAQf7
ZkocFmTzlIsNUHszEnsln9RhjcRyvk19sIPkKLIpxgawRCxrOBIWAw+ujBm2gpIX
5B60bNspRCQAt4Hc1jDKi1a8yyaqt0JbIGhLkz/d6rFlg54UdT5eweHydwyDTCFv
btYRJOcZ9iP6zQZlHFN5osVztBGy3ppMAwqxtJGWRPN4TIq0qUKBqroGLfjx3Er+
l7vcAnJoiDI6vL4IgS/wksiHx1OXVpoZNP5SmHNCxfMZQ2REIOnQ4Z/c6rmvPM4f
AWJ5tE58UoQaNQ/5W5jRDLgDWZSTUv6b7ihzAp8CPWBHPtZjWHSK6aWmqn1p5G9H
fG8+rd2J8P6T1PQgTVS/RLKFX98wa+O8G3X3lPp8F+xMH4ntylg=
=fe1M
-----END PGP SIGNATURE-----
--=-=-=--
