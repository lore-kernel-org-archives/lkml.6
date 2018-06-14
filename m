Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2E7C3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="A1eWnVqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D5D208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936043AbeFNMMU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:12:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:29467 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755019AbeFNMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1528978336;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9dsFI8NgmGoKWoyaViAev9zIcWAucoaRqh4Jp/IAwFk=;
        b=A1eWnVqCvniw2ym2oSfNUJykCs+ZQ2uqMNDR2duc5x4D/zORY/nFxyJuqnsedjzPNg
        fW7S8+TbMj3Likt4IhgYQlyi9idIjIXJIn3lTwCxpE1TY9ZdGGsYnkJF+yG0XXc01a+z
        CRM5UgxB5xbcE/YqzAWBj+8bk7yy5lrn5TpB7LHt6rvsmuDoMCGvqGdTTOdpJnJUQtbE
        ZKBAJqb4bauZqKtzdImZL6I+41URft5lLvUuqqU525MKHs7i1lFVmkJtB6Sza9yrEkk8
        H+LmCobtEbnGxvAWH2mRROyux++A+/qeCBXIL1G3P1IniBCBkVMkdGwlygMFB05036Z4
        2etA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN2EjaY"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id 407f97u5ECCFRm1
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 14 Jun 2018 14:12:15 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180614120157.GE112168@atomide.com>
Date:   Thu, 14 Jun 2018 14:12:14 +0200
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com> <20180614120157.GE112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 14.06.2018 um 14:01 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [180613 12:41]:
>>=20
>> Now if I look into pinctrl_generic_add_group() and =
pinctrl_generic_get_group_name(),
>> pctldev->num_groups++ is not protected if pinctrl_generic_add_group() =
may be called by
>> two threads in parallel for the same pctldev. Hence a second thread =
may try to insert
>> a different node into the radix tree at the same selector index. This =
fails but there
>> is no error check - and the second entry is completely missing (but =
probably assumed to
>> be there).
>=20
> Sounds like pinctrl-single.c is missing mutex around calls to
> pinctrl_generic_add_group()?

Yes, that could be. I didn't research the call path, just the one of
devm_pinctrl_get(). That uses a mutex in

=
https://elixir.bootlin.com/linux/v4.17.1/source/drivers/pinctrl/core.c#L10=
21

Maybe a similar mutex is missing elsewhere.

BR,
Nikolaus

