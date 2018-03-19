Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971133AbeCSUK2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966634AbeCSUJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:09:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1C3204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Jolly Shah <jolly.shah@xilinx.com>, linux-clk@vger.kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@codeaurora.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1519856861-31384-4-git-send-email-jollys@xilinx.com>
Cc: rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>, Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-4-git-send-email-jollys@xilinx.com>
Message-ID: <152149019011.242365.2529338400397080149@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
Date: Mon, 19 Mar 2018 13:09:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-02-28 14:27:41)
> This patch adds CCF compliant clock driver for ZynqMP.
> Clock driver queries supported clock information from
> firmware and regiters pll and output clocks with CCF.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Tejas Patel <tejasp@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Your signoff should go last.

> diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
> new file mode 100644
> index 0000000..4f548bf
> --- /dev/null
> +++ b/drivers/clk/zynqmp/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +config COMMON_CLK_ZYNQMP
> +       bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
> +       depends on OF
> +       depends on ARCH_ZYNQMP || COMPILE_TEST
> +       help
> +         Support for the Zynqmp Ultrascale clock controller.
> +         It has a dependency on the PMU firmware.

So there should be a depends on for that?

> +         Say Y if you want to support clock support
> diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
> new file mode 100644
> index 0000000..3b11134
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Zynq UltraScale+ MPSoC clock controller
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + *
> + * Gated clock implementation
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk/zynqmp.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +
> +/**
> + * struct clk_gate - gating clock
> + *
> + * @hw:        handle between common and hardware-specific interfaces
> + * @flags:     hardware-specific flags

Are you using these flags?

> + * @clk_id:    Id of clock
> + */
> +struct zynqmp_clk_gate {
> +       struct clk_hw hw;
> +       u8 flags;
> +       u32 clk_id;
> +};
> +
> +#define to_zynqmp_clk_gate(_hw) container_of(_hw, struct zynqmp_clk_gate, hw)
> +
> +/**
> + * zynqmp_clk_gate_enable - Enable clock
> + * @hw: handle between common and hardware-specific interfaces
> + *
> + * Return: 0 always
> + */
> +static int zynqmp_clk_gate_enable(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = gate->clk_id;
> +       int ret = 0;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_enable)
> +               return -ENXIO;
> +
> +       ret = eemi_ops->clock_enable(clk_id);
> +
> +       if (ret)
> +               pr_warn_once("%s() clock enabled failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return 0;

But we don't return failure if it fails?

> +}
> +
> +/*
> + * zynqmp_clk_gate_disable - Disable clock
> + * @hw: handle between common and hardware-specific interfaces
> + */
> +static void zynqmp_clk_gate_disable(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = gate->clk_id;
> +       int ret = 0;

Please don't assign things and then reassign them without using them
in between the two.

> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_disable)
> +               return;
> +
> +       ret = eemi_ops->clock_disable(clk_id);
> +
> +       if (ret)
> +               pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +}
> +
> +/**
> + * zynqmp_clk_gate_is_enable - Check clock state
> + * @hw: handle between common and hardware-specific interfaces
> + *
> + * Return: 1 if enabled, 0 if disabled
> + */
> +static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = gate->clk_id;
> +       int state, ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_getstate)
> +               return 0;
> +
> +       ret = eemi_ops->clock_getstate(clk_id, &state);
> +       if (ret)
> +               pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return state ? 1 : 0;

If it fails to read does state get set, or we just return junk state?

> +}
> +
> +const struct clk_ops zynqmp_clk_gate_ops = {
> +       .enable = zynqmp_clk_gate_enable,
> +       .disable = zynqmp_clk_gate_disable,
> +       .is_enabled = zynqmp_clk_gate_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(zynqmp_clk_gate_ops);
> +
> +/**
> + * zynqmp_clk_register_gate - register a gate clock with the clock framework
> + * @dev: device that is registering this clock
> + * @name: name of this clock
> + * @clk_id: Id of this clock
> + * @parents: name of this clock's parents
> + * @num_parents: number of parents
> + * @flags: framework-specific flags for this clock
> + * @clk_gate_flags: gate-specific flags for this clock
> + *
> + * Return: clock handle of the registered clock gate
> + */
> +struct clk *zynqmp_clk_register_gate(struct device *dev, const char *name,
> +                                    u32 clk_id, const char * const *parents,
> +                                    u8 num_parents, unsigned long flags,
> +                                    u8 clk_gate_flags)
> +{
> +       struct zynqmp_clk_gate *gate;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       /* allocate the gate */
> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &zynqmp_clk_gate_ops;
> +       init.flags = flags;
> +       init.parent_names = parents;

This could be a string that we create a pointer to right here because...

> +       init.num_parents = num_parents;

this should always be 1?

> +
> +       /* struct clk_gate assignments */
> +       gate->flags = clk_gate_flags;
> +       gate->hw.init = &init;
> +       gate->clk_id = clk_id;
> +
> +       clk = clk_register(dev, &gate->hw);

Please use clk_hw_register().

> +
> +       if (IS_ERR(clk))
> +               kfree(gate);
> +
> +       return clk;
> +}
> diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> new file mode 100644
> index 0000000..9632b15
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Zynq UltraScale+ MPSoC mux
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk/zynqmp.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +
> +/*
> + * DOC: basic adjustable multiplexer clock that cannot gate
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is only affected by parent switching.  No clk_set_rate support
> + * parent - parent is adjustable through clk_set_parent
> + */
> +
> +/**
> + * struct zynqmp_clk_mux - multiplexer clock
> + *
> + * @hw: handle between common and hardware-specific interfaces
> + * @flags: hardware-specific flags
> + * @clk_id: Id of clock
> + */
> +struct zynqmp_clk_mux {
> +       struct clk_hw hw;
> +       u8 flags;
> +       u32 clk_id;
> +};
> +
> +#define to_zynqmp_clk_mux(_hw) container_of(_hw, struct zynqmp_clk_mux, hw)
> +
> +/**
> + * zynqmp_clk_mux_get_parent - Get parent of clock
> + * @hw: handle between common and hardware-specific interfaces
> + *
> + * Return: Parent index
> + */
> +static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = mux->clk_id;
> +       u32 val;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_getparent)
> +               return -ENXIO;
> +
> +       ret = eemi_ops->clock_getparent(clk_id, &val);
> +
> +       if (ret)
> +               pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       if (val && (mux->flags & CLK_MUX_INDEX_BIT))
> +               val = ffs(val) - 1;
> +
> +       if (val && (mux->flags & CLK_MUX_INDEX_ONE))
> +               val--;
> +
> +       return val;
> +}
> +
> +/**
> + * zynqmp_clk_mux_set_parent - Set parent of clock
> + * @hw: handle between common and hardware-specific interfaces
> + * @index: Parent index
> + *
> + * Return: 0 always
> + */
> +static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = mux->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_setparent)
> +               return -ENXIO;
> +
> +       if (mux->flags & CLK_MUX_INDEX_BIT)
> +               index = 1 << index;
> +
> +       if (mux->flags & CLK_MUX_INDEX_ONE)
> +               index++;

