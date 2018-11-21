Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C10AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DB7214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqw3FgJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DB7214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeKVDLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVDLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:11:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F0921479;
        Wed, 21 Nov 2018 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542818157;
        bh=i2PSP99Thl19D6/maDbiQrck3g9zYn32/purxHOXWss=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kqw3FgJ0Fl4jtgcSgVRGGcxSZQGZS5mPLNNUaOpitGnTJc04q703h/d+2oZfHKZ17
         MV0tFYYjIaxc74CkQf1AyFOhaNO8Awm6jKr629V3Vifs1dIlYEV1HlItmh6EqtkC0N
         KAqYQGeHO6evIziZFbShocNXSnM5vBMYTUxXZu4w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181020135024.28573-4-paul.walmsley@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
 <20181020135024.28573-4-paul.walmsley@sifive.com>
Message-ID: <154281815686.88331.17857751098132553261@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/3] clk: sifive: add a driver for the SiFive FU540 PRCI IP
 block
Date:   Wed, 21 Nov 2018 08:35:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2018-10-20 06:50:24)
> diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-p=
rci.c
> new file mode 100644
> index 000000000000..870cb8333648
> --- /dev/null
> +++ b/drivers/clk/sifive/fu540-prci.c
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0
[...]
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Is this for of_clk_get_parent_count()? Use of_clk.h include for that,
and drop this clk.h include if possible.

> +#include <linux/clk/analogbits-wrpll-cln28hpc.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/log2.h>

Is this used?

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clk/sifive-fu540-prci.h>

Can you sort these at least by path includes so that linux/clk/ is
somewhere together?

