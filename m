Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B098C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C0120881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TR4WCod1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C0120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeJOT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:57:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43748 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:57:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015121245euoutp01f3858dc8dd88ac3f8c92004bef233fd9~dxxrGY8vn2788027880euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:12:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015121245euoutp01f3858dc8dd88ac3f8c92004bef233fd9~dxxrGY8vn2788027880euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539605565;
        bh=qIoVvshBpDvAPVjeR5wjrq1h8rc54kcaWzvaBPUm6V8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TR4WCod15LEhRqCpSD5vlE5ZYAroUYs97NKuYTV60Eg6imS3/Bf0+seMd46seXQcY
         L+j7oTrp9EkHluylZSfU1RNXNOCfitjvcn1jsgDu6YLDtmRx2E2zuOWHfU8RTlRF1A
         fWxO+Z0btlcTGsYN95WoRykd3ZdXUJ2PlcNqMN0Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015121244eucas1p167d7bceb476223a616cbce784f26a66b~dxxqSpPAU0210602106eucas1p12;
        Mon, 15 Oct 2018 12:12:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.FE.04441.C3484CB5; Mon, 15
        Oct 2018 13:12:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181015121243eucas1p1dd6093945310db315fc28092e2c91b6e~dxxpPrR4A1710517105eucas1p1W;
        Mon, 15 Oct 2018 12:12:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181015121243eusmtrp1d3a82b581b3d581814ce754fa16c3523~dxxpAdeou0126901269eusmtrp1P;
        Mon, 15 Oct 2018 12:12:43 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-ef-5bc4843cdd49
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.AB.04284.B3484CB5; Mon, 15
        Oct 2018 13:12:43 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181015121242eusmtip2821e4748adb269940dbf4334f8877522~dxxoeSwwa0474704747eusmtip2q;
        Mon, 15 Oct 2018 12:12:42 +0000 (GMT)
Subject: Re: [PATCH 4/7] clocksource: arch_timer: Add support for
 not-fw-configured timer on ARM64
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <Mark.Rutland@arm.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 15 Oct 2018 14:12:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e9624612-4a94-b9bc-f5ec-0f16d5b12323@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SazBUYRieb8/Zs8ey+izlHV1MO9WoCZnpx2mo6Tq2f5XSZJthy3GZWOy6
        /yhixM5OpAltkplcyijZtZLIWGoZY91CjPLDCpVMYbqIah3Kv+d5vuf53uf95qMJcR/fhQ5X
        xLJKhTxCQgnJ2lc/zO4+6a2yPYYKG6a6oIrPzJRpEDM4N8FnimY3M7mjOSTT1fVEwOjGBvhM
        X30hxRR0veAxiyNLFFM62MNj9LpbBDP1pY08KJJWFlUiqa4ii5KODDRQ0s9ms0CqL7kivV5T
        gaSzui0nBAFCn2A2IjyeVXoeCBKGdTVNUtGVGxJLS7p5KahGrEY2NOC9kL4wIVAjIS3GDxC8
        Lh6kODKHoMw0RHBkFsHDZgtvNfL+t2YlUo4g962e5MgMgsVvjaTV5YiDYS4/HVkPnHAOgvbS
        1GVC4HkedFiqll0U9gL1tJqyYhJvh6stk38xTa/H52Gh3tsqi7ADtN+2LNttsDc0akqXaxDY
        FdIMdwgOO8Ow5R7Pej/gaQG0Z6bwuXA8NC5yjQAfhcmhrBXsCB9MNQIOb4KOmxqSC6chuFag
        FXBEg8BQWEdxLm9oMfXwre0IvBOq6j05+RD0f3+HrDJge3gz7cAVsofc2nyCk0WQmbHy2jtA
        a3r8b2xzdy+RgyTaNWtq16ymXbOa9v/cYkRWIGc2ThUZyqq8FGyCh0oeqYpThHpcjIrUob9f
        rWPJ9LUOzfdeMCJMI4mdCNu1ysR8ebwqKdKIgCYkTiI4bZSJRcHypGRWGRWojItgVUa0kSYl
        zqKyomqZGIfKY9lLLBvNKldPebSNSwrKOPbS1r5YMe4f75a8zW/8V0LD3bjdI/3DRxw6zyQf
        P7cu1ZD97LKxP+LsXKCbaKv/x7wbrT9PHgzxPbUv526LsSpoV8gY5ee/f6q6c6fmrDkGq/P0
        5X6jU9mHscPz30Ft4UeEY02zQ/ayR65uvlLD6NSnxJj7iXa2ymxzg7vj0wcBElIVJvfaRShV
        8j+yXGJ2ZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7rWLUeiDc4e57LYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZPH3zj82i6XXLzJZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KP0bIryS0tSFTLy
        i0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ms7vf8FWsEasYumSC0wN
        jFuEuhg5OSQETCSe/e9h72Lk4hASWMoo8eTDanaIhIzEyWkNrBC2sMSfa11sILaQwFtGiZkv
        uEBsYYEUiS/TWxhBmkUEJjBKnGw/xgLiMAt8Z5K4938OC0THF0aJpz0KIDabgKFE11uISbwC
        dhL9f76D1bAIqEo0HX4BFhcViJE4OrkFqkZQ4uTMJ2A1nALWEnt7ljKB2MwC6hJ/5l1ihrDl
        JZq3zoayxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT8
        3E2MwBjeduzn5h2MlzYGH2IU4GBU4uEV4DkSLcSaWFZcmXuIUYKDWUmEVyLkULQQb0piZVVq
        UX58UWlOavEhRlOg5yYyS4km5wPTS15JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTU
        gtQimD4mDk6pBsaZE0+tPvtk8bYk7s4vO5rsEzKfKog83Jrh7V/2RbdxSvDnmooNte66c56J
        Ceyq2RL684qB98wW1/rMhR+UZizaWh52RHv3SVX+R/38/AfK29d/fHzmWW6P0loL0dOOh8L4
        C+WOJBcs3TBhWZazCxPzkUPT1xnEcC5+Y39a85Cs4ms70/gtATeUWIozEg21mIuKEwHcsLo+
        9wIAAA==
