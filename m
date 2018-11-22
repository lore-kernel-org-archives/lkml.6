Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D726C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E1020820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E1020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbeKVVEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:04:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:27198 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731891AbeKVVEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:04:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 02:25:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="asc'?scan'208";a="91283027"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 02:25:42 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RESEND: About VBUS glitch happen on DWC3 host mode enabling process.
In-Reply-To: <AM5PR0402MB2865186039501C213CB19C1DF1DB0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <AM5PR0402MB2865186039501C213CB19C1DF1DB0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Date:   Thu, 22 Nov 2018 12:25:38 +0200
Message-ID: <87in0ph0il.fsf@linux.intel.com>
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


Hi,

Ran Wang <ran.wang_1@nxp.com> writes:
> Hello Felipe,
>
> We=E2=80=99ve found on some Layerscape platforms which integrating DWC3

which platform is that? Is it supported upstream? Which kernel version
are you using?

> USB3.0 DRD controller, VBUS glitch happened and caused some USB drives

what do you mean by glitch?

> enumeration fail, like to discuss the details as below.
> =E3=80=80
> Story is that, we found once function dwc3_core_init_mode() got called
> and enabled host mode by calling dwc3_set_prtcap(dwc,
> DWC3_GCTL_PRTCAP_HOST) which would write register [DWC3_GCTL] bit
> 12~13, so the pin (such as USB_DRVVBUS) which control VBUS driving
> chip=E2=80=99s EN pin would be pulled high immediately, so did the VBUS (=
up to
> +5V).

this seems specific to your platform. Please clarify a little more? Do
you have a discrete charge pump tied to some output signal from dwc3?

> Then, DWC3 core driver continued to call function
> dwc3_host_init()->platform_device_add(xhci)=E2=80=A6
> xhci_plat_probe()->usb_add_hcd()->xhci_plat_setup()->xhci_gen_setup->
> xhci_reset(), which would reset xHCI controller. At this point, the
> VBUS EN pin (USB_DRVVBUS) was pulled low for about 15us, causing the

why is that pin pulled low? XHCI reset shouldn't be a global reset. Did
your HW engineer tie all reset lines together? If so, there's nothing I
can do to help.

> VBUS did the same drop too, then back to normal voltage when HW reset
> complete. We have confirmed this whole process according to scope
> waveform with test code on DWC3 driver. Impact is that VBUS glitch has
> let some USB drives (such as Transcend 4GB USB2.0 (jetflash) and
> Kingston 16GB USB2.0 DTGE9) malfunction during enumeration
> (particularly happen when drive is connected to root-hub port prior to
> Linux boot).

okay

> Per my understanding, VBUS need to keep +5V once enabled without any
> drop/unstable. And above glitch looks like caused by the gap between
> DWC3 design and driver init procedure.

why are you blaming the driver here? We don't know of any such platform
that has problems with this. Do you mean to say that because your HW
engineer made a choice of tying host reset to global reset, you end up
having an issue? That's something else entirely that SW can't help you
with.

I have no idea about anything nxp has done, no access to documentation,
nothing at all. I need you to do a better job at explaining the
situation starting with kernel version you're using, if platform is
supported upstream, etc.



> One of probably workaround come to my mind is to program all root-hub
> ports=E2=80=99 PORTSC[PP] to 0b immediately after enabling host mode (cal=
ling
> dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST)), so VBUS will keep 0V
> till xhci is reset by xhci driver like above. I have test this and it
> works.

dwc3 will _not_ touch xHCI registers, sorry. If you need something like
that, you need to do it as a quirk in xhci-plat.c

> I know it is not an good fix because DWC3 core driver would touch xHCI
> controller which ought to be handled by xHCI driver instead, so like
> to send out this mail for discussion first, see if anyone has better
> solution on this issue.

please answer my other questions first, after we fully understand the
scenario and the problem, then we can discuss implementation details.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlv2hCIACgkQzL64meEa
mQY2Xg//WYfZuo+yrU2FmkOx9WXQa4FgkZhMcpXgpYxyCOCFt+KHyhkCFjIKfZdG
SfsZ2IJPgITDYvw1SsD+d3Dyw72udXQF/OrLSooKoYPaWujSLQ87myDl76QziPRc
ROncixX9ptziwxmbMFdFsmCe4w4BQpdsg48GuJffUhwheaVSNUyaK4VH4t4bdx7S
1qKBQU53tnTfKT3YuHVL5x5RmzGOVB7xNAc6cRXJr8jDzr6D9N14ajRDwqRxjBMg
NrFN4KFkdicp8AuLc9dMTQCMyHtQh25B/QZPQkXaZOVaU2NZs1xynaLRBCvr+98+
Y2mu2J6ZJlTS6FLO0t6cySvFpo7xMnPOaqWEsaGYjmf1UM4o0DZFvYtji8+WpwmV
z7UqSua5ipILjr2LpMurm5WlOSEdAD4LU/+AMCe5qEB0KIM2TDiuJCdOQtqCjD09
GtFvkTs3KBG5RMcwL8LvyH699ZGutKmSs3adnlfWrvdT3ihW6fYqqZ/tOJwwXJof
pxPbm88asJcqkowMS7ywbffI5YcJAWFCZ5U8eQoj4WqLiIj1aERTAB9WWahQ4cx4
jDhKrHyUA1JDGwxgkIQZLm8rvQbawtukqXm9p9L2UYi5Wd4gXFPbLCR2EuXwPQhX
LXyPJF4nXMpKBkRkQiFrM7X4ZODODu602B1XtnTGIptwyO1MfCI=
=0IXT
-----END PGP SIGNATURE-----
--=-=-=--