> +
> +/*
> + * EXPECTED_CLK_PARENT_COUNT: how many parent clocks this driver expects:
> + *     hfclk and rtcclk
> + */
> +#define EXPECTED_CLK_PARENT_COUNT              2
> +
> +/*
> + * Register offsets and bitmasks
> + */
> +
> +/* COREPLLCFG0 */
> +#define PRCI_COREPLLCFG0_OFFSET                        0x4
> +# define PRCI_COREPLLCFG0_DIVR_SHIFT           0
> +# define PRCI_COREPLLCFG0_DIVR_MASK            (0x3f << PRCI_COREPLLCFG0=
_DIVR_SHIFT)
> +# define PRCI_COREPLLCFG0_DIVF_SHIFT           6
> +# define PRCI_COREPLLCFG0_DIVF_MASK            (0x1ff << PRCI_COREPLLCFG=
0_DIVF_SHIFT)
> +# define PRCI_COREPLLCFG0_DIVQ_SHIFT           15
> +# define PRCI_COREPLLCFG0_DIVQ_MASK            (0x7 << PRCI_COREPLLCFG0_=
DIVQ_SHIFT)
> +# define PRCI_COREPLLCFG0_RANGE_SHIFT          18
> +# define PRCI_COREPLLCFG0_RANGE_MASK           (0x7 << PRCI_COREPLLCFG0_=
RANGE_SHIFT)
> +# define PRCI_COREPLLCFG0_BYPASS_SHIFT         24
> +# define PRCI_COREPLLCFG0_BYPASS_MASK          (0x1 << PRCI_COREPLLCFG0_=
BYPASS_SHIFT)
> +# define PRCI_COREPLLCFG0_FSE_SHIFT            25
> +# define PRCI_COREPLLCFG0_FSE_MASK             (0x1 << PRCI_COREPLLCFG0_=
FSE_SHIFT)
> +# define PRCI_COREPLLCFG0_LOCK_SHIFT           31
> +# define PRCI_COREPLLCFG0_LOCK_MASK            (0x1 << PRCI_COREPLLCFG0_=
LOCK_SHIFT)
> +
> +/* DDRPLLCFG0 */
> +#define PRCI_DDRPLLCFG0_OFFSET                 0xc
> +# define PRCI_DDRPLLCFG0_DIVR_SHIFT            0
> +# define PRCI_DDRPLLCFG0_DIVR_MASK             (0x3f << PRCI_DDRPLLCFG0_=
DIVR_SHIFT)
> +# define PRCI_DDRPLLCFG0_DIVF_SHIFT            6
> +# define PRCI_DDRPLLCFG0_DIVF_MASK             (0x1ff << PRCI_DDRPLLCFG0=
_DIVF_SHIFT)
> +# define PRCI_DDRPLLCFG0_DIVQ_SHIFT            15
> +# define PRCI_DDRPLLCFG0_DIVQ_MASK             (0x7 << PRCI_DDRPLLCFG0_D=
IVQ_SHIFT)
> +# define PRCI_DDRPLLCFG0_RANGE_SHIFT           18
> +# define PRCI_DDRPLLCFG0_RANGE_MASK            (0x7 << PRCI_DDRPLLCFG0_R=
ANGE_SHIFT)
> +# define PRCI_DDRPLLCFG0_BYPASS_SHIFT          24
> +# define PRCI_DDRPLLCFG0_BYPASS_MASK           (0x1 << PRCI_DDRPLLCFG0_B=
YPASS_SHIFT)
> +# define PRCI_DDRPLLCFG0_FSE_SHIFT             25
> +# define PRCI_DDRPLLCFG0_FSE_MASK              (0x1 << PRCI_DDRPLLCFG0_F=
SE_SHIFT)
> +# define PRCI_DDRPLLCFG0_LOCK_SHIFT            31
> +# define PRCI_DDRPLLCFG0_LOCK_MASK             (0x1 << PRCI_DDRPLLCFG0_L=
OCK_SHIFT)
> +
> +/* DDRPLLCFG1 */
> +#define PRCI_DDRPLLCFG1_OFFSET                 0x10
> +# define PRCI_DDRPLLCFG1_CKE_SHIFT             24
> +# define PRCI_DDRPLLCFG1_CKE_MASK              (0x1 << PRCI_DDRPLLCFG1_C=
KE_SHIFT)
> +
> +/* GEMGXLPLLCFG0 */
> +#define PRCI_GEMGXLPLLCFG0_OFFSET              0x1c
> +# define PRCI_GEMGXLPLLCFG0_DIVR_SHIFT         0
> +# define PRCI_GEMGXLPLLCFG0_DIVR_MASK          (0x3f << PRCI_GEMGXLPLLCF=
G0_DIVR_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_DIVF_SHIFT         6
> +# define PRCI_GEMGXLPLLCFG0_DIVF_MASK          (0x1ff << PRCI_GEMGXLPLLC=
FG0_DIVF_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_DIVQ_SHIFT         15
> +# define PRCI_GEMGXLPLLCFG0_DIVQ_MASK          (0x7 << PRCI_GEMGXLPLLCFG=
0_DIVQ_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_RANGE_SHIFT                18
> +# define PRCI_GEMGXLPLLCFG0_RANGE_MASK         (0x7 << PRCI_GEMGXLPLLCFG=
0_RANGE_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_BYPASS_SHIFT       24
> +# define PRCI_GEMGXLPLLCFG0_BYPASS_MASK                (0x1 << PRCI_GEMG=
XLPLLCFG0_BYPASS_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_FSE_SHIFT          25
> +# define PRCI_GEMGXLPLLCFG0_FSE_MASK           (0x1 << PRCI_GEMGXLPLLCFG=
0_FSE_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_LOCK_SHIFT         31
> +# define PRCI_GEMGXLPLLCFG0_LOCK_MASK          (0x1 << PRCI_GEMGXLPLLCFG=
0_LOCK_SHIFT)
> +
> +/* GEMGXLPLLCFG1 */
> +#define PRCI_GEMGXLPLLCFG1_OFFSET              0x20
> +# define PRCI_GEMGXLPLLCFG1_CKE_SHIFT          24
> +# define PRCI_GEMGXLPLLCFG1_CKE_MASK           (0x1 << PRCI_GEMGXLPLLCFG=
1_CKE_SHIFT)
> +
> +/* CORECLKSEL */
> +#define PRCI_CORECLKSEL_OFFSET                 0x24
> +# define PRCI_CORECLKSEL_CORECLKSEL_SHIFT      0
> +# define PRCI_CORECLKSEL_CORECLKSEL_MASK       (0x1 << PRCI_CORECLKSEL_C=
ORECLKSEL_SHIFT)
> +
> +/* DEVICESRESETREG */
> +#define PRCI_DEVICESRESETREG_OFFSET                    0x28
> +# define PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_SHIFT     0
> +# define PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_MASK      (0x1 << PRCI_DEVI=
CESRESETREG_DDR_CTRL_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_DDR_AXI_RST_N_SHIFT      1
> +# define PRCI_DEVICESRESETREG_DDR_AXI_RST_N_MASK       (0x1 << PRCI_DEVI=
CESRESETREG_DDR_AXI_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_DDR_AHB_RST_N_SHIFT      2
> +# define PRCI_DEVICESRESETREG_DDR_AHB_RST_N_MASK       (0x1 << PRCI_DEVI=
CESRESETREG_DDR_AHB_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_DDR_PHY_RST_N_SHIFT      3
> +# define PRCI_DEVICESRESETREG_DDR_PHY_RST_N_MASK       (0x1 << PRCI_DEVI=
CESRESETREG_DDR_PHY_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_GEMGXL_RST_N_SHIFT       5
> +# define PRCI_DEVICESRESETREG_GEMGXL_RST_N_MASK                (0x1 << P=
RCI_DEVICESRESETREG_GEMGXL_RST_N_SHIFT)
> +
> +/* CLKMUXSTATUSREG */
> +#define PRCI_CLKMUXSTATUSREG_OFFSET                    0x2c
> +# define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT    1
> +# define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK     (0x1 << PRCI_CLKM=
UXSTATUSREG_TLCLKSEL_STATUS_SHIFT)
> +
> +/*
> + * Private structures
> + */
> +
> +/**
> + * struct __prci_data - per-device-instance data
> + * @va: base virtual address of the PRCI IP block
> + * @hw_clks: encapsulates struct clk_hw records
> + *
> + * PRCI per-device instance data
> + */
> +struct __prci_data {
> +       void __iomem *va;

Usually this is called 'base', but 'va' is fine too. What happens with
NOMMU? Then it's not a VA anymore?

> +       struct clk_hw_onecell_data hw_clks;
> +};
> +
> +/**
> + * struct __prci_wrpll_data - WRPLL configuration and integration data
> + * @c: WRPLL current configuration record
> + * @bypass: fn ptr to code to bypass the WRPLL (if applicable; else NULL)
> + * @no_bypass: fn ptr to code to not bypass the WRPLL (if applicable; el=
se NULL)
> + * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base =
address
> + *
> + * @bypass and @no_bypass are used for WRPLL instances that contain a se=
parate
> + * external glitchless clock mux downstream from the PLL.  The WRPLL int=
ernal
> + * bypass mux is not glitchless.
> + */
> +struct __prci_wrpll_data {
> +       struct analogbits_wrpll_cfg c;
> +       void (*bypass)(struct __prci_data *pd);
> +       void (*no_bypass)(struct __prci_data *pd);
> +       u8 cfg0_offs;
> +};

