Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5EFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE8521A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ogqG8xVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE8521A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbeHGAXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:23:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46196 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbeHGAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:23:12 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0CF157;
        Tue,  7 Aug 2018 00:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533593523;
        bh=SsOtJjQIpuf94T9eHE43Kz5KS6SLi6iNugGmc/wR3+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogqG8xVin2vPIaSSxelM17e5HsJPyOXAkzHDdV3oKL1rVBcirSSW+TVZzOCGVwa8G
         LY9I62QsCouT+nReUmyotSffzIdzNY8AK/2h/Wq3e8seE78Dg4H4Mdz/+w0LHAyk07
         0viDXwyubP+sC5mpK7f9HGklfihL2rzkI5MdEw28=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Yang <hansy@nvidia.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH resend] [media] uvcvideo: zero seq number when disabling stream
Date:   Tue, 07 Aug 2018 01:12:46 +0300
Message-ID: <15494504.TcLiMcYGsL@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <4325498.0x3d1FfxvC@avalon>
References: <1505456871-12680-1-git-send-email-hansy@nvidia.com> <4037e7e9-e017-e096-8020-94395260655b@nvidia.com> <4325498.0x3d1FfxvC@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

(CC'ing the linux-usb mailing list)

On Thursday, 19 October 2017 15:03:34 EEST Laurent Pinchart wrote:
> On Thursday, 19 October 2017 10:23:06 EEST Hans Yang wrote:
> > On 2017=E5=B9=B410=E6=9C=8818=E6=97=A5 16:52, Guennadi Liakhovetski wro=
te:
> >> On Mon, 16 Oct 2017, Laurent Pinchart wrote:
> >>> On Friday, 15 September 2017 09:27:51 EEST Hans Yang wrote:
> >>>> For bulk-based devices, when disabling the video stream,
> >>>> in addition to issue CLEAR_FEATURE(HALT), it is better to set
> >>>> alternate setting 0 as well or the sequnce number in host
> >>>> side will probably not reset to zero.
> >>>=20
> >>> The USB 2.0 specificatin states in the description of the SET_INTERFA=
CE
> >>> request that "If a device only supports a default setting for the
> >>> specified interface, then a STALL may be returned in the Status stage
> >>> of the request".
> >>>=20
> >>> The Linux implementation of usb_set_interface() deals with this by
> >>> handling STALL conditions and manually clearing HALT for all endpoints
> >>> in the interface, but I'm still concerned that this change could break
> >>> existing bulk- based cameras. Do you know what other operating systems
> >>> do when disabling the stream on bulk cameras ? According to a comment
> >>> in the driver Windows calls CLEAR_FEATURE(HALT), but the situation
> >>> might have changed since that was tested.
> >=20
> > Sorry I did not mention that it is about SS bulk-based cameras using
> > sequence number technique.
> >=20
> > From my observations, invoking usb_clear_halt() will reset the endpoint
> > in the device side via CLEAR_FEATURE(HALT)
> > and reset the sequence number as well; however usb_reset_endpoint() does
> > not reset the host side endpoint with xhci driver,
> > then the sequence number will mismatch in next time stream enable.
> > I can always observe this through a bus analyzer on Linux implementation
> > whatever X86 or ARM based.
> > This is not observed on the Windows.

Do your USB analyser traces show whether Windows sends a SET_INTERFACE(0)=20
request when stopping the stream for bulk-based devices ?

> According to the USB 3.0 specification, section 9.4.5 ("Get Status"),
>=20
> "Regardless of whether an endpoint has the Halt feature set, a
> ClearFeature(ENDPOINT_HALT) request always results in the data sequence
> being reinitialized to zero, and if Streams are enabled, the Stream State
> Machine shall be reinitialized to the Disabled state."
>=20
> If Linux doesn't reset the sequence number when issuing a
> CLEAR_FEATURE(HALT), isn't it a Linux USB stack bug that should be fixed =
in
> the USB core ?

Do you have any update on whether you would consider this to be a Linux USB=
=20
stack issue or a uvcvideo driver issue ?

> >>> Guennadi, how do your bulk-based cameras handle this ?
> >>=20
> >> I don't know what design decisions are implemented there, but I tested=
 a
> >> couple of cameras for sending a STREAMOFF after a few captured buffers,
> >> sleeping for a couple of seconds, requeuing buffers, sending STREAMON
> >> and capturing a few more - that seems to have worked. "Seems" because I
> >> only used a modified version of capture-example, I haven't checked
> >> buffer contents.
> >>=20
> >> BTW, Hans, may I ask - what cameras did you use?
> >=20
> > I have three SS bulk-based cameras as follows:
> > e-con Systems See3CAM_CU130 (2560:c1d0)
> > Leopard ZED (2b03:f580)
> > Intel(R) RealSense(TM) Camera SR300 (8086:0aa5)
> >=20
> > I can observe the same issue on all above;
> > besides, to reproduce issue do not let the camera enter suspend because
> > it will *help* to reset the sequence number through usb_set_interface(0=
).
> >=20
> >>>> Then in next time video stream start, the device will expect
> >>>> host starts packet from 0 sequence number but host actually
> >>>> continue the sequence number from last transaction and this
> >>>> causes transaction errors.
> >>>=20
> >>> Do you mean the DATA0/DATA1 toggle ? Why does the host continue
> >>> toggling the PID from the last transation ? The usb_clear_halt()
> >>> function calls usb_reset_endpoint() which should reset the DATA PID
> >>> toggle.
> >>>=20
> >>>> This commit fixes this by adding set alternate setting 0 back
> >>>> as what isoch-based devices do.
> >>>>=20
> >>>> Below error message will also be eliminated for some devices:
> >>>> uvcvideo: Non-zero status (-71) in video completion handler.
> >>>>=20
> >>>> Signed-off-by: Hans Yang <hansy@nvidia.com>
> >>>> ---
> >>>>=20
> >>>>   drivers/media/usb/uvc/uvc_video.c | 5 ++---
> >>>>   1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>=20
> >>>> diff --git a/drivers/media/usb/uvc/uvc_video.c
> >>>> b/drivers/media/usb/uvc/uvc_video.c index fb86d6af398d..ad80c2a6da6a
> >>>> 100644
> >>>> --- a/drivers/media/usb/uvc/uvc_video.c
> >>>> +++ b/drivers/media/usb/uvc/uvc_video.c
> >>>> @@ -1862,10 +1862,9 @@ int uvc_video_enable(struct uvc_streaming
> >>>> *stream, int enable)
> >>>>   	if (!enable) {
> >>>>   		uvc_uninit_video(stream, 1);
> >>>>=20
> >>>> -		if (stream->intf->num_altsetting > 1) {
> >>>> -			usb_set_interface(stream->dev->udev,
> >>>> +		usb_set_interface(stream->dev->udev,
> >>>>   					  stream->intfnum, 0);
> >>>> -		} else {
> >>>> +		if (stream->intf->num_altsetting =3D=3D 1) {
> >>>>   			/* UVC doesn't specify how to inform a bulk-based device
> >>>>   			 * when the video stream is stopped. Windows sends a
> >>>>   			 * CLEAR_FEATURE(HALT) request to the video streaming

=2D-=20
Regards,

Laurent Pinchart



