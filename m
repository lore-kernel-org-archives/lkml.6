Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EB920663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EB920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408663AbeKWTVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:21:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:26092 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408645AbeKWTVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:21:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 00:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,269,1539673200"; 
   d="asc'?scan'208";a="107028453"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2018 00:37:59 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: RESEND: About VBUS glitch happen on DWC3 host mode enabling process.
In-Reply-To: <AM5PR0402MB2865F6C77B7338F3959FECB4F1D40@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <AM5PR0402MB2865186039501C213CB19C1DF1DB0@AM5PR0402MB2865.eurprd04.prod.outlook.com> <87in0ph0il.fsf@linux.intel.com> <AM5PR0402MB2865F6C77B7338F3959FECB4F1D40@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Date:   Fri, 23 Nov 2018 10:37:55 +0200
Message-ID: <87tvk8yysc.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Ran,

Ran Wang <ran.wang_1@nxp.com> writes:
>> > Then, DWC3 core driver continued to call function
>> > dwc3_host_init()->platform_device_add(xhci)=E2=80=A6
>> > xhci_plat_probe()->usb_add_hcd()->xhci_plat_setup()->xhci_gen_setup->
>> > xhci_reset(), which would reset xHCI controller. At this point, the
>> > VBUS EN pin (USB_DRVVBUS) was pulled low for about 15us, causing the
>>=20
>> why is that pin pulled low? XHCI reset shouldn't be a global reset. Did =
your
>> HW engineer tie all reset lines together? If so, there's nothing I can d=
o to
>> help.
>
> That's the point I also want to make clear: do you mean that the VBUS con=
trol
> signal come from DWC3 IP should not be pulled down when xHCI controller
> conduct reset?=20
> And sorry that I am not quite sure about the 'global reset' you mentioned=
. Do
> you mean to a DWC3 global reset or SoC reset?=20
>
> My understanding is that since VBUS control signal only be meaningful in =
USB
> host mode (xHCI), so it might be in the scope/control of xHCI controller,=
 meaning
> that xHCI reset trigger VBUS/USB_DRVVBUS(EN) pulled low might make sense,
> am I right? And the information come from DWC3 IP design has confirmed th=
at
> PORTSC[PP] will be de-asserted during HCRST, it seems this is native beha=
vior on
> DWC3 IP.

okay, so the thing is about PP being dropped. Right, that should happen
indeed. However, this still shouldn't cause any problems, since
peripheral side shouldn't connect its pull-ups until VBUS is above
session valid threshold.

For how long is VBUS dropped in this case?

>> > VBUS did the same drop too, then back to normal voltage when HW reset
>> > complete. We have confirmed this whole process according to scope
>> > waveform with test code on DWC3 driver. Impact is that VBUS glitch has
>> > let some USB drives (such as Transcend 4GB USB2.0 (jetflash) and
>> > Kingston 16GB USB2.0 DTGE9) malfunction during enumeration
>> > (particularly happen when drive is connected to root-hub port prior to
>> > Linux boot).
>>=20
>> okay
>>=20
>> > Per my understanding, VBUS need to keep +5V once enabled without any
>> > drop/unstable. And above glitch looks like caused by the gap between
>> > DWC3 design and driver init procedure.
>>=20
>> why are you blaming the driver here? We don't know of any such platform
>> that has problems with this. Do you mean to say that because your HW
>> engineer made a choice of tying host reset to global reset, you end up h=
aving
>> an issue? That's something else entirely that SW can't help you with.
>
> I didn't mean to blame driver alone, just found the time interval between=
 host
> mode enabling and host reset causing a observable VBUS control signal gli=
tch
> happen we didn't expected. And experiments proved that VBUS on between ho=
st
> mode enabling and host reset might not be necessary and can avoid this po=
tential risk.
>
>> I have no idea about anything nxp has done, no access to documentation,
>> nothing at all. I need you to do a better job at explaining the situation
>> starting with kernel version you're using, if platform is supported upst=
ream,
>> etc.
>
> Please see my above answer.=20
> These Layerscape platforms are support upstream, I can run them with pure=
 upstream
> build directly.

that's good, then we can debug this. Can you collect xhci tracepoints of
when the problem happens?

>> > One of probably workaround come to my mind is to program all root-hub
>> > ports=E2=80=99 PORTSC[PP] to 0b immediately after enabling host mode (=
calling
>> > dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST)), so VBUS will keep 0V
>> > till xhci is reset by xhci driver like above. I have test this and it
>> > works.
>>=20
>> dwc3 will _not_ touch xHCI registers, sorry. If you need something like =
that,
>> you need to do it as a quirk in xhci-plat.c
>
> Thanks for pointing out a direction for me. If we do it as a quirk in xhc=
i-plat.c, how
> can we control it by some kind of DTS property in board level config?

If, indeed, there is a quirk here, then a quirk can be passed from dwc3
to xhci-plat, yes.

cheers

ps: Mathias, did you see any behavior like this? A drop in VBUS voltage
causing issues during enumeration?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlv3vGMACgkQzL64meEa
mQa1og/+ObOAL8JKDXrvT6ZpDc9XYwMe5DRfhTrVL5Raae05gkM1jJQUcMmS3kSd
EmvOooEaCYaBTiRdNEsak6oGeO+eWi5qGNDqa/hblfLsLIOAcBfLLIQmdq+uCza7
SsOcnA95YRsqngvUeKrca/6N5P5USfz6qDudxXEsdEwgFxVqGMDlTF17vQcu3LVS
QHMie0FKJfDahXevLm3+PGhFk/UPRzZyCxGB4WHg/aROyiq7Z66BLnAGV/KdXCFI
vYC4zNDlJ89fzdNwOhA5AoO/Lsb6j4Bh8imT/OEsYTynVWktnqLTalzYey08juMT
L/rUUgibj0d3zDJs5wF/FxAXSVPiAJjsIWdhIYCoimj/jYEXnPWz/jcJ3kAhM3YI
oS3oN4z9Dg3xNoN71+DnSOp8DeYOtVrAioTnv9sRbF3eMAX77ludaQjEZiiHh+I0
lxWihDhQGO+8xjvErcZUpNeQvD2ymy2LS5Iprb7G/cbSx5aq544HlyR96IKZ/mAW
L3yh/3xtPw8clvBIy6bbtrpcvkmo2gWZRdSDpyG8kzpM+vAra6wXnZS99yvnR/eq
ZHACIivrRu71mNdxIOYnSDYmDZmX03Mdoq/oX3G5u2NDW3mAdbb0Tis1F+/tExnD
hwT4sO5rZdpJezkxX6a0w4ZTYTp86g3m7QtMyMDJviaDgNaV7W4=
=vcqk
-----END PGP SIGNATURE-----
--=-=-=--