Why do we have this struct? Why not fold it into the prci_clock
structure? As far as I can tell it's a one to one correlation right now.

> +
> +/**
> + * struct __prci_clock - describes a clock device managed by PRCI
> + * @name: user-readable clock name string - should match the manual
> + * @parent_name: parent name for this clock
> + * @ops: struct clk_ops for the Linux clock framework to use for control
> + * @hw: Linux-private clock data
> + * @pwd: WRPLL-specific data, associated with this clock (if not NULL)
> + * @pd: PRCI-specific data associated with this clock (if not NULL)
> + *
> + * PRCI clock data.  Used by the PRCI driver to register PRCI-provided
> + * clocks to the Linux clock infrastructure.
> + */
> +struct __prci_clock {
> +       const char *name;
> +       const char *parent_name;
> +       const struct clk_ops *ops;
> +       struct clk_hw hw;
> +       struct __prci_wrpll_data *pwd;
> +       struct __prci_data *pd;
> +};
> +
> +#define clk_hw_to_prci_clock(pwd) container_of(pwd, struct __prci_clock,=
 hw)
> +
> +/*
> + * Private functions
> + */
> +
> +/**
> + * __prci_readl() - read from a PRCI register
> + * @pd: PRCI context
> + * @offs: register offset to read from (in bytes, from PRCI base address)
> + *
> + * Read the register located at offset @offs from the base virtual
> + * address of the PRCI register target described by @pd, and return
> + * the value to the caller.
> + *
> + * Context: Any context.
> + *
> + * Return: the contents of the register described by @pd and @offs.
> + */
> +static u32 __prci_readl(struct __prci_data *pd, u32 offs)
> +{
> +       return readl_relaxed(pd->va + offs);
> +}
> +
> +static void __prci_writel(u32 v, u32 offs, struct __prci_data *pd)
> +{
> +       return writel_relaxed(v, pd->va + offs);
> +}

