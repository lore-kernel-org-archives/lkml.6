Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966759AbeBNDlw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:41:52 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39399 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966671AbeBNDlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:41:50 -0500
X-Google-Smtp-Source: AH8x226MW53Gc0luq8ag8PAbLLt3AkvYFgjdbqXtb+BffbI1aaaSHskobdsa/l1qV0XAsXsMKDIBvU+1z5+Ns0Lz0V0=
MIME-Version: 1.0
In-Reply-To: <CACRpkdado5dzaRUJ0YZuCW_bPPeXr3V1k9YGS3_-Wm0U_G9NFQ@mail.gmail.com>
References: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
 <b8df099671d55de8a2f754d7598a62a9176413dd.1518076643.git.baolin.wang@linaro.org>
 <CACRpkdado5dzaRUJ0YZuCW_bPPeXr3V1k9YGS3_-Wm0U_G9NFQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 14 Feb 2018 11:41:49 +0800
Message-ID: <CAMz4kuKzwabf=RwsOVG9LO2Vcj0O_OyKSQsZx=qzULR+HVV=wQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add Spreadtrum EIC driver support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 13 February 2018 at 17:18, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi Baolin,
>
> thank you for your patch!
>
> On Thu, Feb 8, 2018 at 9:01 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> The Spreadtrum platform has 2 EIC controllers, one is in digital chip and
>> another one is in PMIC. The digital-chip EIC controller has 4 sub-modules:
>> debounce EIC, latch EIC, async EIC and sync EIC, each sub-module can has
>> multiple groups and each group contains 8 EICs. The PMIC EIC controller has
>> only one debounce EIC sub-module.
>
> OK it seems they are at different memory addresses and totally
> separate instances then. I start to understand!

Yes.

>
>> Each EIC can only be used as input mode, and has the capability to trigger
>> interrupts when detecting input signals.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> +config GPIO_EIC_SPRD
>> +       tristate "Spreadtrum EIC support"
>> +       depends on ARCH_SPRD || COMPILE_TEST
>
> depend on OF_GPIO

Sure.

>
>> +       select GPIOLIB_IRQCHIP
>> +       help
>> +         Say yes here to support Spreadtrum EIC device.
>
>> +/* EIC registers definition */
>
> Aha I see so the register map is different depending on which
> type is synthesized.

Yes.

>
>> +#define SPRD_EIC_DBNC_DATA             0x0
>> +#define SPRD_EIC_DBNC_DMSK             0x4
>> +#define SPRD_EIC_DBNC_IEV              0x14
>> +#define SPRD_EIC_DBNC_IE               0x18
>> +#define SPRD_EIC_DBNC_RIS              0x1c
>> +#define SPRD_EIC_DBNC_MIS              0x20
>> +#define SPRD_EIC_DBNC_IC               0x24
>> +#define SPRD_EIC_DBNC_TRIG             0x28
>> +#define SPRD_EIC_DBNC_CTRL0            0x40
>> +#define SPRD_EIC_DBNC_CTRL1            0x44
>> +#define SPRD_EIC_DBNC_CTRL2            0x48
>> +#define SPRD_EIC_DBNC_CTRL3            0x4c
>> +#define SPRD_EIC_DBNC_CTRL4            0x50
>> +#define SPRD_EIC_DBNC_CTRL5            0x54
>> +#define SPRD_EIC_DBNC_CTRL6            0x58
>> +#define SPRD_EIC_DBNC_CTRL7            0x5c
>
> It looks from the code below that register 0x40 thru 0x5c
> are actually present on all the variants, not just the
> debounce DBNC variant.

No. these control registers are only used for debounce eic.

