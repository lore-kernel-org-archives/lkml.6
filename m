Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032586AbeBOAt6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:49:58 -0500
Received: from ozlabs.org ([103.22.144.67]:35675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032264AbeBOAt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:49:56 -0500
Date: Thu, 15 Feb 2018 11:49:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: linux-next: build failure after merge of the mmc tree
Message-ID: <20180215114954.689cc952@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

After merging the mmc tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_set_timing':
drivers/mmc/host/sdhci-omap.c:466:8: error: implicit declaration of function 'pinctrl_select_state'; did you mean 'inc_node_state'? [-Werror=implicit-function-declaration]
  ret = pinctrl_select_state(omap_host->pinctrl, pinctrl_state);
        ^~~~~~~~~~~~~~~~~~~~
        inc_node_state
drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_iodelay_pinctrl_state':
drivers/mmc/host/sdhci-omap.c:740:18: error: implicit declaration of function 'pinctrl_lookup_state'; did you mean 'inc_node_state'? [-Werror=implicit-function-declaration]
  pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
                  ^~~~~~~~~~~~~~~~~~~~
                  inc_node_state
drivers/mmc/host/sdhci-omap.c:740:16: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
                ^
drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_config_iodelay_pinctrl_state':
drivers/mmc/host/sdhci-omap.c:769:23: error: implicit declaration of function 'devm_pinctrl_get'; did you mean 'devm_clk_get'? [-Werror=implicit-function-declaration]
  omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
                       ^~~~~~~~~~~~~~~~
                       devm_clk_get
drivers/mmc/host/sdhci-omap.c:769:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
                     ^
drivers/mmc/host/sdhci-omap.c:775:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  state = pinctrl_lookup_state(omap_host->pinctrl, "default");
        ^

Caused by commit

  713190bb14aa ("mmc: sdhci_omap: Add support to set IODELAY values")

Forgot to include linux/pinctrl/consumer.h?

I have used the mmc tree from next-20180214 for today.

-- 
Cheers,
Stephen Rothwell
