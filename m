Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096D8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453420841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g469m/0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A453420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIAX0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 19:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeIAX0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 19:26:25 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171CB20837;
        Sat,  1 Sep 2018 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535829207;
        bh=mHmApmJc+Fxf0m2OAvoQ25drvynAFgdeIkVG995DRaI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=g469m/0MtW79scrl3tO/3S8+nxCTRUP+NEB1M9q0U7+dTPG5Vz9cpc+cD52Jjef5+
         J2XCz2YPNEKWC4CcCm55eFWxL3IoxYU57F48YC+hFgQht0gKjikazttSsWbFYCM/ZA
         Brh0TdsUz5iohzHxatiC9H9BsyoJSfAyR/QUTEy4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180831102123.GA2472@localhost.localdomain>
Cc:     kbuild-all@01.org, corbet@lwn.net, mturquette@baylibre.com,
        linux@armlinux.org.uk, andrew.smirnov@gmail.com, robh@kernel.org,
        sre@kernel.org, linux@roeck-us.net, sjhuang@iluvatar.ai,
        mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
 <20180831102123.GA2472@localhost.localdomain>
Message-ID: <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC
 clock
Date:   Sat, 01 Sep 2018 12:13:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-08-31 03:21:23)
> Hello All,
> =

> Just wanted to point out for the reviewers that this patch depends on
> not yet accepted MFD/regulator patch. (struct/defines in
> include/linux/mfd/rohm-bd718x7.h were changed)
> https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen@fi.rohm=
europe.com/
> =

> On Fri, Aug 31, 2018 at 09:18:19AM +0800, kbuild test robot wrote:
> > Hi Matti,
> > =

> > Thank you for the patch! Yet something to improve:
> > =

> > [auto build test ERROR on clk/clk-next]
> > [also build test ERROR on v4.19-rc1 next-20180830]
> > [if your patch is applied to the wrong git tree, please drop us a note =
to help improve the system]
> =

> Thus this error was expected. What is the generally best way to work
> when there is changes to more than one subsystem? With this approach
> the patch set here won't compile until MFD part gets applied. But if
> I use old definitions/structs here, then clk tree gets broken when
> MFD/regulator part changes defines. I see only bad and worse options =3D)
> Anyways, I guess sending this patch with new defines (and applying it
> only after MFD) is still better than applying this with old defines and
> breaking it when MFD changes. (Assuming all of the patches get applied
> at some point).
> =


Does anything besides the clk driver need the defines that are in the
header which are used in this file? If not, then it's better to put
those defines in the C file for the clk driver so we don't have to hop
between files and have merge dependencies. Also, the regmap could
possibly by grabbed from the dev->parent pointer instead of passing it
down through an mfd structure, allowing this driver to be more generic
assuming it is always a child of some mfd device that has a regmap.