>
> This is strange, then they should not be named
> with the *_DBNC_* infix but instead something
> neutral like SPRD_CTRL0 0x40 etc.
>
>> +#define SPRD_EIC_LATCH_INTEN           0x0
>> +#define SPRD_EIC_LATCH_INTRAW          0x4
>> +#define SPRD_EIC_LATCH_INTMSK          0x8
>> +#define SPRD_EIC_LATCH_INTCLR          0xc
>> +#define SPRD_EIC_LATCH_INTPOL          0x10
>> +#define SPRD_EIC_LATCH_INTMODE         0x14
>> +
>> +#define SPRD_EIC_ASYNC_INTIE           0x0
>> +#define SPRD_EIC_ASYNC_INTRAW          0x4
>> +#define SPRD_EIC_ASYNC_INTMSK          0x8
>> +#define SPRD_EIC_ASYNC_INTCLR          0xc
>> +#define SPRD_EIC_ASYNC_INTMODE         0x10
>> +#define SPRD_EIC_ASYNC_INTBOTH         0x14
>> +#define SPRD_EIC_ASYNC_INTPOL          0x18
>> +#define SPRD_EIC_ASYNC_DATA            0x1c
>> +
>> +#define SPRD_EIC_SYNC_INTIE            0x0
>> +#define SPRD_EIC_SYNC_INTRAW           0x4
>> +#define SPRD_EIC_SYNC_INTMSK           0x8
>> +#define SPRD_EIC_SYNC_INTCLR           0xc
>> +#define SPRD_EIC_SYNC_INTMODE          0x10
>> +#define SPRD_EIC_SYNC_INTBOTH          0x14
>> +#define SPRD_EIC_SYNC_INTPOL           0x18
>> +#define SPRD_EIC_SYNC_DATA             0x1c
>> +
>> +/*
>> + * The digital-chip EIC controller can support maximum 3 groups, and each group
>> + * contains 8 EICs.
>> + */
>> +#define SPRD_EIC_MAX_GROUP             3
>> +#define SPRD_EIC_PER_GROUP_NR          8
>> +#define SPRD_EIC_DATA_MASK             GENMASK(7, 0)
>> +#define SPRD_EIC_BIT(x)                        ((x) & (SPRD_EIC_PER_GROUP_NR - 1))
>
> Here the comments from the other spreadtrum driver
> applied. (Banks instead of groups)

Sure.

>
>> +/*
>> + * The PMIC EIC controller only has one group, and each group now can contain
>> + * 16 EICs.
>> + */
>> +#define SPRD_PMIC_EIC_PER_GROUP_NR     16
>
> How can it have 16 groups if it has only one group? I don't understand...

PMIC EIC is designed differently, it only has one group and it can
support maximum 16 EICs. I can not say why, but that is what we
design.