Are you using the CLK_MUX_INDEX_BIT or CLK_MUX_INDEX_ONE flags? If not,
drop them.

> +
> +       ret = eemi_ops->clock_setparent(clk_id, index);
> +
> +       if (ret)
> +               pr_warn_once("%s() set parent failed for clock: %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops zynqmp_clk_mux_ops = {
> +       .get_parent = zynqmp_clk_mux_get_parent,
> +       .set_parent = zynqmp_clk_mux_set_parent,
> +       .determine_rate = __clk_mux_determine_rate,
> +};
> +EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ops);
> +
> +const struct clk_ops zynqmp_clk_mux_ro_ops = {
> +       .get_parent = zynqmp_clk_mux_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ro_ops);
> +
> +/**
> + * zynqmp_clk_register_mux_table - register a mux table with the clock framework
> + * @dev: device that is registering this clock
> + * @name: name of this clock
> + * @clk_id: Id of this clock
> + * @parent_names: name of this clock's parents
> + * @num_parents: number of parents
> + * @flags: framework-specific flags for this clock
> + * @clk_mux_flags: mux-specific flags for this clock
> + *
> + * Return: clock handle of the registered clock mux
> + */
> +struct clk *zynqmp_clk_register_mux_table(struct device *dev, const char *name,

Is this API used by anyone besides the mux code? It looks like clk-mux.c
was copied and then hacked up and this got left around with no user.

> +                                         u32 clk_id,
> +                                         const char * const *parent_names,
> +                                         u8 num_parents,
> +                                         unsigned long flags,
> +                                         u8 clk_mux_flags)
> +{
> +       struct zynqmp_clk_mux *mux;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       /* allocate the mux */
> +       mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +       if (!mux)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       if (clk_mux_flags & CLK_MUX_READ_ONLY)
> +               init.ops = &zynqmp_clk_mux_ro_ops;
> +       else
> +               init.ops = &zynqmp_clk_mux_ops;
> +       init.flags = flags;
> +       init.parent_names = parent_names;
> +       init.num_parents = num_parents;
> +
> +       /* struct clk_mux assignments */
> +       mux->flags = clk_mux_flags;
> +       mux->hw.init = &init;
> +       mux->clk_id = clk_id;
> +
> +       clk = clk_register(dev, &mux->hw);
> +
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> new file mode 100644
> index 0000000..f4b5d15
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -0,0 +1,712 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Zynq UltraScale+ MPSoC clock controller
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + *
> + * Based on drivers/clk/zynq/clkc.c
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk/zynqmp.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#define MAX_PARENT                     100
> +#define MAX_NODES                      6
> +#define MAX_NAME_LEN                   50
> +#define MAX_CLOCK                      300
> +
> +#define CLK_INIT_ENABLE_SHIFT          1
> +#define CLK_TYPE_SHIFT                 2
> +
> +#define PM_API_PAYLOAD_LEN             3
> +
> +#define NA_PARENT                      -1
> +#define DUMMY_PARENT                   -2
> +
> +#define CLK_TYPE_FIELD_LEN             4
> +#define CLK_TOPOLOGY_NODE_OFFSET       16
> +#define NODES_PER_RESP                 3
> +
> +#define CLK_TYPE_FIELD_MASK            0xF
> +#define CLK_FLAG_FIELD_SHIFT           8
> +#define CLK_FLAG_FIELD_MASK            0x3FFF
> +#define CLK_TYPE_FLAG_FIELD_SHIFT      24
> +#define CLK_TYPE_FLAG_FIELD_MASK       0xFF
> +
> +#define CLK_PARENTS_ID_LEN             16
> +#define CLK_PARENTS_ID_MASK            0xFFFF
> +
> +/* Flags for parents */
> +#define PARENT_CLK_SELF                        0
> +#define PARENT_CLK_NODE1               1
> +#define PARENT_CLK_NODE2               2
> +#define PARENT_CLK_NODE3               3
> +#define PARENT_CLK_NODE4               4
> +#define PARENT_CLK_EXTERNAL            5
> +
> +#define END_OF_CLK_NAME                        "END_OF_CLK"
> +#define RESERVED_CLK_NAME              ""

These two look odd.

> +
> +#define CLK_VALID_MASK                 0x1
> +#define CLK_INIT_ENABLE_MASK           (0x1 << CLK_INIT_ENABLE_SHIFT)
> +
> +enum clk_type {
> +       CLK_TYPE_OUTPUT,
> +       CLK_TYPE_EXTERNAL,
> +};
> +
> +/**
> + * struct clock_parent - Structure for parent of clock
> + * @name:      Parent name
> + * @id:                Parent clock ID
> + * @flag:      Parent flags
> + */
> +struct clock_parent {
> +       char name[MAX_NAME_LEN];
> +       int id;
> +       u32 flag;
> +};
> +
> +/**
> + * struct clock_topology - Structure for topology of clock
> + * @type:      Type of topology
> + * @flag:      Topology flags
> + * @type_flag: Topology type specific flag
> + */
> +struct clock_topology {
> +       u32 type;
> +       u32 flag;
> +       u32 type_flag;
> +};
> +
> +/**
> + * struct zynqmp_clock - Structure for clock
> + * @clk_name:          Clock name
> + * @valid:             Validity flag of clock
> + * @init_enable:       init_enable flag of clock
> + * @type:              Clock type (Output/External)
> + * @node:              Clock tolology nodes
> + * @num_nodes:         Number of nodes present in topology
> + * @parent:            structure of parent of clock
> + * @num_parents:       Number of parents of clock
> + */
> +struct zynqmp_clock {
> +       char clk_name[MAX_NAME_LEN];
> +       u32 valid;
> +       u32 init_enable;
> +       enum clk_type type;

Is this ever assigned?

> +       struct clock_topology node[MAX_NODES];
> +       u32 num_nodes;
> +       struct clock_parent parent[MAX_PARENT];
> +       u32 num_parents;
> +};
> +
> +static const char clk_type_postfix[][10] = {
> +       [TYPE_INVALID] = "",
> +       [TYPE_MUX] = "_mux",
> +       [TYPE_GATE] = "",
> +       [TYPE_DIV1] = "_div1",
> +       [TYPE_DIV2] = "_div2",
> +       [TYPE_FIXEDFACTOR] = "_ff",
> +       [TYPE_PLL] = ""
> +};
> +
> +static struct zynqmp_clock clock[MAX_CLOCK];
> +static struct clk_onecell_data zynqmp_clk_data;
> +static struct clk *zynqmp_clks[MAX_CLOCK];
> +static unsigned int clock_max_idx;
> +static const struct zynqmp_eemi_ops *eemi_ops;
> +
> +/**
> + * is_valid_clock() - Check whether clock is valid or not
> + * @clk_id:    Clock index.
> + * @valid:     1: if clock is valid.
> + *             0: invalid clock.
> + *
> + * Return: 0 on success else error code.
> + */
> +static int is_valid_clock(u32 clk_id, u32 *valid)
> +{
> +       if (clk_id < 0 || clk_id > clock_max_idx)

clk_id is unsigned, this is impossible.

> +               return -ENODEV;
> +
> +       *valid = clock[clk_id].valid;
> +
> +       return *valid ? 0 : -EINVAL;
> +}
> +
> +/**
> + * zynqmp_get_clock_name() - Get name of clock from Clock index
> + * @clk_id:    Clock index.
> + * @clk_name:  Name of clock.
> + *
> + * Return: 0 on success else error code.
> + */
> +static int zynqmp_get_clock_name(u32 clk_id, char *clk_name)

Please add zynqmp_ prefix to all these APIs, not just this one.

> +{
> +       int ret;
> +       u32 valid;
> +
> +       ret = is_valid_clock(clk_id, &valid);
> +       if (!ret && valid) {
> +               strncpy(clk_name, clock[clk_id].clk_name, MAX_NAME_LEN);
> +               return 0;
> +       } else {
> +               return ret;
> +       }
> +}
> +
> +/**
> + * get_clock_type() - Get type of clock
> + * @clk_id:    Clock index.
> + * @type:      Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL.
> + *
> + * Return: 0 on success else error code.
> + */
> +static int get_clock_type(u32 clk_id, u32 *type)
> +{
> +       int ret;
> +       u32 valid;
> +
> +       ret = is_valid_clock(clk_id, &valid);
> +       if (!ret && valid) {
> +               *type = clock[clk_id].type;
> +               return 0;
> +       } else {
> +               return ret;
> +       }

replace with return ret;

> +}
> +
[...]
> +
> +/**
> + * zynqmp_pm_clock_get_fixedfactor_params() - Get clock's fixed factor params
> + * @clock_id:  Clock ID.
> + * @mul:       Multiplication value.
> + * @div:       Divisor value.
> + *
> + * This function is used to get fixed factor parameers for the fixed
> + * clock. This API is application only for the fixed clock.

That last sentence doesn't make sense. s/application/applicable/
perhaps?

> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_get_fixedfactor_params(u32 clock_id,
> +                                                 u32 *mul,
> +                                                 u32 *div)
> +{
> +       struct zynqmp_pm_query_data qdata = {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +
> +       qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
> +       qdata.arg1 = clock_id;
> +
> +       ret = eemi_ops->query_data(qdata, ret_payload);
> +       *mul = ret_payload[1];
> +       *div = ret_payload[2];
> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_parents() - Get the first 3 parents of clock for given id
> + * @clock_id:  Clock ID.
> + * @index:     Parent index.
> + * @parents:   3 parents of the given clock.
> + *
> + * This function is used to get 3 parents for the clock specified by
> + * given clock ID.
> + *
> + * This API will return 3 parents with a single response. To get
> + * other parents, master should call same API in loop with new
> + * parent index till error is returned. E.g First call should have
> + * index 0 which will return parents 0,1 and 2. Next call, index
> + * should be 3 which will return parent 3,4 and 5 and so on.
> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32 *parents)
> +{
> +       struct zynqmp_pm_query_data qdata = {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +
> +       qdata.qid = PM_QID_CLOCK_GET_PARENTS;
> +       qdata.arg1 = clock_id;
> +       qdata.arg2 = index;
> +
> +       ret = eemi_ops->query_data(qdata, ret_payload);
> +       memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS * 4);

Is 4 sizeof(u32)? Or is it supposed to be 3 for the 3 parents returned?

> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_attributes() - Get the attributes of clock for given id
> + * @clock_id:  Clock ID.
> + * @attr:      Clock attributes.
> + *
> + * This function is used to get clock's attributes(e.g. valid, clock type, etc).
> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_get_attributes(u32 clock_id, u32 *attr)
> +{
> +       struct zynqmp_pm_query_data qdata = {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +
> +       qdata.qid = PM_QID_CLOCK_GET_ATTRIBUTES;
> +       qdata.arg1 = clock_id;
> +
> +       ret = eemi_ops->query_data(qdata, ret_payload);
> +       memcpy(attr, &ret_payload[1], CLK_GET_ATTR_RESP_WORDS * 4);

Can this just be sizeof(*attr)?

> +
> +       return ret;
> +}
> +
> +/**
> + * clock_get_topology() - Get topology of clock from firmware using PM_API
> + * @clk_id:    Clock index.
> + * @clk_topology: Structure of clock topology.
> + * @num_nodes: number of nodes.
> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static int clock_get_topology(u32 clk_id, struct clock_topology *clk_topology,
> +                             u32 *num_nodes)
> +{
> +       int j, k = 0, ret;
> +       u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
> +
> +       *num_nodes = 0;
> +       for (j = 0; j <= MAX_NODES; j += 3) {
> +               ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
> +               if (ret)
> +                       return ret;
> +               for (k = 0; k < PM_API_PAYLOAD_LEN; k++) {
> +                       if (!(pm_resp[k] & CLK_TYPE_FIELD_MASK))
> +                               goto done;

return 0;

> +                       clk_topology[*num_nodes].type = pm_resp[k] &
> +                                                       CLK_TYPE_FIELD_MASK;
> +                       clk_topology[*num_nodes].flag =
> +                                       (pm_resp[k] >> CLK_FLAG_FIELD_SHIFT) &
> +                                       CLK_FLAG_FIELD_MASK;
> +                       clk_topology[*num_nodes].type_flag =
> +                               (pm_resp[k] >> CLK_TYPE_FLAG_FIELD_SHIFT) &
> +                               CLK_TYPE_FLAG_FIELD_MASK;

Use FIELD_GET() for these?

> +                       (*num_nodes)++;
> +               }
> +       }
> +done:

Drop label

> +       return 0;
> +}
> +
> +/**
> + * clock_get_parents() - Get parents info from firmware using PM_API
> + * @clk_id:            Clock index.
> + * @parents:           Structure of parent information.
> + * @num_parents:       Total number of parents.
> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static int clock_get_parents(u32 clk_id, struct clock_parent *parents,
> +                            u32 *num_parents)
> +{
> +       int j = 0, k, ret, total_parents = 0;
> +       u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
> +
> +       do {
> +               /* Get parents from firmware */
> +               ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
> +               if (ret)
> +                       return ret;
> +
> +               for (k = 0; k < PM_API_PAYLOAD_LEN; k++) {
> +                       if (pm_resp[k] == (u32)NA_PARENT) {

Make pm_resp signed? Or specify *_PARENT in hex form.

> +                               *num_parents = total_parents;
> +                               return 0;
> +                       }
> +
> +                       parents[k + j].id = pm_resp[k] & CLK_PARENTS_ID_MASK;

Please grow a local variable for parents[k + j].

> +                       if (pm_resp[k] == (u32)DUMMY_PARENT) {
> +                               strncpy(parents[k + j].name,
> +                                       "dummy_name", MAX_NAME_LEN);
> +                               parents[k + j].flag = 0;
> +                       } else {
> +                               parents[k + j].flag = pm_resp[k] >>
> +                                                       CLK_PARENTS_ID_LEN;
> +                               if (zynqmp_get_clock_name(parents[k + j].id,
> +                                                         parents[k + j].name))
> +                                       continue;
> +                       }
> +                       total_parents++;
> +               }
> +               j += PM_API_PAYLOAD_LEN;
> +       } while (total_parents <= MAX_PARENT);
> +       return 0;
> +}
> +
> +/**
> + * get_parent_list() - Create list of parents name
> + * @np:                        Device node.
> + * @clk_id:            Clock index.
> + * @parent_list:       List of parent's name.
> + * @num_parents:       Total number of parents.

Please drop full stop on kernel doc descriptions of variables.

> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static int get_parent_list(struct device_node *np, u32 clk_id,
> +                          const char **parent_list, u32 *num_parents)
> +{
> +       int i = 0, ret;
> +       u32 total_parents = clock[clk_id].num_parents;
> +       struct clock_topology *clk_nodes;
> +       struct clock_parent *parents;
> +
> +       clk_nodes = clock[clk_id].node;
> +       parents = clock[clk_id].parent;
> +
> +       for (i = 0; i < total_parents; i++) {
> +               if (!parents[i].flag) {
> +                       parent_list[i] = parents[i].name;
> +               } else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
> +                       ret = of_property_match_string(np, "clock-names",
> +                                                      parents[i].name);
> +                       if (ret < 0)
> +                               strncpy(parents[i].name,
> +                                       "dummy_name", MAX_NAME_LEN);
> +                       parent_list[i] = parents[i].name;
> +               } else {
> +                       strcat(parents[i].name,
> +                              clk_type_postfix[clk_nodes[parents[i].flag - 1].
> +                              type]);
> +                       parent_list[i] = parents[i].name;
> +               }
> +       }
> +
> +       *num_parents = total_parents;
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_register_clk_topology() - Register clock topology
> + * @clk_id:            Clock index.
> + * @clk_name:          Clock Name.
> + * @num_parents:       Total number of parents.
> + * @parent_names:      List of parents name.
> + *
> + * Return: Returns status, either success or error+reason.
> + */
> +static struct clk *zynqmp_register_clk_topology(int clk_id, char *clk_name,
> +                                               int num_parents,
> +                                               const char **parent_names)
> +{
> +       int j, ret;
> +       u32 num_nodes, mult, div;
> +       char *clk_out = NULL;
> +       struct clock_topology *nodes;
> +       struct clk *clk = NULL;
> +
> +       nodes = clock[clk_id].node;
> +       num_nodes = clock[clk_id].num_nodes;
> +
> +       for (j = 0; j < num_nodes; j++) {
> +               if (j != (num_nodes - 1)) {

Why is last node special? Add a comment to the code.

> +                       clk_out = kasprintf(GFP_KERNEL, "%s%s", clk_name,
> +                                           clk_type_postfix[nodes[j].type]);
> +               } else {
> +                       clk_out = kasprintf(GFP_KERNEL, "%s", clk_name);
> +               }
> +
> +               switch (nodes[j].type) {
> +               case TYPE_MUX:
> +                       clk = zynqmp_clk_register_mux(NULL, clk_out,
> +                                                     clk_id, parent_names,
> +                                                     num_parents,
> +                                                     nodes[j].flag,
> +                                                     nodes[j].type_flag);
> +                       break;
> +               case TYPE_PLL:
> +                       clk = clk_register_zynqmp_pll(clk_out, clk_id,
> +                                                     parent_names, 1,
> +                                                     nodes[j].flag);
> +                       break;
> +               case TYPE_FIXEDFACTOR:
> +                       ret = zynqmp_pm_clock_get_fixedfactor_params(clk_id,
> +                                                                    &mult,
> +                                                                    &div);
> +                       clk = clk_register_fixed_factor(NULL, clk_out,
> +                                                       parent_names[0],
> +                                                       nodes[j].flag, mult,
> +                                                       div);
> +                       break;
> +               case TYPE_DIV1:
> +               case TYPE_DIV2:
> +                       clk = zynqmp_clk_register_divider(NULL, clk_out, clk_id,
> +                                                         nodes[j].type,
> +                                                         parent_names, 1,
> +                                                         nodes[j].flag,
> +                                                         nodes[j].type_flag);
> +                       break;
> +               case TYPE_GATE:
> +                       clk = zynqmp_clk_register_gate(NULL, clk_out, clk_id,
> +                                                      parent_names, 1,
> +                                                      nodes[j].flag,
> +                                                      nodes[j].type_flag);
> +                       break;
> +               default:
> +                       pr_err("%s() Unknown topology for %s\n",
> +                              __func__, clk_out);
> +                       break;
> +               }
> +               if (IS_ERR(clk))
> +                       pr_warn_once("%s() %s register fail with %ld\n",
> +                                    __func__, clk_name, PTR_ERR(clk));
> +
> +               parent_names[0] = clk_out;
> +       }
> +       kfree(clk_out);
> +       return clk;
> +}
> +
> +/**
> + * zynqmp_register_clocks() - Register clocks
> + * @np:                Device node.
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_register_clocks(struct device_node *np)
> +{
> +       int ret;
> +       u32 i, total_parents = 0, type = 0;
> +       const char *parent_names[MAX_PARENT];
> +
> +       for (i = 0; i < clock_max_idx; i++) {
> +               char clk_name[MAX_NAME_LEN];
> +
> +               /* get clock name, continue to next clock if name not found */
> +               if (zynqmp_get_clock_name(i, clk_name))
> +                       continue;
> +
> +               /* Check if clock is valid and output clock.
> +                * Do not regiter invalid or external clock.
> +                */
> +               ret = get_clock_type(i, &type);
> +               if (ret || type != CLK_TYPE_OUTPUT)
> +                       continue;
> +
> +               /* Get parents of clock*/
> +               if (get_parent_list(np, i, parent_names, &total_parents)) {
> +                       WARN_ONCE(1, "No parents found for %s\n",
> +                                 clock[i].clk_name);
> +                       continue;
> +               }
> +
> +               zynqmp_clks[i] = zynqmp_register_clk_topology(i, clk_name,
> +                                                             total_parents,
> +                                                             parent_names);
> +
> +               /* Enable clock if init_enable flag is 1 */
> +               if (clock[i].init_enable)
> +                       clk_prepare_enable(zynqmp_clks[i]);