Please remove these wrappers. The lines are only barely shorter with
them, they mostly obfuscate the code, and writel swaps 'offs' and 'pd'
vs readl (why?).

      __prci_wrpll_unpack(&pwd->c, __prci_readl(pd, pwd->cfg0_offs));

vs.

      __prci_wrpll_unpack(&pwd->c, readl_relaxed(pd->va + pwd->cfg0_offs));

> +/* WRPLL-related private functions */
> +
> +/**
> + * __prci_wrpll_unpack() - unpack WRPLL configuration registers into par=
ameters
> + * @c: ptr to a struct analogbits_wrpll_cfg record to write config into
> + * @r: value read from the PRCI PLL configuration register
> + *
> + * Given a value @r read from an FU540 PRCI PLL configuration register,
> + * split it into fields and populate it into the WRPLL configuration rec=
ord
> + * pointed to by @c.
> + *
> + * The COREPLLCFG0 macros are used below, but the other *PLLCFG0 macros
> + * have the same register layout.
> + *
> + * Context: Any context.
> + */
> +static void __prci_wrpll_unpack(struct analogbits_wrpll_cfg *c, u32 r)
> +{
> +       u32 v;
> +       v >>=3D PRCI_COREPLLCFG0_DIVR_SHIFT;
> +       c->divr =3D v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_DIVF_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_DIVF_SHIFT;
> +       c->divf =3D v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_DIVQ_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_DIVQ_SHIFT;
> +       c->divq =3D v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_RANGE_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_RANGE_SHIFT;
> +       c->range =3D v;
> +
> +       c->flags &=3D (WRPLL_FLAGS_INT_FEEDBACK_MASK |
> +                    WRPLL_FLAGS_EXT_FEEDBACK_MASK);
> +
> +       if (r & PRCI_COREPLLCFG0_FSE_MASK)
> +               c->flags |=3D WRPLL_FLAGS_INT_FEEDBACK_MASK;
> +       else
> +               c->flags |=3D WRPLL_FLAGS_EXT_FEEDBACK_MASK;
> +}
> +
> +/**
> + * __prci_wrpll_pack() - pack PLL configuration parameters into a regist=
er value
> + * @c: pointer to a struct analogbits_wrpll_cfg record containing the PL=
L's cfg
> + *
> + * Using a set of WRPLL configuration values pointed to by @c,
> + * assemble a PRCI PLL configuration register value, and return it to
> + * the caller.
> + *
> + * Context: Any context.  Caller must ensure that the contents of the
> + *          record pointed to by @c do not change during the execution
> + *          of this function.
> + *
> + * Returns: a value suitable for writing into a PRCI PLL configuration
> + *          register
> + */
> +static u32 __prci_wrpll_pack(struct analogbits_wrpll_cfg *c)

const c?

