Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD93C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9545920882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548796574;
	bh=KT7Gwov4ZiqUUMyByf5Q3HPDsRLms8N27mSa7zlDwK4=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=ejKHIWH2uK4oxUw3qXkJUA3ZDFsqn3e//HDjzClqXuSImhbCmVAIIsUadsp5nb6VM
	 ywHwj9Qhql4GDuGUnuJOrFejcBZNt2HikXuiCMfCa+2ibmHYv9QkPhdsP7vgHNcak2
	 FM95i/sZvabxSNhTc3ia3DrfW30UjZTn84FeCHIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfA2VQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfA2VQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:16:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFAF920881;
        Tue, 29 Jan 2019 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548796572;
        bh=KT7Gwov4ZiqUUMyByf5Q3HPDsRLms8N27mSa7zlDwK4=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=KH6m8ojVZrCCaJPU5MBNObR4z6AHJ7MPct0rRjLfjYzGlpQIwoV0w3oe7Jnzzir/l
         5v9uIC4cZogqwDqO6E6ybiDNLPt0tInTfh49zgzFeAMaBmMHqQhOR4BVDH6cQVSq37
         WEb3YE9/PvuZ/FY492PHXLKviD6mjtn5W4hCeQYE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: ingenic: jz4740: Fix gating of UDC clock
References: <20190125153436.13517-1-paul@crapouillou.net> <154844250661.136743.15303302299846585853@swboyd.mtv.corp.google.com> <1548444298.1804.2@crapouillou.net> <154878559039.136743.10189442694979275708@swboyd.mtv.corp.google.com> <1548789745.2531.0@crapouillou.net>
User-Agent: alot/0.8
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548789745.2531.0@crapouillou.net>
Message-ID: <154879657128.136743.2772783193736020021@swboyd.mtv.corp.google.com>
To:     Paul Cercueil <paul@crapouillou.net>
Date:   Tue, 29 Jan 2019 13:16:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-01-29 11:22:25)
> Hi,
>=20
> Le mar. 29 janv. 2019 =C3=A0 15:13, Stephen Boyd <sboyd@kernel.org> a=20
> =C3=A9crit :
> > Quoting Paul Cercueil (2019-01-25 11:24:58)
> >>  Hi,
> >>=20
> >>=20
> >>  On Fri, Jan 25, 2019 at 3:55 PM, Stephen Boyd <sboyd@kernel.org>=20
> >> wrote:
> >>  > Quoting Paul Cercueil (2019-01-25 07:34:36)
> >>  >>  The UDC clock is gated when the bit is cleared, not when it is=20
> >> set.
> >>  >>
> >>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net
> >>  >> <mailto:paul@crapouillou.net>>
> >>  >>  Tested-by: Artur Rojek <contact@artur-rojek.eu
> >>  >> <mailto:contact@artur-rojek.eu>>
> >>  >>  ---
> >>  >
> >>  > Any Fixes tag for this?
> >>  >
> >>=20
> >>  Fixes: 2b555a4b9cae
> >>=20
> >>  Should I resend?
> >>=20
> >=20
> > No need to resend. Is this fixing something that's broken in the=20
> > v5.0-rc
> > series? I'm trying to understand if this is a critical fix or a
> > non-critical fix that can bake until the next release cycle.
>=20
> It's been broken for one year and nobody noticed, it can wait for 5.1.
>=20

Ok, thanks!