Use critical clock flag instead?

> +       }
> +
> +       for (i = 0; i < clock_max_idx; i++) {
> +               if (IS_ERR(zynqmp_clks[i])) {
> +                       pr_err("Zynq Ultrascale+ MPSoC clk %s: register failed with %ld\n",
> +                              clock[i].clk_name, PTR_ERR(zynqmp_clks[i]));
> +                       WARN_ON(1);
> +               }
> +       }
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_get_clock_info() - Get clock information from firmware using PM_API
> + */
> +static void zynqmp_get_clock_info(void)
> +{
> +       int i, ret;
> +       u32 attr, type = 0;
> +
> +       memset(clock, 0, sizeof(clock));
> +       for (i = 0; i < MAX_CLOCK; i++) {
> +               zynqmp_pm_clock_get_name(i, clock[i].clk_name);
> +               if (!strncmp(clock[i].clk_name, END_OF_CLK_NAME,
> +                            MAX_NAME_LEN)) {

Just strcmp? END_OF_CLK_NAME has a known length.

> +                       clock_max_idx = i;
> +                       break;
> +               } else if (!strncmp(clock[i].clk_name, RESERVED_CLK_NAME,
> +                                   MAX_NAME_LEN)) {
> +                       continue;
> +               }
> +
> +               ret = zynqmp_pm_clock_get_attributes(i, &attr);
> +               if (ret)
> +                       continue;
> +
> +               clock[i].valid = attr & CLK_VALID_MASK;
> +               clock[i].init_enable = !!(attr & CLK_INIT_ENABLE_MASK);
> +               clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
> +                                                       CLK_TYPE_OUTPUT;
> +       }
> +
> +       /* Get topology of all clock */
> +       for (i = 0; i < clock_max_idx; i++) {
> +               ret = get_clock_type(i, &type);
> +               if (ret || type != CLK_TYPE_OUTPUT)
> +                       continue;
> +
> +               ret = clock_get_topology(i, clock[i].node, &clock[i].num_nodes);
> +               if (ret)
> +                       continue;
> +
> +               ret = clock_get_parents(i, clock[i].parent,
> +                                       &clock[i].num_parents);
> +               if (ret)
> +                       continue;
> +       }
> +}
> +
> +/**
> + * zynqmp_clk_setup() - Setup the clock framework and register clocks
> + * @np:                Device node
> + */
> +static void __init zynqmp_clk_setup(struct device_node *np)
> +{
> +       int idx;
> +
> +       idx = of_property_match_string(np, "clock-names", "pss_ref_clk");
> +       if (idx < 0) {
> +               pr_err("pss_ref_clk not provided\n");
> +               return;
> +       }
> +       idx = of_property_match_string(np, "clock-names", "video_clk");
> +       if (idx < 0) {
> +               pr_err("video_clk not provided\n");
> +               return;
> +       }
> +       idx = of_property_match_string(np, "clock-names", "pss_alt_ref_clk");
> +       if (idx < 0) {
> +               pr_err("pss_alt_ref_clk not provided\n");
> +               return;
> +       }
> +       idx = of_property_match_string(np, "clock-names", "aux_ref_clk");
> +       if (idx < 0) {
> +               pr_err("aux_ref_clk not provided\n");
> +               return;
> +       }
> +       idx = of_property_match_string(np, "clock-names", "gt_crx_ref_clk");
> +       if (idx < 0) {
> +               pr_err("aux_ref_clk not provided\n");
> +               return;
> +       }

Why are we doing all this? Please don't verify DT contents in driver
code.

> +
> +       zynqmp_get_clock_info();
> +       zynqmp_register_clocks(np);
> +
> +       zynqmp_clk_data.clks = zynqmp_clks;
> +       zynqmp_clk_data.clk_num = clock_max_idx;
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &zynqmp_clk_data);