> +{
> +       u32 r =3D 0;
> +
> +       r |=3D c->divr << PRCI_COREPLLCFG0_DIVR_SHIFT;
> +       r |=3D c->divf << PRCI_COREPLLCFG0_DIVF_SHIFT;
> +       r |=3D c->divq << PRCI_COREPLLCFG0_DIVQ_SHIFT;
> +       r |=3D c->range << PRCI_COREPLLCFG0_RANGE_SHIFT;
> +       if (c->flags & WRPLL_FLAGS_INT_FEEDBACK_MASK)
> +               r |=3D PRCI_COREPLLCFG0_FSE_MASK;
> +
> +       return r;
> +}
> +
> +/**
> + * __prci_wrpll_read_cfg() - read the WRPLL configuration from the PRCI
> + * @pd: PRCI context
> + * @pwd: PRCI WRPLL metadata
> + *
> + * Read the current configuration of the PLL identified by @pwd from
> + * the PRCI identified by @pd, and store it into the local configuration
> + * cache in @pwd.
> + *
> + * Context: Any context.  Caller must prevent the records pointed to by
> + *          @pd and @pwd from changing during execution.
> + */
> +static void __prci_wrpll_read_cfg(struct __prci_data *pd,
> +                                 struct __prci_wrpll_data *pwd)
> +{
> +       __prci_wrpll_unpack(&pwd->c, __prci_readl(pd, pwd->cfg0_offs));
> +       __prci_wrpll_unpack(&pwd->c, readl_relaxed(pd->va + pwd->cfg0_off=
s));
> +}
> +
> +/**
> + * __prci_wrpll_write_cfg() - write WRPLL configuration into the PRCI
> + * @pd: PRCI context
> + * @pwd: PRCI WRPLL metadata
> + * @c: WRPLL configuration record to write
> + *
> + * Write the WRPLL configuration described by @c into the WRPLL
> + * configuration register identified by @pwd in the PRCI instance
> + * described by @c.  Make a cached copy of the WRPLL's current
> + * configuration so it can be used by other code.
> + *
> + * Context: Any context.  Caller must prevent the records pointed to by
> + *          @pd and @pwd from changing during execution.
> + */
> +static void __prci_wrpll_write_cfg(struct __prci_data *pd,
> +                                  struct __prci_wrpll_data *pwd,
> +                                  struct analogbits_wrpll_cfg *c)
> +{
> +       __prci_writel(__prci_wrpll_pack(c), pwd->cfg0_offs, pd);
> +
> +       memcpy(&pwd->c, c, sizeof(struct analogbits_wrpll_cfg));

I'm trying to understand what all the memcpy() calls in this driver are
doing. What is being optimized by storing the values in software? Is I/O
access really that bad that we need to use memcpy()? Can you remove it
all and just read and write registers when we need them? It would make
things clearer and shorter. If you need caching, I would suggest you use
regmap and all the caching features therein.

> +}
> +
> +/* Core clock mux control */
> +
> +/**
> + * __prci_coreclksel_use_hfclk() - switch the CORECLK mux to output HFCLK
> + * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
> + *
> + * Switch the CORECLK mux to the HFCLK input source; return once complet=
e.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_CORECLKSEL_OFFSET register.
> + */
> +static void __prci_coreclksel_use_hfclk(struct __prci_data *pd)
> +{
> +       u32 r;
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
> +       r |=3D PRCI_CORECLKSEL_CORECLKSEL_MASK;
> +       __prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */

Barrier with what? What are we synchronizing with?

> +}
> +
> +/**
> + * __prci_coreclksel_use_corepll() - switch the CORECLK mux to output CO=
REPLL
> + * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
> + *
> + * Switch the CORECLK mux to the PLL output clock; return once complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_CORECLKSEL_OFFSET register.
> + */
> +static void __prci_coreclksel_use_corepll(struct __prci_data *pd)
> +{
> +       u32 r;
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
> +       r &=3D ~PRCI_CORECLKSEL_CORECLKSEL_MASK;
> +       __prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */
> +}
> +
> +/*
> + * Linux clock framework integration
> + *
> + * See the Linux clock framework documentation for more information on
> + * these functions.
> + */
> +
> +static unsigned long sifive_fu540_prci_wrpll_recalc_rate(struct clk_hw *=
hw,
> +                                                        unsigned long pa=
rent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_wrpll_data *pwd =3D pc->pwd;
> +
> +       return analogbits_wrpll_calc_output_rate(&pwd->c, parent_rate);

I suppose this is one place where the caching must have gone wrong, so
then we needed to add __prci_wrpll_read_cfg() to make sure we've kept
things in sync with our memcpy? Please don't do that. Just read the
hardware in recalc_rate() so that we don't have to worry about syncing
framework state with this driver state.

> +}
> +
> +static long sifive_fu540_prci_wrpll_round_rate(struct clk_hw *hw,
> +                                              unsigned long rate,
> +                                              unsigned long *parent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_wrpll_data *pwd =3D pc->pwd;
> +       struct analogbits_wrpll_cfg c;
> +
> +       memcpy(&c, &pwd->c, sizeof(c));
> +
> +       analogbits_wrpll_configure_for_rate(&c, rate, *parent_rate);
> +
> +       return analogbits_wrpll_calc_output_rate(&c, *parent_rate);
> +}
> +
> +static int sifive_fu540_prci_wrpll_set_rate(struct clk_hw *hw,
> +                                           unsigned long rate,
> +                                           unsigned long parent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_wrpll_data *pwd =3D pc->pwd;
> +       struct __prci_data *pd =3D pc->pd;
> +       int r;
> +
> +       r =3D analogbits_wrpll_configure_for_rate(&pwd->c, rate, parent_r=
ate);
> +       if (r)
> +               return -ERANGE;

Why not return the value of 'r'?

> +
> +       if (pwd->bypass)
> +               pwd->bypass(pd);
> +
> +       __prci_wrpll_write_cfg(pd, pwd, &pwd->c);
> +
> +       udelay(analogbits_wrpll_calc_max_lock_us(&pwd->c));
> +
> +       if (pwd->no_bypass)
> +               pwd->no_bypass(pd);

Maybe call it enable/disable_bypass() instead? no_bypass sounds like
it's doing something if there isn't a bypass.

> +
> +       return 0;
> +}
[...]
> +
> +/**
> + * __prci_register_clocks() - register clock controls in the PRCI with L=
inux
> + * @dev: Linux struct device *
> + *
> + * Register the list of clock controls described in __prci_init_plls[] w=
ith
> + * the Linux clock framework.
> + *
> + * Return: 0 upon success or a negative Linux error code upon failure.

This is all Linux, so drop the "Linux" part?

> + */
> +static int __prci_register_clocks(struct device *dev)
> +{
> +       struct __prci_data *pd =3D dev_get_drvdata(dev);
> +       struct clk_init_data init;
> +       struct __prci_clock *pic;
> +       int parent_count, i, clk_hw_count, r;
> +
> +       parent_count =3D of_clk_get_parent_count(dev->of_node);
> +       if (parent_count !=3D EXPECTED_CLK_PARENT_COUNT) {
> +               dev_err(dev, "expected two parent clocks, only found %d\n=
",
> +                       parent_count);

Heh, this would read funny if it says "expected two parent clocks, only
found 50". Can this be enforced with DT schema instead of checking at
runtime in the driver? We don't typically validate DT in the kernel
because the kernel is not a DT validator.

> +               return -EINVAL;
> +       }
> +
> +       memset(&init, 0, sizeof(struct clk_init_data));
> +
> +       /* Register PLLs */
> +       clk_hw_count =3D sizeof(__prci_init_clocks) / sizeof(struct __prc=
i_clock);
> +
> +       for (i =3D 0; i < clk_hw_count; ++i) {
> +               pic =3D &__prci_init_clocks[i];
> +
> +               init.name =3D pic->name;
> +               init.parent_names =3D (const char *[]) { pic->parent_name=
 };

Just use &pic->parent_name instead?

> +               init.num_parents =3D 1;
> +               init.ops =3D pic->ops;
> +               init.flags =3D CLK_IGNORE_UNUSED;

Why? Can you remove it? Or add a comment indicating why you need to have
it here?

> +               pic->hw.init =3D &init;
> +
> +               pic->pd =3D pd;
> +
> +               if (pic->pwd)
> +                       __prci_wrpll_read_cfg(pd, pic->pwd);
> +
> +               r =3D devm_clk_hw_register(dev, &pic->hw);
> +               if (r) {
> +                       dev_warn(dev, "Failed to register clock %s: %d\n",
> +                                init.name, r);
> +                       return r;
> +               }
> +
> +               r =3D clk_hw_register_clkdev(&pic->hw, pic->name, dev_nam=
e(dev));

Do you need clkdev? I would avoid clkdev if possible and just use DT
based lookups until you need clkdev.

> +               if (r) {
> +                       dev_warn(dev, "Failed to register clkdev for %s: =
%d\n",
> +                                init.name, r);
> +                       return r;
> +               }
> +
> +               pd->hw_clks.hws[i] =3D &pic->hw;
> +       }
> +
> +       pd->hw_clks.num =3D i;
> +
> +       r =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                       &pd->hw_clks);
> +       if (r) {
> +               dev_err(dev, "could not add hw_provider: %d\n", r);
> +               return -EINVAL;

Why override error code?

> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Linux device model integration
> + *
> + * See the Linux device model documentation for more information about
> + * these functions.
> + */
> +static int sifive_fu540_prci_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *res;
> +       struct __prci_data *pd;
> +       int r;
> +
> +       pd =3D devm_kzalloc(dev, sizeof(struct __prci_data), GFP_KERNEL);

sizeof(*pd) please, makes shorter lines and avoids types changing.

> +       if (!pd)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(dev, pd);

Why not just pass the pd to __prci_register_clocks() and not have any
driver data?

> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pd->va =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(pd->va))
> +               return PTR_ERR(pd->va);