>
>> +#define SPRD_PMIC_EIC_DATA_MASK                GENMASK(15, 0)
>> +#define SPRD_PMIC_EIC_BIT(x)           ((x) & (SPRD_PMIC_EIC_PER_GROUP_NR - 1))
>> +#define SPRD_PMIC_EIC_CACHE_NR_REGS    (SPRD_EIC_DBNC_TRIG + 0x4)
>> +
>> +#define SPRD_EIC_DBNC_MASK             GENMASK(11, 0)
>> +
>> +/*
>> + * The Spreadtrum EIC (external interrupt controller) can only be used
>> + * as input mode to generate interrupts if detecting input signals.
>> + *
>> + * The Spreadtrum platform has two EIC controllers, one EIC controller
>> + * is in digital-chip, another one is in PMIC. There are some differences
>> + * between this two EIC controllers. The digital-chip EIC controller
>> + * includes 4 sub-modules: debounce EIC, latch EIC, async EIC and sync EIC,
>> + * but the PMIC EIC controller only has one debounce EIC sub-module.
>> + *
>> + * The debounce EIC is used to capture input signal's stable status
>> + * (ms grade) and a single-trigger mechanism is introduced into this
>> + * sub-module to enhance the input event detection reliability. The
>> + * debounce range is from 1ms to 4s with the step of 1ms.
>> + *
>> + * The latch EIC is used to latch some special input signal and send
>> + * interrupts to MCU core.
>> + *
>> + * The async EIC uses 32k clock to capture short signal (us grade)
>> + * to generate interrupt to MCU by level or edge trigger.
>> + *
>> + * The sync EIC is similar with GPIO's input function.
>
> Same text as in the DT binding, so since I had a lot of comments on
> spelling and grammar, re-copy-and-paste after fixing up the binding
> please.

Sure.

>
>> +enum sprd_eic_type {
>> +       SPRD_EIC_DEBOUNCE,
>> +       SPRD_EIC_LATCH,
>> +       SPRD_EIC_ASYNC,
>> +       SPRD_EIC_SYNC,
>> +       SPRD_EIC_PMIC_DEBOUNCE,
>> +       SPRD_EIC_MAX,
>> +};
>
> OK good
>
>> +struct sprd_eic {
>> +       struct gpio_chip chip;
>> +       struct irq_chip intc;
>> +       void __iomem *base[SPRD_EIC_MAX_GROUP];
>> +       struct regmap *map;
>> +       u32 map_base;
>> +       u8 reg[SPRD_PMIC_EIC_CACHE_NR_REGS];
>> +       enum sprd_eic_type type;
>> +       spinlock_t lock;
>> +       struct mutex buslock;
>> +       int irq;
>> +};
>
> This might need some kerneldoc. The regmap is not evident.

OK, will add some documentation.

>
>> +struct sprd_eic_data {
>> +       enum sprd_eic_type type;
>> +       u32 num_eics;
>> +};
>
> Maybe name it sprd_eic_variant_data so it is clear that this is a
> data container for the variants. Maybe add some kerneldoc to make
> it clear?

Sure, change to sprd_eic_variant_data and doc them.

>
>> +static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
>> +       "eic-debounce", "eic-latch", "eic-async",
>> +       "eic-sync", "eic-pmic-debounce",
>> +};
>> +
>> +static const struct sprd_eic_data sc9860_eic_dbnc_data = {
>> +       .type = SPRD_EIC_DEBOUNCE,
>> +       .num_eics = 8,
>> +};
>> +
>> +static const struct sprd_eic_data sc9860_eic_latch_data = {
>> +       .type = SPRD_EIC_LATCH,
>> +       .num_eics = 8,
>> +};
>> +
>> +static const struct sprd_eic_data sc9860_eic_async_data = {
>> +       .type = SPRD_EIC_ASYNC,
>> +       .num_eics = 8,
>> +};
>> +
>> +static const struct sprd_eic_data sc9860_eic_sync_data = {
>> +       .type = SPRD_EIC_SYNC,
>> +       .num_eics = 8,
>> +};
>> +
>> +static const struct sprd_eic_data pmic_eic_dbnc_data = {
>> +       .type = SPRD_EIC_PMIC_DEBOUNCE,
>> +       .num_eics = 16,
>> +};
>
> Makes sense.
>
>> +static inline void __iomem *sprd_eic_group_base(struct sprd_eic *sprd_eic,
>> +                                               unsigned int group)
>> +{
>> +       if (group >= SPRD_EIC_MAX_GROUP)
>> +               return NULL;
>> +
>> +       return sprd_eic->base[group];
>> +}
>
> Same comment as the other driver, maybe just use offset as parameter
> to this instead of group?
>
> Maybe rename sprd_eic_offset_base()?

Like I said, in some situation, we can only pass the group number as parameter.

>
>> +static void sprd_eic_update(struct gpio_chip *chip, unsigned int offset,
>> +                           unsigned int reg, unsigned int val)
>> +{
>> +       struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
>> +       u32 shift;
>> +
>> +       if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
>> +               shift = SPRD_PMIC_EIC_BIT(offset);
>> +
>> +               regmap_update_bits(sprd_eic->map, sprd_eic->map_base + reg,
>> +                                  BIT(shift), val << shift);
>
> So since everything about the PMIC debounce is handled separately
> since it goes through regmap, I think maybe you should
> simply make that its own driver to make this driver cleaner?

I also thought about one new driver, but they are all named EIC and
have the same registers description, so ...

But if you have strong opinion to split the PMIC debounce EIC into one
new driver, I will do that.

>
>> +       } else {
>> +               void __iomem *base = sprd_eic_group_base(sprd_eic,
>> +                                               offset / SPRD_EIC_PER_GROUP_NR);
>> +               unsigned long flags;
>> +               u32 orig, tmp;
>> +
>> +               shift = SPRD_EIC_BIT(offset);
>> +
>> +               spin_lock_irqsave(&sprd_eic->lock, flags);
>> +               orig = readl_relaxed(base + reg);
>> +
>> +               tmp = (orig & ~BIT(shift)) | (val << shift);
>> +               writel_relaxed(tmp, base + reg);
>> +               spin_unlock_irqrestore(&sprd_eic->lock, flags);
>> +       }
>
> On this read-modify-write algoritm I have the same comments
> as on the other driver.

Make sense.

>
>> +static int sprd_eic_request(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       sprd_eic_update(chip, offset, SPRD_EIC_DBNC_DMSK, 1);
>> +       return 0;
>> +}
>> +
>> +static void sprd_eic_free(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       sprd_eic_update(chip, offset, SPRD_EIC_DBNC_DMSK, 0);
>> +}
>> +
>> +static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
>> +}
>> +
>> +static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       /* EICs are always input, nothing need to do here. */
>> +       return 0;
>> +}
>
> Implement sprd_eic_direction_output() as well and make it
> return -EIO every time. So setting as output fails.