Use the clk_hw provider registration method please.

> +}
> +
> +/**
> + * zynqmp_clock_init() - Initialize zynqmp clocks
> + *
> + * Return: 0 always

Why not error too?

> + */
> +static int __init zynqmp_clock_init(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> +       if (!np)
> +               return 0;
> +       of_node_put(np);
> +
> +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clkc");
> +       if (np)
> +               panic("%s: %s binding is deprecated, please use new DT binding\n",
> +                      __func__, np->name);

Is this already present in mainline? Drop this check?

> +
> +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clk");
> +       if (!np) {
> +               pr_err("%s: clk node not found\n", __func__);
> +               of_node_put(np);
> +               return 0;
> +       }
> +
> +       eemi_ops = zynqmp_pm_get_eemi_ops();
> +       if (!eemi_ops || !eemi_ops->query_data) {
> +               pr_err("%s: clk data not found\n", __func__);
> +               of_node_put(np);
> +               return 0;
> +       }
> +
> +       zynqmp_clk_setup(np);

Preferably this all moves to a platform driver that gets registered by
the eemi_ops code.

> +
> +       return 0;
> +}
> +arch_initcall(zynqmp_clock_init);
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> new file mode 100644
> index 0000000..cea908f
> --- /dev/null
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Zynq UltraScale+ MPSoC Divider support
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + *
> + * Adjustable divider clock implementation
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk/zynqmp.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include <linux/log2.h>