Cool!

> +
> +       r =3D __prci_register_clocks(dev);
> +       if (r) {
> +               dev_err(dev, "could not register clocks: %d\n", r);
> +               return -EINVAL;

But we override return value and always return -EINVAL? Why not return
r?

> +       }
> +
> +       dev_info(dev, "SiFive FU540 PRCI probed\n");

Please no "I'm alive!" messages.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sifive_fu540_prci_of_match[] =3D {
> +       { .compatible =3D "sifive,fu540-c000-prci0", },
> +       {}
> +};

Can it be a module? If so, add an MODULE_DEVICE_TABLE(of, ...) here.

> +
> +static struct platform_driver sifive_fu540_prci_driver =3D {
> +       .driver =3D {
> +               .name =3D "sifive-fu540-prci",
> +               .of_match_table =3D sifive_fu540_prci_of_match,

And consider suppressing unbind from sysfs here if you don't want that
feature.

> +       },
> +       .probe =3D sifive_fu540_prci_probe,

Especially because there isn't a remove function.

> +};
> +
> +static int __init sifive_fu540_prci_init(void)
> +{
> +       return platform_driver_register(&sifive_fu540_prci_driver);
> +}
> +core_initcall(sifive_fu540_prci_init);
> diff --git a/include/linux/clk/sifive-fu540-prci.h b/include/linux/clk/si=
five-fu540-prci.h
> new file mode 100644
> index 000000000000..5d03eae7d4ef
> --- /dev/null
> +++ b/include/linux/clk/sifive-fu540-prci.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 SiFive, Inc.
> + * Wesley Terpstra
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Same SPDX comments apply here.

> + */
> +
> +#ifndef __LINUX_CLK_SIFIVE_FU540_PRCI_H
> +#define __LINUX_CLK_SIFIVE_FU540_PRCI_H
> +
> +/* Clock indexes for use by Device Tree data */

Seems obvious, but OK!

> +
> +#define PRCI_CLK_COREPLL               0
> +#define PRCI_CLK_DDRPLL                        1
> +#define PRCI_CLK_GEMGXLPLL             2
> +#define PRCI_CLK_TLCLK                 3
> +
> +#endif
> -- =

> 2.19.1
>=20
