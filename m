Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A482C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58CA217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549482536;
	bh=pHLrlFbTI2rLtkD4ymAbJFQdveLIaTglrm1K9+u6yhM=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=UVCTuUjbYQ0rEd3zNQmMl42be2rZ23PvXkKTinOpz36vlz0x6JwpWnEwRXpl6xKyO
	 20HF7RgweO+pGqx/2HIJhEhNN7aQXgjY1GxenOuQMchc+dFnYUOKshu3S2vxu+zuaU
	 ZnKTdC/mnFoObjsuXSOh3VDUWR0LZEk1cw4oWgPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBFTsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBFTsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:48:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C87252083B;
        Wed,  6 Feb 2019 19:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549482533;
        bh=pHLrlFbTI2rLtkD4ymAbJFQdveLIaTglrm1K9+u6yhM=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=rvuR0ScaEWKQKT5ykL4ztFMunBBetOQRmRJ1O6JbU42z61DGwrk60EniHR+JNt/iU
         P+IhPIW/7NvlsOIuIHGJex4gUU1l0WrW1ZkNGvsGCKCIWywsiST30LbKK1Py4rIzy2
         HiTkNUrinhuGLTP5jCNBjUkudBy4oea/CAZwWj4U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
In-Reply-To: <SN6PR04MB4925A158FB93AC99D15ED3EBFC6F0@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: alot/0.8
Subject: RE: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for PHY
Message-ID: <154948253306.115909.17663891665120785337@swboyd.mtv.corp.google.com>
References: <20190205185902.106085-1-evgreen@chromium.org> <20190205185902.106085-7-evgreen@chromium.org> <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com> <SN6PR04MB4925A158FB93AC99D15ED3EBFC6F0@SN6PR04MB4925.namprd04.prod.outlook.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:48:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Avri Altman (2019-02-06 05:57:17)
> Hi,
>=20
> > On 06/02/19 12:29 AM, Evan Green wrote:
> > > Expose a reset controller that the phy will later use to control its
> > > own PHY reset in the UFS controller. This will enable the combining
> > > of PHY init functionality into a single function.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> >=20
> > I'd like to get ACK from scsi/ufs/ MAINTAINER Vinayak for me merge it i=
n PHY
> > tree.
> Looks like this series is qcom specific, and has less impact of the ufs c=
ore driver.
>=20
> > > +   err =3D devm_reset_controller_register(dev, &host->rcdev);
> Just my 2 cents:
> Isn't this should be done somewhere in drivers/clk/qcom,
> Like its done for any other qcom board?

It's not a clk controller, so I don't see how that makes sense. There
are clk/reset controllers on qcom platforms, and so we've combined them
into the same overall driver there because those resets affect clk
operations and vice-versa. But this looks like some sort of reset in the
phy or the controller itself and isn't the "clk type" resets that we
implement in drivers/clk/qcom/