Used?

> +
> +/*
> + * DOC: basic adjustable divider clock that cannot gate
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is adjustable.  clk->rate = ceiling(parent->rate / divisor)
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +#define to_zynqmp_clk_divider(_hw)             \
> +       container_of(_hw, struct zynqmp_clk_divider, hw)
> +
> +/**
> + * struct zynqmp_clk_divider - adjustable divider clock
> + *
> + * @hw:        handle between common and hardware-specific interfaces
> + * @flags: Hardware specific flags
> + * @clk_id: Id of clock
> + * @div_type: divisor type (TYPE_DIV1 or TYPE_DIV2)
> + */
> +struct zynqmp_clk_divider {
> +       struct clk_hw hw;
> +       u8 flags;
> +       u32 clk_id;
> +       u32 div_type;
> +};
> +
> +static int zynqmp_divider_get_val(unsigned long parent_rate, unsigned long rate)
> +{
> +       return DIV_ROUND_CLOSEST(parent_rate, rate);
> +}
> +
> +static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
> +                                                   unsigned long parent_rate)
> +{
> +       struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = divider->clk_id;
> +       u32 div_type = divider->div_type;
> +       u32 div, value;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_getdivider)
> +               return -ENXIO;

Can we just not register these clks or something if the eemi_ops or type
of ops isn't present? Checking this all the time is not good.

