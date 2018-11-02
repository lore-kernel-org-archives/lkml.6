Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8380C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D9B20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTCJt03L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D9B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeKCBNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCBNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:13:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B6320657;
        Fri,  2 Nov 2018 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541174732;
        bh=Xzo2ah8+MOWC5eFrU2QkwjlZM1tsEzvBnGDVebFj1tM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KTCJt03L8wHXFUKn53H1R4PdWG6wjDuMAjodw6hNlKIl4Q79+WBde2DwAo6X8X4u8
         qoQKWJ7Gd9WQfAeu+K3h4AUrHWobzgOA9PmxxWH0kqpcrQsTiEURjzQabEZCX72tpT
         quU/iZl2Qwa4egpaQlGUwCSYe8hPYJzlkmBYrIx8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAPybu_3AGAYx2YKSuRvaNVBFSVkRVoOEa7oPaOAwuTDWK6drjQ@mail.gmail.com>
Cc:     Alan Tull <atull@kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
 <154111534593.88331.1129843003477644482@swboyd.mtv.corp.google.com>
 <CAPybu_3AGAYx2YKSuRvaNVBFSVkRVoOEa7oPaOAwuTDWK6drjQ@mail.gmail.com>
Message-ID: <154117473137.88331.9628947623071045450@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/5] Implement devm_of_clk_add_provider
Date:   Fri, 02 Nov 2018 09:05:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Ribalda Delgado (2018-11-01 23:54:50)
> Hi Stephen
> On Fri, Nov 2, 2018 at 12:35 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Ricardo Ribalda Delgado (2018-11-01 07:40:39)
> > > All Tull reported that there might be a great ammount of drivers with
> > > imbalance on clk_add_provider. This is an issue for Device tree overl=
ays
> > > (and also a bug) https://lkml.org/lkml/2018/10/18/1103
> > >
> > > This patchset implement a devm_ function of of_clk_add_provider, and
> > > fixes 3 drivers.
> > >
> > > Drivers like clk-gpio will be easily fixed with coccinelle if this set
> > > is accepted. (I volunteer, I want to learn how to use it, just seen t=
he
> > > great presentations from Julia).
> >
> > We already have devm_of_clk_add_hw_provider(), so any instances of
> > of_clk_add_provider() should be replaced with that, instead of
> > propagating the usage of of_clk_add_provider() any further. I'll gladly
> > apply patches to convert drivers from struct clk based APIs to struct
> > clk_hw based APIs so that we can clearly split clk providers from clk
> > consumers. So if you're interested in working on some coccinelle script
> > for that it would be great!
> >
> =

> Will look into that.
> Can you take a look to 1/5 of this patchset? I believe that it is
> valid even if we do not take 2-5.

Sure. Again, that patch is combining code that we eventually want to
delete, so while it is a nice 9 line reduction, it again goes in the
wrong direction by merging two functions together that we'll want to
unmerge later when one of the functions is removed. I'd rather see
effort put into converting all drivers than merging deprecated code.

