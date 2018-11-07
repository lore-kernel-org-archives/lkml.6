Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F1FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91C20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D91C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeKGQ3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:29:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:11577 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeKGQ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:29:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 23:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="asc'?scan'208";a="278994200"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2018 23:00:36 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, kieran.bingham@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
In-Reply-To: <Pine.LNX.4.44L0.1811060939160.1450-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1811060939160.1450-100000@iolanthe.rowland.org>
Date:   Wed, 07 Nov 2018 09:00:32 +0200
Message-ID: <87r2fxtlrj.fsf@linux.intel.com>
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

Alan Stern <stern@rowland.harvard.edu> writes:
>> DATA stage always depends on a usb_ep_queue() from gadget driver. So
>> it's always "delayed" in that sense.
>
> However, it's conceivable that some UDC drivers might behave=20
> differently depending on whether the usb_ep_queue call occurs within=20
> the setup callback or after that callback returns.  They _shouldn't_,=20
> but they might.

but now we're speculating. Should we really care before we catch
regressions?

>> it avoids all the special cases. UDC drivers can implement a single
>> handling for struct usb_request. We could do away with special return
>> values and so on...
>
> It's not quite so simple, because the UDC driver will need to keep=20
> track of whether a request queued on ep0 should be in the IN or the OUT=20
> direction.  (Maybe they have to do this already, I don't know.)

UDC drivers already have to do that.

>> > request and the UDC would then need to check whether that request corr=
esponds=20
>> > to a status stage and process it accordingly. A new operation specific=
 to this=20
>>=20
>> no, it wouldn't. UDC would have to check the size of request, that's
>> all:
>>=20
>> 	if (r->length =3D=3D 0)
>>         	special_zlp_handling();
>> 	else
>>         	regular_non_zlp_handling();
>
> Checking the length isn't enough.  A data stage can have 0 length.

apologies, I meant wLength, like so:

	len =3D le16_to_cpu(ctrl->wLength);
	if (!len) {
		dwc->three_stage_setup =3D false;
		dwc->ep0_expect_in =3D false;
		dwc->ep0_next_event =3D DWC3_EP0_NRDY_STATUS;
	} else {
		dwc->three_stage_setup =3D true;
		dwc->ep0_expect_in =3D !!(ctrl->bRequestType & USB_DIR_IN);
		dwc->ep0_next_event =3D DWC3_EP0_NRDY_DATA;
	}

>> But we don't need to care about special return values and the like. We
>> don't even need to care (from UDC perspective) if we're dealing with
>> 2-stage or 3-stage control transfers (well, dwc3 needs to care because
>> of different TRB types that needs to be used, but that's another story)
>
> No, we do need to care because of the direction issue.

special return values would be rendered uncessary if there's agreement
that status stage is always explicit. Why would need
USB_GADGET_DELAYED_STATUS if every case returns that?

>> > There's also the fact that requests can specify a completion handler, =
but only=20
>> > the data stage request would see its completion handler called (unless=
 we=20
>> > require UDCs to call completion requests at the completion of the stat=
us=20
>> > stage, but I'm not sure that all UDCs can report the event to the driv=
er, and=20
>> > that would likely be useless as nobody needs that feature).
>>=20
>> you still wanna know if the host actually processed your status
>> stage. udc-core can (and should) provide a generic status stage
>> completion function which, at a minimum, aids with some tracepoints.
>
> Helping with tracepoints is fine.  However, I don't think function=20
> drivers really need to know whether the status stage was processed by=20
> the host.  Can you point out any examples where such information would=20
> be useful?

If you know your STATUS stage completed, you have a guarantee that your
previous control transfer is complete. It's a very clear signal that you
should prepare for more control transfers.

>> >> (But it does involve a
>> >> race in cases where the host gets tired of waiting and issues another
>> >> SETUP packet before the processing of the first transfer is finished.)
>>=20
>> Host would stall first in that case.
>
> I don't follow.  Suppose the host sends a SETUP packet for an IN=20
> transfer, but the gadget takes so long to send the IN data back that=20
> the host times out.  So then the host sends a SETUP packet for a new=20
> transfer.  No stalls.
>
> (Besides, hosts never send STALL packets anyway.  Only peripherals do.)

oh okay. This is the setup_packet_pending case.

>> > To simplify function drivers, do you think the above proposal of addin=
g a flag=20
>> > to the (data stage) request to request an automatic transition to the =
status=20
>> > stage is a good idea ? We could even possibly invert the logic and tra=
nsition=20
>>=20
>> no, I don't think so. Making the status phase always explicit is far
>> better. UDCs won't have to check flags, or act on magic return
>> values. It just won't do anything until a request is queued.
>
> I don't agree.  This would be a simple test in a localized area (the=20
> completion callback for control requests).  It could even be=20
> implemented by a library routine; the UDC driver would simply have to=20
> call this routine immediately after invoking the callback.

I don't follow what you mean here.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvijZAACgkQzL64meEa
mQaAig/9EeGyVRELHHx4RBGS9zypenEkdvs6zDNWpWHddHDyreb2AoVbO77hKmV5
TYvrRokufGmBfMx4VMmkTa43zgLLwAet1G8uOMC/AdK8BA12KSLEsqSZnBF0U843
P8ZtJ0mu4cvt95JMEJ+pMTmLzqjdIV1KFekqyr/5C66RlxHkAp8CB2MuBaDOBRV2
/1YB9Vzx2zUnZTtnsBhFteK968Phk2VPajjMqdZaupsbQ2LhlgcfNFuaaQLJTPW2
hdS8eQfrVcUCG/KvkoXyUQ5bj8X3qJ0NkdBQmKNxJX6oHNOemIpi1amI7nprUhd8
P+sH5w1CAx35qhwmP17oUla5ENFvAcDu9iWBcWXygH0crDu90zBRhkuviJFJbPUe
Bj6oIfsDdNDZPazkv0FTjxGCwXCE8xSTbjqE16e3aRAkFfNITM8r5jKBHY96zD74
sNsnX5NrMnqcI7P1IOip+THJDH/dG9X5RrLZjiuV53CjSKiCw0pG8YrEgmGCB23O
FsnnbcHbePCObFUhriFvJecKVCzRzXSUCVXb3UlxXt051ej6w+LgsvgOTSJ8/++b
9rMFjMSaWWBkAwPT3Y7tzdiV4oTQbZMCpaKLxsY8cQIQFFpJ5tdNm/oPQ+IYgAcm
5DSRmZna4WyWKA5XpAtfq2vOAy1LKV80F/S1M4bXu5Mh35Zr0ZY=
=648u
-----END PGP SIGNATURE-----
--=-=-=--