> +
> +       ret = eemi_ops->clock_getdivider(clk_id, &div);
> +
> +       if (ret)
> +               pr_warn_once("%s() get divider failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       if (div_type == TYPE_DIV1)
> +               value = div & 0xFFFF;
> +       else
> +               value = (div >> 16) & 0xFFFF;
> +
> +       if (!value) {
> +               WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
> +                    "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
> +                    clk_name);

Do you use this flag? Copy-paste?

> +               return parent_rate;
> +       }
> +
> +       return DIV_ROUND_UP_ULL(parent_rate, value);
> +}
> +
> +static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
> +                                         unsigned long rate,
> +                                         unsigned long *prate)
> +{
> +       struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = divider->clk_id;
> +       u32 div_type = divider->div_type;
> +       u32 bestdiv;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_getdivider)
> +               return -ENXIO;
> +
> +       /* if read only, just return current value */
> +       if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> +               ret = eemi_ops->clock_getdivider(clk_id, &bestdiv);
> +
> +               if (ret)
> +                       pr_warn_once("%s() get divider failed for %s, ret = %d\n",
> +                                    __func__, clk_name, ret);
> +               if (div_type == TYPE_DIV1)
> +                       bestdiv = bestdiv & 0xFFFF;
> +               else
> +                       bestdiv  = (bestdiv >> 16) & 0xFFFF;
> +
> +               return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
> +       }
> +
> +       bestdiv = zynqmp_divider_get_val(*prate, rate);
> +
> +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
> +           ((clk_hw_get_flags(hw) & CLK_FRAC)))

Too many parenthesis here.

> +               bestdiv = rate % *prate ? 1 : bestdiv;
> +       *prate = rate * bestdiv;
> +
> +       return rate;
> +}
> +
> +/**
> + * zynqmp_clk_divider_set_rate - Set rate of divider clock
> + * @hw:        handle between common and hardware-specific interfaces
> + * @rate: rate of clock to be set
> + * @parent_rate: rate of parent clock
> + *
> + * Return: 0 always
> + */
> +static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                      unsigned long parent_rate)
> +{
> +       struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = divider->clk_id;
> +       u32 div_type = divider->div_type;
> +       u32 value, div;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_setdivider)
> +               return -ENXIO;
> +
> +       value = zynqmp_divider_get_val(parent_rate, rate);
> +       if (div_type == TYPE_DIV1) {
> +               div = value & 0xFFFF;
> +               div |= ((u16)-1) << 16;

div |= 0xffff << 16;

> +       } else {
> +               div = ((u16)-1);

div = 0xffff;

> +               div |= value << 16;
> +       }
> +
> +       ret = eemi_ops->clock_setdivider(clk_id, div);
> +
> +       if (ret)
> +               pr_warn_once("%s() set divider failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops zynqmp_clk_divider_ops = {
> +       .recalc_rate = zynqmp_clk_divider_recalc_rate,
> +       .round_rate = zynqmp_clk_divider_round_rate,
> +       .set_rate = zynqmp_clk_divider_set_rate,
> +};
> +
> +/**
> + * _register_divider - register a divider clock
> + * @dev: device registering this clock
> + * @name: name of this clock
> + * @clk_id: Id of clock
> + * @div_type: Type of divisor
> + * @parents: name of clock's parents
> + * @num_parents: number of parents
> + * @flags: framework-specific flags
> + * @clk_divider_flags: divider-specific flags for this clock
> + *
> + * Return: handle to registered clock divider
> + */
> +static struct clk *_register_divider(struct device *dev, const char *name,
> +                                    u32 clk_id, u32 div_type,
> +                                    const char * const *parents,
> +                                    u8 num_parents, unsigned long flags,
> +                                    u8 clk_divider_flags)
> +{
> +       struct zynqmp_clk_divider *div;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       /* allocate the divider */
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &zynqmp_clk_divider_ops;
> +       init.flags = flags;
> +       init.parent_names = parents;
> +       init.num_parents = num_parents;
> +
> +       /* struct clk_divider assignments */
> +       div->flags = clk_divider_flags;
> +       div->hw.init = &init;
> +       div->clk_id = clk_id;
> +       div->div_type = div_type;
> +
> +       /* register the clock */
> +       clk = clk_register(dev, &div->hw);

Please use clk_hw_register().

> +
> +       if (IS_ERR(clk))
> +               kfree(div);
> +
> +       return clk;
> +}
> +
> +/**
> + * zynqmp_clk_register_divider - register a divider clock
> + * @dev: device registering this clock
> + * @name: name of this clock
> + * @clk_id: Id of clock
> + * @div_type: Type of divisor
> + * @parents: name of clock's parents
> + * @num_parents: number of parents
> + * @flags: framework-specific flags
> + * @clk_divider_flags: divider-specific flags for this clock
> + *
> + * Return: handle to registered clock divider
> + */
> +struct clk *zynqmp_clk_register_divider(struct device *dev, const char *name,
> +                                       u32 clk_id, u32 div_type,
> +                                       const char * const *parents,
> +                                       u8 num_parents, unsigned long flags,
> +                                       u8 clk_divider_flags)
> +{
> +       return _register_divider(dev, name, clk_id, div_type, parents,
> +                                num_parents, flags, clk_divider_flags);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_clk_register_divider);
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> new file mode 100644
> index 0000000..7535e12
> --- /dev/null
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Zynq UltraScale+ MPSoC PLL driver
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk/zynqmp.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +
> +/**
> + * struct zynqmp_pll - Structure for PLL clock
> + * @hw:                Handle between common and hardware-specific interfaces
> + * @clk_id:    PLL clock ID
> + */
> +struct zynqmp_pll {
> +       struct clk_hw hw;
> +       u32 clk_id;
> +};
> +
> +#define to_zynqmp_pll(_hw)     container_of(_hw, struct zynqmp_pll, hw)
> +
> +/* Register bitfield defines */
> +#define PLLCTRL_FBDIV_MASK     0x7f00
> +#define PLLCTRL_FBDIV_SHIFT    8
> +#define PLLCTRL_BP_MASK                BIT(3)
> +#define PLLCTRL_DIV2_MASK      BIT(16)
> +#define PLLCTRL_RESET_MASK     1
> +#define PLLCTRL_RESET_VAL      1
> +#define PLL_STATUS_LOCKED      1
> +#define PLLCTRL_RESET_SHIFT    0
> +#define PLLCTRL_DIV2_SHIFT     16
> +
> +#define PLL_FBDIV_MIN  25
> +#define PLL_FBDIV_MAX  125
> +
> +#define PS_PLL_VCO_MIN 1500000000
> +#define PS_PLL_VCO_MAX 3000000000UL
> +
> +enum pll_mode {
> +       PLL_MODE_INT,
> +       PLL_MODE_FRAC,
> +};
> +
> +#define FRAC_OFFSET 0x8
> +#define PLLFCFG_FRAC_EN        BIT(31)
> +#define FRAC_DIV  0x10000  /* 2^16 */

