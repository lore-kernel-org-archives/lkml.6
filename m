Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CDA208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="exr5RKGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CDA208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeFRQnz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:43:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:15556 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755347AbeFRQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529340232;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=A+9hkhgKSYgaqChb14ur8pVFZR3ZNCF/nCuWMhWzOAY=;
        b=exr5RKGKpXuZ/WbrVxAlNWxc02MCrQGx8AiL+5zu8Gc45ntfooNKHp1uTtW5x+c27o
        MC3hfuY1zDB/K+LPaJUKexeIBLoSn+Iab87npnVYnPsTTdWRRzUfc4Tgi3+Afz4tyrzS
        9KnOfRejhSK15Ks3nZrMwWemDB6cpfQki+dyH3Bjoacaf/caquP62xdZm7v8/A5okQmp
        Eirlj5scC2OS8nJyCH710SliLySvL2giBanq4SPZRr2lcnW5jsKA+UWfTXubW73X1Tf9
        CI92fzV0xGb/SzSQ+oVfRKJk8j3PDoycu3Gs43WS5z14VJXWHn7G8fzGesPszuToUntA
        7PQw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qEjr9Tw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5IGhoFuD
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Jun 2018 18:43:50 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in pinctrl_groups and deferred probing
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180618115122.GT26255@atomide.com>
Date:   Mon, 18 Jun 2018 18:43:49 +0200
Cc:     Christ van Willegen <cvwillegen@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com>
References: <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com> <20180615065810.GI112168@atomide.com> <20180615111318.GJ112168@atomide.com> <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com> <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com> <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com> <20180618091433.GP112168@atomide.com> <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com> <20180618095428.GQ112168@atomide.com> <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com> <20180618115122.GT26255@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 18.06.2018 um 13:51 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * Christ van Willegen <cvwillegen@gmail.com> [180618 10:01]:
>>> --- a/drivers/pinctrl/core.c
>>> +++ b/drivers/pinctrl/core.c
>>> +               if (!strcmp(function, gname))
>>=20
>>=20
>> This could never fail? gname guaranteed to never =3D=3D NULL?

If there are no duplicates and stale entries any more, gname must
be valid.

>=20
> Thanks I'll add checks to make sure we always have a valid
> name for new functions and groups added.

Well, not having checks is the cheapest debugging tool that does not
even need to be enabled because strcmp(NULL) checks come for free :)

Jokes aside, I now have tested the latest patch and it seems to solve =
the issues :) :) :)

I can also demonstrate that the duplication has gone:

root@letux:~# dmesg|fgrep generic_add
[    0.747436] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_hsusb2_pins selector=3D0
[    0.750671] pinctrl_generic_add_group: pctldev=3Dee486f80 =
name=3Dpinmux_hsusb2_2_pins selector=3D0
[    0.751403] pinctrl_generic_add_group: pctldev=3Dee486e00 =
name=3Dpinmux_mcbsp1_devconf0_pins selector=3D0
[    0.752227] pinctrl_generic_add_group: pctldev=3Dee486d00 =
name=3Dpinmux_tv_acbias_devconf1_pins selector=3D0
[    0.769104] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_uart1_pins selector=3D1
[    0.770874] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_uart2_pins selector=3D2
[    0.772003] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_uart3_pins selector=3D3
[    1.799316] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_twl4030_pins selector=3D4
[    1.808624] pinctrl_generic_add_group: pctldev=3Dee446000 =
name=3Dpinmux_twl4030_vpins selector=3D0
[    1.978912] pinctrl_generic_add_group: pctldev=3Dee486f80 =
name=3Dspi_gpio_pinmux selector=3D1
[    2.173522] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_mmc1_pins selector=3D5
[    2.207916] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_wlan_irq_pin selector=3D6
[    2.383666] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_gpmc_pins selector=3D7
[    2.778808] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_wlan_pins selector=3D8
[    2.794708] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_bt_pins selector=3D9
[    5.405273] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_dss_dpi_pins selector=3D10
[    6.051666] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_mcbsp1_pins selector=3D11
[    6.136688] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_mcbsp2_pins selector=3D12
[    6.222015] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_mcbsp3_pins selector=3D13
[    6.261199] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_penirq_pins selector=3D14
[    6.288787] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_mcbsp4_pins selector=3D15
[    6.336700] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dhdq_pins selector=3D16
[    6.607788] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_camera_pins selector=3D17
[    6.900848] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dbacklight_pins_pinmux selector=3D18
[    7.298217] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dmodem_pins selector=3D19
[    8.134826] pinctrl_generic_add_group: pctldev=3Dee446180 =
name=3Dpinmux_pps_pins selector=3D20
root@letux:~#

And I was no longer able to reproduce the strcmp(NULL) issue. So it is =
either better hidden
or gone.

So code just needs group cleanup on failed probing and fixing the mutex =
around pinctrl_generic_add_group().

I think we need the mutex because a race still can happen when =
create_pinctrl() is calling pcs_dt_node_to_map()
and pinctrl_generic_add_group() w/o being locked on pinctrl_maps_mutex.

The race I suspect is that two drivers are trying to insert the same =
name and may come
both to the conclusion that it does not yet exist. And both insert into =
the radix tree.

The window of risk is small though... It is in =
pinctrl_generic_add_group() between calling
pinctrl_generic_group_name_to_selector() and radix_tree_insert() so we =
probably won't
see it in real hardware tests.

Anyhow, I'll apply the patches as "hacks" to the LetuxOS kernel (4.17.x =
and 4.18-rc1) so that
more users can test. And we can replace them if they are finally =
accepted upstream.

BR and thanks for fixing the bug,
Nikolaus

