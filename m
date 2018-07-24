Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96276C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB0D20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eBT9JfKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB0D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbeGXKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:23:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33182 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbeGXKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:23:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724091818euoutp029f6d9e54e2720a63f0eab872c4e23a1b~EQ2qbrC8x2432424324euoutp02q
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:18:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724091818euoutp029f6d9e54e2720a63f0eab872c4e23a1b~EQ2qbrC8x2432424324euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532423898;
        bh=Ri56D3PFpEY+fNdh7hbMcfLwCniy67mEoIdRIk82J+0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eBT9JfKvXr0kV1D3fpFR9P/mnygvG9H2pAr0LSOgrIF1pLB//IUImdRdpryfmf1gm
         uFNkr/D+Nx+Uy/8wjkS+p54+od8BkvdagANgGgAq45MzxgG8q8fMfeAVyeoqDGqKat
         K60fGLmPh2ykzDkKbKHXOg5TzHGs3ZhcBuw3bp4Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724091817eucas1p163fc0ba718f4b98ae834f7a8f4d5019f~EQ2poneba1277512775eucas1p1h;
        Tue, 24 Jul 2018 09:18:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.39.05751.9DEE65B5; Tue, 24
        Jul 2018 10:18:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180724091816eucas1p29790b3c45492b261ff154db8056fbb88~EQ2otAHnr1142511425eucas1p2l;
        Tue, 24 Jul 2018 09:18:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180724091816eusmtrp1ba33d135d985364603caf46356973e54~EQ2odYZOB0423404234eusmtrp1W;
        Tue, 24 Jul 2018 09:18:16 +0000 (GMT)
X-AuditID: cbfec7f4-c47ff70000001677-93-5b56eed9c99f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.D5.04178.8DEE65B5; Tue, 24
        Jul 2018 10:18:16 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180724091815eusmtip13d8ad46937ea1b6d916edbc32eb4427b~EQ2nqbwGa1108611086eusmtip1A;
        Tue, 24 Jul 2018 09:18:15 +0000 (GMT)
