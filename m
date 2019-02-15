Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32482C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70F421A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MshO6e6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393681AbfBOKXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:23:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52354 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbfBOKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:23:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190215102332euoutp01380e48cd468c34884e4a860a4b2b00cd~DgobiXP082479924799euoutp01c
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190215102332euoutp01380e48cd468c34884e4a860a4b2b00cd~DgobiXP082479924799euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550226212;
        bh=Xgs4ECjK2w2EGc1IdmngDs3q2ZGicewg2WMbPX5mPK8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MshO6e6/oWOzB8evWhSqlgQgrfhWTzM9GlC4wMBGGJ3qyBW8GihHXTvZqew0RR0b9
         AQqx0jFo86D3eBBH67wlCUIn/TE8jibxLrvE5ygtligKz1TZFKR1o4lNbDRo7yTwaN
         RjMY9iTf+3sA/Osqi0gtnODH1DX1nAZ3TnbV6Fb8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215102331eucas1p2abebf11a2874539bacbb273af36ef610~DgoarAooA2803828038eucas1p2u;
        Fri, 15 Feb 2019 10:23:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5C.2F.04806.323966C5; Fri, 15
        Feb 2019 10:23:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190215102330eucas1p1107316a33f3cf5ab7347d0e2eb088516~DgoZvncKb0580005800eucas1p1f;
        Fri, 15 Feb 2019 10:23:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215102330eusmtrp170f252a98f16f630dec5f40cfc6fea33~DgoZhJW1z0652206522eusmtrp1L;
        Fri, 15 Feb 2019 10:23:30 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-f1-5c66932393a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.9C.04284.223966C5; Fri, 15
        Feb 2019 10:23:30 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190215102329eusmtip23cf2ffe37c0b6db7b58c0bc386c48d49~DgoY-ZqNK0079700797eusmtip2O;
        Fri, 15 Feb 2019 10:23:29 +0000 (GMT)
Subject: Re: [PATCH] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7548bc35-caef-0737-be39-5ddb8e097f67@samsung.com>
Date:   Fri, 15 Feb 2019 11:23:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214165807.eq34njmunqhrdvxx@shell.armlinux.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7rKk9NiDDae4LPYOGM9q8XP9i1M
        FufPb2C32PT4GqvF5V1z2CxmnN/HZHFo6l5Gi/XTfrJafHr2j91ixuSXbA5cHpevXWT2eH+j
        ld1j56y77B6bVnWyedy5tofNY/OSeo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+LzkCnPB
        G/mKNRuPMTcwfpPsYuTkkBAwkdg0aQZbFyMXh5DACkaJI6cns0M4Xxgl3v9vgMp8ZpTYsv0K
        kMMB1vLrbAJEfDmjxLODf1kgnPeMEhe2bGYEmSss4CmxpOMAK0iDiICVxIUeDZAaZoHPTBL/
        fnxjBalhEzCU6HrbxQZi8wrYSSxrXwNmswioSrz5eYwFxBYViJGYcu4IO0SNoMTJmU/A4pwC
        LhKnt21hBrGZBeQltr+dA2WLS9x6Mp8J4rdH7BI37uhD2C4S/cv6mCFsYYlXx7ewQ9gyEqcn
        94A9ICHQzCjRPmMWO4TTwyixdc4ONogqa4nDxy+CfcMsoCmxfhfUUEeJbzdWMkFChU/ixltB
        iBv4JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSaheSzWUi+mYXkm1kIexcwsqxiFE8t
        Lc5NTy02zkst1ytOzC0uzUvXS87P3cQITF6n/x3/uoNx35+kQ4wCHIxKPLwrMlJjhFgTy4or
        cw8xSnAwK4nwLupKixHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgm
        y8TBKdXAGGhv2Z0QK9R9S9727re5Z1793GrN/ESXb4qtr7R85kT5ItG9X19Y/nB8EO0saPzK
        zXVBmWOncERo8XSprRkanUwdxe/mHXVJ//psq2O2pLnr1/27nvBsuBYh7cw8Y6vd0guntSyd
        xL4lTjYMMTGW/bcn/kx1Tt0ZjXnlS3Ss+a7MN401nsGtxFKckWioxVxUnAgAdle861oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7pKk9NiDN4+ELfYOGM9q8XP9i1M
        FufPb2C32PT4GqvF5V1z2CxmnN/HZHFo6l5Gi/XTfrJafHr2j91ixuSXbA5cHpevXWT2eH+j
        ld1j56y77B6bVnWyedy5tofNY/OSeo++LasYPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+LzkCnPBG/mKNRuPMTcwfpPsYuTgkBAw
        kfh1NqGLkYtDSGApo8SuE8vZuxg5geIyEienNbBC2MISf651sUEUvWWUaH0ykwkkISzgKbGk
        4wAryCARASuJCz0aIDXMAl+ZJCZ838oO0XCaUeLW9AvMIA1sAoYSXW9BJnFy8ArYSSxrXwNm
        swioSrz5eYwFZJCoQIzE1XOMECWCEidnPmEBsTkFXCROb9sCNoZZQF3iz7xLULa8xPa3c6Bs
        cYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMFq3
        Hfu5eQfjpY3BhxgFOBiVeHhXZKTGCLEmlhVX5h5ilOBgVhLhXdSVFiPEm5JYWZValB9fVJqT
        WnyI0RTot4nMUqLJ+cBEklcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+J
        g1OqgbGaMaDHX0DywuuXi03en5KSelh5d6mAVqL8TbXgAsY330/Kd4i/O/7ygfqTi+m3F384
        djBa5FWXntvfE32JSl4mgfVZTcfEsrjeb8ny6AnLL0j+3L3X1M5w4qyTs6/xXjlQ1tTYkbNF
        cdLci7m9PSXL5i9aPPnSnW6BHxrP5W/9fZ5QEqfyeIISS3FGoqEWc1FxIgDzBLqW7AIAAA==
