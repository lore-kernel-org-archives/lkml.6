Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881DD20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gNHhiHvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881DD20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKZUAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:00:05 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:45291 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:00:05 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wAQ96R3m027687;
        Mon, 26 Nov 2018 18:06:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAQ96R3m027687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543223188;
        bh=3yrttje3Lo8lp3aPcMiPLp29pQqesw4fxLAh89FC+aE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNHhiHvhUCiYVqL5c7ngPcAR8HhmD770hqjqLLX0hNbVBMkeA5ucv06dnbtB5z6/+
         NCpVjojwRZKsb41EfL4BOH36z6Q7DKhuhtGNp9xr3v/g4z43QG0NKbxXbp+xoEEBGU
         Pz6g5NsxWwhlBGfPI23mj6l/qx/eD0yJNbXDk6sYe/yTF9swZ442tvmZrlZgngH9Pn
         GwWNsZ7n97kvYN5yovFjqVV9m6+gq60ZuuFBulQTPaRIezkk5ZBcVBtaPttH0Zys8G
         qZJnXsLwMw7VquvVFea/kSCwUYxy3jxXv58G3Wm+9nHLVx4/g02/JrY28/LONJTcKs
         1Wb9AGmRFLeoQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id x64so10810641vsa.5;
        Mon, 26 Nov 2018 01:06:27 -0800 (PST)
X-Gm-Message-State: AGRZ1gLtRdwsENXZWN5wKftGA6zuQVnhff5Tn7ZY37VPt3Rl/uYW1rLx
        //IHAtTDwP+WaJ/916Nbj20kq9eiuTP4nWaYa04=
X-Google-Smtp-Source: AJdET5cCG45bQvi5nMakiZ2byFrkMDsYs7ofVM083qQisX/kH35N/sqVqEE67SOjD0GNGcQVpz3qyLngMhICxg6c47M=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr11126394vsb.155.1543223186179;
 Mon, 26 Nov 2018 01:06:26 -0800 (PST)
MIME-Version: 1.0
References: <1543216969-2227-1-git-send-email-yamada.masahiro@socionext.com> <201811261636.PY7IBywo%fengguang.wu@intel.com>
In-Reply-To: <201811261636.PY7IBywo%fengguang.wu@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Nov 2018 18:05:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkTm4kLSwtF_jDCHSayy5mAMHyNhekA2T5meDTRrVmFg@mail.gmail.com>
Message-ID: <CAK7LNAQkTm4kLSwtF_jDCHSayy5mAMHyNhekA2T5meDTRrVmFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: fix reverse dependency with tristate if-conditional
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Taehee Yoo <ap420073@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 5:17 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on masahiroy/kconfig]
> [also build test ERROR on v4.20-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kconfig-fix-reverse-dependency-with-tristate-if-conditional/20181126-152716
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig
> config: i386-randconfig-s1-201847 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):


OK, this is not so easy to fix as I expected.


UML is not defined at all for i386,

'UML != n' is evaluated to 'y'.


I need to think about how to fix this.








>    drivers/input//mouse/synaptics.c: In function 'synaptics_create_intertouch':
> >> drivers/input//mouse/synaptics.c:1754:9: error: implicit declaration of function 'psmouse_smbus_init' [-Werror=implicit-function-declaration]
>      return psmouse_smbus_init(psmouse, &intertouch_board,
>             ^~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +/psmouse_smbus_init +1754 drivers/input//mouse/synaptics.c
>
> e839ffab Benjamin Tissoires 2017-03-02  1728
> e839ffab Benjamin Tissoires 2017-03-02  1729  static int synaptics_create_intertouch(struct psmouse *psmouse,
> e839ffab Benjamin Tissoires 2017-03-02  1730                                   struct synaptics_device_info *info,
> e839ffab Benjamin Tissoires 2017-03-02  1731                                   bool leave_breadcrumbs)
> e839ffab Benjamin Tissoires 2017-03-02  1732  {
> e839ffab Benjamin Tissoires 2017-03-02  1733    bool topbuttonpad =
> e839ffab Benjamin Tissoires 2017-03-02  1734            psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
> e839ffab Benjamin Tissoires 2017-03-02  1735            !SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
> e839ffab Benjamin Tissoires 2017-03-02  1736    const struct rmi_device_platform_data pdata = {
> e839ffab Benjamin Tissoires 2017-03-02  1737            .sensor_pdata = {
> e839ffab Benjamin Tissoires 2017-03-02  1738                    .sensor_type = rmi_sensor_touchpad,
> e839ffab Benjamin Tissoires 2017-03-02  1739                    .axis_align.flip_y = true,
> 2b30297d Andrew Duggan      2017-10-09  1740                    .kernel_tracking = false,
> e839ffab Benjamin Tissoires 2017-03-02  1741                    .topbuttonpad = topbuttonpad,
> e839ffab Benjamin Tissoires 2017-03-02  1742            },
> e839ffab Benjamin Tissoires 2017-03-02  1743            .f30_data = {
> e839ffab Benjamin Tissoires 2017-03-02  1744                    .buttonpad = SYN_CAP_CLICKPAD(info->ext_cap_0c),
> e839ffab Benjamin Tissoires 2017-03-02  1745                    .trackstick_buttons =
> e839ffab Benjamin Tissoires 2017-03-02  1746                            !!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10),
> e839ffab Benjamin Tissoires 2017-03-02  1747            },
> e839ffab Benjamin Tissoires 2017-03-02  1748    };
> e839ffab Benjamin Tissoires 2017-03-02  1749    const struct i2c_board_info intertouch_board = {
> e839ffab Benjamin Tissoires 2017-03-02  1750            I2C_BOARD_INFO("rmi4_smbus", 0x2c),
> e839ffab Benjamin Tissoires 2017-03-02  1751            .flags = I2C_CLIENT_HOST_NOTIFY,
> e839ffab Benjamin Tissoires 2017-03-02  1752    };
> e839ffab Benjamin Tissoires 2017-03-02  1753
> e839ffab Benjamin Tissoires 2017-03-02 @1754    return psmouse_smbus_init(psmouse, &intertouch_board,
> bf232e46 Benjamin Tissoires 2018-05-22  1755                              &pdata, sizeof(pdata), true,
> e839ffab Benjamin Tissoires 2017-03-02  1756                              leave_breadcrumbs);
> e839ffab Benjamin Tissoires 2017-03-02  1757  }
> e839ffab Benjamin Tissoires 2017-03-02  1758
>
> :::::: The code at line 1754 was first introduced by commit
> :::::: e839ffab028981ac77f650faf8c84f16e1719738 Input: synaptics - add support for Intertouch devices
>
> :::::: TO: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> :::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Best Regards
Masahiro Yamada