Yes, will do.

>
>> +
>> +static void sprd_eic_set(struct gpio_chip *chip, unsigned int offset, int value)
>> +{
>> +       /* EICs are always input, nothing need to do here. */
>> +}
>
> So only the debounce version really supports GPIO read.
>
> And for the other versions, all you really do is use gpiolib to
> get an irqchip in a convenient way?
>
> I'm not so sure about this.
>
> I think it is more appropriate to just have a GPIO driver for
> the first variant in that case, and then put the support
> for the remaining variants into drivers/irqchip/* since
> they can only do IRQ.
>
> If they are supposed to be present in drivers/gpio/* they should
> at least be able to read a value, SPRD_EIC_LATCH_INTRAW
> etc if nothing else. Else I think it is a real bad fit for those.
>
> But then comes the fact that it seems all of them have
> debounce. So I'm a bit confused. The irqchips don't have
> debounce, so in that case it makes a bit of sense.
>
> But again: you can't really use the debounce properties from
> the irqchip side, and then I think the right thing to do is
> to use drivers/irqchip, and add debouncing support to
> the irqchip infrastructure so you can use it directly on the
> irqchip.

Yes, we have debounce EIC, this type EIC need be requested firstly and
can be read. Only latch EIC can not be read. So I still think put them
in drivers/gpio/* is more suitable, they have most of GPIO features
except they can only be used as input mode.

>
>> +static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
>> +                                unsigned int debounce)
>> +{
>> +       struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
>> +       u32 shift, reg, value;
>> +
>> +       if (sprd_eic->type == SPRD_EIC_PMIC_DEBOUNCE) {
>> +               int ret;
>> +
>> +               shift = SPRD_PMIC_EIC_BIT(offset);
>> +               reg = SPRD_EIC_DBNC_CTRL0 + shift * 0x4;
>> +               ret = regmap_read(sprd_eic->map, sprd_eic->map_base + reg,
>> +                                 &value);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               value &= ~SPRD_EIC_DBNC_MASK;
>> +               value |= debounce / 1000;
>> +               ret = regmap_write(sprd_eic->map, sprd_eic->map_base + reg,
>> +                                  value);
>> +               if (ret)
>> +                       return ret;
>
> This illustrated I think again why the PMIC should have its
> own driver.
>
>> +       } else {
>> +               void __iomem *base = sprd_eic_group_base(sprd_eic,
>> +                                               offset / SPRD_EIC_PER_GROUP_NR);
>> +
>> +               shift = SPRD_EIC_BIT(offset);
>> +               reg = SPRD_EIC_DBNC_CTRL0 + shift * 0x4;
>> +               value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
>> +
>> +               value |= debounce / 1000;
>> +               writel_relaxed(value, base + reg);
>> +       }
>
> So these variants, also those which are not named *DEBOUNCE
> still has a debounce register?
>
> That is pretty confusing.

Only debounce EICs are implemented the set_config() intrface.

>
>> +static int sprd_eic_set_config(struct gpio_chip *chip, unsigned int offset,
>> +                              unsigned long config)
>> +{
>> +       unsigned long param = pinconf_to_config_param(config);
>> +       u32 arg = pinconf_to_config_argument(config);
>> +
>> +       if (param == PIN_CONFIG_INPUT_DEBOUNCE)
>> +               return sprd_eic_set_debounce(chip, offset, arg);
>
> So this is supported on *all* variants?

No, only for debounce EIC.

>
> Does this mean that you have a number of "gpios" which
> can only handle interrupts, have debounce but you can never
> read the value from them?
>
> Apart from these design questions it looks all right,
> but we really need to think about if this should rather be,
> at least partially, inside drivers/irqchip.
>
> I understand it is convenient to use the infrastructure inside
> drivers/gpio/* but if it means things that are not even GPIO
> start to be implemented as "GPIO" then we are a victim of
> our own success.

But we have lots of GPIO features, and we need request debounce EIC
firstly, and we can read EIC except latch EIC. Moreover we use EIC to
be gpio-keys, if we implement them in drivers/irqchip, it will be hard
to use for other drivers. Please think about our special GPIOs (EIC).
Thanks.

-- 
Baolin.wang
Best Regards