Subject: Re: [RFT v2 00/10] pinctrl: samsung: Remove ugly hack for sharing
 eint_wakeup_mask
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 24 Jul 2018 11:18:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN6yydNtQMBcINEMVGcUlARU1eqDFi+OifW+CDKlJlxAUqtgW3
        qERlsQF3Qq1AhYhAQxDZxApV2apBgUIEMUBNcJflw4oScWE6Lvydc+89755z8xhC/oUKYPZp
        DZxOq0lS0FKyoWO6O3RwIka98qNTil8VNdB4wP2Owpa2LgpfGP1E4O7uajF+dnpMjK/OlIlw
        zWg/hWstMwj32QpobOq2i3BLXjPCpQNOES6pd4vxN8d5Amc0t4lx61gWhbPefCCw1TaDNvio
        Kosqkaqv30mo7pmHxaoa6zlaNdTfRKtqb55Sna+zItXnmvmbmVjpugQuaV8ap1uxPl669+v3
        DnHK2eAjnQNDRDpygRFJGGDXgOVSI2lEUkbOliN4aM8VCcSNoG64lRDIZwTGe99mCeORlE96
        82o5WzarMIUIM5MIpiabaL7hw+6A3q46Md/wZc+RUFXg8rxEsB8QNI/wL0kYml0FxnGjR0Gy
        i+GXe0zEb/Bjt8N3m5Ivy1hveHLtNcljCbsWqt7e8UgJdgHcHS/4g/3h5WuLxzawxQwUZrQi
        QZwGQ84uQggaBc2jtygB+8BHB++Ox0HQeSWHFMRnEGSZzGKB5CCoL2ikhSkltDqcFO+OYJfB
        bdsKoRwJOXYXLZxlHrwY9xYMzYPLDfl/riWD7Ey5MB0CZkfVv7WPenqJi0hhnhPTPCeaeU40
        8/+9NxBpRf5cqj45kdOHa7nDYXpNsj5Vmxi2+2ByDZr9jJ0/He5GZJvZ1YJYBim8ZEfc0Wo5
        pUnTH01uQcAQCl9Z6vUYtVyWoDl6jNMd3KlLTeL0LSiQIRX+srilJ2PlbKLGwB3guBRO97cr
        YiQB6SgiMHxR01SxaXjJrq1Bhqj9C0tdxevj4iP3KF0jFSF+d6Lvr21fnW734jZviUzJPivf
        1L4xu8I4oSs5MVSR+SAgd/rUcaV1otZvz/PClCvW0OGgsR+OGIPP+3yT9Kl14tC0ZOqR+vFI
        Zx5l98pV1JenaSPatyktXj0Gjhqs9u8LVpD6vZpVywmdXvMbX5OcBogDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGeXd2tjNzcZyKLyZqp4IUmh51+mpm9sf2UxIFv9ClBxXdJjub
        aBCNULRlllSmS2aZUgwz3UxLUstsKpJLDS1RK10fok6o9S2VU4P9u3ie+3rggZvARFW4L1Gg
        UDMqhayI4rlxx/4Mzx96ZU9JDzV+JtBbQzcPzTg+4qhpaBxHF5dWMGS1dvDR87OrfHRl4zYH
        mZamcWRu2gBoqreRh+qt/Rw0eLUPoNaZCQ5qvu/gox/DNRiq6Bvio6erlTiqfL+MIWPvBoj3
        lLYZ2oB0anoCkz7Uz/OlJuM5nnRu+hFPam45I63pMgLpF5N/IpEmjlUpNWomMF/Jqo9Q6TQK
        E9PRSBwWES2mw6MyY8IkVEhcbC5TVFDCqELissX5339b+MXlgaVjM3OYFryBOkAQkIyAd9Y9
        dMCNEJGtAHZYeng6INic+8HROi2+zZ5wY1rH2w6tAdi+aNhaeJKZcHK8i+9ceJHnufDb7OhW
        CiOXAaxYadlRqgC0DVi37vJIGurWnLcIQkjGwbERvnPMJQ/Av45VjpO9yQz47HL5VlxIesDR
        BhvXyQJSAts/dGJOxshIaDC/2+EA2LPWuMM+cNbWxLkERHoXXe+i6F0UvYtyA3CNwIvRsPI8
        OUuLWZmc1SjyxDlKuQlstqDb8tP8AEx2Jg0CkgCUu7DUkZwuwmUlbJl8EEACo7yEmusp6SJh
        rqzsFKNSZqk0RQw7CCSbz9Vivt45ys1OKdRZtISOQtF0VHhUeCSifITW0LI0EZknUzOFDFPM
        qP57HELgqwVJMZKFPQsJGSZbccKtXT6F/S9sj09yB25SliK3/evXDi/mHp3R+5s6744WBtf0
        HqMmtNUX7jUOHMweSU6sDCrZGx/goxU023BbrV+qaZhTd7x6nJb8Up+2n5j4+ilod42wYTZV
        0+2NcPf61/Z9FktvVj8jty/Al+042WZ4IqK4bL6MDsZUrOwfJqB4YBsDAAA=
Message-Id: <20180724091816eucas1p29790b3c45492b261ff154db8056fbb88~EQ2otAHnr1142511425eucas1p2l@eucas1p2.samsung.com>
X-CMS-MailID: 20180724091816eucas1p29790b3c45492b261ff154db8056fbb88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180723175334epcas5p3e46820b4d356d4f1ea718ec1a6c093a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180723175334epcas5p3e46820b4d356d4f1ea718ec1a6c093a6
References: <CGME20180723175334epcas5p3e46820b4d356d4f1ea718ec1a6c093a6@epcas5p3.samsung.com>
        <20180723175302.22535-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-07-23 19:52, Krzysztof Kozlowski wrote:
