Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeCLSZg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:25:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38393 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:25:34 -0400
X-Google-Smtp-Source: AG47ELv350roQ1YNg8pcLb4epQZIJl/UfwGe7Xc0DA8nYPWtQ4pHaB+yXAlyZ02ALGNbTJvVOynvgw==
Date: Mon, 12 Mar 2018 11:25:24 -0700
From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 00/19] clk: meson: use regmap in clock controllers
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>
References: <20180212145846.19380-1-jbrunet@baylibre.com>
In-Reply-To: <20180212145846.19380-1-jbrunet@baylibre.com>
MIME-Version: 1.0
User-Agent: astroid/8ea8c2a3 (https://github.com/astroidmail/astroid)
Message-Id: <1520878632.grlxixwihc.astroid@resonance.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2CIPhJM010636

Bonjour Jerome,

Excerpts from Jerome Brunet's message of February 12, 2018 6:58 am:
> This changeset is a rework of meson's clock controllers to use regmap
> instead of directly using io memory. It based clk-meson next/drivers
> and depends on few core clock patches, mainly to export generic clocks
> helpers: [0],[1]. The line count is pretty high but the changes are
> actually fairly simple and repetitive.
> 
> This work has been triggered by the fact that the HHI register space on
> gxbb and axg provides more than just clocks. The display driver already
> uses a syscon for HHI on gxbb. This is why gxbb did not use
> devm_ioremap_resource() to map the registers, since it would have
> reserved the memory region, preventing another driver from re-mapping
> it. The cleaner solution is, of course, to use syscon to handle. The
> purpose of this changeset is to allow it. Even if meson8b does not need
> this ATM, there is real reason to leave it behind. It is actually easier
> to migrate it as well, so all meson clock drivers may support regmap
> only.
> 
> The rework starts with a few easy clean-ups. The real deal starts with
> patch 5, which adds meson's clk_regmap. This will be used as common
> structure to implement all the controller clocks. Having this replaces
> the gxbb AO controller specific regmap gate. This structure will also be
> re-used in upcoming controllers, such as the axg's AO and audio
> controllers.  Each clock type is then migrated, one at a time, to this
> new structure.
> 
> While at it, the meson clock drivers have been cleaned-up a bit,
> removing the gate embedded in the mpll driver, simplifying the pll
> driver and removing the legacy cpu_clk of meson8b.
> 
> The new code around the cpu clk of the meson8b is just re-implementation,
> using simple elements, of the old cpu_clk. As explained by Martin, the
> old cpu_clk would hang quite often when changing the rate of the cpu
> clock. Surprisingly, the new implementation improved the situation a bit,
> but still hangs from time to time. As this is not acceptable, the cpu
> clk subtree as been switched to a read-only mode, preventing any change
> of the cpu rate, until an acceptable solution is found.
> 
> With this series applied, the clock controllers of the gxbb, gxl and axg
> SoC will try get regmap from their parent DT node. If this fails, they
> will fallback to mapping the register themselves. This fallback will be
> kept until platform DTs have changed so clock controllers is a child of
> the HHI system controller.

Looks OK to me. As we discussed off-list, can you send this (and the
other meson patches) as a PR based on top of the clk-helpers branch in
the clk git tree? That should satisfy the dependencies (I hope).

Best regards,
Mike

> 
> Based on this changeset, more patches are coming. For those interested,
> the WIP is available here [2]
> 
> Changes since v1 [3]:
> * Fixed a few typos in patches descriptions
> * Fixed cpu clock names on meson8b, as suggested by Martin
> * Switched cpu clock subtree to reead-only mode
> * Fix clk_regmap mux documentation, as reported by Yixun
> 
> [0]: https://lkml.kernel.org/r/20180118110144.30619-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20180122105759.12206-1-jbrunet@baylibre.com
> [2]: https://github.com/jeromebrunet/linux/tree/v4.17/meson/clk-regmap
> [1]: https://lkml.kernel.org/r/20180131180945.18025-1-jbrunet@baylibre.com
> 
> Jerome Brunet (19):
>   clk: meson: use dev pointer where possible
>   clk: meson: use devm_of_clk_add_hw_provider
>   clk: meson: only one loop index is necessary in probe
>   clk: meson: remove obsolete comments
>   clk: meson: add regmap clocks
>   clk: meson: switch gxbb ao_clk to clk_regmap
>   clk: meson: remove superseded aoclk_gate_regmap
>   clk: meson: add regmap to the clock controllers
>   clk: meson: migrate gates to clk_regmap
>   clk: meson: migrate dividers to clk_regmap
>   clk: meson: migrate muxes to clk_regmap
>   clk: meson: add regmap helpers for parm
>   clk: meson: migrate mplls clocks to clk_regmap
>   clk: meson: migrate the audio divider clock to clk_regmap
>   clk: meson: migrate plls clocks to clk_regmap
>   clk: meson: split divider and gate part of mpll
>   clk: meson: rework meson8b cpu clock
>   clk: meson: remove obsolete cpu_clk
>   clk: meson: use hhi syscon if available
> 
>  drivers/clk/meson/Kconfig             |    9 +
>  drivers/clk/meson/Makefile            |    5 +-
>  drivers/clk/meson/axg.c               |  722 +++++++++--------
>  drivers/clk/meson/axg.h               |    6 +-
>  drivers/clk/meson/clk-audio-divider.c |   63 +-
>  drivers/clk/meson/clk-cpu.c           |  178 -----
>  drivers/clk/meson/clk-mpll.c          |  132 +---
>  drivers/clk/meson/clk-pll.c           |  243 +++---
>  drivers/clk/meson/clk-regmap.c        |  166 ++++
>  drivers/clk/meson/clk-regmap.h        |  111 +++
>  drivers/clk/meson/clkc.h              |   93 +--
>  drivers/clk/meson/gxbb-aoclk-regmap.c |   46 --
>  drivers/clk/meson/gxbb-aoclk.c        |   20 +-
>  drivers/clk/meson/gxbb-aoclk.h        |   11 -
>  drivers/clk/meson/gxbb.c              | 1402 ++++++++++++++++++---------------
>  drivers/clk/meson/gxbb.h              |    5 +-
>  drivers/clk/meson/meson8b.c           |  588 ++++++++------
>  drivers/clk/meson/meson8b.h           |   11 +-
>  18 files changed, 1978 insertions(+), 1833 deletions(-)
>  delete mode 100644 drivers/clk/meson/clk-cpu.c
>  create mode 100644 drivers/clk/meson/clk-regmap.c
>  create mode 100644 drivers/clk/meson/clk-regmap.h
>  delete mode 100644 drivers/clk/meson/gxbb-aoclk-regmap.c
> 
> -- 
> 2.14.3
> 
> 