Could be 1 << 16 then?

> +
> +/**
> + * pll_get_mode - Get mode of PLL
> + * @hw: Handle between common and hardware-specific interfaces
> + *
> + * Return: Mode of PLL
> + */
> +static inline enum pll_mode pll_get_mode(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       u32 clk_id = clk->clk_id;
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 ret_payload[PAYLOAD_ARG_CNT];

How big is PAYLOAD_ARG_CNT?

> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return -ENXIO;
> +
> +       ret = eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
> +                             ret_payload);
> +       if (ret)
> +               pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return ret_payload[1];
> +}
> +
> +/**
> + * pll_set_mode - Set the PLL mode
> + * @hw:                Handle between common and hardware-specific interfaces
> + * @on:                Flag to determine the mode
> + */
> +static inline void pll_set_mode(struct clk_hw *hw, bool on)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       u32 clk_id = clk->clk_id;
> +       const char *clk_name = clk_hw_get_name(hw);
> +       int ret;
> +       u32 mode;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->ioctl) {
> +               pr_warn_once("eemi_ops not found\n");
> +               return;
> +       }
> +
> +       if (on)
> +               mode = PLL_MODE_FRAC;
> +       else
> +               mode = PLL_MODE_INT;
> +
> +       ret = eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NULL);
> +       if (ret)
> +               pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +}
> +
> +/**
> + * zynqmp_pll_round_rate - Round a clock frequency
> + * @hw:                Handle between common and hardware-specific interfaces
> + * @rate:      Desired clock frequency
> + * @prate:     Clock frequency of parent clock
> + *
> + * Return:     Frequency closest to @rate the hardware can generate
> + */
> +static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long *prate)
> +{
> +       u32 fbdiv;
> +       long rate_div, f;
> +
> +       /* Enable the fractional mode if needed */
> +       rate_div = ((rate * FRAC_DIV) / *prate);

Drop useless parenthesis.

> +       f = rate_div % FRAC_DIV;
> +       pll_set_mode(hw, !!f);
> +
> +       if (pll_get_mode(hw) == PLL_MODE_FRAC) {
> +               if (rate > PS_PLL_VCO_MAX) {
> +                       fbdiv = rate / PS_PLL_VCO_MAX;
> +                       rate = rate / (fbdiv + 1);
> +               }
> +               if (rate < PS_PLL_VCO_MIN) {
> +                       fbdiv = DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
> +                       rate = rate * fbdiv;
> +               }
> +               return rate;
> +       }
> +
> +       fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
> +       fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
> +       return *prate * fbdiv;
> +}
> +
> +/**
> + * zynqmp_pll_recalc_rate - Recalculate clock frequency
> + * @hw:                        Handle between common and hardware-specific interfaces
> + * @parent_rate:       Clock frequency of parent clock
> + * Return:             Current clock frequency
> + */
> +static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       u32 clk_id = clk->clk_id;
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 fbdiv, data;
> +       unsigned long rate, frac;
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_getdivider)
> +               return 0;
> +
> +       /*
> +        * makes probably sense to redundantly save fbdiv in the struct
> +        * zynqmp_pll to save the IO access.
> +        */
> +       ret = eemi_ops->clock_getdivider(clk_id, &fbdiv);
> +       if (ret)
> +               pr_warn_once("%s() get divider failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       rate =  parent_rate * fbdiv;
> +       if (pll_get_mode(hw) == PLL_MODE_FRAC) {
> +               eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
> +                               ret_payload);
> +               data = ret_payload[1];
> +               frac = (parent_rate * data) / FRAC_DIV;
> +               rate = rate + frac;
> +       }
> +
> +       return rate;
> +}
> +
> +/**
> + * zynqmp_pll_set_rate - Set rate of PLL
> + * @hw:                        Handle between common and hardware-specific interfaces
> + * @rate:              Frequency of clock to be set
> + * @parent_rate:       Clock frequency of parent clock
> + */
> +static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       u32 clk_id = clk->clk_id;
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 fbdiv, data;
> +       long rate_div, frac, m, f;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_setdivider)
> +               return -ENXIO;
> +
> +       if (pll_get_mode(hw) == PLL_MODE_FRAC) {
> +               unsigned int children;
> +
> +               /*
> +                * We're running on a ZynqMP compatible machine, make sure the
> +                * VPLL only has one child.
> +                */
> +               children = clk_get_children("vpll");
> +
> +               /* Account for vpll_to_lpd and dp_video_ref */
> +               if (children > 2)
> +                       WARN(1, "Two devices are using vpll which is forbidden\n");

I suppose a clk_hw_count_children() API would be OK, but I don't know if
we really care. It looks like more firmware validation code that I'd
prefer we don't carry around.

> +
> +               rate_div = ((rate * FRAC_DIV) / parent_rate);
> +               m = rate_div / FRAC_DIV;
> +               f = rate_div % FRAC_DIV;
> +               m = clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
> +               rate = parent_rate * m;
> +               frac = (parent_rate * f) / FRAC_DIV;
> +
> +               ret = eemi_ops->clock_setdivider(clk_id, m);
> +               if (ret)
> +                       pr_warn_once("%s() set divider failed for %s, ret = %d\n",
> +                                    __func__, clk_name, ret);
> +
> +               data = (FRAC_DIV * f) / FRAC_DIV;
> +               eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data, NULL);
> +
> +               return (rate + frac);

