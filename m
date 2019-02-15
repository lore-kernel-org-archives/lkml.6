Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530521924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550265218;
	bh=gq1vIpAQ5xhaJCbqZE7MY8qByqFbm3xYfjPjYDHgrOY=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=DjmvX+hPb/qJpyFDTBk7xR47+G11kSpsrm2wuXyW5FHgvu8MM/p9397CADQuudNMJ
	 InV4OGW+7zzSFELFe7PKmUAZsts2BRufuG4A6fgedeMrBGWlj/1JcM/EYnU3EmN3Dr
	 g33kaq3tsnXuG5DNbkgHADRDfLgJ0RQQAFFfZry8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391895AbfBOVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbfBOVNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:13:33 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE5121924;
        Fri, 15 Feb 2019 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550265212;
        bh=gq1vIpAQ5xhaJCbqZE7MY8qByqFbm3xYfjPjYDHgrOY=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=AbJ5MivR1nRCYWcnke33d+NdocuoJ3tHCZmL5l+yPeiRVQ+idUUBst5/PToBnTVNZ
         33dWebsuyrAs/tOKaBMbUvv4IboFf7/3VRNyBWKlpz5ewQRQqFIWN5ZYBkrC/1aHAO
         P7V6bXGhNJA6OWAg1tALPPLl236vXV59Q6uYNQXs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <121ae6212cd555bc784af675d63f6b190c0bee10.camel@baylibre.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 7/9] clk: Allow parents to be specified without string names
Message-ID: <155026521168.115909.10774224013908368981@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-8-sboyd@kernel.org> <2f88e7fb1788f68f7b97d9806d56f9271663bdfc.camel@baylibre.com> <154878820913.136743.9860407353339842831@swboyd.mtv.corp.google.com> <121ae6212cd555bc784af675d63f6b190c0bee10.camel@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 13:13:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-02-13 01:32:23)
> On Tue, 2019-01-29 at 10:56 -0800, Stephen Boyd wrote:
> > > > +/**
> > > > + * struct clk_parent_data - clk parent information
> > > > + * @hw: parent clk_hw pointer (used for clk providers with internal
> > > > clks)
> > > > + * @name: parent name local to provider registering clk
> > > > + * @fallback: globally unique parent name (used as a fallback)
> > > > + */
> > > > +struct clk_parent_data {
> > > > +     struct clk_hw   *hw;
> > > > +     const char      *name;
> > > > +     const char      *fallback;
>=20
> One last nitpick about this structure, because I did not figure it out at
> first.
>=20
> 'fallback' is what we known as 'name' in CCF so far.
>=20
> What do you think about renaming 'fallback' to 'name' and 'name' to somet=
hing
> more obvious, like 'of_name' or 'fw_name' or something else ?

Ok. I'm not super fond of assuming it's the DT specific, so maybe
fw_name is good, or ext_name for external name? Or con_id to match
clkdev?

>=20
> > >=20
> > > If I understand correctly, .name and .fallback will be ignored if hw =
is
> > > provided ? Maybe this should be documented somehow ?
> >=20
> > Sure. I'll add some documentation to the long portion of the kernel-doc
> > here describing priority order.
>=20
> Anyway, with this patch, I should be able to remove a lot of (ugly) code I
> have been writting lately. I'll be happy to test it when you have a v2 re=
ady.
>=20

Great!

