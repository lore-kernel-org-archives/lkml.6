Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F52C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39C12082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxh6dvBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39C12082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLDSVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDSVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:21:15 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4309A2081B;
        Tue,  4 Dec 2018 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543947674;
        bh=ji3ydNM9SAxkRfwU4F7pz7IU3OSBPHbSsD5+rB3CtjE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Mxh6dvBeoILkGY7JQWm9eHVEtdIGzc31l5mDVHjU33+gY0nmzB8039rMp/3c8DFIP
         IenYO7tNM5siEPvUG5ja6mDDge9vLVLoulcaGATqqDTEgpISHfrIxt48SMXeO+Dj05
         8O/w11s2m6SBxBKixpmDT43w9VJjjt5Bs8rTxpiI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204071315.GA31204@localhost.localdomain>
Cc:     mazziesaccount@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
 <20181204071315.GA31204@localhost.localdomain>
Message-ID: <154394767367.88331.17679291261207728780@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and provider
 registrations
Date:   Tue, 04 Dec 2018 10:21:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-03 23:13:15)
> On Mon, Dec 03, 2018 at 03:35:10PM -0800, Stephen Boyd wrote:
> =

> > If the DT doesn't have the #clock-cells property in the node being
> > registered then calling clk_get() will fail for any consumer devices
> > that point to the node with a phandle and clock specifier. I don't
> > expect us to get very far into development if that's the case.
> =

> Makes sense. So only potential thing to break is if someone out there
> has broken DT/driver - where they currently see this failure. Eg. they
> use node w/o #clock-cells as provider and where they try and fail
> controlling this clock - but ignore the error (and system just "works"
> with HW defaults). After this change they may actually succeed in
> controlling - but do control wrong clock.
> =

> Not likely scenario (sure happens somewhere) - and it involves already
> broken design. So I agree with you. Besides, you are the maintainer for
> clk framework and thus get the most of the rain if **** hits the fan =3DD

Yes, exactly.

> =

> > Of course, we don't fail in of_clk_add_provider() if there isn't a
> > #clock-cells property in the node, we just happily add the node to the
> > provider list and carry on. I doubt anyone is failing to specify the DT
> > property, but maybe they are, in which case we could keep not failing
> > and just add the node of whatever we're called with originally if
> > neither the parent or the passed node have the #clock-cells property. I
> > wouldn't try to go any higher than one node above the current node and
> > look for a #clock-cells though.
> =

> I think we should use parent device's node, not the paren node in DT,
> right? But I agree, we should only look "one level up in the chain".

Are these two things different? I'm suggesting looking at
device_node::parent and trying to find a #clock-cells property.

