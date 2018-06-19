Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146EBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF72C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="EQ17nm3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF72C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755546AbeFSEvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:51:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:20432 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeFSEvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529383900;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=e06hDtnhUtZyVTlHtfmv5+5+dIYeggxaNUiuOZLzYSg=;
        b=EQ17nm3FzxlRsUBnCjVxrEhJAMnD8e5WIVywklDBuXusC3BT4dKvcG7scjL8IGbauG
        AIHFpC8NXdi2heWTwxaTc9PTH4Ze0ZSOXd96mauVFGD/at5yFH1RDb6HQJjsh8EIkn7V
        z4LfzPeGyo5UPyp8B6GXGZ3qcHkd/lBSOu757QxwMu+3VuhLh7utKJdPqiTpkcHME1Yb
        yL2AfsbVILK+7u6DHv6tM0aQUL+vp69pdL09vk8b1iRE2QaF6O0CvSplReOxAXR/IZHo
        Q+Xr4NQGZd0EgrtcDSXFuSh1d6xKmfClHG4KChdvmcLIJebjrXiRVNgkEvUP7T6Cb//J
        g9rA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN1FjmY"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5J4pVHGz
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 19 Jun 2018 06:51:31 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180619043408.GT112168@atomide.com>
Date:   Tue, 19 Jun 2018 06:51:31 +0200
Cc:     Christ van Willegen <cvwillegen@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <631A1D2F-093A-498F-8923-FC9CD20E11A8@goldelico.com>
References: <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com> <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com> <20180618091433.GP112168@atomide.com> <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com> <20180618095428.GQ112168@atomide.com> <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com> <20180618115122.GT26255@atomide.com> <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com> <20180618181744.GS112168@atomide.com> <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com> <20180619043408.GT112168@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 19.06.2018 um 06:34 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [180618 18:33]:
>>>> So code just needs group cleanup on failed probing and fixing the =
mutex around pinctrl_generic_add_group().
>>>>=20
>>>> I think we need the mutex because a race still can happen when =
create_pinctrl() is calling pcs_dt_node_to_map()
>>>> and pinctrl_generic_add_group() w/o being locked on =
pinctrl_maps_mutex.
>>>>=20
>>>> The race I suspect is that two drivers are trying to insert the =
same name and may come
>>>> both to the conclusion that it does not yet exist. And both insert =
into the radix tree.
>>>>=20
>>>> The window of risk is small though... It is in =
pinctrl_generic_add_group() between calling
>>>> pinctrl_generic_group_name_to_selector() and radix_tree_insert() so =
we probably won't
>>>> see it in real hardware tests.
>>>=20
>>> Hmm but that race should be already fixed with mutex held
>>> by the pin controller drivers with these fixes? Or am I
>>> missing something still?
>>=20
>> Hm. Maybe we refer to a different mutex?
>=20
> Yes I think that's the case, you're talking about a different
> mutex here :)
>=20
>> I had seen the call sequence
>>=20
>> create_pinctrl()-> pinctrl_dt_to_map() -> pcs_dt_node_to_map() -> =
pinctrl_generic_add_group()
>>=20
>> w/o any lock inside.
>>=20
>> There is a mutex_lock(&pinctrl_maps_mutex); in create_pinctrl(), but =
locked after that.
>>=20
>> Or is there a lock outside of create_pinctrl()?
>>=20
>> If I look into the stack dumps, call nesting is
>>=20
>> driver_probe_device() -> pinctrl_bind_pins() -> devm_pinctrl_get() -> =
create_pinctrl()
>>=20
>> They all do no locking.
>>=20
>> Maybe I am missing something.
>=20
> Can you please post a patch for that as you already have it
> debugged? That's easier to understand than reading a verbal
> patch :)

I have no patch for it and all tests were without, but I can suggest a =
change which IMHO
could solve it:

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index eb2b217f5e1e..7d125f9a7804 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1037,15 +1037,16 @@ static struct pinctrl *create_pinctrl(struct =
device *dev,
        INIT_LIST_HEAD(&p->states);
        INIT_LIST_HEAD(&p->dt_maps);
=20
+       mutex_lock(&pinctrl_maps_mutex);
        ret =3D pinctrl_dt_to_map(p, pctldev);
        if (ret < 0) {
                kfree(p);
+               mutex_unlock(&pinctrl_maps_mutex);
                return ERR_PTR(ret);
        }
=20
        devname =3D dev_name(dev);
=20
-       mutex_lock(&pinctrl_maps_mutex);
        /* Iterate over the pin control maps to locate the right ones */
        for_each_maps(maps_node, i, map) {
                /* Map must be for this device */

Description: we should also protect pinctrl_dt_to_map(), which calls =
pinctrl_generic_add_group()
and the calls inside pinctrl_generic_add_group() to =
pinctrl_generic_group_name_to_selector()
and radix_tree_insert() with a mutex.

But I haven't tested this case (because it is unlikely to happen and be =
testable).

BR,
Nikolaus

