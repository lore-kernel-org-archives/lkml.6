Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A75C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4052075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ml1wgbMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4052075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936040AbeFRSa2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:30:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:24160 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935793AbeFRSaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529346623;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DQzZGpF4a17fuNCHJRQdBlxsq08yXTJ/ASNTGqqcEVs=;
        b=ml1wgbMRuyNVpZYoEE121GYU0/jjMMzQXr+otYGjFiw5Bi08mlvTybeDRhraGqoyzb
        e21rVeEo9Mhdi/UcMrLO2ifLuDY9sPgZF7tl0SmHdErVWUJawOCiAx/yo+kp6ucDHR2T
        2a5TNL3hdI6W5glFTbNHABTRy5Zg3du7ZnUq8nM7220KSZ+coDt0d7t0XNXirXI3hY5G
        qdIAehOpq0PIgML+wzNXqgrmZCCTER52svrX/nOb4tSYS1In6wD1TprCYAxkohDPY/5w
        RLpwtQzocRiAJtRBU1UPQqu7CnKPCR4/TmxHYNZ7S/x/GYdpWfGdZ7J8xdR4wwBkI5/u
        ycSg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qEjr9Tw=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5IIUIGE6
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Jun 2018 20:30:18 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180618181744.GS112168@atomide.com>
Date:   Mon, 18 Jun 2018 20:30:17 +0200
Cc:     Christ van Willegen <cvwillegen@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com>
References: <20180615111318.GJ112168@atomide.com> <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com> <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com> <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com> <20180618091433.GP112168@atomide.com> <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com> <20180618095428.GQ112168@atomide.com> <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com> <20180618115122.GT26255@atomide.com> <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com> <20180618181744.GS112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 18.06.2018 um 20:17 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [180618 16:46]:
>=20
>>=20
>> I can also demonstrate that the duplication has gone:
>=20
> OK good to hear.
>=20
>> And I was no longer able to reproduce the strcmp(NULL) issue. So it =
is either better hidden
>> or gone.
>=20
> It should not be possible with checks preventing registering
> a group or function with no name. I'll try to repost the whole
> series tomorrow with that added.

Fine.

>=20
>> So code just needs group cleanup on failed probing and fixing the =
mutex around pinctrl_generic_add_group().
>>=20
>> I think we need the mutex because a race still can happen when =
create_pinctrl() is calling pcs_dt_node_to_map()
>> and pinctrl_generic_add_group() w/o being locked on =
pinctrl_maps_mutex.
>>=20
>> The race I suspect is that two drivers are trying to insert the same =
name and may come
>> both to the conclusion that it does not yet exist. And both insert =
into the radix tree.
>>=20
>> The window of risk is small though... It is in =
pinctrl_generic_add_group() between calling
>> pinctrl_generic_group_name_to_selector() and radix_tree_insert() so =
we probably won't
>> see it in real hardware tests.
>=20
> Hmm but that race should be already fixed with mutex held
> by the pin controller drivers with these fixes? Or am I
> missing something still?

Hm. Maybe we refer to a different mutex?

I had seen the call sequence

create_pinctrl()-> pinctrl_dt_to_map() -> pcs_dt_node_to_map() -> =
pinctrl_generic_add_group()

w/o any lock inside.

There is a mutex_lock(&pinctrl_maps_mutex); in create_pinctrl(), but =
locked after that.

Or is there a lock outside of create_pinctrl()?

If I look into the stack dumps, call nesting is

driver_probe_device() -> pinctrl_bind_pins() -> devm_pinctrl_get() -> =
create_pinctrl()

They all do no locking.

Maybe I am missing something.

BR,
Nikolaus