X-CMS-MailID: 20190215102330eucas1p1107316a33f3cf5ab7347d0e2eb088516
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190214143126eucas1p126506139ef72c1685654c8dac8957b3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214143126eucas1p126506139ef72c1685654c8dac8957b3d
References: <CGME20190214143126eucas1p126506139ef72c1685654c8dac8957b3d@eucas1p1.samsung.com>
        <20190214143114.24356-1-m.szyprowski@samsung.com>
        <20190214165807.eq34njmunqhrdvxx@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-02-14 17:58, Russell King - ARM Linux admin wrote:
> On Thu, Feb 14, 2019 at 03:31:14PM +0100, Marek Szyprowski wrote:
>> MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
>> perform low-level platform initialization. This results in a try to install
>> HYP stubs for the second time for each CPU and results in false HYP/SVC
>> mode mismatch detection. The HYP stubs are already installed at the
>> beginning of the kernel initialization on the boot CPU (head.S) or in the
>> secondary_startup() for other CPUs. To fix this issue MCPM code should use
>> a cpu_resume() routine without HYP stubs installation.
>>
>> This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
>> XU3/XU4/HC1 boards.
>>
>> Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  arch/arm/common/mcpm_entry.c   |  2 +-
>>  arch/arm/include/asm/suspend.h |  1 +
>>  arch/arm/kernel/sleep.S        | 11 +++++++++++
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
>> index ad574d20415c..1b1b82b37ce0 100644
>> --- a/arch/arm/common/mcpm_entry.c
>> +++ b/arch/arm/common/mcpm_entry.c
>> @@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
>>  	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>>  	phys_reset_t phys_reset;
>>  
>> -	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
>> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
>>  	setup_mm_for_reboot();
>>  
>>  	__mcpm_cpu_going_down(cpu, cluster);
>> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
>> index 452bbdcbcc83..506314265c6f 100644
>> --- a/arch/arm/include/asm/suspend.h
>> +++ b/arch/arm/include/asm/suspend.h
>> @@ -10,6 +10,7 @@ struct sleep_save_sp {
>>  };
>>  
>>  extern void cpu_resume(void);
>> +extern void cpu_resume_no_hyp(void);
>>  extern void cpu_resume_arm(void);
>>  extern int cpu_suspend(unsigned long, int (*)(unsigned long));
>>  
>> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
>> index a8257fc9cf2a..b856d183691e 100644
>> --- a/arch/arm/kernel/sleep.S
>> +++ b/arch/arm/kernel/sleep.S
>> @@ -122,6 +122,11 @@ ENDPROC(cpu_resume_after_mmu)
>>  
>>  #ifdef CONFIG_MMU
>>  	.arm
>> +#ifdef CONFIG_MCPM
>> +ENTRY(cpu_resume_no_hyp)
>> +ARM_BE8(setend be)			@ ensure we are in BE mode
>> +	b	0f
> What if the kernel is built for Thumb?  You'll be branching to thumb
> code at the '0' label - don't you need to do the same that
> cpu_resume_arm does below?

Maybe yes, but I don't get how did it work so far. Current version of
the cpu_resume() doesn't check the CPU ARM/Thumb mode. Such version is
used by MCPM, blSwitcher and various suspend/resume code from
arch/arm/mach-*. The mode check is in the cpu_resume_arm(), which is
used only by two SoC drivers in drivers/soc). Does it mean that most of
the current cpu_resume() users are wrong?

I've didn't try building Thumb kernel so far to check that.

>> +#endif
>>  ENTRY(cpu_resume_arm)
>>   THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
>>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
>> @@ -135,6 +140,9 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
>>  	bl	__hyp_stub_install_secondary
>>  #endif
>>  	safe_svcmode_maskall r1
>> +#ifdef CONFIG_MCPM
>> +0:
>> +#endif
> You don't need to conditionalise this.  I'd also use a symbol rather
> than a numeric label given that safe_svcmode_maskall is a macro that
> also uses numeric labels.

Okay.

>>  	mov	r1, #0
>>  	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
>>  	ALT_UP_B(1f)
>> @@ -163,6 +171,9 @@ ENDPROC(cpu_resume)
>>  
>>  #ifdef CONFIG_MMU
>>  ENDPROC(cpu_resume_arm)
>> +#endif
>> +#ifdef CONFIG_MCPM
>> +ENDPROC(cpu_resume_no_hyp)
>>  #endif
>>  
>>  	.align 2
>> -- 
>> 2.17.1

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

