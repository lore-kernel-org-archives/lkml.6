Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C373D20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8m+1kHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C373D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeLDWeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDWeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:34:37 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7308F20850;
        Tue,  4 Dec 2018 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543962876;
        bh=jS8StQMa3BUE62Zzh9us93WzTTsdLclQIEBoUphweFE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=u8m+1kHRX6QfiIh7dauftG2afWM8/xp+oIrRj4m0+Ctgw8lKirnUcPamrJgA1e/MD
         UEhnelhzhLRB0ocx7RoHHSIGzSutq4a2ONhFblIyZnlO+pbLuxut5EzisH+bhI1R4R
         4GHcTwnBGOKlKImhWFyDLPyJ7f+5fiXi1Oxibtgc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <38e17678c713c2bde0967ac34349436fffe033dd.camel@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181204163403.32321-1-jbrunet@baylibre.com>
 <154394899913.88331.6973889205055781649@swboyd.mtv.corp.google.com>
 <38e17678c713c2bde0967ac34349436fffe033dd.camel@baylibre.com>
Message-ID: <154396287588.88331.2840230818482804190@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: fix clk_mux_val_to_index() error value
Date:   Tue, 04 Dec 2018 14:34:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-04 11:55:10)
> On Tue, 2018-12-04 at 10:43 -0800, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2018-12-04 08:34:03)
> > > clk_mux_val_to_index() is meant to be used by .get_parent(), which
> > > returns a u8, so when the value provided does not map to any valid in=
dex,
> > > it is not a good idea to return a negative error value.
> > > =

> > > Instead, return num_parents which we know is an invalid index and let
> > > CCF deal with it.
> > > =

> > > Fixes: 77deb66d262f ("clk: mux: add helper function for index/value
> > > translation")
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > =

> > Thanks!
> > =

> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provide=
r.h
> > > index 60c51871b04b..fc20886ef069 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -550,8 +550,8 @@ struct clk_hw *clk_hw_register_mux_table(struct d=
evice
> > > *dev, const char *name,
> > >                 void __iomem *reg, u8 shift, u32 mask,
> > >                 u8 clk_mux_flags, u32 *table, spinlock_t *lock);
> > >  =

> > > -int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int
> > > flags,
> > > -                        unsigned int val);
> > > +u8 clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int
> > > flags,
> > =

> > I wonder if we should just make this unsigned int? Does it hurt at all
> > to have it be a wider type even though it doesn't match the CCF decision
> > to make this a u8 for the parent index number space?
> > =

> =

> I also wondered about this but since the target is get_parent(), I just
> aligned the two.
> =

> In the end, I don't really care, as you prefer. Just let me know if you w=
ould
> like a v2 with this change
> =


Ok I may just make it unsigned int when applying then.