Message-Id: <20181015121243eucas1p1dd6093945310db315fc28092e2c91b6e~dxxpPrR4A1710517105eucas1p1W@eucas1p1.samsung.com>
X-CMS-MailID: 20181015121243eucas1p1dd6093945310db315fc28092e2c91b6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001@eucas1p2.samsung.com>
        <20181008125009.3721-5-m.szyprowski@samsung.com>
        <e9624612-4a94-b9bc-f5ec-0f16d5b12323@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-10-08 15:17, Marc Zyngier wrote:
> + Mark Rutland
>
> Hi Marek,
>
> On 08/10/18 13:50, Marek Szyprowski wrote:
>> Use common infrastructure for ARM Architected Timers erratum to enable
>> support for systems with broken CPU firmware (timer registers not
>> properly configured). This mode has been already availabled on ARM
>> (32bits) architecture. This enables to run Linux kernel on ARM64 boards
>> using physical architected timers instead of the virtual ones. Examples
>> of such system with broken firmware are Samsung Exynos5433 SoC based
>> TM2(e) boards, which is already deployed for years and updating firmware
>> is not possible.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/clocksource/Kconfig          | 11 +++++++++++
>>   drivers/clocksource/arm_arch_timer.c | 15 ++++++++++++---
>>   2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index a11f4ba98b05..a30752579b03 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
>>         The workaround will be dynamically enabled when an affected
>>         core is detected.
>>   +config ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
>> +    bool "Workaround for arch timer registers not configured by
>> firmware"
>> +    default y
>> +    select ARM_ARCH_TIMER_OOL_WORKAROUND
>> +    depends on ARM_ARCH_TIMER && ARM64
>> +    help
>> +      This option enables a workaround for boards, on which arch timer
>> +      registers are not properly configured by the board firmware.
>> +      The workaround will be dynamically enabled when an affected
>> +      board is detected.
>> +
>
> I'm sorry, but I'm strongly pushing back on this.
>
> This horrible hack was accepted with the express condition that it
> would be limited to ARMv7 platforms (on the ground that we never
> really documented the arch timer boot requirements on that version of
> the architecture), and would never proliferate on arm64. From day 1,
> we established what the boot protocol was, and we mandated that either:
>
> - kernel is entered at EL2 on all CPUs
> - cntvoff_el2 is zeroed on all CPUs
>
> and we've got most people to fix their firmware, or live with the
> consequences. If these machines cannot receive a non-broken firmware,
> what are the odds that they will receive a mainline kernel?

Well, I know that the firmware is broken, but I cannot do anything about it.
On the other hand updating kernel is still possible and mainline runs fine
on TM2(e) boards. I will send v2 without this patch then.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