Drop useless parenthesis. 

> +       }
> +
> +       fbdiv = DIV_ROUND_CLOSEST(rate, parent_rate);
> +       fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
> +       ret = eemi_ops->clock_setdivider(clk_id, fbdiv);
> +       if (ret)
> +               pr_warn_once("%s() set divider failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return parent_rate * fbdiv;
> +}
> +
> +/**
> + * zynqmp_pll_is_enabled - Check if a clock is enabled
> + * @hw:                Handle between common and hardware-specific interfaces
> + *
> + * Return:     1 if the clock is enabled, 0 otherwise
> + */
> +static int zynqmp_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = clk->clk_id;
> +       unsigned int state;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_getstate)
> +               return 0;
> +
> +       ret = eemi_ops->clock_getstate(clk_id, &state);
> +       if (ret)
> +               pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return state ? 1 : 0;
> +}
> +
> +/**
> + * zynqmp_pll_enable - Enable clock
> + * @hw:                Handle between common and hardware-specific interfaces
> + *
> + * Return:     0 always
> + */
> +static int zynqmp_pll_enable(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = clk->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_enable)
> +               return 0;
> +
> +       if (zynqmp_pll_is_enabled(hw))
> +               return 0;
> +
> +       pr_info("PLL: enable\n");
> +
> +       ret = eemi_ops->clock_enable(clk_id);
> +       if (ret)
> +               pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_pll_disable - Disable clock
> + * @hw:                Handle between common and hardware-specific interfaces
> + *
> + */
> +static void zynqmp_pll_disable(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> +       const char *clk_name = clk_hw_get_name(hw);
> +       u32 clk_id = clk->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->clock_disable)
> +               return;
> +
> +       if (!zynqmp_pll_is_enabled(hw))
> +               return;
> +
> +       pr_info("PLL: shutdown\n");
> +
> +       ret = eemi_ops->clock_disable(clk_id);
> +       if (ret)
> +               pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
> +                            __func__, clk_name, ret);
> +}
> +
> +static const struct clk_ops zynqmp_pll_ops = {
> +       .enable = zynqmp_pll_enable,
> +       .disable = zynqmp_pll_disable,
> +       .is_enabled = zynqmp_pll_is_enabled,
> +       .round_rate = zynqmp_pll_round_rate,
> +       .recalc_rate = zynqmp_pll_recalc_rate,
> +       .set_rate = zynqmp_pll_set_rate,
> +};
> +
> +/**
> + * clk_register_zynqmp_pll - Register PLL with the clock framework
> + * @name:      PLL name
> + * @clk_id:    Clock ID
> + * @parents:   Parent clock names
> + * @num_parents:Number of parents
> + * @flag:      PLL flgas
> + *
> + * Return:     Handle to the registered clock
> + */
> +struct clk *clk_register_zynqmp_pll(const char *name, u32 clk_id,
> +                                   const char * const *parents,
> +                                   u8 num_parents, unsigned long flag)
> +{
> +       struct zynqmp_pll *pll;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +       int status;
> +
> +       init.name = name;
> +       init.ops = &zynqmp_pll_ops;
> +       init.flags = flag;
> +       init.parent_names = parents;
> +       init.num_parents = num_parents;
> +
> +       pll = kmalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Populate the struct */
> +       pll->hw.init = &init;
> +       pll->clk_id = clk_id;
> +
> +       clk = clk_register(NULL, &pll->hw);
> +       if (WARN_ON(IS_ERR(clk)))
> +               kfree(pll);
> +
> +       status = clk_set_rate_range(clk, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
> +       if (status < 0)
> +               pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, status);
> +
> +       return clk;
> +}
> diff --git a/include/linux/clk/zynqmp.h b/include/linux/clk/zynqmp.h
> new file mode 100644
> index 0000000..9ae3d28
> --- /dev/null
> +++ b/include/linux/clk/zynqmp.h

Why is this here and not local to the zynqmp clk driver?  
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  Copyright (C) 2016-2018 Xilinx
> + */
> +
> +#ifndef __LINUX_CLK_ZYNQMP_H_
> +#define __LINUX_CLK_ZYNQMP_H_
> +
> +#include <linux/spinlock.h>
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +
> +#define CLK_FRAC       BIT(13) /* has a fractional parent */

Please move this to the one file that uses it. And does anyone use it?

> +
> +struct device;
> +
> +struct clk *clk_register_zynqmp_pll(const char *name, u32 clk_id,
> +                                   const char * const *parent, u8 num_parents,
> +                                   unsigned long flag);
> +
> +struct clk *zynqmp_clk_register_gate(struct device *dev, const char *name,
> +                                    u32 clk_id,
> +                                    const char * const *parent_name,
> +                                    u8 num_parents, unsigned long flags,
> +                                    u8 clk_gate_flags);
> +
> +struct clk *zynqmp_clk_register_divider(struct device *dev, const char *name,
> +                                       u32 clk_id, u32 div_type,
> +                                       const char * const *parent_name,
> +                                       u8 num_parents,
> +                                       unsigned long flags,
> +                                       u8 clk_divider_flags);
> +
> +struct clk *zynqmp_clk_register_mux(struct device *dev, const char *name,
> +                                   u32 clk_id,
> +                                   const char **parent_names,
> +                                   u8 num_parents, unsigned long flags,
> +                                   u8 clk_mux_flags);
> +
> +struct clk *zynqmp_clk_register_mux_table(struct device *dev, const char *name,
> +                                         u32 clk_id,
> +                                         const char * const *parent_names,
> +                                         u8 num_parents, unsigned long flags,
> +                                         u8 clk_mux_flags);
> +
