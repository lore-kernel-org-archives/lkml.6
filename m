Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7304821486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="dsnz6/Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7304821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeHVLKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:10:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:16687 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbeHVLKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1534924000;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zlFViGBN6d0EjH1ElwJXezRvFZ0GGXTjV86/DikrrZc=;
        b=dsnz6/Dl7WJiXuSNaz0B5t2rUOKp4fBU/e5yKW7vbsJLKsUINJJcH4khtRR861YwvC
        LzUizZ6Q5URmGT4hn/pBFqc1HVqy82R+WmgxIej3cDLTlk5BOH/EP7b6C/DBnuIHzdnR
        3SiL14Xv2VNkVi5IOqVvmHacb5ySxSdf496sFlAmpk/+W94Au2KsuDKhX7/w7yXUmFKw
        x/FQ66R0w/AFWEOZIIRrIW+xvwQsNay2tLKxc/PZ/TfDCo+u6ddkOjfgn2C73Ez/U5o5
        +mctUaaHc3ado4PN3vWCnFVefe/Du/yIociVwGnJGF8jNHeEDWgj7737z7YtlRRWIKMU
        UA8Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBs7wpz98S0o3m2fIKh"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.18 DYNA|AUTH)
        with ESMTPSA id x038eeu7M7kVPDf
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 22 Aug 2018 09:46:31 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] drm: omapdrm: displays: fix port_num for opa362 output
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <6854891.0j5LuaEH9O@avalon>
Date:   Wed, 22 Aug 2018 09:46:30 +0200
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1123AD2-C238-4F19-8AF7-3FB8F60BF62D@goldelico.com>
References: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com> <6854891.0j5LuaEH9O@avalon>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

> Am 19.08.2018 um 16:07 schrieb Laurent Pinchart =
<laurent.pinchart@ideasonboard.com>:
>=20
> Hi Nikolaus,
>=20
> Thank you for the patch.
>=20
> On Friday, 27 July 2018 17:24:32 EEST H. Nikolaus Schaller wrote:
>> The opa362 amplifier has two ports, an input (usually connected
>> to the OMAP3 VENC) and an output port connected to the external
>> connector.
>>=20
>> These are usually defined as input port@0 and outpt port@1 in
>> the DT and really distinguished by the reg =3D <port_num> property
>> of these nodes.
>>=20
>> But we are missing to define the output port as number 1 so
>> it does not match the DT entry.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> I think this patch is superseded by "[PATCH v3 36/61] drm/omap: dss: =
Replace=20
> omap_dss_device port number with bitmask"

looks good and from cursory review it seems to resolve the opa362
bug as a side-effect. Maybe this can be noted in the commit description.

What I am not sure how this magically defines the output as
reg=3D<1> or if we have to swap reg number definitions in the DT.
But encoder-tfp410.c and encoder-tpd12s015.c seem to do it the
same way, so it is very likely that it works as defined.

> which should get merged in v4.20.

Well, I had hoped our bug fix makes it into v4.19 and can be
potentially backported to stable.

Do you plan to backport you patch? It seems to be quite independent
and should apply to older releases.

BR,
Nikolaus

