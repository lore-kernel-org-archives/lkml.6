Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7432075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550857587;
	bh=FKwqrUUguu6NXIhqOpxtDvpDKNPuz1Ra3atbXUUhTWc=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=sHuyFrmGbj+uIbWsFJAb4jyoxeheqLdDrVzfQRSRV9ZcNBHo04qC68FhKuV/KCq54
	 RILTD1cvM1PXSgeKxp6Rt+DhEko51DdhXmUOF9UVPLf/5CQTjxekE4VpMxp3aKibTx
	 3ANrzOydzjiIoS50uD+e4udga3RYHouElSiEAkfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfBVRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVRqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:46:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459E520700;
        Fri, 22 Feb 2019 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550857584;
        bh=FKwqrUUguu6NXIhqOpxtDvpDKNPuz1Ra3atbXUUhTWc=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=mJjR4trVsbcC/03rAfScJB4DuFBnG1OW7vXMZZ3kZ3m5PEI2xnEILwW2h6LPsvcbn
         5F8/SHFwx1P3JsDdkiiGxd9skUIEbR3sPvGGgo8h9F7WSMF4q0F1B5Duy76Y1xvF29
         /0J9CnP5GAXIelVhFL4gvpoQWLjH1fk6/iFbf7rU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Message-ID: <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Date:   Fri, 22 Feb 2019 09:46:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-22 09:07:32)
> Make the entire combination of plls to be one single clock. The parents u=
sed
> for bypasses are specified each as an index in the parents list.
> The determine_rate does a lookup throughout all the possible combinations
> for all the divs and returns the best possible 'setup' which in turn is u=
sed
> by set_rate later to set up all the divs and bypasses.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>

I suspect these tested by and acked tags should have been dropped,
unless you discussed and tested off-list?