> Hi All,
>
> Changes since v1
> ================
> 1. Add Tomasz's ack.
> 2. Reword description in patch 6/10.
>
>
> Tests
> =====
> This is both request for comments and requests for tests. Only basic
> tests were done, including suspend to RAM on Odroid U3 (Exynos4412)
> with max7768 RTC wakeup. Please kindly test it with devices capable of
> suspending and resuming. I am mostly thinking about S5Pv210-based (Aria),
> Trats, Trats2 and TM2 (Exynos5433). Existing platforms should not be
> broken however changing external interrupt wakeup mask was not done
> on Exynos5433.

Works fine on Exynos5433 TM2 with some additional patches related to
suspend/resume handling of the PMU. It handles only EINT0..EINT31 pins
for now. Exynos5433 has more external interrupt wakeup lines: EINT32-63
located at banks GPF1[0..7], GPF2[0..3], GPF3[0..3], GPF4[0..7] and
GPF5[0..7]. They can be configured as wakeup sources in
EXYNOS5433_EINT_WAKEUP_MASK1 (0x062C) PMU register. Handling of them
can be added later when it will be really needed.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Description
> ===========
> The Exynos/S5Pv210 machine suspend code needs to write the external
> interrupt mask during suspend.  The mask is controlled by pin controller
> driver: the exynos_wkup_irq_set_wake() in IRQ chip for these wakeup
> interrupts.
>
> Therefore pinctrl driver code exposed an exynos_get_eint_wake_mask()
> function which was later used as an extern in machine code.
>
> This is quite ugly way of combining driver and machine code,
> not portable triggering Sparse and GCC warnings.
>
>
> This might break suspend capability S5Pv210 on with older DTBs (thus
> breaks DTB compatibility), however:
> 1. just "might" because in case of using older DTB, the wakeup mask
>     will not be changed during suspend and default reset value (all
>     interrupts non-masked) should work,
> 2. mainline support for S5Pv210 with DTB is limited and suspend
>     to RAM already might be broken.
>
>
> Dependencies
> ============
> 1. The first seven patches should be taken through one tree,
>     preferably samsung-pinctrl,
> 2. The DTS patch (7/10) for S5Pv210 should go into next cycle,
> 3. The remaining patches (8-10) should go after all previous,
>     so probably another release cycle.
>
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (10):
>    pinctrl: samsung: Define suspend and resume callbacks for all banks
>      and SoCs
>    pinctrl: samsung: Document suspend and resume members
>    pinctrl: samsung: Document hidden requirement about one external
>      wakeup
>    pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup
>      interrupts
>    ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and
>      Exynos5433
>    pinctrl: samsung: Write external wakeup interrupt mask
>    ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup
>      compatible
>    ARM: s5pv210: Remove legacy setting of external wakeup interrupts
>    ARM: exynos: Remove legacy setting of external wakeup interrupts
>    pinctrl: samsung: Remove legacy API for handling external wakeup
>      interrupts mask
>
>   .../bindings/pinctrl/samsung-pinctrl.txt           | 11 ++-
>   arch/arm/boot/dts/s5pv210.dtsi                     |  2 +-
>   arch/arm/mach-exynos/common.h                      |  2 -
>   arch/arm/mach-exynos/suspend.c                     | 16 +++--
>   arch/arm/mach-s5pv210/common.h                     |  1 -
>   arch/arm/mach-s5pv210/pm.c                         | 16 +++--
>   drivers/pinctrl/samsung/pinctrl-exynos-arm.c       | 16 +++++
>   drivers/pinctrl/samsung/pinctrl-exynos.c           | 78 +++++++++++++++++++---
>   drivers/pinctrl/samsung/pinctrl-samsung.h          | 11 +++
>   include/linux/soc/samsung/exynos-regs-pmu.h        |  8 ++-
>   10 files changed, 136 insertions(+), 25 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

