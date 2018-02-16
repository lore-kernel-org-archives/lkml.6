Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162117AbeBPRf6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:35:58 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42637 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161197AbeBPRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:35:57 -0500
X-Google-Smtp-Source: AH8x2270M++c+NVmDZug+JRw8xDg2+0MhG3cbcejGJsvT9nUVSy00E8JfWe+15Vy0oS7ftUM5Ihr9Q==
Subject: Re: [PATCH] ARM64: Kconfig: Fix the missing hi655x common clk
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>,
        Wei Xu <xuwei5@hisilicon.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
 <1496686434-13181-1-git-send-email-daniel.lezcano@linaro.org>
 <CAPDyKFqWptneK2V7wCR8LGbgU7=U9kBCKkHrtgGmZKmNQJ4s7g@mail.gmail.com>
 <20170609154652.GG2244@mai>
 <CAK8P3a1PsFcqLC95rSQf6EdkqhQ6sE3OXC9gDQ8TLp2mTVO3pw@mail.gmail.com>
 <CALAqxLXtLc16zT9AFaHXbbQp-Vf3GNOJ1nb7PoUJgj22rh=X-w@mail.gmail.com>
 <CAK8P3a0L6QNAJf6DB876DFHf7aGcD=uwxOUB36LKr-AX67VYAA@mail.gmail.com>
 <20170612093853.GB2261@mai>
 <CAK8P3a1DbjovHF3QX9OuPA1q4XAEj1KackgKqGvceDWL3f1cJg@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a5050f68-3adb-6973-9164-1bb43272cbd0@linaro.org>
Date: Fri, 16 Feb 2018 18:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1DbjovHF3QX9OuPA1q4XAEj1KackgKqGvceDWL3f1cJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2017 23:12, Arnd Bergmann wrote:
> On Mon, Jun 12, 2017 at 11:38 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On Fri, Jun 09, 2017 at 10:48:13PM +0200, Arnd Bergmann wrote:
>>> On Fri, Jun 9, 2017 at 10:15 PM, John Stultz <john.stultz@linaro.org> wrote:
>>>> On Fri, Jun 9, 2017 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> On Fri, Jun 9, 2017 at 5:46 PM, Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> Yes, but I'm not sure this is the right patch either. We tend to not
>>>>> use 'select' for user-visible drivers, and most hisilicon platforms
>>>>> won't need this driver.
>>>>>
>>>>> I think it would be more consistent to add this to the defconfig
>>>>> and regard it as a user error when the driver is disabled on a
>>>>> machine that needs it.
>>>>
>>>> Maybe the select is not exactly in the right place, but I don't really
>>>> feel like a pmic on an SoC is a "user-visible driver". I deal with the
>>>> board often and when the new dependency was made on the clk, I would
>>>> have never have found it on my own w/o Ulf and Daniel pointing out
>>>> what I needed to enable.
>>>
>>> What I meant is that the Kconfig option is user-visible. On a very high
>>> level, this is a result of arch/arm64/Kconfig.platforms listing only
>>> very broad categories of SoCs, in many cases only the manufacturers
>>> of very different chip families, which then control the visibility of the
>>> individual Kconfig items for things like pinctrl or clk.
>>>
>>> I now see that MFD_HI655X_PMIC is the top-level driver that you
>>> have to select before enabling COMMON_CLK_HI655X, so the
>>> patch is actually broken unless it actually selects both.
>>>
>>> How about simply adding a 'default MFD_HI655X_PMIC' to
>>> COMMON_CLK_HI655X to enable it unless it is explicitly
>>> turned off?
>>
>> Actually, I share John's opinion.
>>
>> Ideally when we choose a platform, all the relevants devices configuration
>> options should be selected automatically from a single topmost node of a tree
>> (platform selection) to all the nodes corresponding to the devices, leaving the
>> user to select one simple option without knowledge of the SoC hardware
>> internals.
>>
>> If the user is expert in the platform and knows exactly what he does, then he
>> can select an _EXPERT_ like option and be able to disable some drivers.
>>
>> It is how I tend to write the Kconfig options, so the 'default MFD_HI655X_PMIC'
>> is confusing for me. Wouldn't make sense to select COMMON_CLK_HI655X when
>> MFD_HI655X_PMIC is enabled?
> 
> I don't think it's that easy. When you do that, MFD_HI655X_PMIC gains
> a dependency on COMMON_CLK and will again cause a warning on
> machines that disable that during compile testing.
> 
> Using 'select' for user-selectable options generally leads to problems,
> and you are better off avoiding it. If you want to make the symbol impossible
> to turn off for non-EXPERT configurations, you can write it like
> 
> config COMMON_CLK_HI655X
>         tristate "Clock driver for Hi655x" if EXPERT
>         depends on (MFD_HI655X_PMIC || COMPILE_TEST)
>         depends on REGMAP
>         default MFD_HI655X_PMIC
> 
> That way the option is completely hidden for non-EXPERT,
> but still has the right default otherwise, and the dependencies
> are tracked right for compile-testing.

What about the options:

CONFIG_HI3660_MBOX
CONFIG_HI6220_MBOX

CONFIG_STUB_CLK_HI6220
CONFIG_STUB_CLK_HI3660

?

Would make sense to do something like:



diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b9546ab..3a07dfe 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -517,7 +517,6 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
-CONFIG_STUB_CLK_HI3660=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_IPQ_GCC_8074=y
@@ -529,8 +528,6 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
-CONFIG_HI3660_MBOX=y
-CONFIG_HI6220_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 1bd4355..becdb1d 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -44,14 +44,17 @@ config RESET_HISI
 	  Build reset controller driver for HiSilicon device chipsets.

 config STUB_CLK_HI6220
-	bool "Hi6220 Stub Clock Driver"
-	depends on COMMON_CLK_HI6220 && MAILBOX
-	default ARCH_HISI
+	bool "Hi6220 Stub Clock Driver" if EXPERT
+	depends on (COMMON_CLK_HI6220 || COMPILE_TEST)
+	depends on MAILBOX
+	default COMMON_CLK_HI6220
 	help
 	  Build the Hisilicon Hi6220 stub clock driver.

 config STUB_CLK_HI3660
-	bool "Hi3660 Stub Clock Driver"
-	depends on COMMON_CLK_HI3660 && MAILBOX
+	bool "Hi3660 Stub Clock Driver" if EXPERT
+	depends on (COMMON_CLK_HI3660 || COMPILE_TEST)
+	depends on MAILBOX
+	default COMMON_CLK_HI3660
 	help
 	  Build the Hisilicon Hi3660 stub clock driver.
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index de8390d4..8d1726c 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -109,16 +109,19 @@ config TI_MESSAGE_MANAGER
 	  platform has support for the hardware block.

 config HI3660_MBOX
-	tristate "Hi3660 Mailbox"
-	depends on ARCH_HISI && OF
+	tristate "Hi3660 Mailbox" if EXPERT
+	depends on (ARCH_HISI || COMPILE_TEST)
+	depends on OF
+	default ARCH_HISI
 	help
 	  An implementation of the hi3660 mailbox. It is used to send message
 	  between application processors and other processors/MCU/DSP. Select
 	  Y here if you want to use Hi3660 mailbox controller.

 config HI6220_MBOX
-	tristate "Hi6220 Mailbox"
-	depends on ARCH_HISI
+	tristate "Hi6220 Mailbox" if EXPERT
+	depends on (ARCH_HISI || COMPILE_TEST)
+	default ARCH_HISI
 	help
 	  An implementation of the hi6220 mailbox. It is used to send message
 	  between application processors and MCU. Say Y here if you want to




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
